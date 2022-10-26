import logging
import os
import re
import errno
from datetime import datetime
from datetime import timedelta
from io import TextIOBase, StringIO
from pathlib import Path
import sys
sys.path.append('..')
from model.configuration import SolvisConfiguration
import requests
from requests.auth import HTTPDigestAuth

class SolvisAccessor():
    def __init__(self, configuration: SolvisConfiguration):
        self._basePath = "http://{}:{}".format(configuration.host, configuration.port)
        self._username = configuration.user
        self._password = configuration.password
        self._cachedir = Path(configuration.cachedir)
        self._alwaysFetchLastTwoMeasurementFiles = configuration.alwaysFetchLastTwoMeasurementFiles
        self._dataFileEncoding = configuration.logFileEncoding

        self._cacheListing = list()
        self._cacheWeeklyData = list()
        self._log = logging.getLogger(self.__class__.__name__)

        self.__ensureCacheDirExists()
        self.updateCache()

    def updateCache(self):
        self._log.debug("Updating cache")
        filesToFetch = self.__filesToFetchToUpdateCache()
        for fileToFetch in filesToFetch:
            self._log.debug("Retriegving file '{}' for caching".format(filesToFetch))
            currentFile = self._getLogfile(fileToFetch)
            self.__storeFileToCache(fileToFetch, currentFile)

    def getMaxEndDateOfLogFile(self, fileName):
        logDateRaw = re.findall(r'mi(\d{2})(\d{2})(\d{2})', fileName)
        if len(logDateRaw) == 0:
            raise Exception("Could not parse timerange of input file '{}'".format(fileName))
        year = 2000 + int(logDateRaw[0][0])
        month = int(logDateRaw[0][1])
        # filedate + 7 days, e.g. filename 20210405 contains measurements from 2021-04-05T00:00:00 upto 2021-04-12T00:00:00
        day = int(logDateRaw[0][2])
        startDate = datetime(year, month, day)
        endDate = startDate + timedelta(days=7)
        return endDate

    def getLogfilesList(self, reverseSorted: bool = False) -> list[str]:
        return self._cacheListing

    def getLogfile(self, fileName: str) -> TextIOBase:
        if fileName not in self._cacheListing:
            raise FileNotFoundError(errno.ENOENT, os.strerror(errno.ENOENT), fileName)

        cacheFilePath = self._cachedir / fileName
        return open(cacheFilePath, "r", encoding=self._dataFileEncoding)

    # Private method section
    def __ensureCacheDirExists(self):
        os.makedirs(self._cachedir, exist_ok=True, mode=0o700)

    def __filesToFetchToUpdateCache(self) -> list[str]:
        self._cacheListing = self._getLogfilesList()
        thisFiles = os.listdir(self._cachedir)
        otherFiles = self._cacheListing
        missingFiles = [x for x in otherFiles if x not in thisFiles]

        # also add the latest two measurement data files to this list as the latest is most certainly out-of-date and the second latest is out-of-date on a change of the calendar week
        if self._alwaysFetchLastTwoMeasurementFiles:
            self._log.debug("Enforced appending of latest two measurements to list of files to update")
            missingFiles.extend(otherFiles[-2:])

        # only keep unique elements
        missingFiles = list(set(missingFiles))
        return missingFiles

    def __storeFileToCache(self, fileName: str, data: TextIOBase):
        cacheFilePath = self._cachedir / fileName
        self._log.debug("Writing file '{}' to cache file '{}'".format(fileName, cacheFilePath))
        with cacheFilePath.open(mode='w') as cacheFile:
            cacheFile.write(data.getvalue())
        self._log.debug("Cache file '{}' is written".format(cacheFilePath))


    def _getLogfilesList(self, reverseSorted: bool = False) -> list[str]:
        self._log.debug("Fetch list of logfiles")
        response = requests.get(self._basePath + "/dir.txt", auth=HTTPDigestAuth(self._username, self._password))
        response.raise_for_status()
        return sorted(response.text.splitlines(), reverse=reverseSorted)

    def _getLogfile(self, fileName: str) -> TextIOBase:
        self._log.debug("Fetch log file '{}'".format(fileName))
        response = requests.get(self._basePath + "/SC3_MA7/log/" + fileName, auth=HTTPDigestAuth(self._username, self._password))
        response.raise_for_status()
        response.encoding = self._dataFileEncoding
        return StringIO(response.text)
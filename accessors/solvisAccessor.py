import logging
import sys
sys.path.append('..')
from model.configuration import SolvisConfiguration
import requests
from requests.auth import HTTPDigestAuth
from io import StringIO

class SolvisAccessor():
    def __init__(self, configuration: SolvisConfiguration):
        self._basePath = "http://{}:{}".format(configuration.host, configuration.port)
        self._username = configuration.user
        self._password = configuration.password
        self._log = logging.getLogger(self.__class__.__name__)

    def getLogfilesList(self, reverseSorted: bool = False) -> list[str]:
        self._log.debug("Fetch list of logfiles")
        response = requests.get(self._basePath + "/dir.txt", auth=HTTPDigestAuth(self._username, self._password))
        response.raise_for_status()
        return sorted(response.text.splitlines(), reverse=reverseSorted)

    def getLogfile(self, fileName: str) -> StringIO:
        self._log.debug("Fetch log file")
        response = requests.get(self._basePath + "/SC3_MA7/log/" + fileName, auth=HTTPDigestAuth(self._username, self._password))
        response.raise_for_status()
        return StringIO(response.text)

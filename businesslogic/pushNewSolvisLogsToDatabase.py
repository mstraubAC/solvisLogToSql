import logging
import sys
from datetime import datetime
sys.path.append('..')
from accessors.databaseAccessor import DatabaseAccessor
from accessors.solvisAccessor import SolvisAccessor
from .pandasSolvisLog import PandasSolvisLog
from exceptions.solvis import SolvisInconsistentCsvError

class PushNewSolvisLogsToDatabase:
    def __init__(self, databaseAccessor: DatabaseAccessor, solvisAccessor: SolvisAccessor):
        self._db = databaseAccessor
        self._solvis = solvisAccessor
        self._log = logging.getLogger(self.__class__.__name__)
        self._numberDataRowsProcessed = 0
        self._numberDataRowsStoredToDatabase = 0
        self._numberMeasurementsStoredToDatabase = 0


    def sync(self):
        """Initiates a sync of Solvis sensor data younger than the latest data available in database"""
        solvisLogFileList = self._solvis.getLogfilesList()
        latestMeasurementOnDb = self._db.getLastDeviceTimestamp()
        self._log.info("Latest measurement for device on DB from {}".format(latestMeasurementOnDb))

        # build dataset for database import
        for fileName in solvisLogFileList:
            logMaxDate = self._solvis.getMaxEndDateOfLogFile(fileName)
            if logMaxDate < latestMeasurementOnDb:
                self._log.debug("Data from {} already imported --> Skipped".format(fileName))
                continue

            self._log.info("Importing {}".format(fileName))
            try:
                solvisLogData = PandasSolvisLog(self._solvis.getLogfile(fileName))
                self.__saveDataFrameToDatabase(solvisLogData.df, latestMeasurementOnDb)
            except SolvisInconsistentCsvError:
                self._log.warning("Skipping {} because of inconsistent data: Number of columns vary without valid data description.".format(fileName))

        self._log.info("Finished processing of {} timepoints from Solvis Log. {} timepoints were saved to database totalling to {} individual measurements.".format(self._numberDataRowsProcessed, self._numberDataRowsStoredToDatabase, self._numberMeasurementsStoredToDatabase))

    # private methods
    def __saveDataFrameToDatabase(self, dataFrame, earliestMeasurementToImport: datetime):
        for timestamp, row in dataFrame.iterrows():
            self._numberDataRowsProcessed += 1

            thisTime = datetime.utcfromtimestamp(timestamp)
            if thisTime <= earliestMeasurementToImport:
                # do not try to re-import already imported data. Database will reject it and script fails
                continue

            self._numberDataRowsStoredToDatabase += 1

            for sensorName, sensorValue in row.iteritems():
                self._db.insertMeasurement(int(timestamp), sensorName, sensorValue)
                self._numberMeasurementsStoredToDatabase += 1
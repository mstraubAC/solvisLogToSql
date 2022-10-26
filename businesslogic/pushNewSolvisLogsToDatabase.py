import logging
import sys
sys.path.append('..')
from accessors.databaseAccessor import DatabaseAccessor
from accessors.solvisAccessor import SolvisAccessor

class PushNewSolvisLogsToDatabase:
    def __init__(self, databaseAccessor: DatabaseAccessor, solvisAccessor: SolvisAccessor):
        self._db = databaseAccessor
        self._solvis = solvisAccessor
        self._log = logging.getLogger(self.__class__.__name__)


    def sync(self):
        """Initiates a sync of Solvis sensor data younger than the latest data available in database"""
        solvisLogFileList = self._solvis.getLogfilesList()
        
        latestMeasurementOnDb = self._db.getLastDeviceTimestamp()
        logging.info("Latest measurement for device on DB from {}".format(latestMeasurementOnDb))
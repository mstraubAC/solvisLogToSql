from .databaseAccessor import DatabaseAccessor
import sys
sys.path.append('..')
from model.configuration import SqlConfiguration
import psycopg2
import logging
import datetime

class PostgresDatabaseAccessor(DatabaseAccessor):
    # Class infrastructure
    def __init__(self, configuration: SqlConfiguration):
        super(PostgresDatabaseAccessor, self).__init__(logging.getLogger(self.__class__.__name__))
        self._config = configuration
        self._connection = None
        self._cursor = None
        self.open()

    def open(self):
        if not self.isConnectionOpen():
            self._log.debug("Opening SQL connection")
            self._connection = psycopg2.connect(
                host=self._config.host,
                database=self._config.database,
                user=self._config.user,
                password=self._config.password
                )
            self._connection.set_client_encoding('UTF8')
            self._cursor = self._connection.cursor()

    def close(self):
        if self.isConnectionOpen():
            self._log.debug("Closing SQL connection")
            self._connection.commit()
            self._connection.close()

            self._connection = None
            self._cursor = None

    def isConnectionOpen(self) -> bool:
        if self._connection is None:
            return False
        elif self._connection.closed != 0:
            return False
        else:
            return True

    ## Interfaces to database
    def insertMeasurement(self, timestamp: int, sensorName: str, sensorValue: float):
        self._log.debug("CALL \"data\".\"pInsertMeasurement\"(%s,%s,%s,%s);" % (timestamp,self._config.deviceName,sensorName,sensorValue,))
        self._cursor.execute(
            "CALL \"data\".\"pInsertMeasurement\"(%s,%s,%s,%s);"
            ,(timestamp,self._config.deviceName,sensorName,sensorValue,)
        )
        self._connection.commit()

    def getLastDeviceTimestamp(self) -> datetime.datetime:
        self._log.debug("SELECT * FROM \"data\".\"fnGetLatestMeasurementOfDevice\"('{}');'".format(self._config.deviceName))
        self._cursor.execute(
            "SELECT * FROM \"data\".\"fnGetLatestMeasurementOfDevice\"(%s);"
            ,(self._config.deviceName, )
            )
        return self._cursor.fetchone()[0]
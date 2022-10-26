from .databaseAccessor import DatabaseAccessor
import sys
sys.path.append('..')
from model.configuration import SqlConfiguration
import psycopg2
import logging

class PostgresDatabaseAccessor(DatabaseAccessor):
    def __init__(self, configuration: SqlConfiguration):
        self._config = configuration

        self._connection = psycopg2.connect(
            host=self._config.host,
            database=self._config.database,
            user=self._config.user,
            password=self._config.password
            )
        self._connection.set_client_encoding('UTF8')
        self._cursor = self._connection.cursor()

    def insertMeasurement(self, timestamp: int, sensorName: str, sensorValue: float):
        logging.debug("CALL \"data\".\"pInsertMeasurement\"(%s,%s,%s,%s);" % (timestamp,self._config.deviceName,sensorName,sensorValue,))
        self._cursor.execute(
            "CALL \"data\".\"pInsertMeasurement\"(%s,%s,%s,%s);"
            ,(timestamp,self._config.deviceName,sensorName,sensorValue,)
        )

    def getLastDeviceTimestamp(self):
        logging.debug("SELECT * FROM \"data\".\"fnGetLatestMeasurementOfDevice\"('{}');'".format(self._config.deviceName))
        self._cursor.execute(
            "SELECT * FROM \"data\".\"fnGetLatestMeasurementOfDevice\"(%s);"
            ,(self._config.deviceName, )
            )
        return self._cursor.fetchone()[0]
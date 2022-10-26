import json

class SolvisConfiguration:
    def __init__(self, host: str, port: str, user: str, password: str, cachedir: str, alwaysFetchLastTwoMeasurementFiles: bool, logFileEncoding: str):
        self.host = host
        self.port = port
        self.user = user
        self.password = password
        self.cachedir = cachedir
        self.alwaysFetchLastTwoMeasurementFiles = alwaysFetchLastTwoMeasurementFiles
        self.logFileEncoding = logFileEncoding

    def __str__(self):
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self):
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self):
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(json: dict):
        # default value initializations
        alwaysFetchLastTwoMeasurementFiles = json['alwaysFetchLastTwoMeasurementFiles'] if 'alwaysFetchLastTwoMeasurementFiles' in json else True        
        logFileEncoding = json['logFileEncoding'] if 'logFileEncoding' in json else 'ISO-8859-1'
        return SolvisConfiguration(
            json['host'],
            json['port'],
            json['user'],
            json['pass'],
            json['cachedir'],
            alwaysFetchLastTwoMeasurementFiles,
            logFileEncoding
            )

class SqlConfiguration:
    def __init__(self, host: str, user: str, password: str, database: str, deviceName: str):
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.deviceName = deviceName

    def __str__(self):
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self):
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self):
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(json: dict):
        return SqlConfiguration(
            json['host'],
            json['user'],
            json['pass'],
            json['database'],
            json['dbDeviceName']
        )


class Configuration:
    def __init__(self, solvis: SolvisConfiguration, sql: SqlConfiguration):
        self.solvis = solvis
        self.sql = sql

    def __str__(self):
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self):
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self):
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(solvis, sql):
        return Configuration(
            SolvisConfiguration.fromJson(solvis),
            SqlConfiguration.fromJson(sql)
        )
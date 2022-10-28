import json

class SolvisConfiguration:
    def __init__(self, host: str, port: str, user: str, password: str, cachedir: str, alwaysFetchLastTwoMeasurementFiles: bool, logFileEncoding: str) -> None:
        self.host = host
        self.port = port
        self.user = user
        self.password = password
        self.cachedir = cachedir
        self.alwaysFetchLastTwoMeasurementFiles = alwaysFetchLastTwoMeasurementFiles
        self.logFileEncoding = logFileEncoding

    def __str__(self) -> str():
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(json: dict[str, any]) -> 'SolvisConfiguration':
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
    def __init__(self, host: str, user: str, password: str, database: str, deviceName: str) -> None:
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.deviceName = deviceName

    def __str__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(json: dict[str, any]) -> 'SqlConfiguration':
        return SqlConfiguration(
            json['host'],
            json['user'],
            json['pass'],
            json['database'],
            json['dbDeviceName']
        )

class PandasSolvisLogConverterConfiguration:
    def __init__(self, columnNameMapping: dict[str, str], electricHeatingRodTotalPower: float, electricHeatingRodPowerSteps: int, dataEncoding: str) -> None:
        self.columnNameMapping = columnNameMapping
        self.electricHeatingRodTotalPower = electricHeatingRodTotalPower
        self.electricHeatingRodPowerSteps = electricHeatingRodPowerSteps
        self.dataEncoding = dataEncoding

    def __str__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(json: dict[str, any]) -> 'PandasSolvisLogConverterConfiguration':
        columnNameMapping = json['columnNameMapping'] if 'columnNameMapping' in json else {
                'S1': 'heatStoreTemperatureTop',
                'S2': 'warmWaterTemperature',
                'S3': 'heatStoreTemperatureBottomReference',
                'S4': 'heatStoreTemperatureHeatingTop',
                'S9': 'heatStoreTemperatureHeatingBottom',
                'S10': 'outsideTemperature',
                'S11': 'circulation',
                'S12': 'flowTemperatureCircuit1',
                'S13': 'flowTemperatureCircuit2',
                'S14': 'flowTemperatureCircuitHeatpump',
                'S15': 'coldWaterTemperature',
                'S16': 'flowTemperatureCircuit3',
                'S18': 'warmWaterThroughput',
                'I1': 'SmartGrid',
                'A3': 'heatingPumpCircuit1',
                'A4': 'heatingPumpCircuit2',
                'A5': 'heatingPumpCircuit3',
                'A6': 'mixerOpenCircuit3',
                'A7': 'mixerClosedCircuit3',
                'A8': 'mixerOpenCircuit1',
                'A9': 'mixerClosedCircuit1',
                'A10': 'mixerOpenCircuit2',
                'A11': 'mixerClosedCircuit2',
                'A12': 'heatpumpResistanceHeating1',
                'A13': 'heatpumpResistanceHeating2',
                'A14': 'heatpumpThreeWayOutlet',
                'O1': 'heatpumpUnused',
                'WP Leist': 'heatpumpThermalPower',
                'WP Pel': 'heatpumpElectricPower',
                'SmartGrid': 'smartGridState',
                'AnfHK1': 'targetTemperatureCircuit1',
                'AnfHK2': 'targetTemperatureCircuit2',
                'AnfHK3': 'targetTemperatureCircuit3',
                'Vdrz': 'compressorSpeed',
                'WPVL': 'heatpumpFlow',
                'WPRL': 'heatpumpReverse',
                'VAtemp': 'compressourOutsideTemperature',
                'ND': 'heatpumpLowPressure',
                'HD': 'heatpumpHighPressure'
            }
        electricHeatingRodTotalPower = json['electricHeatingRodTotalPower'] if 'electricHeatingRodTotalPower' in json else 8.8
        electricHeatingRodPowerSteps = json['electricHeatingRodPowerSteps'] if 'electricHeatingRodPowerSteps' in json else 3
        dataEncoding = json['dataEncoding'] if 'dataEncoding' in json else 'ISO-8859-1'

        return PandasSolvisLogConverterConfiguration(
            columnNameMapping,
            electricHeatingRodTotalPower,
            electricHeatingRodPowerSteps,
            dataEncoding
        )


class Configuration:
    def __init__(self, solvis: SolvisConfiguration, sql: SqlConfiguration, pandasSolvisLogConverter: PandasSolvisLogConverterConfiguration) -> None:
        self.solvis = solvis
        self.sql = sql
        self.pandasSolvisLogConverter = pandasSolvisLogConverter

    def __str__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def __repr__(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)
    
    def toJson(self) -> str:
        return json.dumps(dict(self), ensure_ascii=False)

    @staticmethod
    def fromJson(solvis: dict[str, any], sql: dict[str, any], pandasSolvisLogConverter: dict[str, any]) -> 'Configuration':
        return Configuration(
            SolvisConfiguration.fromJson(solvis),
            SqlConfiguration.fromJson(sql),
            PandasSolvisLogConverterConfiguration.fromJson(pandasSolvisLogConverter)
        )
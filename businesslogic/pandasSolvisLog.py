import pandas as pd
import logging
import csv
import re
from io import IOBase
import sys
sys.path.append('..')
from exceptions.solvis import SolvisInconsistentCsvError

class PandasSolvisLog:
    def __init__(self, inputData: IOBase):
        self._electricHeatingRodTotalPower = 8.8
        self._electricHeatingRodPowerSteps = 3
        self._dataEncoding = 'ISO-8859-1'
        self._log = logging.getLogger(self.__class__.__name__)
        self.df = None
        self.columnUnits = {}

        if not isinstance(inputData, IOBase):
            raise TypeError("Expect object of type IOBase")
        if inputData.seekable():
            inputData.seek(0)

        self.__processCsvToPandasDataFrame(inputData)

    def __columnNameMapping(self) -> dict[str, str]:
        return {
            'S1': 'heatStoreTemperatureTop',
            'S2': 'warmWaterTemperature',
            'S3': 'heatStoreTemperatureBottomReference',
            'S4': 'heatStoreTemperatureHeatingTop',
            'S9': 'heatStoreTemperatureHeatingBottom',
            'S10': 'outsideTemperature',
    #        'S11': 'circulation',
            'S12': 'flowTemperatureCircuit1',
    #        'S13': 'flowTemperatureCircuit2',
            'S14': 'flowTemperatureCircuitHeatpump',
            'S15': 'coldWaterTemperature',
    #        'S16': 'flowTemperatureCircuit3',
            'S18': 'warmWaterThroughput',
            'I1': 'SmartGrid',
            'A3': 'heatingPumpCircuit1',
    #        'A4': 'heatingPumpCircuit2',
    #        'A5': 'heatingPumpCircuit3',
    #        'A6': 'mixerOpenCircuit3',
    #        'A7': 'mixerClosedCircuit3',
    #        'A8': 'mixerOpenCircuit1',
    #        'A9': 'mixerClosedCircuit1',
    #        'A10': 'mixerOpenCircuit2',
    #        'A11': 'mixerClosedCircuit2',
            'A12': 'heatpumpResistanceHeating1',
            'A13': 'heatpumpResistanceHeating2',
            'A14': 'heatpumpThreeWayOutlet',
            'O1': 'heatpumpUnused',
            'WP Leist': 'heatpumpThermalPower',
            'WP Pel': 'heatpumpElectricPower',
            'SmartGrid': 'smartGridState',
            'AnfHK1': 'targetTemperatureCircuit1',
    #        'AnfHK2': 'targetTemperatureCircuit2',
    #        'AnfHK3': 'targetTemperatureCircuit3',
            'Vdrz': 'compressorSpeed',
            'WPVL': 'heatpumpFlow',
            'WPRL': 'heatpumpReverse',
            'VAtemp': 'compressourOutsideTemperature',
            'ND': 'heatpumpLowPressure',
            'HD': 'heatpumpHighPressure'
        }

    def __renameDictKeys(self, d, keymap):
        """
        :param d: old dict
        :type d: dict
        :param keymap: [{:keys from-keys :values to-keys} keymap]
        :returns: new dict
        :rtype: dict
        """
        new_dict = {}
        for key, value in zip(d.keys(), d.values()):
            new_key = keymap.get(key, key)
            new_dict[new_key] = d[key]
        return new_dict

    def __getMinMaxNumberOfColumnsOfCsv(self, inputData: IOBase, skiprows: int =0, sep: str =','):
        csvFile = csv.reader(inputData, delimiter=sep)
        for i in range(skiprows):
            next(csvFile)
        
        minCols = None
        maxCols = None
        headers = []
        for row in csvFile:
            thisLen = len(row)
            if minCols is None:
                headers = row
                minCols = thisLen
                maxCols = thisLen
            if maxCols < thisLen:
                maxCols = thisLen
        self._log.info("Found: minCols={}, maxCols={}".format(minCols, maxCols))

        if minCols != maxCols:
            self._log.warn("CSV file has varying number of columns! Declare additional columns not in header as dummy columns")

        for iAdditionalColumn in range(maxCols - len(headers)):
            self._log.append('Column{}'.format(iAdditionalColumn))

        return minCols, maxCols, headers
    
    def __failIfInconsistentColumnCount(self, inputData: IOBase):
        # find if we must have csv with changing number of columns. That's happened during a firmwareupdate :(
        minCols, maxCols, rawHeaders = self.__getMinMaxNumberOfColumnsOfCsv(inputData, skiprows=4, sep='\t')
        if minCols != maxCols:
            self._log.error("CSV cannot be processed because of inconsistent column numbers")
            raise SolvisInconsistentCsvError("Number of columns in Solvis CSV file differ throughout the file")

        # reset position
        if inputData.seekable():
            inputData.seek(0)
    
    def __createRawDataFrame(self, inputData: IOBase):
        dfLog = pd.read_csv(inputData, sep='\t', skiprows=4, encoding=self._dataEncoding, header=[0])
        dfHeaders = dfLog.iloc[:1]
        dfLog = dfLog.iloc[1:]
        return dfLog, dfHeaders

    def __applyDataScaling(self, dfLog, dfHeaders) -> dict[str, str]:
        """ convert numeric columns and scale them """
        colUnits = {}
        for colName in dfHeaders.columns:
            logging.debug("Parsing data in column '{}".format(colName))
            colUnitsRaw = dfHeaders.loc[0, colName]
            colScaler = re.findall(r'#([0-9]+([.][0-9]*)?|[.][0-9]+)#', colUnitsRaw)
            tmpUnits = re.findall(r'([a-zA-Z\d/%]+)#([0-9]+([.][0-9]*)?|[.][0-9]+)#', colUnitsRaw)
            if len(tmpUnits) > 0:
                colUnits[colName] = tmpUnits[0][0]
            else:
                colUnits[colName] = ""
            logging.debug("column=" + colName + ", rawUnits=" + colUnitsRaw + ", colUnits=" + colUnits[colName])
            if len(colScaler) != 1:
                logging.error("found a list of column scalers, i.e. '%s', in this descriptor '%s'" % ( colScaler, colUnitsRaw, ))
                break
            colScaler = float(colScaler[0][0])

            # scaling column
            dfLog[colName] = dfLog[colName].astype(float)
            dfLog[colName] *= colScaler

        return colUnits

    def __mergeDateTimeColumnsIntoSingleColumn(self, dfLog, dfHeaders):
        dfLog['DateTime'] = pd.to_datetime(dfLog['Datum'].astype(str) + ' ' + dfLog['Zeit'].astype(str), format='%d.%m.%y %H:%M:%S', errors='coerce')
        dfLog.drop(labels=['Datum', 'Zeit'], axis=1, inplace=True)
        dfHeaders.drop(labels=['Datum', 'Zeit'], axis=1, inplace=True)
        dfLog['DateTime'] = (dfLog['DateTime'] - pd.Timestamp("1970-01-01")) // pd.Timedelta('1s')

    def __calculateElectricalHeatingPower(self, dfLog, colUnits):
        # calculate electrical heating power
        dfLog['heatpumpResistanceHeatingLevel'] = (dfLog['heatpumpResistanceHeating1'] * 1. + dfLog['heatpumpResistanceHeating2'] * 2.) / 100
        dfLog['heatpumpResistanceHeatingPower'] = dfLog['heatpumpResistanceHeatingLevel'] * self._electricHeatingRodTotalPower / self._electricHeatingRodPowerSteps
        colUnits['heatpumpResistanceHeatingPower'] = 'kW'
        
        colDrops = [
            'heatpumpResistanceHeatingLevel',
            'heatpumpResistanceHeating1',
            'heatpumpResistanceHeating2'
        ]
        dfLog.drop(labels=colDrops, axis=1, inplace=True)
        colUnits = { key: val for key, val in colUnits.items() if key not in colDrops }
        
        if len(colUnits) != len(dfLog.columns):
            logging.error("column in units (%i) and data frame (%i) do not match" % ( len(colUnitsTarget), len(dfLogTarget.columns), ))
            logging.debug({key for key in dfLogTarget.columns if key not in colUnitsTarget})

    def __processCsvToPandasDataFrame(self, inputData: IOBase):
        self._log.debug("Start processing of Solvis CSV data to Pandas Data frame")
        self.__failIfInconsistentColumnCount(inputData)
        self._log.debug("Input data is valid CSV")

        # separate data unit row and log data
        dfLog, dfHeaders = self.__createRawDataFrame(inputData)
        self.__mergeDateTimeColumnsIntoSingleColumn(dfLog, dfHeaders)
        colUnits = self.__applyDataScaling(dfLog, dfHeaders)

        # set index to DateTime column
        dfLog = dfLog.set_index(keys=['DateTime'])

        # filter colNaming to only include available columns
        colNaming = { k: v for k, v in self.__columnNameMapping().items() if k in dfLog.columns }
        dfLog = dfLog.rename(colNaming, axis=1)
        colUnits = self.__renameDictKeys(colUnits, colNaming)
        
        # drop all unmapped columns
        acceptedColumnList = list( colNaming.values() )
        dfLogTarget = dfLog[acceptedColumnList].copy()
        colUnitsTarget = { k: v for k, v in colUnits.items() if k in acceptedColumnList }

        self.__calculateElectricalHeatingPower(dfLogTarget, colUnitsTarget)

        # initialize class members
        self.df = dfLogTarget
        self.columnUnits = colUnitsTarget

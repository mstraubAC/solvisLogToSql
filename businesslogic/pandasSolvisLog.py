import pandas as pd
import logging
import csv
import re
from io import IOBase
import sys
sys.path.append('..')
from exceptions.solvis import SolvisInconsistentCsvError
from model.configuration import PandasSolvisLogConverterConfiguration

class SolvisLogDataFrame:
    def __init__(self, inputData: IOBase, config: PandasSolvisLogConverterConfiguration):
        self._log = logging.getLogger(self.__class__.__name__)
        self._config = config
        self.df = None
        self.columnUnits = {}

        if not isinstance(inputData, IOBase):
            raise TypeError("Expect object of type IOBase")
        if inputData.seekable():
            inputData.seek(0)

        self.__processCsvToPandasDataFrame(inputData)

    def __columnNameMapping(self) -> dict[str, str]:
        return self._config.columnNameMapping

    def __renameDictKeys(self, oldDict: dict, keymap: dict) -> dict:
        """
        :param d: old dict
        :type d: dict
        :param keymap: [{:keys from-keys :values to-keys} keymap]
        :returns: new dict
        :rtype: dict
        """
        newDict = {}
        for key, value in zip(oldDict.keys(), oldDict.values()):
            newKey = keymap.get(key, key)
            newDict[newKey] = oldDict[key]
        return newDict

    def __getMinMaxNumberOfColumnsOfCsv(self, inputData: IOBase, skiprows: int =0, sep: str =',') -> tuple[int, int, list[str]]:
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
    
    def __createRawDataFrame(self, inputData: IOBase) -> pd.DataFrame:
        dfLog = pd.read_csv(inputData, sep='\t', skiprows=4, encoding=self._config.dataEncoding, header=[0])
        dfHeaders = dfLog.iloc[:1]
        dfLog = dfLog.iloc[1:]
        return dfLog, dfHeaders

    def __applyDataScaling(self, dfLog: pd.DataFrame, dfHeaders: pd.DataFrame) -> dict[str, str]:
        """ convert numeric columns and scale them """
        colUnits = {}
        for colName in dfHeaders.columns:
            self._log.debug("Parsing data in column '{}".format(colName))
            colUnitsRaw = dfHeaders.loc[0, colName]
            colScaler = re.findall(r'#([0-9]+([.][0-9]*)?|[.][0-9]+)#', colUnitsRaw)
            tmpUnits = re.findall(r'([a-zA-Z\d/%]+)#([0-9]+([.][0-9]*)?|[.][0-9]+)#', colUnitsRaw)
            if len(tmpUnits) > 0:
                colUnits[colName] = tmpUnits[0][0]
            else:
                colUnits[colName] = ""
            self._log.debug("column=" + colName + ", rawUnits=" + colUnitsRaw + ", colUnits=" + colUnits[colName])
            if len(colScaler) != 1:
                self._log.error("found a list of column scalers, i.e. '%s', in this descriptor '%s'" % ( colScaler, colUnitsRaw, ))
                break
            colScaler = float(colScaler[0][0])

            # scaling column
            dfLog[colName] = dfLog[colName].astype(float)
            dfLog[colName] *= colScaler

        return colUnits

    def __mergeDateTimeColumnsIntoSingleColumn(self, dfLog: pd.DataFrame, dfHeaders: pd.DataFrame):
        dfLog['DateTime'] = pd.to_datetime(dfLog['Datum'].astype(str) + ' ' + dfLog['Zeit'].astype(str), format='%d.%m.%y %H:%M:%S', errors='coerce')
        dfLog.drop(labels=['Datum', 'Zeit'], axis=1, inplace=True)
        dfHeaders.drop(labels=['Datum', 'Zeit'], axis=1, inplace=True)
        dfLog['DateTime'] = (dfLog['DateTime'] - pd.Timestamp("1970-01-01")) // pd.Timedelta('1s')

    def __calculateElectricalHeatingPower(self, dfLog: pd.DataFrame, colUnits: pd.DataFrame):
        # calculate electrical heating power
        dfLog['heatpumpResistanceHeatingLevel'] = (dfLog['heatpumpResistanceHeating1'] * 1. + dfLog['heatpumpResistanceHeating2'] * 2.) / 100
        dfLog['heatpumpResistanceHeatingPower'] = dfLog['heatpumpResistanceHeatingLevel'] * self._config.electricHeatingRodTotalPower / self._config.electricHeatingRodPowerSteps
        colUnits['heatpumpResistanceHeatingPower'] = 'kW'
        
        colDrops = [
            'heatpumpResistanceHeatingLevel',
            'heatpumpResistanceHeating1',
            'heatpumpResistanceHeating2'
        ]
        dfLog.drop(labels=colDrops, axis=1, inplace=True)
        colUnits = { key: val for key, val in colUnits.items() if key not in colDrops }
        
        if len(colUnits) != len(dfLog.columns):
            self._log.error("column in units (%i) and data frame (%i) do not match" % ( len(colUnitsTarget), len(dfLogTarget.columns), ))
            self._log.debug({key for key in dfLogTarget.columns if key not in colUnitsTarget})

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

class PandasSolvisLog:
    def __init__(self, config: PandasSolvisLogConverterConfiguration) -> None:
        self._config = config

    def convert(self, inputData: IOBase) -> SolvisLogDataFrame:
        return SolvisLogDataFrame(inputData, self._config)
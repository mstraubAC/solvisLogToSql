#!/usr/bin/env python3
import argparse
import logging
import json
import re
import csv
import psycopg2
import pandas as pd
import requests
from requests.auth import HTTPDigestAuth
from datetime import datetime
from datetime import date
from datetime import timedelta
from io import IOBase
from io import StringIO
from exceptions.solvis import SolvisInconsistentCsvError


### Parsing CLI parameters
parser = argparse.ArgumentParser(description="Save mqtt datasamples into sql warehouse")
parser.add_argument("--config", default="solvisLogToSql.conf.json")
parser.add_argument("--verbosity", type=int, default=2)
args = parser.parse_args()

### CONFIG
with open(args.config, 'r', encoding='utf-8') as configFile:
    config = json.load(configFile)

logUnfiltered = False

# set log level
if not args.verbosity:
    logging.basicConfig(level=logging.ERROR)
elif args.verbosity == 0:
    logging.basicConfig(level=logging.ERROR)
elif args.verbosity == 1:
    logging.basicConfig(level=logging.WARNING)
elif args.verbosity == 2:
    logging.basicConfig(level=logging.INFO)
elif args.verbosity >= 2:
    logging.basicConfig(level=logging.DEBUG)
else:
    logging.critical("Invalid log level")

# Solvis connection parameters
basePath = "http://{}:{}".format(config['solvis']['host'], config['solvis']['port'])
username = config['solvis']['user']
password = config['solvis']['pass']

# PostGres Connection
dbDeviceName = config['sql']['dbDeviceName']
conn = psycopg2.connect(
    host=config['sql']['host'],
    database=config['sql']['database'],
    user=config['sql']['user'],
    password=config['sql']['pass'])
conn.set_client_encoding('UTF8')
cur = conn.cursor()

# program start
def renameDictKeys(d, keymap):
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
def getMinMaxNumberOfColumnsOfCsv(rawCsv, skiprows=0, sep=','):
   csvFile = csv.reader(rawCsv, delimiter=sep)
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
   logging.info("Found: minCols={}, maxCols={}".format(minCols, maxCols))

   if minCols != maxCols:
       logging.warn("CSV file has varying number of columns! Declare additional columns not in header as dummy columns")

   for iAdditionalColumn in range(maxCols - len(headers)):
       headers.append('Column{}'.format(iAdditionalColumn))

   return minCols, maxCols, headers


def parseSolvisLogToPandas(rawLogData):
    _electricHeatingRodTotalPower = 8.8
    _electricHeatingRodPowerSteps = 3
    
    if not isinstance(rawLogData, IOBase):
        raise TypeError("Expect object of type IOBase")
    if rawLogData.seekable():
        rawLogData.seek(0)

    # find if we must have csv with changing number of columns. That's happened during a firmwareupdate :(
    minCols, maxCols, rawHeaders = getMinMaxNumberOfColumnsOfCsv(rawLogData, skiprows=4, sep='\t')
    if minCols != maxCols:
        logging.error("CSV cannot be processed because of inconsistent column numbers")
        raise SolvisInconsistentCsvError("Number of columns in Solvis CSV file differ throughout the file")
        
    # reset position
    if rawLogData.seekable():
        rawLogData.seek(0)
    # separate headers and log data
    dfLog =pd.read_csv(rawLogData, sep='\t', skiprows=4, encoding='latin', header=[0])
    dfHeaders = dfLog.iloc[:1]
    dfLog = dfLog.iloc[1:]

    logging.info(dfLog.columns)

    # convert date time
    dfLog['DateTime'] = pd.to_datetime(dfLog['Datum'].astype(str) + ' ' + dfLog['Zeit'].astype(str), format='%d.%m.%y %H:%M:%S', errors='coerce')
    dfLog.drop(labels=['Datum', 'Zeit'], axis=1, inplace=True)
    dfHeaders.drop(labels=['Datum', 'Zeit'], axis=1, inplace=True)
    dfLog['DateTime'] = (dfLog['DateTime'] - pd.Timestamp("1970-01-01")) // pd.Timedelta('1s')

    # convert numeric columns and scale them columns
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

    # set index to DateTime column
    dfLog = dfLog.set_index(keys=['DateTime'])

    # give meaningful columns names
    colNaming = {
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
    # filter colNaming to only include available columns
    colNaming = { k: v for k, v in colNaming.items() if k in dfLog.columns }
    dfLog = dfLog.rename(colNaming, axis=1)
    colUnits = renameDictKeys(colUnits, colNaming)
    
    # drop all unmapped columns
    acceptedColumnList = list( colNaming.values() )
    dfLogTarget = dfLog[acceptedColumnList].copy()
    colUnitsTarget = { k: v for k, v in colUnits.items() if k in acceptedColumnList }


    dfLogTarget.head()
    # calculate electrical heating power
    dfLogTarget['heatpumpResistanceHeatingLevel'] = (dfLogTarget['heatpumpResistanceHeating1'] * 1. + dfLogTarget['heatpumpResistanceHeating2'] * 2.) / 100
    dfLogTarget['heatpumpResistanceHeatingPower'] = dfLogTarget['heatpumpResistanceHeatingLevel'] * _electricHeatingRodTotalPower / _electricHeatingRodPowerSteps
    colUnitsTarget['heatpumpResistanceHeatingPower'] = 'kW'
    
    colDrops = [
        'heatpumpResistanceHeatingLevel',
        'heatpumpResistanceHeating1',
        'heatpumpResistanceHeating2',
#        'S5', 'S6', 'S7', 'S8', 'S17',
#        'circulation',
#        'flowTemperatureCircuit2',
#        'flowTemperatureCircuit3',
#        'heatingPumpCircuit2',
#        'heatingPumpCircuit3',
#        'mixerOpenCircuit2',
#        'mixerOpenCircuit3',
#        'mixerClosedCircuit2',
#        'mixerClosedCircuit3',
#        'PV-Pakt',
#        'PV_Prest'
    ]
    dfLogTarget.drop(labels=colDrops, axis=1, inplace=True)
    colUnitsTarget = { key: val for key, val in colUnitsTarget.items() if key not in colDrops }
    
    if len(colUnitsTarget) != len(dfLogTarget.columns):
        logging.error("column in units (%i) and data frame (%i) do not match" % ( len(colUnitsTarget), len(dfLogTarget.columns), ))
        logging.debug({key for key in dfLogTarget.columns if key not in colUnitsTarget})
    
    return dfLogTarget, colUnitsTarget

def insertMeasurement(dbCursor, timestamp, deviceName, sensorName, value):
    logging.debug("CALL \"data\".\"pInsertMeasurement\"(%s,%s,%s,%s);" % (int(timestamp),deviceName,sensorName,value,))
    dbCursor.execute( \
        "CALL \"data\".\"pInsertMeasurement\"(%s,%s,%s,%s);" \
        ,(int(timestamp),deviceName,sensorName,value,) \
    )

def getLastTimestampInDb(dbCursor):
    dbCursor.execute("SELECT * FROM \"data\".\"vGetLastTimestamp\";")
    return cur.fetchone()[0]

def getLastDeviceTimestampInDb(dbCursor):
    #dbCursor.execute("SELECT * FROM \"data\".\"vGetLastTimestamp\";")
    dbCursor.execute("SELECT * FROM \"data\".\"fnGetLatestMeasurementOfDevice\"('{}')".format(dbDeviceName))
    return cur.fetchone()[0]

# check if potentially newer data exists in heat log
def getLogfilesList(reverseSorted=False):
    response = requests.get(basePath + "/dir.txt", auth=HTTPDigestAuth(username, password))
    response.raise_for_status()
    return sorted(response.text.splitlines(), reverse=reverseSorted)

def getLogfile(fileName):
    response = requests.get(basePath + "/SC3_MA7/log/" + fileName, auth=HTTPDigestAuth(username, password))
    response.raise_for_status()
    return StringIO(response.text)

def extractMaxEndDateFromLogFiles(fileName):
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

### retrieve available log files that might be of interest
logfiles = getLogfilesList()
latestMeasurementOnDb = getLastDeviceTimestampInDb(cur)

logging.info("Latest measurement for device on DB from {}".format(latestMeasurementOnDb))

###########################
dfLog = None
logUnits = None

for fileName in logfiles:
    logMaxDate = extractMaxEndDateFromLogFiles(fileName)
    if logMaxDate < latestMeasurementOnDb:
        logging.info("Data from {} already imported --> Skipped".format(fileName))
        continue
        
    logging.info("Importing {}".format(fileName))
    try:
        if dfLog is None:
            dfLog, logUnits = parseSolvisLogToPandas(getLogfile(fileName))
        else:
            dfLogTmp, logUnits = parseSolvisLogToPandas(getLogfile(fileName))
            dfLog = dfLog.append(dfLogTmp)
    except SolvisInconsistentCsvError:
        logging.warning("Skipping {} because of inconsistent data: Number of columns vary without valid data description.".format(fileName))

## insert data into database
iRow = 0
iSavedToDb = 0
lastDbImportTime = latestMeasurementOnDb #getLastTimestampInDb(cur)
for timestamp, row in dfLog.iterrows():
    if iRow % 2000 == 0:
        logging.info("%i of %i --> %.1f %%" % (iRow, dfLog.shape[0], 100. * float(iRow) / float(dfLog.shape[0]), ) )
    iRow += 1
    thisTime = datetime.utcfromtimestamp(timestamp)
    if thisTime <= lastDbImportTime:
        # do not try to re-import already imported data. Database will reject it and script fails
#        logging.debug("Already imported dataset: lastDbImportTime={}, thisTime={}".format(lastDbImportTime, thisTime) )
        continue
    
    for name, value in row.iteritems():
        valueUnit = logUnits[name]
        if name in ("heatpumpThermalPower", "heatpumpElectricPower") and value > 0.1:
            print("[{}] {} --> {} {}".format(thisTime, name, value, logUnits[name]))
        insertMeasurement(cur, int(timestamp), dbDeviceName, name, value)
        conn.commit()
        iSavedToDb += 1

# close database connection
conn.commit()
conn.close()

# output status
logging.info("Processed {} time points to database. {} were saved.".format(iRow, iSavedToDb))

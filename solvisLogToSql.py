#!/usr/bin/env python3
import click
import logging
import json
from model.configuration import Configuration
from accessors.postgresDatabaseAccessor import PostgresDatabaseAccessor
from accessors.solvisAccessor import SolvisAccessor
from businesslogic.pushNewSolvisLogsToDatabase import PushNewSolvisLogsToDatabase

__version="0.2"
__name="solvisLogToSql"

def setupLogging(verbosity):
    # format
    loggerParameters = {
        'format': '[%(asctime)s] [%(levelname)s] [%(name)s] (%(module)s %(funcName)s lno %(lineno)d): %(message)s'
    }

    # set log level
    if not verbosity:
        loggerParameters['level'] = logging.ERROR
    elif verbosity == 0:
        loggerParameters['level'] = logging.ERROR
    elif verbosity == 1:
        loggerParameters['level'] = logging.WARNING
    elif verbosity == 2:
        loggerParameters['level'] = logging.INFO
    elif verbosity >= 2:
        loggerParameters['level'] = logging.DEBUG
    else:
        raise ValueError("Invalid log level")

    logging.basicConfig(**loggerParameters)

def dumpConfigurationToLog(config: Configuration):
    logging.debug("Solvis: http://{}:{}@{}:{}".format(config.solvis.user, 'xxx', config.solvis.host, config.solvis.port))
    logging.debug("Sql: host={}, user={}, pass={}, database={}, deviceName='{}'".format(config.sql.host, config.sql.user, "xxx", config.sql.database, config.sql.deviceName))

@click.command()
@click.option('--config', default="solvisLogToSql.conf.json", help="Path to configuration file containing secrets for connecting to Solvis and SQL server")
@click.option('--verbosity', type=int, default=2, help="0: error, 1: warning, 2: info, 3: debug")
def main(config, verbosity):
    setupLogging(verbosity)

    logging.info("{} v{}".format(__name, __version))

    with open(config, 'r', encoding='utf-8') as configFile:
        config = Configuration.fromJson(**json.load(configFile))
        dumpConfigurationToLog(config)

    solvis = SolvisAccessor(config.solvis)
    with PostgresDatabaseAccessor(config.sql) as db:
        businessLogic = PushNewSolvisLogsToDatabase(db, solvis)
        businessLogic.sync()

if __name__ == "__main__":
    main()
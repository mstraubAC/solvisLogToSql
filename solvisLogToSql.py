#!/usr/bin/env python3
import click
import logging
import json
from model.configuration import Configuration

__version="0.2"
__name="solvisLogToSql"

def setupLogging(verbosity):
    # set log level
    if not verbosity:
        logging.basicConfig(level=logging.ERROR)
    elif verbosity == 0:
        logging.basicConfig(level=logging.ERROR)
    elif verbosity == 1:
        logging.basicConfig(level=logging.WARNING)
    elif verbosity == 2:
        logging.basicConfig(level=logging.INFO)
    elif verbosity >= 2:
        logging.basicConfig(level=logging.DEBUG)
    else:
        logging.critical("Invalid log level")

def dumpConfigurationToLog(config: Configuration):
    logging.debug("Solvis: http://{}:{}@{}:{}".format(config.solvis.user, 'xxx', config.solvis.host, config.solvis.port))
    logging.debug("Sql: host={}, user={}, pass={}, database={}, deviceName='{}'".format(config.sql.host, config.sql.user, "xxx", config.sql.database, config.sql.deviceName))

@click.command()
@click.option('--config', default="solvisLogToSql.conf.json", help="Path to configuration file containing secrets for connecting to Solvis and SQL server")
@click.option('--verbosity', type=int, default=3, help="0: error, 1: warning, 2: info, 3: debug")
def main(config, verbosity):
    setupLogging(verbosity)

    logging.info("{} v{}".format(__name, __version))

    with open(config, 'r', encoding='utf-8') as configFile:
        config = Configuration.fromJson(**json.load(configFile))
        dumpConfigurationToLog(config)


if __name__ == "__main__":
    main()
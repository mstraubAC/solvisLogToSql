# solvisLogToSQL

## Project description
The tool downloads the CSV logfiles from a [Solvis](https://solvis.de) SC3 heat control system and store relevant information into a SQL database to enable analysis of energy consumption, usage, etc.pp. With each run of the software only the newest data is appended to the database.

Currently, only support for PostgreSQL is implemented.

## How to use
### Install database server
Follow the way of your environment to install PostgreSQL, e.g. ``apt install postgresql``.

To install the database schema provided in the ``sql`` directory, you must first create two users that only have the right to login to the SQL server. The exact permissions are granted by the provided SQL script:
- heizung_ingress
  - Used by the solvisLogToSQL too to insert the CSV data into the database. 
- smarthome_datascience

> TODO: Add information about setting up the database.

### Install and use solvisLogToSQL
After cloning this repository, you must create a json configuration file that defines howto reach your Solvis SC3 as well as your database. Here, you find an example that you can adapt to your environment and save it as myConfiguration.json:
```json
{
        "solvis": {
                "host": "solvis.local",
                "port": 80,
                "user": "Solvis",
                "pass": "a-secure-password",
                "cachedir": "/var/cache/solvisLogToSql/csvFiles",
                "alwaysFetchLastTwoMeasurementFiles": true
        },
        "sql": {
                "host": "sql.local",
                "user": "heating_ingress",
                "pass": "another-secure-password",
                "database": "smarthome",
                "dbDeviceName": "Solvis Lea 11kW"
        }
}
```
You must provide a directory where the tool can cache the CSV files. The user executing the tool must have the right permissions to read and write from this directory. You also must adjust the ``dbDeviceName`` to your setup.

Now, you can execute the tool from within the cloned repository
```shell
~/solvisLogToSql % ./solvisLogToSql.py --config myConfiguration.json
```
All not cached data is fetched from Solvis SC3 web head-end and afterwards all new data, i.e. data that is younger than the data in the database, is inserted into the database.


# To-Dos
- Extract the Solvis Sensor name to database name mapping to config file
- Create and implement SQL security concept for both users
- Explain datbase setup in more detail
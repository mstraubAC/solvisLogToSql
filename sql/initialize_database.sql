-- DROP SCHEMA "data";

CREATE SCHEMA "data" AUTHORIZATION postgres;

-- DROP TYPE "data".device_id_seq;

CREATE TYPE "data".device_id_seq AS (
	"last_value" int8,
	log_cnt int8,
	is_called bool);

-- DROP TYPE "data".devices;

CREATE TYPE "data".devices AS (
	deviceid int8,
	locationid int8,
	"name" varchar(120),
	devicetypeid int8);

-- DROP TYPE "data".devicetypes;

CREATE TYPE "data".devicetypes AS (
	devicetypeid bigserial,
	"name" varchar(120));

-- DROP TYPE "data".devicetypes_devicetypeid_seq;

CREATE TYPE "data".devicetypes_devicetypeid_seq AS (
	"last_value" int8,
	log_cnt int8,
	is_called bool);

-- DROP TYPE "data".locations;

CREATE TYPE "data".locations AS (
	id int8,
	"name" varchar(120));

-- DROP TYPE "data".locations_id_seq;

CREATE TYPE "data".locations_id_seq AS (
	"last_value" int8,
	log_cnt int8,
	is_called bool);

-- DROP TYPE "data".sensors;

CREATE TYPE "data".sensors AS (
	deviceid int8,
	"name" varchar(120),
	sensorid bigserial,
	unit varchar(20));

-- DROP TYPE "data".sensors_sensorid_seq;

CREATE TYPE "data".sensors_sensorid_seq AS (
	"last_value" int8,
	log_cnt int8,
	is_called bool);

-- DROP TYPE "data".timeseries;

CREATE TYPE "data".timeseries AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_mstrau2;

CREATE TYPE "data".timeseries_mstrau2 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_old;

CREATE TYPE "data".timeseries_old AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2021;

CREATE TYPE "data".timeseries_y2021 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2021m01;

CREATE TYPE "data".timeseries_y2021m01 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m02;

CREATE TYPE "data".timeseries_y2021m02 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m03;

CREATE TYPE "data".timeseries_y2021m03 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m04;

CREATE TYPE "data".timeseries_y2021m04 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m05;

CREATE TYPE "data".timeseries_y2021m05 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m06;

CREATE TYPE "data".timeseries_y2021m06 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m07;

CREATE TYPE "data".timeseries_y2021m07 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m08;

CREATE TYPE "data".timeseries_y2021m08 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m09;

CREATE TYPE "data".timeseries_y2021m09 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m10;

CREATE TYPE "data".timeseries_y2021m10 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m11;

CREATE TYPE "data".timeseries_y2021m11 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2021m12;

CREATE TYPE "data".timeseries_y2021m12 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022;

CREATE TYPE "data".timeseries_y2022 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2022m01;

CREATE TYPE "data".timeseries_y2022m01 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m02;

CREATE TYPE "data".timeseries_y2022m02 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m03;

CREATE TYPE "data".timeseries_y2022m03 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m04;

CREATE TYPE "data".timeseries_y2022m04 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m05;

CREATE TYPE "data".timeseries_y2022m05 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m06;

CREATE TYPE "data".timeseries_y2022m06 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m07;

CREATE TYPE "data".timeseries_y2022m07 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m08;

CREATE TYPE "data".timeseries_y2022m08 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m09;

CREATE TYPE "data".timeseries_y2022m09 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m10;

CREATE TYPE "data".timeseries_y2022m10 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m11;

CREATE TYPE "data".timeseries_y2022m11 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2022m12;

CREATE TYPE "data".timeseries_y2022m12 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023;

CREATE TYPE "data".timeseries_y2023 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2023m01;

CREATE TYPE "data".timeseries_y2023m01 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m02;

CREATE TYPE "data".timeseries_y2023m02 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m03;

CREATE TYPE "data".timeseries_y2023m03 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m04;

CREATE TYPE "data".timeseries_y2023m04 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m05;

CREATE TYPE "data".timeseries_y2023m05 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m06;

CREATE TYPE "data".timeseries_y2023m06 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m07;

CREATE TYPE "data".timeseries_y2023m07 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m08;

CREATE TYPE "data".timeseries_y2023m08 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m09;

CREATE TYPE "data".timeseries_y2023m09 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m10;

CREATE TYPE "data".timeseries_y2023m10 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m11;

CREATE TYPE "data".timeseries_y2023m11 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2023m12;

CREATE TYPE "data".timeseries_y2023m12 AS (
	logtimestamp timestamp,
	logdate date,
	sensorid int8,
	value float8,
	createdate timestamp,
	updatedate timestamp);

-- DROP TYPE "data".timeseries_y2024;

CREATE TYPE "data".timeseries_y2024 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2025;

CREATE TYPE "data".timeseries_y2025 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2026;

CREATE TYPE "data".timeseries_y2026 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2027;

CREATE TYPE "data".timeseries_y2027 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2028;

CREATE TYPE "data".timeseries_y2028 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2029;

CREATE TYPE "data".timeseries_y2029 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2030;

CREATE TYPE "data".timeseries_y2030 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2031;

CREATE TYPE "data".timeseries_y2031 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2032;

CREATE TYPE "data".timeseries_y2032 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2033;

CREATE TYPE "data".timeseries_y2033 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data".timeseries_y2034;

CREATE TYPE "data".timeseries_y2034 AS (
	logtimestamp timestamp,
	logdate date,
	sensorname varchar(120),
	numericvalue float8,
	unit varchar(20),
	createdate timestamp,
	updatedate timestamp,
	deviceid int8);

-- DROP TYPE "data"."vAnalyzePowerConsumptionHeatpump";

CREATE TYPE "data"."vAnalyzePowerConsumptionHeatpump" AS (
	logtimestamp timestamp,
	"fnCoefficientOfPower" float8,
	totalheatingpower float8,
	totalelectricpower float8,
	heatpumpthermalpower float8,
	heatpumpelectricpower float8,
	heatpumpresistanceheatingpower float8,
	outsidetemperature float8,
	flowtemperaturecircuit1 float8);

-- DROP TYPE "data"."vAnalyzePowerConsumptionHeatpumpDaily";

CREATE TYPE "data"."vAnalyzePowerConsumptionHeatpumpDaily" AS (
	logdate date,
	tagesarbeitszahlinclcontrolandpumps numeric,
	tagesarbeitszahlsolvis numeric,
	tagesarbeitszahlfullelectricmeasurement numeric,
	totalelectricenergy numeric,
	totalelectricenergyfullmeasurement numeric,
	totalelectricenergysolvismeasurement numeric,
	totalheatingenergy numeric,
	heatpumpthermalpowerenergy numeric,
	heatpumpresistanceheatingenergy numeric,
	outsidetemperatureavg numeric,
	flowtemperaturecircuit1avg numeric);

-- DROP TYPE "data"."vAnalyzePowerConsumptionHeatpumpMonthly";

CREATE TYPE "data"."vAnalyzePowerConsumptionHeatpumpMonthly" AS (
	"year" float8,
	"month" float8,
	totalheatingenergy numeric,
	totalelectricenergy numeric,
	monatsarbeitszahl numeric,
	mintagesarbeitszahl numeric,
	maxtagesarbeitszahl numeric,
	totalelectricenergyfullmeasurement numeric,
	totalelectricenergysolvismeasurement numeric,
	totalelectricenergydelta numeric,
	monatsarbeitszahlfullelectricmeasurement numeric,
	monatsarbeitszahlsolviselectricmeasurement numeric);

-- DROP TYPE "data"."vAnalyzePowerConsumptionHeatpumpYearly";

CREATE TYPE "data"."vAnalyzePowerConsumptionHeatpumpYearly" AS (
	"year" float8,
	totalheatingenergy numeric,
	totalelectricenergy numeric,
	totalelectricenegyfullmeasurement numeric,
	totalelectricenergysolvismeasurement numeric,
	totelelectricenergydelta numeric,
	jahresarbeitszahl numeric,
	jahresarbeitszahlmanufacturer numeric);

-- DROP TYPE "data"."vGetLastTimestamp";

CREATE TYPE "data"."vGetLastTimestamp" AS (
	lasttimestamp timestamp);

-- DROP TYPE "data"."vGetTimeSeries";

CREATE TYPE "data"."vGetTimeSeries" AS (
	logtimestamp timestamp,
	devicename varchar(120),
	locationname varchar(120),
	devicetypename varchar(120),
	sensorname varchar(120),
	value float8,
	unit varchar(20));

-- DROP TYPE "data"."_devices";

CREATE TYPE "data"."_devices" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".devices,
	DELIMITER = ',');

-- DROP TYPE "data"."_devicetypes";

CREATE TYPE "data"."_devicetypes" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".devicetypes,
	DELIMITER = ',');

-- DROP TYPE "data"."_locations";

CREATE TYPE "data"."_locations" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".locations,
	DELIMITER = ',');

-- DROP TYPE "data"."_sensors";

CREATE TYPE "data"."_sensors" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".sensors,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries";

CREATE TYPE "data"."_timeseries" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_mstrau2";

CREATE TYPE "data"."_timeseries_mstrau2" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_mstrau2,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_old";

CREATE TYPE "data"."_timeseries_old" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_old,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021";

CREATE TYPE "data"."_timeseries_y2021" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m01";

CREATE TYPE "data"."_timeseries_y2021m01" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m01,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m02";

CREATE TYPE "data"."_timeseries_y2021m02" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m02,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m03";

CREATE TYPE "data"."_timeseries_y2021m03" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m03,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m04";

CREATE TYPE "data"."_timeseries_y2021m04" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m04,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m05";

CREATE TYPE "data"."_timeseries_y2021m05" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m05,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m06";

CREATE TYPE "data"."_timeseries_y2021m06" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m06,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m07";

CREATE TYPE "data"."_timeseries_y2021m07" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m07,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m08";

CREATE TYPE "data"."_timeseries_y2021m08" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m08,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m09";

CREATE TYPE "data"."_timeseries_y2021m09" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m09,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m10";

CREATE TYPE "data"."_timeseries_y2021m10" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m10,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m11";

CREATE TYPE "data"."_timeseries_y2021m11" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m11,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2021m12";

CREATE TYPE "data"."_timeseries_y2021m12" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2021m12,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022";

CREATE TYPE "data"."_timeseries_y2022" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m01";

CREATE TYPE "data"."_timeseries_y2022m01" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m01,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m02";

CREATE TYPE "data"."_timeseries_y2022m02" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m02,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m03";

CREATE TYPE "data"."_timeseries_y2022m03" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m03,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m04";

CREATE TYPE "data"."_timeseries_y2022m04" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m04,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m05";

CREATE TYPE "data"."_timeseries_y2022m05" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m05,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m06";

CREATE TYPE "data"."_timeseries_y2022m06" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m06,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m07";

CREATE TYPE "data"."_timeseries_y2022m07" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m07,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m08";

CREATE TYPE "data"."_timeseries_y2022m08" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m08,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m09";

CREATE TYPE "data"."_timeseries_y2022m09" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m09,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m10";

CREATE TYPE "data"."_timeseries_y2022m10" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m10,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m11";

CREATE TYPE "data"."_timeseries_y2022m11" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m11,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2022m12";

CREATE TYPE "data"."_timeseries_y2022m12" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2022m12,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023";

CREATE TYPE "data"."_timeseries_y2023" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m01";

CREATE TYPE "data"."_timeseries_y2023m01" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m01,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m02";

CREATE TYPE "data"."_timeseries_y2023m02" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m02,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m03";

CREATE TYPE "data"."_timeseries_y2023m03" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m03,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m04";

CREATE TYPE "data"."_timeseries_y2023m04" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m04,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m05";

CREATE TYPE "data"."_timeseries_y2023m05" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m05,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m06";

CREATE TYPE "data"."_timeseries_y2023m06" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m06,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m07";

CREATE TYPE "data"."_timeseries_y2023m07" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m07,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m08";

CREATE TYPE "data"."_timeseries_y2023m08" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m08,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m09";

CREATE TYPE "data"."_timeseries_y2023m09" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m09,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m10";

CREATE TYPE "data"."_timeseries_y2023m10" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m10,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m11";

CREATE TYPE "data"."_timeseries_y2023m11" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m11,
	DELIMITER = ',');

-- DROP TYPE "data"."_timeseries_y2023m12";

CREATE TYPE "data"."_timeseries_y2023m12" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data".timeseries_y2023m12,
	DELIMITER = ',');

-- DROP TYPE "data"."_vAnalyzePowerConsumptionHeatpump";

CREATE TYPE "data"."_vAnalyzePowerConsumptionHeatpump" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data"."vAnalyzePowerConsumptionHeatpump",
	DELIMITER = ',');

-- DROP TYPE "data"."_vAnalyzePowerConsumptionHeatpumpDaily";

CREATE TYPE "data"."_vAnalyzePowerConsumptionHeatpumpDaily" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data"."vAnalyzePowerConsumptionHeatpumpDaily",
	DELIMITER = ',');

-- DROP TYPE "data"."_vAnalyzePowerConsumptionHeatpumpMonthly";

CREATE TYPE "data"."_vAnalyzePowerConsumptionHeatpumpMonthly" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data"."vAnalyzePowerConsumptionHeatpumpMonthly",
	DELIMITER = ',');

-- DROP TYPE "data"."_vAnalyzePowerConsumptionHeatpumpYearly";

CREATE TYPE "data"."_vAnalyzePowerConsumptionHeatpumpYearly" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data"."vAnalyzePowerConsumptionHeatpumpYearly",
	DELIMITER = ',');

-- DROP TYPE "data"."_vGetLastTimestamp";

CREATE TYPE "data"."_vGetLastTimestamp" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data"."vGetLastTimestamp",
	DELIMITER = ',');

-- DROP TYPE "data"."_vGetTimeSeries";

CREATE TYPE "data"."_vGetTimeSeries" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = "data"."vGetTimeSeries",
	DELIMITER = ',');

-- DROP SEQUENCE "data".device_id_seq;

CREATE SEQUENCE "data".device_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE "data".device_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE "data".device_id_seq TO postgres;

-- DROP SEQUENCE "data".devicetypes_devicetypeid_seq;

CREATE SEQUENCE "data".devicetypes_devicetypeid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE "data".devicetypes_devicetypeid_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE "data".devicetypes_devicetypeid_seq TO postgres;

-- DROP SEQUENCE "data".locations_id_seq;

CREATE SEQUENCE "data".locations_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE "data".locations_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE "data".locations_id_seq TO postgres;

-- DROP SEQUENCE "data".sensors_sensorid_seq;

CREATE SEQUENCE "data".sensors_sensorid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE "data".sensors_sensorid_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE "data".sensors_sensorid_seq TO postgres;
-- "data".devicetypes definition

-- Drop table

-- DROP TABLE "data".devicetypes;

CREATE TABLE "data".devicetypes (
	devicetypeid bigserial NOT NULL,
	"name" varchar(120) NOT NULL,
	CONSTRAINT devicetypes_pk PRIMARY KEY (devicetypeid)
);

-- Permissions

ALTER TABLE "data".devicetypes OWNER TO postgres;
GRANT ALL ON TABLE "data".devicetypes TO postgres;
GRANT SELECT ON TABLE "data".devicetypes TO smarthome_datascience;


-- "data".locations definition

-- Drop table

-- DROP TABLE "data".locations;

CREATE TABLE "data".locations (
	id int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar(120) NULL,
	CONSTRAINT locations_pk PRIMARY KEY (id),
	CONSTRAINT locations_un UNIQUE (id)
);

-- Permissions

ALTER TABLE "data".locations OWNER TO postgres;
GRANT ALL ON TABLE "data".locations TO postgres;
GRANT SELECT ON TABLE "data".locations TO smarthome_datascience;


-- "data".timeseries_mstrau2 definition

-- Drop table

-- DROP TABLE "data".timeseries_mstrau2;

CREATE TABLE "data".timeseries_mstrau2 (
	logtimestamp timestamp NOT NULL,
	logdate date NOT NULL,
	sensorid int8 NOT NULL,
	value float8 NULL,
	createdate timestamp NOT NULL,
	updatedate timestamp NOT NULL
);
CREATE INDEX timeseries_sensorid_idx_1 ON data.timeseries_mstrau2 USING btree (sensorid);
CREATE UNIQUE INDEX timeseries_timestamp_logdate_sensorid_idx_1 ON data.timeseries_mstrau2 USING btree (logtimestamp, logdate, sensorid);

-- Permissions

ALTER TABLE "data".timeseries_mstrau2 OWNER TO postgres;
GRANT ALL ON TABLE "data".timeseries_mstrau2 TO postgres;
GRANT SELECT ON TABLE "data".timeseries_mstrau2 TO smarthome_datascience;


-- "data".timeseries_old definition

-- Drop table

-- DROP TABLE "data".timeseries_old;

CREATE TABLE "data".timeseries_old (
	logtimestamp timestamp NOT NULL,
	logdate date NOT NULL,
	sensorname varchar(120) NOT NULL,
	numericvalue float8 NULL,
	unit varchar(20) NULL,
	createdate timestamp NOT NULL,
	updatedate timestamp NOT NULL,
	deviceid int8 NULL
)
PARTITION BY RANGE (logdate);
CREATE UNIQUE INDEX timeseries_timestamp_idx ON ONLY data.timeseries_old USING btree (logtimestamp, logdate, sensorname);

-- Permissions

ALTER TABLE "data".timeseries_old OWNER TO postgres;
GRANT ALL ON TABLE "data".timeseries_old TO postgres;
GRANT SELECT ON TABLE "data".timeseries_old TO smarthome_datascience;


-- "data".devices definition

-- Drop table

-- DROP TABLE "data".devices;

CREATE TABLE "data".devices (
	deviceid int8 NOT NULL GENERATED ALWAYS AS IDENTITY,
	locationid int8 NOT NULL,
	"name" varchar(120) NOT NULL,
	devicetypeid int8 NOT NULL,
	CONSTRAINT devices_pk PRIMARY KEY (deviceid),
	CONSTRAINT devices_un UNIQUE (name),
	CONSTRAINT device_fk FOREIGN KEY (locationid) REFERENCES "data".locations(id),
	CONSTRAINT devices_fk FOREIGN KEY (devicetypeid) REFERENCES "data".devicetypes(devicetypeid)
);
CREATE INDEX device_id_idx ON data.devices USING btree (deviceid);
CREATE INDEX device_name_idx ON data.devices USING btree (name);

-- Permissions

ALTER TABLE "data".devices OWNER TO postgres;
GRANT ALL ON TABLE "data".devices TO postgres;
GRANT SELECT ON TABLE "data".devices TO smarthome_datascience;


-- "data".sensors definition

-- Drop table

-- DROP TABLE "data".sensors;

CREATE TABLE "data".sensors (
	deviceid int8 NOT NULL,
	"name" varchar(120) NOT NULL,
	sensorid bigserial NOT NULL,
	unit varchar(20) NULL,
	CONSTRAINT sensors_pk PRIMARY KEY (sensorid),
	CONSTRAINT sensors_un UNIQUE (name, deviceid),
	CONSTRAINT sensors_fk FOREIGN KEY (deviceid) REFERENCES "data".devices(deviceid)
);
CREATE INDEX sensors_name_idx ON data.sensors USING btree (name);
CREATE INDEX sensors_sensorid_idx ON data.sensors USING btree (sensorid);

-- Permissions

ALTER TABLE "data".sensors OWNER TO postgres;
GRANT ALL ON TABLE "data".sensors TO postgres;
GRANT SELECT ON TABLE "data".sensors TO smarthome_datascience;


-- "data".timeseries definition

-- Drop table

-- DROP TABLE "data".timeseries;

CREATE TABLE "data".timeseries (
	logtimestamp timestamp NOT NULL,
	logdate date NOT NULL,
	sensorid int8 NOT NULL,
	value float8 NULL,
	createdate timestamp NOT NULL,
	updatedate timestamp NOT NULL,
	CONSTRAINT sensors_fk FOREIGN KEY (sensorid) REFERENCES "data".sensors(sensorid)
)
PARTITION BY RANGE (logdate);
CREATE INDEX timeseries_sensorid_idx ON ONLY data.timeseries USING btree (sensorid);
CREATE UNIQUE INDEX timeseries_timestamp_logdate_sensorid_idx ON ONLY data.timeseries USING btree (logtimestamp, logdate, sensorid);

-- Permissions

ALTER TABLE "data".timeseries OWNER TO postgres;
GRANT ALL ON TABLE "data".timeseries TO postgres;
GRANT SELECT ON TABLE "data".timeseries TO smarthome_datascience;


-- "data".timeseries_y2021 definition

CREATE TABLE "data".timeseries_y2021 PARTITION OF  FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');


-- "data".timeseries_y2021m01 definition

CREATE TABLE "data".timeseries_y2021m01 PARTITION OF  FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');


-- "data".timeseries_y2021m02 definition

CREATE TABLE "data".timeseries_y2021m02 PARTITION OF  FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');


-- "data".timeseries_y2021m03 definition

CREATE TABLE "data".timeseries_y2021m03 PARTITION OF  FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');


-- "data".timeseries_y2021m04 definition

CREATE TABLE "data".timeseries_y2021m04 PARTITION OF  FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');


-- "data".timeseries_y2021m05 definition

CREATE TABLE "data".timeseries_y2021m05 PARTITION OF  FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');


-- "data".timeseries_y2021m06 definition

CREATE TABLE "data".timeseries_y2021m06 PARTITION OF  FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');


-- "data".timeseries_y2021m07 definition

CREATE TABLE "data".timeseries_y2021m07 PARTITION OF  FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');


-- "data".timeseries_y2021m08 definition

CREATE TABLE "data".timeseries_y2021m08 PARTITION OF  FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');


-- "data".timeseries_y2021m09 definition

CREATE TABLE "data".timeseries_y2021m09 PARTITION OF  FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');


-- "data".timeseries_y2021m10 definition

CREATE TABLE "data".timeseries_y2021m10 PARTITION OF  FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');


-- "data".timeseries_y2021m11 definition

CREATE TABLE "data".timeseries_y2021m11 PARTITION OF  FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');


-- "data".timeseries_y2021m12 definition

CREATE TABLE "data".timeseries_y2021m12 PARTITION OF  FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');


-- "data".timeseries_y2022 definition

CREATE TABLE "data".timeseries_y2022 PARTITION OF  FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');


-- "data".timeseries_y2022m01 definition

CREATE TABLE "data".timeseries_y2022m01 PARTITION OF  FOR VALUES FROM ('2022-01-01') TO ('2022-02-01');


-- "data".timeseries_y2022m02 definition

CREATE TABLE "data".timeseries_y2022m02 PARTITION OF  FOR VALUES FROM ('2022-02-01') TO ('2022-03-01');


-- "data".timeseries_y2022m03 definition

CREATE TABLE "data".timeseries_y2022m03 PARTITION OF  FOR VALUES FROM ('2022-03-01') TO ('2022-04-01');


-- "data".timeseries_y2022m04 definition

CREATE TABLE "data".timeseries_y2022m04 PARTITION OF  FOR VALUES FROM ('2022-04-01') TO ('2022-05-01');


-- "data".timeseries_y2022m05 definition

CREATE TABLE "data".timeseries_y2022m05 PARTITION OF  FOR VALUES FROM ('2022-05-01') TO ('2022-06-01');


-- "data".timeseries_y2022m06 definition

CREATE TABLE "data".timeseries_y2022m06 PARTITION OF  FOR VALUES FROM ('2022-06-01') TO ('2022-07-01');


-- "data".timeseries_y2022m07 definition

CREATE TABLE "data".timeseries_y2022m07 PARTITION OF  FOR VALUES FROM ('2022-07-01') TO ('2022-08-01');


-- "data".timeseries_y2022m08 definition

CREATE TABLE "data".timeseries_y2022m08 PARTITION OF  FOR VALUES FROM ('2022-08-01') TO ('2022-09-01');


-- "data".timeseries_y2022m09 definition

CREATE TABLE "data".timeseries_y2022m09 PARTITION OF  FOR VALUES FROM ('2022-09-01') TO ('2022-10-01');


-- "data".timeseries_y2022m10 definition

CREATE TABLE "data".timeseries_y2022m10 PARTITION OF  FOR VALUES FROM ('2022-10-01') TO ('2022-11-01');


-- "data".timeseries_y2022m11 definition

CREATE TABLE "data".timeseries_y2022m11 PARTITION OF  FOR VALUES FROM ('2022-11-01') TO ('2022-12-01');


-- "data".timeseries_y2022m12 definition

CREATE TABLE "data".timeseries_y2022m12 PARTITION OF  FOR VALUES FROM ('2022-12-01') TO ('2023-01-01');


-- "data".timeseries_y2023 definition

CREATE TABLE "data".timeseries_y2023 PARTITION OF  FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');


-- "data".timeseries_y2023m01 definition

CREATE TABLE "data".timeseries_y2023m01 PARTITION OF  FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');


-- "data".timeseries_y2023m02 definition

CREATE TABLE "data".timeseries_y2023m02 PARTITION OF  FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');


-- "data".timeseries_y2023m03 definition

CREATE TABLE "data".timeseries_y2023m03 PARTITION OF  FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');


-- "data".timeseries_y2023m04 definition

CREATE TABLE "data".timeseries_y2023m04 PARTITION OF  FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');


-- "data".timeseries_y2023m05 definition

CREATE TABLE "data".timeseries_y2023m05 PARTITION OF  FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');


-- "data".timeseries_y2023m06 definition

CREATE TABLE "data".timeseries_y2023m06 PARTITION OF  FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');


-- "data".timeseries_y2023m07 definition

CREATE TABLE "data".timeseries_y2023m07 PARTITION OF  FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');


-- "data".timeseries_y2023m08 definition

CREATE TABLE "data".timeseries_y2023m08 PARTITION OF  FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');


-- "data".timeseries_y2023m09 definition

CREATE TABLE "data".timeseries_y2023m09 PARTITION OF  FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');


-- "data".timeseries_y2023m10 definition

CREATE TABLE "data".timeseries_y2023m10 PARTITION OF  FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');


-- "data".timeseries_y2023m11 definition

CREATE TABLE "data".timeseries_y2023m11 PARTITION OF  FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');


-- "data".timeseries_y2023m12 definition

CREATE TABLE "data".timeseries_y2023m12 PARTITION OF  FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');

-- "data"."vAnalyzePowerConsumptionHeatpump" source

CREATE OR REPLACE VIEW "data"."vAnalyzePowerConsumptionHeatpump"
AS SELECT ep.logtimestamp,
    data."fnCoefficientOfPower"(tp.value + rp.value, rp.value + ep.value) AS "fnCoefficientOfPower",
    tp.value + rp.value AS totalheatingpower,
    rp.value + ep.value AS totalelectricpower,
    tp.value AS heatpumpthermalpower,
    ep.value AS heatpumpelectricpower,
    rp.value AS heatpumpresistanceheatingpower,
    ot.value AS outsidetemperature,
    ftc1.value AS flowtemperaturecircuit1
   FROM data.timeseries ep
     JOIN data.timeseries tp ON ep.logdate = tp.logdate AND ep.logtimestamp = tp.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND tp.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpThermalPower'::character varying)
     JOIN data.timeseries rp ON ep.logdate = rp.logdate AND ep.logtimestamp = rp.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND rp.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpResistanceHeatingPower'::character varying)
     JOIN data.timeseries ot ON ep.logdate = ot.logdate AND ep.logtimestamp = ot.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND ot.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'outsideTemperature'::character varying)
     JOIN data.timeseries ftc1 ON ep.logdate = ftc1.logdate AND ep.logtimestamp = ftc1.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND ftc1.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'flowTemperatureCircuit1'::character varying);

-- Permissions

ALTER TABLE "data"."vAnalyzePowerConsumptionHeatpump" OWNER TO postgres;
GRANT ALL ON TABLE "data"."vAnalyzePowerConsumptionHeatpump" TO postgres;
GRANT SELECT ON TABLE "data"."vAnalyzePowerConsumptionHeatpump" TO smarthome_datascience;


-- "data"."vAnalyzePowerConsumptionHeatpumpDaily" source

CREATE OR REPLACE VIEW "data"."vAnalyzePowerConsumptionHeatpumpDaily"
AS WITH heatpump AS (
         SELECT ep.logdate,
            round((sum(tp.value + rp.value) / NULLIF(sum(rp.value + ep.value), 0::double precision))::numeric, 2) AS tagesarbeitszahl,
            round((sum(tp.value + rp.value) / 60::double precision)::numeric, 1) AS totalheatingenergy,
            round((sum(rp.value + ep.value) / 60::double precision)::numeric, 1) AS totalelectricenergy,
            round((sum(tp.value) / 60::double precision)::numeric, 1) AS heatpumpthermalpowerenergy,
            round((sum(ep.value) / 60::double precision)::numeric, 1) AS heatpumpelectricenergy,
            round((sum(rp.value) / 60::double precision)::numeric, 1) AS heatpumpresistanceheatingenergy,
            round(avg(ot.value)::numeric, 1) AS outsidetemperatureavg,
            round(avg(ftc1.value)::numeric, 1) AS flowtemperaturecircuit1avg
           FROM data.timeseries ep
             JOIN data.timeseries tp ON ep.logdate = tp.logdate AND ep.logtimestamp = tp.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND tp.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpThermalPower'::character varying)
             JOIN data.timeseries rp ON ep.logdate = rp.logdate AND ep.logtimestamp = rp.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND rp.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpResistanceHeatingPower'::character varying)
             JOIN data.timeseries ot ON ep.logdate = ot.logdate AND ep.logtimestamp = ot.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND ot.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'outsideTemperature'::character varying)
             JOIN data.timeseries ftc1 ON ep.logdate = ftc1.logdate AND ep.logtimestamp = ftc1.logtimestamp AND ep.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'heatpumpElectricPower'::character varying) AND ftc1.sensorid = data."fnGetSensorId"('Solvis Lea 11kW'::character varying, 'flowTemperatureCircuit1'::character varying)
          GROUP BY ep.logdate
        ), heatpumpelectricmeter AS (
         SELECT pmheat.logdate,
            round((max(pmheat.value) - min(pmheat.value))::numeric, 1) AS totalelectricconsumptionheating
           FROM data.timeseries pmheat
          WHERE pmheat.sensorid = data."fnGetSensorId"('Heating Powermeter'::character varying, 'consumedEnergy'::character varying)
          GROUP BY pmheat.logdate
        ), consulatedheatingview AS (
         SELECT hp.logdate,
            COALESCE(hpem.totalelectricconsumptionheating, hp.totalelectricenergy) AS totalelectricenergy,
            hp.totalelectricenergy AS totalelectricenergysolvismeasurement,
            hpem.totalelectricconsumptionheating AS totalelectricenergyfullmeasurement,
            hp.tagesarbeitszahl,
            hp.totalheatingenergy,
            hp.heatpumpthermalpowerenergy,
            hp.heatpumpresistanceheatingenergy,
            hp.outsidetemperatureavg,
            hp.flowtemperaturecircuit1avg
           FROM heatpump hp
             LEFT JOIN heatpumpelectricmeter hpem ON hp.logdate = hpem.logdate
        )
 SELECT chv.logdate,
    round(chv.totalheatingenergy / chv.totalelectricenergy, 2) AS tagesarbeitszahlinclcontrolandpumps,
    chv.tagesarbeitszahl AS tagesarbeitszahlsolvis,
    round(chv.totalheatingenergy / chv.totalelectricenergyfullmeasurement, 2) AS tagesarbeitszahlfullelectricmeasurement,
    chv.totalelectricenergy,
    chv.totalelectricenergyfullmeasurement,
    chv.totalelectricenergysolvismeasurement,
    chv.totalheatingenergy,
    chv.heatpumpthermalpowerenergy,
    chv.heatpumpresistanceheatingenergy,
    chv.outsidetemperatureavg,
    chv.flowtemperaturecircuit1avg
   FROM consulatedheatingview chv;

-- Permissions

ALTER TABLE "data"."vAnalyzePowerConsumptionHeatpumpDaily" OWNER TO postgres;
GRANT ALL ON TABLE "data"."vAnalyzePowerConsumptionHeatpumpDaily" TO postgres;


-- "data"."vAnalyzePowerConsumptionHeatpumpMonthly" source

CREATE OR REPLACE VIEW "data"."vAnalyzePowerConsumptionHeatpumpMonthly"
AS WITH dailydata AS (
         SELECT dd.logdate,
            date_part('year'::text, dd.logdate) AS year,
            date_part('month'::text, dd.logdate) AS month,
            date_part('day'::text, dd.logdate) AS day,
            dd.tagesarbeitszahlinclcontrolandpumps AS tagesarbeitszahl,
            dd.tagesarbeitszahlsolvis,
            dd.tagesarbeitszahlfullelectricmeasurement,
            dd.totalelectricenergy,
            dd.totalelectricenergyfullmeasurement,
            dd.totalelectricenergysolvismeasurement,
            dd.totalheatingenergy,
            dd.heatpumpthermalpowerenergy,
            dd.heatpumpresistanceheatingenergy,
            dd.outsidetemperatureavg,
            dd.flowtemperaturecircuit1avg
           FROM data."vAnalyzePowerConsumptionHeatpumpDaily" dd
        ), monthlydata AS (
         SELECT dd.year,
            dd.month,
            sum(dd.totalheatingenergy) AS totalheatingenergy,
            sum(dd.totalelectricenergy) AS totalelectricenergy,
            round(sum(dd.totalheatingenergy) / sum(dd.totalelectricenergy), 2) AS monatsarbeitszahl,
            min(dd.tagesarbeitszahl) AS mintagesarbeitszahl,
            max(dd.tagesarbeitszahl) AS maxtagesarbeitszahl,
            sum(dd.totalelectricenergyfullmeasurement) AS totalelectricenergyfullmeasurement,
            sum(dd.totalelectricenergysolvismeasurement) AS totalelectricenergysolvismeasurement,
            sum(dd.totalelectricenergyfullmeasurement) - sum(dd.totalelectricenergysolvismeasurement) AS totalelectricenergydelta,
            round(sum(dd.totalheatingenergy) / sum(dd.totalelectricenergyfullmeasurement), 2) AS monatsarbeitszahlfullelectricmeasurement,
            round(sum(dd.totalheatingenergy) / sum(dd.totalelectricenergysolvismeasurement), 2) AS monatsarbeitszahlsolviselectricmeasurement,
            sum(
                CASE
                    WHEN dd.totalelectricenergyfullmeasurement IS NOT NULL THEN 1
                    ELSE 0
                END) AS dayswithelectricenergyfullmeasurement,
            sum(
                CASE
                    WHEN dd.totalelectricenergysolvismeasurement IS NOT NULL THEN 1
                    ELSE 0
                END) AS dayswithelectricenergysolvismeasurement
           FROM dailydata dd
          GROUP BY dd.year, dd.month
        )
 SELECT md.year,
    md.month,
    md.totalheatingenergy,
    md.totalelectricenergy,
    md.monatsarbeitszahl,
    md.mintagesarbeitszahl,
    md.maxtagesarbeitszahl,
    md.totalelectricenergyfullmeasurement,
    md.totalelectricenergysolvismeasurement,
    md.totalelectricenergydelta,
    md.monatsarbeitszahlfullelectricmeasurement,
    md.monatsarbeitszahlsolviselectricmeasurement
   FROM monthlydata md;

-- Permissions

ALTER TABLE "data"."vAnalyzePowerConsumptionHeatpumpMonthly" OWNER TO postgres;
GRANT ALL ON TABLE "data"."vAnalyzePowerConsumptionHeatpumpMonthly" TO postgres;


-- "data"."vAnalyzePowerConsumptionHeatpumpYearly" source

CREATE OR REPLACE VIEW "data"."vAnalyzePowerConsumptionHeatpumpYearly"
AS SELECT md.year,
    sum(md.totalheatingenergy) AS totalheatingenergy,
    sum(md.totalelectricenergy) AS totalelectricenergy,
    sum(md.totalelectricenergyfullmeasurement) AS totalelectricenegyfullmeasurement,
    sum(md.totalelectricenergysolvismeasurement) AS totalelectricenergysolvismeasurement,
    sum(md.totalelectricenergydelta) AS totelelectricenergydelta,
    round(sum(md.totalheatingenergy) / sum(md.totalelectricenergy), 2) AS jahresarbeitszahl,
    round(sum(md.totalheatingenergy) / sum(md.totalelectricenergysolvismeasurement), 2) AS jahresarbeitszahlmanufacturer
   FROM data."vAnalyzePowerConsumptionHeatpumpMonthly" md
  GROUP BY md.year;

-- Permissions

ALTER TABLE "data"."vAnalyzePowerConsumptionHeatpumpYearly" OWNER TO postgres;
GRANT ALL ON TABLE "data"."vAnalyzePowerConsumptionHeatpumpYearly" TO postgres;


-- "data"."vGetLastTimestamp" source

CREATE OR REPLACE VIEW "data"."vGetLastTimestamp"
AS SELECT max(timeseries.logtimestamp) AS lasttimestamp
   FROM data.timeseries;

-- Permissions

ALTER TABLE "data"."vGetLastTimestamp" OWNER TO postgres;
GRANT ALL ON TABLE "data"."vGetLastTimestamp" TO postgres;
GRANT SELECT ON TABLE "data"."vGetLastTimestamp" TO heizung_ingress;
GRANT SELECT ON TABLE "data"."vGetLastTimestamp" TO smarthome_datascience;


-- "data"."vGetTimeSeries" source

CREATE OR REPLACE VIEW "data"."vGetTimeSeries"
AS SELECT ts.logtimestamp,
    d.name AS devicename,
    l.name AS locationname,
    dt.name AS devicetypename,
    s.name AS sensorname,
    ts.value,
    s.unit
   FROM data.timeseries ts
     JOIN data.sensors s ON s.sensorid = ts.sensorid
     JOIN data.devices d ON s.deviceid = d.deviceid
     JOIN data.locations l ON l.id = d.locationid
     JOIN data.devicetypes dt ON dt.devicetypeid = d.devicetypeid;

-- Permissions

ALTER TABLE "data"."vGetTimeSeries" OWNER TO postgres;
GRANT ALL ON TABLE "data"."vGetTimeSeries" TO postgres;
GRANT SELECT ON TABLE "data"."vGetTimeSeries" TO smarthome_datascience;



CREATE OR REPLACE FUNCTION data."fnCoefficientOfPower"(heatpower double precision, electricpower double precision)
 RETURNS double precision
 LANGUAGE plpgsql
 IMMUTABLE
AS $function$
	BEGIN
		RETURN
			COALESCE(heatPower, 0)
			/ 
			(
				CASE WHEN 
					(COALESCE(electricPower, 0) = 0) 
				THEN 
					1
				ELSE 
					electricPower 
				END
			)
		; 
	END;
	$function$
;

-- Permissions

ALTER FUNCTION "data"."fnCoefficientOfPower"(float8, float8) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnCoefficientOfPower"(float8, float8) TO postgres;

CREATE OR REPLACE FUNCTION data."fnGetDaysInMonth"(currentdate date)
 RETURNS integer
 LANGUAGE sql
 IMMUTABLE SECURITY DEFINER
AS $function$
	SELECT  
	    DATE_PART('days', 
	        DATE_TRUNC('month', currentDate) 
	        + '1 MONTH'::INTERVAL 
	        - '1 DAY'::INTERVAL
	    )
		; 
	$function$
;

-- Permissions

ALTER FUNCTION "data"."fnGetDaysInMonth"(date) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnGetDaysInMonth"(date) TO postgres;

CREATE OR REPLACE FUNCTION data."fnGetDaysInMonth"(currentdate timestamp without time zone)
 RETURNS integer
 LANGUAGE sql
 IMMUTABLE SECURITY DEFINER
AS $function$
	SELECT  
	    DATE_PART('days', 
	        DATE_TRUNC('month', currentDate) 
	        + '1 MONTH'::INTERVAL 
	        - '1 DAY'::INTERVAL
	    )
		; 
	$function$
;

-- Permissions

ALTER FUNCTION "data"."fnGetDaysInMonth"(timestamp) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnGetDaysInMonth"(timestamp) TO postgres;

CREATE OR REPLACE FUNCTION data."fnGetDaysInMonth"(currentdate timestamp with time zone)
 RETURNS integer
 LANGUAGE sql
 IMMUTABLE SECURITY DEFINER
AS $function$
	SELECT  
	    DATE_PART('days', 
	        DATE_TRUNC('month', currentDate) 
	        + '1 MONTH'::INTERVAL 
	        - '1 DAY'::INTERVAL
	    )
		; 
	$function$
;

-- Permissions

ALTER FUNCTION "data"."fnGetDaysInMonth"(timestamptz) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnGetDaysInMonth"(timestamptz) TO postgres;

CREATE OR REPLACE FUNCTION data."fnGetLatestMeasurementOfDevice"("deviceName" character varying)
 RETURNS timestamp without time zone
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
	
	DECLARE
		_deviceId BIGINT := NULL;
		_latestTimeStamp TIMESTAMP without TIME zone;
	BEGIN
		-- check existence of device
		BEGIN
			SELECT D.DEVICEID INTO STRICT _deviceId FROM "data"."devices" D 
			WHERE 
				D."name" = "deviceName"
			;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE EXCEPTION 'Provided device "%" is unknown', "deviceName";
				WHEN TOO_MANY_ROWS THEN
					RAISE EXCEPTION 'Found multiple devices for provided name %', "deviceName";
		END;
	
		-- Get latest logtimestamp
		SELECT 
			MAX(t.logtimestamp) into _latestTimeStamp
		FROM "data"."timeseries" t
		join "data".sensors s 
		ON 
			s.sensorid = t.sensorid 
		where 
			s.deviceid = _deviceId
		;
	
		return _latestTimeStamp;
	END
$function$
;

-- Permissions

ALTER FUNCTION "data"."fnGetLatestMeasurementOfDevice"(varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnGetLatestMeasurementOfDevice"(varchar) TO postgres;

CREATE OR REPLACE FUNCTION data."fnGetLatestMeasurementOfSensor"("deviceName" character varying, "sensorName" character varying)
 RETURNS timestamp without time zone
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
	
	DECLARE
		_deviceId BIGINT := NULL;
		_sensorId BIGINT := NULL;
		_latestTimeStamp TIMESTAMP without TIME zone;
	BEGIN
		-- check existence of device
		BEGIN
			SELECT D.DEVICEID INTO STRICT _deviceId FROM "data"."devices" D 
			WHERE 
				D."name" = "deviceName"
			;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE EXCEPTION 'Provided device "%" is unknown', "deviceName";
				WHEN TOO_MANY_ROWS THEN
					RAISE EXCEPTION 'Found multiple devices for provided name %', "deviceName";
		END;
	
		-- check existence of sensor
		BEGIN
			SELECT S.SENSORID INTO STRICT _sensorId FROM "data"."sensors" S 
			WHERE 
				S."name" = "sensorName"
				AND S.DEVICEID = _deviceId
			;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE EXCEPTION 'Provided sensor "%" is unknown', "sensorName";
				WHEN TOO_MANY_ROWS THEN
					RAISE EXCEPTION 'Found multiple sensors for provided name and device ';
		END;
	
		-- Get latest logtimestamp
		SELECT 
			MAX(t.logtimestamp) into _latestTimeStamp
		FROM "data"."timeseries" t
		where 
			t.sensorid = _sensorId
		;
	
		return _latestTimeStamp;
	END
$function$
;

-- Permissions

ALTER FUNCTION "data"."fnGetLatestMeasurementOfSensor"(varchar, varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnGetLatestMeasurementOfSensor"(varchar, varchar) TO postgres;

CREATE OR REPLACE FUNCTION data."fnGetSensorId"(devicename character varying, sensorname character varying)
 RETURNS bigint
 LANGUAGE sql
 IMMUTABLE SECURITY DEFINER
AS $function$
		SELECT 
			S.SENSORID 
		FROM "data"."sensors" S 
		JOIN "data"."devices" D 
		ON
			S.DEVICEID = D.DEVICEID 
		WHERE 
			S."name"=sensorName
			AND D."name"=deviceName
		LIMIT 1
		; 
	$function$
;

-- Permissions

ALTER FUNCTION "data"."fnGetSensorId"(varchar, varchar) OWNER TO postgres;
GRANT ALL ON FUNCTION "data"."fnGetSensorId"(varchar, varchar) TO postgres;

CREATE OR REPLACE FUNCTION data.fngetdailyconsumptionofsensor(bigint)
 RETURNS TABLE(logdate date, sensorid bigint, dailyconsumption double precision)
 LANGUAGE sql
AS $function$
		SELECT
			ts.logdate AS logDate
			,$1 AS sensorId
		 	,ROUND(CAST(MAX(ts.value) - MIN(ts.value) AS NUMERIC), 1) AS dailyConsumption
		FROM DATA.timeseries ts
		WHERE
			ts.sensorid = $1
		GROUP BY ts.logdate
		$function$
;

-- Permissions

ALTER FUNCTION "data".fngetdailyconsumptionofsensor(int8) OWNER TO postgres;
GRANT ALL ON FUNCTION "data".fngetdailyconsumptionofsensor(int8) TO postgres;

CREATE OR REPLACE PROCEDURE data."pInsertMeasurement"("timestampInSeconds" bigint, "deviceName" character varying, "sensorName" character varying, value double precision)
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $procedure$
	
	DECLARE
		_internalTimestamp TIMESTAMP := to_timestamp("timestampInSeconds");
		_deviceId BIGINT := NULL;
		_sensorId BIGINT := NULL;
	BEGIN
		-- check existence of device
		BEGIN
			SELECT D.DEVICEID INTO STRICT _deviceId FROM "data"."devices" D 
			WHERE 
				D."name" = "deviceName"
			;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE EXCEPTION 'Provided device "%" is unknown', "deviceName";
				WHEN TOO_MANY_ROWS THEN
					RAISE EXCEPTION 'Found multiple devices for provided name %', "deviceName";
		END;
	
		-- check existence of sensor
		BEGIN
			SELECT S.SENSORID INTO STRICT _sensorId FROM "data"."sensors" S 
			WHERE 
				S."name" = "sensorName"
				AND S.DEVICEID = _deviceId
			;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE EXCEPTION 'Provided sensor "%" is unknown', "sensorName";
				WHEN TOO_MANY_ROWS THEN
					RAISE EXCEPTION 'Found multiple sensors for provided name and device ';
		END;
	
		-- Insert
		INSERT INTO "data"."timeseries" 
			("logtimestamp", "logdate", "sensorid", "value", "createdate", "updatedate")
			VALUES (_internalTimestamp, _internalTimestamp::DATE, _sensorId, "value", NOW(), NOW())
		;
	END
$procedure$
;

-- Permissions

ALTER PROCEDURE "data"."pInsertMeasurement"(int8, varchar, varchar, float8) OWNER TO postgres;
GRANT ALL ON PROCEDURE "data"."pInsertMeasurement"(int8, varchar, varchar, float8) TO postgres;


-- Permissions

GRANT ALL ON SCHEMA "data" TO postgres;
GRANT USAGE ON SCHEMA "data" TO heizung_ingress;
GRANT USAGE ON SCHEMA "data" TO smarthome_datascience;

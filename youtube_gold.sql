SELECT *
FROM OPENROWSET(
    BULK 'https://neudamgdatalakefinal.blob.core.windows.net/silver/CAvideos/part-00000-tid-349744299117817892-4544af5d-f616-4caf-b96f-96d126dc0ee4-48-1-c000.snappy.parquet',
    FORMAT = 'PARQUET'
) AS [result]

CREATE VIEW gold.ca
AS
SELECT
*
FROM OPENROWSET(
    BULK 'https://neudamgdatalakefinal.blob.core.windows.net/silver/CAvideos/part-00000-tid-349744299117817892-4544af5d-f616-4caf-b96f-96d126dc0ee4-48-1-c000.snappy.parquet',
    FORMAT = 'PARQUET'
) AS [result]

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'NEUdtr@trt2024'

CREATE DATABASE SCOPED CREDENTIAL cred_zheng
WITH
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sp=racwdlmeop&st=2025-04-08T03:55:57Z&se=2025-04-22T11:55:57Z&spr=https&sv=2024-11-04&sr=c&sig=HYzKW1ylcf0pkpK4T6uCckbbprjpSaEaJVSvgJFrLVw%3D';

CREATE EXTERNAL TABLE gold.exca
WITH (
    LOCATION = 'extca/',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.ca;

-- neu-synapse-awproject-dtr-ondemand.sql.azuresynapse.net

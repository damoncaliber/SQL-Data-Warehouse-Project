/*
---------------------------------------------------
  Data Warehouse Initialization Script
---------------------------------------------------

Script Purpose:
- Creates a new database named 'DataWarehouse'.
- If it exists, it is dropped and recreated.
- Sets up three schemas: bronze, silver, and gold.

Schemas:
- Bronze: Raw data layer
- Silver: Cleaned and transformed data layer
- Gold: Curated analytical data layer

⚠️ WARNING:
Running this script will DROP the entire 'DataWarehouse' database if it exists. 
All data in the database will be permanently deleted. 
Proceed with caution and ensure proper backups are in place before execution.
*/

USE master;
GO

---------------------------------------------------
-- Drop and Recreate the 'DataWarehouse' database
---------------------------------------------------

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    PRINT 'Database ''DataWarehouse'' found. Dropping existing database...';

    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;

    PRINT 'Existing ''DataWarehouse'' database dropped successfully.';
END
ELSE
BEGIN
    PRINT 'No existing ''DataWarehouse'' database found. Proceeding with creation...';
END
GO

---------------------------------------------------
-- Create the 'DataWarehouse' database
---------------------------------------------------

CREATE DATABASE DataWarehouse;
GO

PRINT 'New ''DataWarehouse'' database created successfully.';
GO

---------------------------------------------------
-- Configure the database 
---------------------------------------------------

ALTER DATABASE DataWarehouse 
SET RECOVERY SIMPLE;
GO

PRINT 'Database recovery model set to SIMPLE.';
GO


USE DataWarehouse;
GO

---------------------------------------------------
-- Create Schemas: bronze, silver, gold
---------------------------------------------------

CREATE SCHEMA bronze;
GO
PRINT 'Schema ''bronze'' created successfully.';
GO

CREATE SCHEMA silver;
GO
PRINT 'Schema ''silver'' created successfully.';
GO

CREATE SCHEMA gold;
GO
PRINT 'Schema ''gold'' created successfully.';
GO

PRINT 'All schemas created successfully.';
GO


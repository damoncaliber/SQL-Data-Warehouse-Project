---------------------------------------------------
-- 📂 BRONZE LAYER – BULK DATA LOAD SCRIPT
---------------------------------------------------
-- 📝 Purpose:
-- This stored procedure loads raw CSV data into the Bronze layer tables 
-- for both CRM and ERP source systems. 
-- Each table is truncated before data ingestion to ensure freshness.
-- Minimal transformations are applied at this stage, maintaining 
-- a close reflection of the raw source files.

⚡ Execution:
--  EXEC bronze.load_bronze

-- 🧱 Bronze Layer Characteristics:
-- - Raw / semi-structured data zone
-- - Acts as the foundation for Silver and Gold layers
-- - Useful for data lineage and audit tracking
---------------------------------------------------

---------------------------------------------------
--  CRM: Customer Information
---------------------------------------------------
-- Remove existing data to prepare for fresh load
USE DataWarehouse;
GO

-- STORED PROCEDURE: bronze.load_bronze
-- Main procedure to orchestrate the Bronze layer bulk load process.
---------------------------------------------------
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
      ---------------------------------------------------
        -- Start: Log procedure execution
        ---------------------------------------------------
        SET @batch_start_time = GETDATE();
        PRINT '===================================================';
        PRINT 'Loading bronze layer Data';
        PRINT '===================================================';

        PRINT '---------------------------------------------------';
        PRINT '--  Loading CRM Tables --';
        PRINT '---------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\SQL datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT 'Data loaded into bronze.crm_cust_info successfully.';
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ---------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\SQL datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT 'Data loaded into bronze.crm_prd_info successfully.';
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ---------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\SQL datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT 'Data loaded into bronze.crm_sales_details successfully.';
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ---------------------------';

        PRINT '---------------------------------------------------';
        PRINT '--  Loading ERP Tables --';
        PRINT '---------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\SQL datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT 'Data loaded into bronze.erp_cust_az12 successfully.';
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ---------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\SQL datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT 'Data loaded into bronze.erp_loc_a101 successfully.';
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ---------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\SQL datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT 'Data loaded into bronze.erp_px_cat_g1v2 successfully.';
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> ---------------------------';

        ---------------------------------------------------
        -- End of Procedure
        ---------------------------------------------------
        PRINT '===================================================';
        PRINT 'All Bronze Layer tables (CRM & ERP) loaded successfully.';
        PRINT '===================================================';
        SET @batch_end_time = GETDATE();
        PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
    
    END TRY
    BEGIN CATCH
        
        PRINT '===================================================';
        PRINT 'ERROR OCCURED LOADING BRONZE LAYER'
        PRINT '===================================================';
    END CATCH
END
GO

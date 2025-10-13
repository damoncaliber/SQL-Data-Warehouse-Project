/*
===================================================
 📂 BRONZE LAYER – TABLE CREATION SCRIPT
===================================================

📌 Script Purpose:
- Create staging (raw) tables for CRM and ERP source files.
- These tables mirror the structure of incoming raw data.
- Minimal transformations — only enough to store and stage the data.
- Adds load timestamp to track data ingestion time.

Data Flow:
Source Files (CRM / ERP) ➝ Bronze Tables ➝ Silver ➝ Gold

===================================================
*/

USE DataWarehouse;
GO

---------------------------------------------------
-- Ensure Bronze Schema Exists
---------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

---------------------------------------------------
-- 🧾 CRM: Customer Information
---------------------------------------------------
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL 
    DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
);
GO
PRINT 'Table bronze.crm_cust_info created successfully.';

---------------------------------------------------
-- 🧾 CRM: Product Information
---------------------------------------------------
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL 
    DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost DECIMAL(18,2),
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME,
);
GO
PRINT 'Table bronze.crm_prd_info created successfully.';


---------------------------------------------------
-- 🧾 CRM: Sales Details
---------------------------------------------------
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL 
    DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt NVARCHAR(50),
    sls_ship_dt NVARCHAR(50),
    sls_due_dt NVARCHAR(50),
    sls_sales DECIMAL(18,2),
    sls_quantity INT,
    sls_price DECIMAL(18,2)
);
GO
PRINT 'Table bronze.crm_sales_details created successfully.';

---------------------------------------------------
-- 🏢 ERP: Location Information
---------------------------------------------------
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
   DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
    cid NVARCHAR(50),
    cntry NVARCHAR(50),
);
GO
PRINT 'Table bronze.erp_loc_a101 created successfully.';

---------------------------------------------------
-- 🏢 ERP: Customer Data
---------------------------------------------------
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
   DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50),
);
GO
PRINT 'Table bronze.erp_cust_az12 created successfully.';

---------------------------------------------------
-- 🏢 ERP: Product Category
---------------------------------------------------
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
   DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50),
);
GO
PRINT 'Table bronze.erp_px_cat_g1v2 created successfully.';

---------------------------------------------------
--  FINAL MESSAGE
---------------------------------------------------
PRINT '===================================================';
PRINT ' All Bronze Layer tables (CRM & ERP) created successfully.';
PRINT '===================================================';
GO

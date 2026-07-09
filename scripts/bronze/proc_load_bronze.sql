--create stored procedure
--meaning: save frequently used sql code in stored procedure in database.

/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

EXEC bronze.load_bronze

create or alter procedure bronze.load_bronze as 
BEGIN
	DECLARE @start_time datetime, @end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
	BEGIN TRY
		set @batch_start_time = getdate();
		print'===================================================='
		print 'Loading bronze layer'
		print'===================================================='

		print'===================================================='
		print 'Loading CRM tables'
		print'===================================================='

		SET @start_time= getdate();
		print '>> Truncating Table: bronze.crm_cust_info'
		truncate table bronze.crm_cust_info;

		print '>> Inserting data into: bronze.crm_cust_info'
		bulk insert bronze.crm_cust_info
		from 'C:\Users\$ ASUS $\OneDrive\Documents\data analytics\data_project\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		SET @end_time= getdate();
		print '>> Load Duration: '+ cast(datediff(second, @start_time, @end_time) as nvarchar)+' seconds';
		print '*************************************************************'

		SET @start_time= getdate();
		print '>> Truncating Table: bronze.crm_prd_info'
		truncate table bronze.crm_prd_info;

		print '>> Inserting data into: bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info
		from 'C:\Users\$ ASUS $\OneDrive\Documents\data analytics\data_project\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		SET @end_time= getdate();
		print '>> Load Duration: '+ cast(datediff(second, @start_time, @end_time) as nvarchar)+' seconds';
		print '*************************************************************'

		SET @start_time= getdate();
		print '>> Truncating Table: bronze.crm_sales_info'
		truncate table bronze.crm_sales_details;

		print '>> Inserting data into: bronze.crm_sales_info'
		bulk insert bronze.crm_sales_details
		from 'C:\Users\$ ASUS $\OneDrive\Documents\data analytics\data_project\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		SET @end_time= getdate();
		print '>> Load Duration: '+ cast(datediff(second, @start_time, @end_time) as nvarchar)+' seconds';
		print '*************************************************************'

		print'===================================================='
		print 'Loading ERP tables'
		print'===================================================='
	
		SET @start_time= getdate();
		print '>> Truncating Table: bronze.erp_loc_a101'
		truncate table bronze.erp_loc_a101;

		print '>> Inserting data into: bronze.erp_loc_a101'
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\$ ASUS $\OneDrive\Documents\data analytics\data_project\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		SET @end_time= getdate();
		print '>> Load Duration: '+ cast(datediff(second, @start_time, @end_time) as nvarchar)+' seconds';
		print '*************************************************************'

		SET @start_time= getdate();
		print '>> Truncating Table: bronze.erp_cust_az12'
		truncate table bronze.erp_cust_az12;

		print '>> Inserting data into: bronze.erp_cust_az12'
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\$ ASUS $\OneDrive\Documents\data analytics\data_project\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		SET @end_time= getdate();
		print '>> Load Duration: '+ cast(datediff(second, @start_time, @end_time) as nvarchar)+' seconds';
		print '*************************************************************'

		SET @start_time= getdate();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2'
		truncate table bronze.erp_px_cat_g1v2;

		print '>> Inserting data into: bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\$ ASUS $\OneDrive\Documents\data analytics\data_project\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			tablock
		);
		SET @end_time= getdate();
		print '>> Load Duration: '+ cast(datediff(second, @start_time, @end_time) as nvarchar)+' seconds';
		print '*************************************************************'

		set @batch_end_time= getdate();
		print '=========================================================='
		print 'loading bronze layer is completed';
		print '  -total load duration:' + cast(datediff(second, @batch_start_time,@batch_end_time) as nvarchar)+ ' seconds';
		print '=========================================================='
	END TRY

	BEGIN CATCH
		PRINT '==============================================================='
		PRINT 'error occured during loading bronze layer'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==============================================================='
	END CATCH
END

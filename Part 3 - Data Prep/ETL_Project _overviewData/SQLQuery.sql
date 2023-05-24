
/*
CREATE TABLE testtable
(
	name VARCHAR(100)
	, age INT
)

INSERT INTO testtable (name, age)
VALUES ('Matt',35), ('James', 45), ('Helen', 26)
*/


select * 
from testtable



SELECT [RowNumber]
      ,[Number]
      ,[Gender]
      ,[NameSet]
      ,[Title]
      ,[GivenName]
      ,[MiddleInitial]
      ,[Surname]
      ,[AmountPaid]
      ,[StreetAddress]
      ,[City]
      ,[State]
      ,[StateFull]
      ,[ZipCode]
      ,[Country]
      ,[CountryFull]
      ,[Feedback]
      ,[EmailAddress]
      ,[Username]
      ,[Password]
      ,[BrowserUserAgent]
      ,[TelephoneNumber]
      ,[TelephoneCountryCode]
      ,[MothersMaiden]
      ,[Birthday]
      ,[TropicalZodiac]
      ,[CCType]
      ,[CCNumber]
      ,[CVV2]
      ,[CCExpires]
      ,[NationalID]
      ,[UPS]
      ,[WesternUnionMTCN]
      ,[MoneyGramMTCN]
      ,[Color]
      ,[Occupation]
      ,[Company]
      ,[Vehicle]
      ,[Domain]
      ,[BloodType]
      ,[Pounds]
      ,[Kilograms]
      ,[FeetInches]
      ,[Centimeters]
      ,[GUID]
      ,[Latitude]
      ,[Longitude]
      ,[Column 46]
  FROM [ds_training].[dbo].[RAW_FakeNames_20230513]
  WHERE [Column 46] NOT LIKE ''
	OR [Longitude] NOT LIKE '%.%'

/*
SSIS Errors (most common)
-- Truncation - -- Truncation occurs when the data in our cell is too long. I.e # of char are more than allocated chars...
-- Bad Input File format - Makes sure to specify text qualifier such as " , another example of this would be 2 cols with same name, etc.... 
-- Code page Mismatch
-- Out of Memory
-- Database / Log File Too Big()
-- Connection Failures
-- Metadata Changes
-- Data Type Mismatch
-- Primary key/ Unique Index Violations
-- Permission Issues
-- Configuration File Missing
-- Deadlocks
Note: Stick to the blueprint to avoid about half (from below in above list) of the above errors and its a good method too... 
*/

-- TRUNCATE Does not remove the table but removes the data within....
-- TRUNCATE TABLE [ds_training].[dbo].[RAW_FakeNames_20230513]
SELECT * FROM [ds_training].[dbo].[RAW_FakeNames_20230513]

SELECT COUNT(*) 
FROM [ds_training].[dbo].[RAW_FakeNames_20230513]





--------------- HW ETL

/****** Script for SelectTopNRows command from SSMS  ******/
-- Query to check data after SSIS .... 
SELECT [RowNumber]
      ,[Number]
      ,[Gender]
      ,[Title]
      ,[FirstName]
      ,[LastName]
      ,[Address]
      ,[ZipCode]
      ,[EmailAddress]
      ,[Username]
      ,[Password]
      ,[Birthday]
      ,[CCType]
      ,[CCNumber]
      ,[CVV2]
      ,[CCExpires]
      ,[BloodType]
      ,[Kilograms]
      ,[Centimeters]
      ,[Column 18]
      ,[Column 19]
  FROM [ds_training].[dbo].[RAW_FakeNamesUK_20230514]
  -- Put auto removal of rows with below two filter condition and return text file with bad records...
  WHERE [Column 18] NOT LIKE ''  
	OR [Column 19] NOT LIKE ''
	-- put the below 3 conditions in SSIS for auto filtering of rows as we need data in those 3 rows very importantly
	OR [Centimeters] LIKE ''
	OR [Kilograms] LIKE ''
	OR [BloodType] LIKE ''
	
	--OR RowNumber IN (1,5)

-- DROP TABLE [ds_training].[dbo].[RAW_FakeNamesUK_hw]
-- DROP TABLE [ds_training].[dbo].[RAW_FakeNamesUK_20230514]
-- TRUNCATE TABLE [ds_training].[dbo].[RAW_FakeNamesUK_hw]
-- TRUNCATE TABLE [ds_training].[dbo].[RAW_FakeNamesUK_20230514]
TRUNCATE TABLE [ds_training].[dbo].[RAW_FakeNamesUK_20230514]	;
SElECT * FROM [ds_training].[dbo].[RAW_FakeNamesUK_20230514];


--------- 

SELECT [RowNumber]
      ,[Order ID]
      ,[Order Date]
      ,[Customer Name]
      ,[Country]
  FROM [ds_training].[dbo].[RAW_ListOfOrders_20230515]



-- TRUNCATE TABLE [ds_training].[dbo].[RAW_OrderBreakdown_20230515];
-- DROP TABLE [ds_training].[dbo].[RAW_OrderBreakdown_20230515];

SELECT [RowNumber]
      ,[Order ID]
      ,[Product Name]
      ,[Discount]
      ,[Sales]
      ,[Quantity]
      ,[Category]
  FROM [ds_training].[dbo].[RAW_OrderBreakdown_20230515]
  -- ORDER BY CONVERT(FLOAT, [Sales])
  -- OR we can also ...
  ORDER BY CAST([Sales] AS FLOAT) DESC,
	CONVERT(INT, [Quantity]) DESC,
	CAST([Discount] AS FLOAT) DESC
/***** 
We can use CAST / CONVERT to change data types, as shown above,
However, Use CONVERT when working with dates
*****/

/*
UPDATE [RAW_OrderBreakdown_20230515]
SET [Discount] = NULL
WHERE [Discount] = 0.5
*/

---------- ETL Phase 1: Original -> Prepared -> Uploaded
---------- ETL Phase 2: Uploaded -> RAW [in SSIS]
---------- ETL Phase 3: RAW -> WRK ~> DRV [in SQL] ----------

SELECT [RowNumber]
      ,[Customer ID]
      ,[City]
      ,[ZipCode]
      ,[Gender]
      ,[Age]
  FROM [ds_training].[dbo].[RAW_CustomerList_20230515];


  SELECT [RowNumber]
      ,[Order ID]
      ,[Order Date]
      ,[Customer ID]
      ,[Region]
      ,[Rep]
      ,[Item]
      ,[Units]
      ,[Unit Price]
  FROM [ds_training].[dbo].[RAW_TransactionalData_20230515];

-- PROC - Stored Procedures
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sandeep Solanki
-- Create date: 2023-05-15
-- Description:	RAW -> WRK
-- Last Mod Date: 
-- =============================================
CREATE PROC [BLD_WRK_OfficeSupply_CustomerList]

AS
BEGIN

	-- This is my first proc
    -- Insert statements for procedure here
	SELECT * FROM [dbo].[RAW_OfficeSupply_CustomerList_20230515]
END
GO

-- Executing PROC



SELECT TOP (1000) [RowNumber]
      ,[Customer ID]
      ,[City]
      ,[ZipCode]
      ,[Gender]
      ,[Age]
  FROM [ds_training].[dbo].[WRK_OfficeSupply_CustomerList_20230515]




-- ETL Phase 3 
-- Where balance has other than numeric values
SELECT * 
FROM [ds_training].[dbo].[RAW_FakeNamesCanada_20230515]
-- WHERE ISNUMERIC([Balance]) <> 1
-- WHERE LEN([ZipCode]) > 7
WHERE ISDATE([Birthday]) <> 1;


SELECT * 
FROM [ds_training].[dbo].[RAW_FakeNamesCanada_20230515]
WHERE ISNUMERIC([Balance]) <> 1
AND LEN([ZipCode]) > 7









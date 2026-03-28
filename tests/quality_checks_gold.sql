/* 
====================================================================================
Quality Checks
====================================================================================
Script purpose:
	This script performs quality checks to validate the integrity, consistency,
	and accurancy of the Gold Layer. These checks ensure:
	- Uniqueness of surrogate keys in dimension tables.
	- Referential Integrity between fact and dimension tables.
	- Validation of relationships in the data model for analytical purposes.

Usage Notes:
	- Run these checks after data loading Silver Layer.
	- Investigate and resolve any discrepancies found during the checks.
====================================================================================
*/

=============================================
-- Checking gold.dim_customers
=============================================

-- Check for uniqueness of customer key in gold.dim_products
--Expectation: No Results
SELECT
	customer_key,
	COUNT(*) AS dublicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

==================================================
-- Checking gold.dim_products
==================================================

-- Check for uniqueness of product key in gold.dim_products
--Expectation: No Results
SELECT
	product_key,
	COUNT(*) AS dublicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

===================================================
-- Checking Foreign Key Integrity
===================================================

-- Foreign key integrity (Dimensions)

SELECT*
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = f.customer_key
WHERE c.customer_key IS NULL

SELECT*
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL

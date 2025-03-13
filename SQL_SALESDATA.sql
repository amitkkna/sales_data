-- Create the database and terminate the statement with a semicolon
CREATE DATABASE sql_project_p2;

-- Select the new database
USE sql_project_p2;

-- Create the retail_sales table
CREATE TABLE retail_sales (
    transection_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    catogory VARCHAR(15),
    quantity INT, 
    price_per_unit FLOAT,
    cogs FLOAT, 
    total_sales FLOAT
);

SELECT * FROM  retail_sales;
SELECT COUNT(*) AS total_records FROM retail_sales;

-- Check for any NULL values in the table
SELECT * FROM retail_sales
WHERE
      transection_id IS NULL
      OR sale_date IS NULL
      OR sale_time IS NULL
      OR gender IS NULL
      OR age IS NULL
      OR catogory IS NULL
      OR quantity IS NULL
      OR price_per_unit IS NULL
      OR cogs IS NULL
      OR total_sales IS NULL;
      
-- Data Exploration

-- How many sales do we have?
SELECT COUNT(*) AS total_sales FROM retail_sales;

SELECT distinct catogory as total_sales FROM retail_sales;

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

SELECT *
FROM retail_sales
WHERE catogory = 'Clothing'
  AND YEAR(sale_date) = 2022
  AND MONTH(sale_date) = 11
  AND quantity >= 3;
  
SELECT 
    catogory,
    SUM(total_sales) AS total_sales_by_category
FROM retail_sales
GROUP BY catogory;

SELECT 
    AVG(age) AS average_age
FROM retail_sales
WHERE catogory = 'Beauty';

SELECT *
FROM retail_sales
WHERE total_sales > 100;

SELECT 
    gender,
    catogory,
    COUNT(transection_id) AS total_transactions
FROM retail_sales
GROUP BY gender, catogory;

SELECT 
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(total_sales) AS monthly_total_sales
FROM retail_sales
GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date)
ORDER BY 
    sales_year,
    sales_month;

WITH monthly_sales AS (
    SELECT 
        YEAR(sale_date) AS yr,
        MONTH(sale_date) AS mnth,
        SUM(total_sales) AS monthly_total
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT *
FROM monthly_sales ms1
WHERE ms1.monthly_total = (
    SELECT MAX(ms2.monthly_total)
    FROM monthly_sales ms2
    WHERE ms2.yr = ms1.yr
);

SELECT 
    catogory,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY catogory;

SELECT 
    CASE 
        WHEN HOUR(sale_time) BETWEEN 7 AND 11 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 14 THEN 'Afternoon'
        ELSE 'Other'
    END AS time_period,
    COUNT(transection_id) AS order_count,
    SUM(total_sales) AS total_sales
FROM retail_sales
GROUP BY time_period;







     
     
     





# SQL Project - Retail Sales Analysis

This project explores and analyzes retail sales data using SQL. The code provided demonstrates the creation of a database, table, data insertion, and various queries for data exploration and analysis.

## Project Structure

This repository contains the following:

*   `README.md`: This file, providing an overview of the project.
*   `sql_script.sql`: (Assumed name - you might name it this) Contains the SQL code to create the database, table, and perform queries.

## Database Setup

The `sql_script.sql` file contains the necessary SQL commands to set up the database and table:

1.  **Create Database:**

    ```sql
    CREATE DATABASE sql_project_p2;
    ```

2.  **Select Database:**

    ```sql
    USE sql_project_p2;
    ```

3.  **Create Table:**

    ```sql
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
    ```
   **Note:** You will need to insert your own data into this table. There were no INSERT statements provided.  You will likely want to add INSERT statements to the `sql_script.sql` file.

## Data Exploration and Analysis Queries

The `sql_script.sql` also includes a series of SQL queries for data exploration and analysis:

*   **Basic Checks:**

    *   Select all records from the table.
    *   Count the total number of records.

    ```sql
    SELECT * FROM  retail_sales;
    SELECT COUNT(*) AS total_records FROM retail_sales;
    ```

*   **Null Value Check:**

    *   Check for any NULL values in any of the columns.

    ```sql
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
    ```

*   **Data Exploration:**

    *   **Total Sales Count:**  Determines the total number of sales transactions.
    *   **Distinct Categories:** Lists the unique product categories available.
    *   **Sales on a Specific Date:**  Retrieves all sales records for a given date.
    *   **Specific Product Sales:** Finds sales records for a particular category, within a specific time frame, and where quantity is above a certain threshold.
    *   **Total Sales by Category:**  Calculates the total sales amount for each product category.
    *   **Average Age by Category:**  Computes the average age of customers who purchased a specific category (e.g., Beauty).
    *   **High Value Sales:** Identifies sales records where the total sales amount exceeds a certain value.
    *   **Transactions by Gender and Category:**  Counts the number of transactions for each gender and product category combination.
    *   **Monthly Total Sales:** Calculates the total sales for each month of the year.
    *   **Month with Highest Sales:** Finds the month with the highest total sales.
    *   **Unique Customers by Category:** Determines the number of unique customers who purchased from each product category.
    *   **Sales by Time Period:** Segments sales based on time of day (Morning, Afternoon, Other) and calculates order count and total sales for each period.

    ```sql
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
    ```

## Usage

1.  **Install a SQL Server:** Ensure you have a SQL server (e.g., MySQL, PostgreSQL, SQL Server, SQLite) installed and configured.
2.  **Create the database:** Execute the `CREATE DATABASE` statement.
3.  **Run the SQL script:** Execute the `sql_script.sql` file against your SQL server to create the table and load data (after you insert your data).
4.  **Execute Queries:** Run the provided SQL queries to explore and analyze the data.

## Future Enhancements

*   **Data Visualization:**  Integrate with data visualization tools (e.g., Tableau, Power BI) to create insightful dashboards.
*   **Advanced Analytics:** Implement more advanced analytical techniques, such as cohort analysis, customer segmentation, and predictive modeling.
*   **Data Cleaning & Validation:**  Implement thorough data cleaning procedures to handle missing or inaccurate data.
*   **More Detailed Analysis:**  Expand on the existing queries to answer more in-depth business questions.
*   **Parameterization:**  Make the script more dynamic by adding parameters that can be easily adjusted.

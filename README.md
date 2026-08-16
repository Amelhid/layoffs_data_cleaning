# Layoffs Dataset – Data Cleaning with MySQL

## Project Overview

This project focuses on cleaning and preparing a real-world dataset containing global tech layoffs, including information such as company, location, industry, number of employees laid off, percentage laid off, funding raised, and more.

The goal is to transform a messy, duplicate-filled, and inconsistently formatted raw dataset into a clean and analysis-ready dataset using MySQL.

This project demonstrates practical SQL skills used in real-world data preparation workflows.

## Tools & Technologies

- MySQL 8.0
- MySQL Workbench

## Data Cleaning Process

### 1. Create a Staging Table

Created a working copy of the raw dataset (`layoffs2`) to preserve the original data and provide a safety net during the cleaning process.

### 2. Remove Duplicates

Used the `ROW_NUMBER()` window function with `PARTITION BY` across relevant columns to identify duplicate records.

Duplicates were flagged using:

- Company
- Location
- Industry
- Total laid off
- Percentage laid off
- Date
- Stage
- Country
- Funds raised

Rows where `row_num > 1` were then removed.

### 3. Standardize Data

- Trimmed whitespace from company names
- Unified inconsistent industry labels (e.g., "Crypto", "Crypto Currency", "CryptoCurrency")
- Cleaned trailing periods from country values (e.g., "United States.")
- Converted date from text to a proper `DATE` type using `STR_TO_DATE()`

### 4. Handle Missing Values

Missing and inconsistent values were cleaned using several techniques:

- Identified records with missing industry values
- Used a self-join to populate missing industry values from other records belonging to the same company
- Converted empty strings (`''`) into proper `NULL` values
- Removed records where both `total_laid_off` and `percentage_laid_off` were `NULL`, since these records provided no useful information for the analysis

### 5. Final Cleanup

After the cleaning process:

- Removed the temporary `row_num` column
- Preserved the cleaned dataset as `layoffs3`
- Produced a structured and analysis-ready dataset

## SQL Skills Demonstrated

This project demonstrates practical use of:

- `ROW_NUMBER()` and window functions
- `PARTITION BY`
- `UPDATE`
- `DELETE`
- `JOIN` / self-joins
- `CASE` expressions
- `TRIM()`
- `STR_TO_DATE()`
- NULL handling
- Data standardization
- Duplicate detection and removal
- Staging tables
## Result

The raw layoffs dataset was transformed into a clean, standardized, and analysis-ready dataset, suitable for further exploratory data analysis and visualization.
## Exploratory Data Analysis (EDA)

After cleaning the dataset, I explored it using SQL to answer key questions about the layoffs.

### Key Questions Explored

- What was the single largest layoff event?
- What percentage of companies shut down completely (100% laid off)?
- Which companies, locations, countries, industries, and company stages were hit hardest?
- How did layoffs trend year over year and month over month?
- Which companies had the most layoffs each year?
- What did the rolling total of layoffs look like over time?


### SQL Techniques Used in EDA

- Aggregation with `GROUP BY` and `SUM()`
- Window functions: `DENSE_RANK()`, running totals with `SUM() OVER (ORDER BY ...)`
- CTEs for multi-step logic (aggregate → rank → filter)
- Date functions: `YEAR()`, `MONTH()`, `DATE_FORMAT()`

All EDA queries are available in [`eda_queries.sql`](./eda_queries.sql).

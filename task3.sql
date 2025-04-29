CREATE TABLE sales_data (
    InvoiceNo VARCHAR(20) NOT NULL,
    StockCode VARCHAR(15) NOT NULL,
    Description TEXT,
    Quantity INT NOT NULL,
    InvoiceDate TIMESTAMP NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CustomerID INT,
    Country VARCHAR(50)
);

SHOW datestyle;

SET datestyle = 'MDY';


select * from sales_data;

drop table sales_data;

copy sales_data FROM 'C:/Program Files/PostgreSQL/16/data/dataset/SQL_task/data.csv' CSV HEADER;

SHOW server_encoding;  -- For showing PostgreSQL server 

--For Total price of sale we will do multiplication of quantity*unit price

create table Sales_info as 
select * ,quantity*unitprice as Total_price
from sales_data; 

-- For highest sale & lowest sale
SELECT
    MAX(quantity * unitprice) AS Highest_Sale,
    MIN(quantity * unitprice) AS Lowest_Sale
FROM sales_data;

-- peak time of purchasing 
SELECT
    TO_CHAR(invoicedate, 'HH24') AS peak_hour,
    COUNT(*) AS transaction_count
FROM sales_data  -- Or Sales_info
GROUP BY peak_hour
ORDER BY transaction_count DESC
LIMIT 1;


-- Top 6 hours by viewing 

SELECT
    TO_CHAR(invoicedate, 'HH24') AS view_hour,
    COUNT(*) AS view_count
FROM sales_data
GROUP BY view_hour
ORDER BY view_count DESC
LIMIT 6;

-- top 7 hours by purchasing 

SELECT
    TO_CHAR(invoicedate, 'HH24') AS purchase_hour,
    COUNT(*) AS purchase_count
FROM sales_data  
GROUP BY purchase_hour
ORDER BY purchase_count DESC
LIMIT 7;

-- Top 10 brand category by sales

SELECT description, SUM(quantity * unitprice) AS total_sales
FROM sales_data 
GROUP BY description 
ORDER BY total_sales DESC
LIMIT 10;

--Frequency of top 20 purchase 


SELECT
    customerid,
    COUNT(invoiceno) AS number_of_purchases
FROM sales_data
GROUP BY CustomerID
ORDER BY number_of_purchases DESC
limit 20;


--Top month of the sales

SELECT
    TO_CHAR(invoicedate, 'Month') AS sales_month,
    SUM(quantity * unitprice) AS total_revenue
FROM sales_data 
GROUP BY sales_month
ORDER BY total_revenue DESC
LIMIT 1;

CREATE VIEW monthly_sales AS
SELECT
    TO_CHAR(invoicedate, 'YYYY-MM') AS sales_month,
    SUM(quantity * unitprice) AS monthly_revenue,
    COUNT(*) AS monthly_transactions
FROM sales_data  
GROUP BY TO_CHAR(invoicedate, 'YYYY-MM');



 












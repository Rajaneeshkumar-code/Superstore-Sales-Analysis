CREATE TABLE sales_data (
    ship_mode      VARCHAR(50),
    segment        VARCHAR(50),
    country        VARCHAR(100),
    city           VARCHAR(100),
    state          VARCHAR(100),
    postal_code    INTEGER,
    region         VARCHAR(50),
    category       VARCHAR(50),
    sub_category   VARCHAR(50),
    sales          NUMERIC(12,4),
    quantity       INTEGER,
    discount       NUMERIC(5,2),
    profit         NUMERIC(12,4)
);



COPY sales_data(Ship_Mode,Segment,Country,City,State,Postal_Code,Region,Category,Sub_Category,Sales,Quantity,
Discount,Profit)
FROM 'F:\Project _File\sampleSuperstore_clean.csv'
DELIMITER ','
CSV HEADER;
select * from sales_data;
-- Analysize the data

--1. Total Sales, Profit, and Quantity

--Calculates the overall sales, profit, and quantity sold
select sum(sales) as TotalSales,sum(profit) as TotalProfit ,sum(quantity) as Totalquantity from sales_data;
-- 2. Sales by Category
--Identify which product categories generate the highest sales.
select category,sum(sales) as total_sales  from sales_data group by category Order by  total_sales Desc LIMIT 1;
-- 3. Profit by Category
--Find the most profitable categories.
select sum(profit) as totalProfit ,category from sales_data group by category Order by totalProfit DESC;

-- 4.Sales by Region
--Analyze revenue generated from different regions.
select region ,sum(sales) as TotalSales from sales_data group by region;

--5.Profit by Region
--Compare profit performance across regions
select region ,sum(profit) as Totalprofit from sales_data group by region Order by Totalprofit DESC;

--6. Top 10 Cities by Sales
--Identify the cities with the highest sales
select city ,sum(sales) as totalSales from sales_data group by city order by totalSales DESC LIMIT 10;

-- 7. Top 10 Products Sub-Categories by Sales
--Determine the best-selling product sub-categories.
select  sub_category,sum(sales) as totalSales from sales_data group by sub_category order by totalSales DESC LIMIT 10;

-- 8,Top 10 Products Sub-Categories by Profit
--Find the most profitable product sub-categories.
select sub_category ,sum(profit) as TotalProfit from sales_data group by sub_category Order by TotalProfit DESC LIMIT 10;

--9. Average Discount by Category
--Analyze discount strategies across categories.
select category ,round(avg(discount),2) as Total_Discount from sales_data group by category order by Total_Discount DESC; 
--- 10.  10. Sales by Customer Segment
--Compare sales performance across customer segments.
SELECT
    segment,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;

--11. Profit by Customer Segment
--Determine which customer segment contributes the most profit.
select segment ,sum(profit) as Total_Profit from sales_data group by segment Order by Total_Profit  DESC;

-- 12. Top 10 Loss-Making Products Sub-Categories
--Identify product groups that incur losses.
select sub_category,sum(profit) as Total_profit from sales_data group by sub_category having sum(profit)<0 ORDER BY Total_profit ;

-- 13. Relationship Between Discount and Profit.
--Check whether higher discounts reduce profitability.
SELECT
    discount,
    ROUND(AVG(profit), 2) AS avg_profit
FROM sales_data
GROUP BY discount
ORDER BY discount;

-- 14. Top 10 States by Sales
--Find the highest revenue-generating states.
select state , sum(sales) as Totalsales from sales_data group by state Order by Totalsales DESC LIMIT 10;

-- 15.Top 10 States by Profit
--Find the most profitable states.
select state , sum(profit) as Totalprofit from sales_data group by state Order by Totalprofit DESC LIMIT 10;


-- PIZZA SALES SQL QUERIES (Using [TEST].[dbo].[dominos_sales$])

-- A. KPI's

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM [TEST].[dbo].[dominos_sales$];

-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM [TEST].[dbo].[dominos_sales$];

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM [TEST].[dbo].[dominos_sales$];

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM [TEST].[dbo].[dominos_sales$];

-- 5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM [TEST].[dbo].[dominos_sales$];

-- Chart Requirements  

-- B. Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY DATENAME(DW, order_date);

-- C. Monthly Trend for Orders
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY DATENAME(MONTH, order_date);

-- D. % of Sales by Pizza Category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [TEST].[dbo].[dominos_sales$]) AS DECIMAL(10,2)) AS PCT
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_category;

-- E. % of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [TEST].[dbo].[dominos_sales$]) AS DECIMAL(10,2)) AS PCT
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_size
ORDER BY pizza_size;

-- F. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM [TEST].[dbo].[dominos_sales$]
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- G. Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- H. Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- I. Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- J. Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;

-- K. Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- L. Bottom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [TEST].[dbo].[dominos_sales$]
GROUP BY pizza_name
ORDER BY Total_Orders ASC;

-- NOTE: If you want to apply the pizza_category or pizza_size filters to the above queries you can use WHERE clause. Example below:

-- Example with Pizza Category Filter
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [TEST].[dbo].[dominos_sales$]
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC;
-- Day 2 of 30 of SQL Challenge

-- 1. What are all the unique product categories ShopStream sells? List them in alphabetical order.
SELECT DISTINCT COUNT(category) AS total_category_count FROM online_orders ORDER BY category;
-- or
SELECT DISTINCT category FROM online_orders ORDER BY category;

-- 2. What are the top 10 highest-value orders? Show the customer name, product, amount, and region, sorted from highest to lowest.
SELECT customer_name, product_name, region, SUM(order_amount) AS total_order FROM online_orders GROUP BY product_name, customer_name, region ORDER BY total_order DESC;
-- or
SELECT customer_name, product_name, region FROM online_orders ORDER BY order_amount DESC;

-- 3. Find all orders from London, North West, and West Midlands where the order amount is between $40 and $150. Sort by region, then by amount (highest first). 
WITH lnw AS(
SELECT order_id, order_amount, region FROM online_orders WHERE region IN ('London', 'North West', 'West Midlands'))
SELECT order_id FROM lnw WHERE order_amount >= 40 AND order_amount <= 150 ORDER BY region, order_amount;
-- or
SELECT *
FROM online_orders
WHERE region IN ('London', 'North West', 'West Midlands')
    AND order_amount BETWEEN 40 AND 150
ORDER BY region, order_amount;

-- 4. Which customers placed orders using a @shopstream.com email address? Show their names, emails, products, and amounts, sorted by amount (highest first). 
SELECT customer_name, email, product_name, order_amount, SUM(order_amount) AS total_order FROM online_orders WHERE email LIKE '%@shopstream.com' GROUP BY customer_name, email, product_name, order_amount ORDER BY total_order DESC;

-- 5. Find all Sportswear orders from regions outside Scotland. Sort by amount (highest first).  
SELECT order_id, region, SUM(order_amount) AS total_order
FROM online_orders
WHERE region NOT IN ('Scotland')
    AND category = 'Sportswear'
GROUP BY order_id ORDER BY total_order DESC;

-- 6. Find Gmail customers in London, Scotland, or Wales with order amounts between $30 and $300. Sort by region, then by amount (highest first), and show only the top 10. 
WITH gmail AS(
SELECT order_id, email, order_amount, region FROM online_orders WHERE email LIKE '%gmail.com' AND region IN ('London', 'Scotland', 'Wales'))
SELECT order_id, email, region, SUM(order_amount) AS total_order FROM gmail WHERE order_amount >= 30 AND order_amount <= 300 GROUP BY order_id, email, region ORDER BY region, total_order DESC;
-- or
SELECT *
FROM online_orders
WHERE email LIKE '%gmail.com'
    AND region IN ('London', 'Wales', 'Scotland')
    AND order_amount BETWEEN 30 AND 300
ORDER BY region, order_amount DESC;

-- 7. Marcus also wants to know the second page of results for orders sorted by date (most recent first) - specifically rows 11 through 20. Write a query that returns this exact "page 2" of results using OFFSET and LIMIT.
SELECT * FROM online_orders ORDER BY order_date DESC LIMIT 10 OFFSET 10;

-- For each customer, calculate the average order amount and rank their orders 
-- by `total_amount` within each customer’s order history.
SELECT customer_id,order_id,total_amount, 
rank() over(partition by customer_id order by total_amount DESC) as rn
from orders;

-- Retrieve the customer_name and product_name for each order.
SELECT c.customer_name,p.product_name
FROM orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
INNER JOIN products p ON p.product_id = o.product_id;

-- List all campaign_names along with their respective result_ids.
SELECT m.campaign_name,c.result_id
FROM marketing_campaigns m
INNER JOIN campaign_results c ON m.campaign_id = c.campaign_id;

-- Get the customer_name and order_date for each order.
SELECT c.customer_name,o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Find product_name and price for products that have been ordered.
SELECT  p.product_name,p.price
FROM orders o 
INNER JOIN products p ON o.product_id = p.product_id 
GROUP BY p.product_name,p.price;

-- Retrieve all customers and their corresponding orders 
-- (include customers even if they haven’t placed any orders).
SELECT c.customer_id,c.customer_name,o.order_id,o.order_date,o.total_amount
FROM customers c 
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_name;

-- List all products and their associated orders 
-- (include products even if they haven’t been ordered).
SELECT p.product_name,p.product_id,o.order_id,o.order_date,o.total_amount
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
ORDER BY p.product_name;

-- Get all marketing campaigns and their results
-- (include campaigns even if there are no results).
SELECT c.result_id,m.campaign_id,m.campaign_name
FROM marketing_campaigns m
LEFT JOIN campaign_results c
ON m.campaign_id = c.campaign_id
ORDER BY m.campaign_name;
-- Find the total amount spent by each customer on orders by joining Customers and Orders.
SELECT sum(o.total_amount) as total_amount,c.customer_name
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_amount DESC;

-- Retrieve the total revenue generated for each product by joining Products with Orders.
SELECT p.product_name,p.price,sum(total_amount) as total_revenue
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name,p.price
ORDER BY total_revenue DESC;

-- List the campaign_name and the total number of clicks for each 
-- campaign by joining marketing_Campaigns with Campaign_Results.
SELECT m.campaign_name,count(c.clicks) AS total_clicks
FROM marketing_campaigns m
INNER JOIN campaign_results c
ON m.campaign_id = c.campaign_id
GROUP BY m.campaign_name
ORDER BY total_clicks;

-- Retrieve all customers who have not placed any orders.
SELECT c.customer_name,c.email,c.phone,c.address
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id is null;

-- List all products that have not been ordered by any customer.
SELECT p.product_name,p.price,o.customer_id
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id
WHERE o.order_id is null;

-- Get all campaigns that have not generated any clicks.
SELECT m.campaign_name
FROM marketing_campaigns m
LEFT JOIN campaign_results c
ON m.campaign_id = c.campaign_id
WHERE c.clicks <> null;

-- Multiple Joins
-- Retrieve customer_name, product_name, and order_date for each order.
SELECT c.customer_name,p.product_name, o.order_date,o.order_id
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY o.order_id,c.customer_name,p.product_name
ORDER BY o.order_id DESC;

-- Get product_name, customer_name, and the total order amount for orders that
-- include a specific product ("Doohickey Pro").
SELECT p.product_name,c.customer_name,sum(o.total_amount) as total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id
WHERE p.product_name = 'Doohickey Pro'
GROUP BY c.customer_name,p.product_name;
	

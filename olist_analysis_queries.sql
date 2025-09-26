
-- olist_analysis_queries.sql
-- SQL queries for Task 4: SQL for Data Analysis (works in SQLite, MySQL, PostgreSQL with minor syntax tweaks)
-- Tables: customers (from provided CSV), orders (synthetic for demo)
-- 1) Basic SELECT + LIMIT
SELECT * FROM customers LIMIT 10;

-- 2) Count customers overall
SELECT COUNT(*) AS total_customers FROM customers;

-- 3) Customers per state (GROUP BY + ORDER BY)
SELECT customer_state, COUNT(*) AS num_customers
FROM customers
GROUP BY customer_state
ORDER BY num_customers DESC
LIMIT 20;

-- 4) Filter + ORDER BY (example for a top state - replace 'SP' with your state code)
SELECT customer_id, customer_city, customer_state
FROM customers
WHERE customer_state = (SELECT customer_state FROM customers GROUP BY customer_state ORDER BY COUNT(*) DESC LIMIT 1)
ORDER BY customer_city
LIMIT 30;

-- 5) JOIN (INNER JOIN customers with orders to get order counts per customer)
SELECT c.customer_id, c.customer_city, c.customer_state,
       COUNT(o.order_id) AS num_orders, ROUND(AVG(o.order_total),2) AS avg_order_total
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY num_orders DESC
LIMIT 20;

-- 6) LEFT JOIN to find customers with zero orders (customers that are not in orders table)
SELECT c.customer_id, c.customer_city, c.customer_state
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
LIMIT 20;

-- 7) Subquery: customers who have at least one order over 500 (amount threshold)
SELECT DISTINCT c.customer_id, c.customer_city, c.customer_state
FROM customers c
WHERE c.customer_id IN (SELECT customer_id FROM orders WHERE order_total > 500);

-- 8) View creation for repeated analyses (create view of counts by state)
CREATE VIEW IF NOT EXISTS view_customers_by_state AS
SELECT customer_state, COUNT(*) AS num_customers
FROM customers
GROUP BY customer_state;

-- Querying the view:
SELECT * FROM view_customers_by_state ORDER BY num_customers DESC LIMIT 20;

-- 9) Index creation to speed lookups (example)
CREATE INDEX IF NOT EXISTS idx_customers_state ON customers(customer_state);
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);

-- 10) Example of an aggregate + HAVING (states with > 50 customers)
SELECT customer_state, COUNT(*) AS num_customers
FROM customers
GROUP BY customer_state
HAVING COUNT(*) > 50
ORDER BY num_customers DESC;

-- 11) Example of a correlated subquery (customers whose order average is above the overall avg)
SELECT c.customer_id, c.customer_city
FROM customers c
WHERE (SELECT AVG(o.order_total) FROM orders o WHERE o.customer_id = c.customer_id) >
      (SELECT AVG(order_total) FROM orders);

-- 12) Cleanup (DROP the synthetic tables/views if you created them and want to reset)
-- DROP VIEW IF EXISTS view_customers_by_state;
-- DROP TABLE IF EXISTS orders;
-- DROP INDEX IF EXISTS idx_customers_state;

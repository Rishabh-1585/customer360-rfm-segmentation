
# Create dayabase
CREATE DATABASE customer360_db;
USE customer360_db;

# Create customer table
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

# Create product table
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    price DECIMAL(12,2)
);

# Create Order Table
CREATE TABLE orders (
    order_id VARCHAR(15) PRIMARY KEY,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    order_date DATE,
    quantity INT,
    sales DECIMAL(12,2),
    discount DECIMAL(12,2),
    profit DECIMAL(12,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

# Create customer360 table
CREATE TABLE customer360 (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE,
    Recency INT,
    Frequency INT,
    Monetary DECIMAL(14,2),
    R_Score INT,
    F_Score INT,
    M_Score INT,
    RFM_Score VARCHAR(10),
    RFM_Total INT,
    Segment VARCHAR(50),
    Purchase_Status VARCHAR(20)
);

SHOW tables;

SELECT COUNT(*) AS total_customers FROM customers;

SELECT COUNT(*) AS total_orders FROM orders;

SELECT COUNT(*) AS total_products FROM products;

SELECT COUNT(*) AS total_customer360 FROM customer360;

# create customer 360 table
INSERT INTO customer360 (
    customer_id,
    customer_name,
    gender,
    age,
    city,
    state,
    signup_date,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    RFM_Score,
    RFM_Total,
    Segment,
    Purchase_Status
)
SELECT
    c.customer_id,
    c.customer_name,
    c.gender,
    c.age,
    c.city,
    c.state,
    c.signup_date,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'No Purchase',
    'No Purchase'
FROM customers c
LEFT JOIN customer360 cx
ON c.customer_id = cx.customer_id
WHERE cx.customer_id IS NULL;

SELECT COUNT(*) AS total_customers
FROM customer360;

SELECT Segment,COUNT(*) AS customer_count
FROM customer360
GROUP BY Segment
ORDER BY customer_count DESC;

SELECT 
COUNT(*) AS total_customers,
COUNT(DISTINCT customer_id) AS unique_customers
FROM customer360;

# Orders Validation to check total and unique orders
SELECT 
COUNT(*) AS total_orders,
COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

# Product validation 
SELECT 
COUNT(*) AS total_products,
COUNT(DISTINCT product_id) AS unique_products
FROM products;



								
                                
                                /* SQL Business Analysis */

# Find Total_sales, total_discount, total_profit, net_sales
SELECT SUM(sales) AS total_sales,
SUM(discount) AS total_discount,
SUM(profit) AS total_profit,
SUM(sales - discount) AS total_profit
FROM orders;

# Average order value
SELECT
ROUND(SUM(sales - discount) / COUNT(DISTINCT order_id),2) AS average_order_value
FROM orders;

# Top 10 Customers by Revenue
SELECT c.customer_id, c.customer_name, c.city, c.state,
COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(SUM(o.sales - o.discount), 2) AS total_revenue,
ROUND(SUM(o.profit), 2) AS total_profit
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name,
c.city,
c.state
ORDER BY total_revenue DESC
LIMIT 10;

# Revenue by Customer Segment
SELECT c360.Segment,COUNT(DISTINCT c360.customer_id) AS customer_count,
COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(SUM(o.sales - o.discount), 2) AS total_revenue,
ROUND(SUM(o.profit), 2) AS total_profit
FROM customer360 c360
JOIN orders o
ON c360.customer_id = o.customer_id
GROUP BY c360.Segment
ORDER BY total_revenue DESC;

# At-Risk Customers ki list
SELECT customer_id, customer_name, city, state, Recency, Frequency, Monetary, RFM_Score, Segment
FROM customer360
WHERE Segment = 'At Risk'
ORDER BY Monetary DESC;

# At-Risk Customers ka business summary
SELECT
COUNT(*) AS at_risk_customers,
ROUND(AVG(Recency), 2) AS avg_recency,
ROUND(AVG(Frequency), 2) AS avg_frequency,
ROUND(SUM(Monetary), 2) AS total_at_risk_revenue
FROM customer360
WHERE Segment = 'At Risk';

# Lost Customers List
SELECT customer_id, customer_name, city, state, Recency, Frequency, Monetary, RFM_Score, Segment
FROM customer360
WHERE Segment = 'Lost Customers'
ORDER BY Monetary DESC;

# Lost customer summary
SELECT
COUNT(*) AS lost_customers,
ROUND(AVG(Recency), 2) AS avg_recency,
ROUND(AVG(Frequency), 2) AS avg_frequency,
ROUND(SUM(Monetary), 2) AS total_lost_revenue
FROM customer360
WHERE Segment = 'Lost Customers';

# No Purchase Customers
SELECT customer_id, customer_name, gender, age, city, state, signup_date
FROM customer360
WHERE Purchase_Status = 'No Purchase'
ORDER BY signup_date;

# State-wise No Purchase Customers
SELECT state, COUNT(*) AS no_purchase_customers
FROM customer360
WHERE Purchase_Status = 'No Purchase'
GROUP BY state
ORDER BY no_purchase_customers DESC;

# No Purchase Summary
SELECT COUNT(*) AS no_purchase_customers, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer360),2) AS no_purchase_percentage
FROM customer360
WHERE Purchase_Status = 'No Purchase';

# Customer Purchase Frequency
SELECT
customer_id,
COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY customer_id;

#2
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
) AS customer_orders
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;
    
# Repeat Customer %
SELECT
ROUND(COUNT(*) * 100.0 /(SELECT COUNT(DISTINCT customer_id) FROM orders),2) AS repeat_customer_percentage
FROM (SELECT customer_id FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1) AS repeat_customers;

# State-wise Analysis 🇮🇳
SELECT c.state, COUNT(DISTINCT c.customer_id) AS total_customers, COUNT(DISTINCT o.order_id) AS total_orders,
ROUND(SUM(o.sales - o.discount), 2) AS total_revenue,
ROUND(SUM(o.profit), 2) AS total_profit
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_revenue DESC;

# Category-wise Analysis
SELECT p.category, COUNT(DISTINCT o.order_id) AS total_orders, SUM(o.quantity) AS total_quantity, ROUND(SUM(o.sales - o.discount), 2) AS total_revenue,
ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

# Monthly & Yearly Sales Trend
SELECT YEAR(order_date) AS order_year, COUNT(DISTINCT order_id) AS total_orders, ROUND(SUM(sales - discount), 2) AS total_revenue,
ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

#Monthly Revenue Trend
SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month,
ROUND(SUM(sales - discount), 2) AS total_revenue,
ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

# Customer Retention Analysis
SELECT COUNT(DISTINCT customer_id) AS total_customers, COUNT(DISTINCT CASE
WHEN order_count > 1 THEN customer_id END) AS repeat_customers, COUNT(DISTINCT CASE
WHEN order_count = 1 THEN customer_id END) AS one_time_customers
FROM (SELECT customer_id, COUNT(DISTINCT order_id) AS order_count FROM orders 
GROUP BY customer_id ) AS customer_orders;

# Repeat Customer %
SELECT ROUND(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM orders), 2
    ) AS repeat_customer_percentage
FROM (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(DISTINCT order_id) > 1
) AS repeat_customers;

# High-Value Customer Analysis
SELECT customer_id, customer_name, city, state, Recency, Frequency,
ROUND(Monetary, 2) AS Monetary, RFM_Score, Segment
FROM customer360
WHERE Purchase_Status = 'Purchased'
ORDER BY Monetary DESC
LIMIT 20;

# Final Business Insights
SELECT(SELECT COUNT(*) FROM customers) AS total_customers, (SELECT COUNT(*) FROM orders) AS total_orders,
(SELECT COUNT(*) FROM products) AS total_products,
(SELECT ROUND(SUM(sales - discount), 2) FROM orders) AS total_revenue,
(SELECT ROUND(SUM(profit), 2) FROM orders) AS total_profit,
(SELECT COUNT(*)
FROM customer360
WHERE Segment = 'Champions') AS champions, (SELECT COUNT(*)
FROM customer360
WHERE Segment = 'At Risk') AS at_risk_customers, (SELECT COUNT(*) FROM customer360
WHERE Purchase_Status = 'No Purchase') AS no_purchase_customers;
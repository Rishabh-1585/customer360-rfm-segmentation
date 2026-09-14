# customer360-rfm-segmentation
RFM-based Customer Segmentation &amp; Analytics project using Python, SQL, and Power BI to analyze customer behavior, value, retention, and purchasing patterns.

# Customer360 – RFM-Based Customer Segmentation & Analytics

An end-to-end **Customer Analytics and RFM-based Customer Segmentation** project built using **Python, SQL/MySQL, and Power BI**. The project analyzes customer purchasing behavior, identifies high-value and at-risk customers, and provides actionable business insights through an interactive dashboard.

---

## 📌 Project Overview

Businesses often have a large amount of customer and transaction data but struggle to identify:

* Who their most valuable customers are
* Which customers are loyal
* Which customers are at risk of leaving
* Which customers have become inactive
* Which customer segments generate the most revenue
* How customer behavior changes over time

## 📌 Project Flow
**CSV Data → Python/Pandas → MySQL/SQL → RFM Analysis → Customer Segmentation → Power BI Dashboard → Business Insights**

---

## 🎯 Business Objective

The main objective is to analyze customer behavior and divide customers into meaningful segments so that businesses can make better decisions related to:

* Customer retention
* Marketing campaigns
* Customer loyalty
* Revenue optimization
* Customer reactivation
* Personalized offers

---

## ❓ Business Questions

This project answers questions such as:

1. Who are the most valuable customers?
2. Which customers purchase most frequently?
3. Which customers generate the highest revenue?
4. Which customers are at risk of becoming inactive?
5. How many customers belong to each segment?
6. Which segment generates the highest revenue?
7. Which states/cities generate the highest sales?
8. Which product categories are preferred by different customer segments?
9. Who are the top customers by revenue?
10. How do sales and orders change over time?
11. Which customers should be targeted for retention?
12. Which customers should receive reactivation campaigns?

---

# 📊 Dataset

The project uses **3 CSV datasets**.

| Dataset         |   Rows | Columns | Description                        |
| --------------- | -----: | ------: | ---------------------------------- |
| `customers.csv` |  5,000 |       7 | Customer information               |
| `orders.csv`    | 35,000 |       8 | Customer transaction/order history |
| `products.csv`  |    300 |       5 | Product information                |

---

## 👥 Customers Dataset

`customers.csv`

| Column          | Description                |
| --------------- | -------------------------- |
| `customer_id`   | Unique customer ID         |
| `customer_name` | Customer name              |
| `gender`        | Customer gender            |
| `age`           | Customer age               |
| `city`          | Customer city              |
| `state`         | Customer state             |
| `signup_date`   | Customer registration date |

---

## 🛒 Orders Dataset

`orders.csv`

| Column        | Description                   |
| ------------- | ----------------------------- |
| `order_id`    | Unique order ID               |
| `customer_id` | Customer who placed the order |
| `product_id`  | Purchased product             |
| `order_date`  | Order date                    |
| `quantity`    | Quantity purchased            |
| `sales`       | Sales/revenue amount          |
| `discount`    | Discount applied              |
| `profit`      | Profit generated              |

---

## 📦 Products Dataset

`products.csv`

| Column         | Description          |
| -------------- | -------------------- |
| `product_id`   | Unique product ID    |
| `product_name` | Product name         |
| `category`     | Product category     |
| `sub_category` | Product sub-category |
| `price`        | Product price        |

### Product Categories

* Electronics
* Furniture
* Office Supplies

---

# 🔗 Data Model

The datasets are connected using common IDs.

```text
customers
    |
    | customer_id
    ↓
orders
    |
    | product_id
    ↓
products
```

### Relationships

```text
customers.customer_id
        ↓
orders.customer_id

products.product_id
        ↓
orders.product_id
```
---


# 🛠️ Technology Stack

| Technology     | Purpose                               |
| -------------- | ------------------------------------- |
| **Python**     | Data cleaning and analysis            |
| **Pandas**     | Data manipulation and preprocessing   |
| **NumPy**      | Numerical operations                  |
| **Matplotlib** | Data visualization                    |
| **MySQL**      | Database management                   |
| **SQL**        | Data querying and business analysis   |
| **Power BI**   | Interactive dashboard                 |
| **DAX**        | Power BI calculations and measures    |
| **GitHub**     | Version control and project portfolio |

---

# 🔄 Project Workflow

```text
Raw CSV Data
     ↓
Data Exploration
     ↓
Data Cleaning
     ↓
Python / Pandas
     ↓
MySQL Database
     ↓
SQL Analysis
     ↓
RFM Calculation
     ↓
Customer Segmentation
     ↓
Power BI Data Model
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Business Insights
```

---

# 🧹 Data Cleaning

Python and Pandas are used for:

* Checking missing values
* Removing duplicate records
* Checking incorrect data types
* Handling inconsistent values
* Validating customer IDs
* Validating product IDs
* Checking invalid dates
* Checking numerical values
* Preparing clean analytical datasets

---

# 🗄️ SQL Analysis

MySQL is used to perform analysis such as:

* Total customers
* Total orders
* Total revenue
* Average Order Value
* Customer order frequency
* Revenue by customer
* Revenue by category
* Revenue by state
* Top customers
* Repeat customers
* Customer purchase behavior
* Segment-level analysis



# 📊 Power BI Dashboard

The Power BI dashboard contains **3 main pages**.

## 1️⃣ Customer Overview

Key KPIs:

* Total Customers
* Total Orders
* Total Revenue
* Average Order Value
* Repeat Customers
* Retention %

Visualizations:

* Monthly Revenue
* Monthly Orders
* Customer Segment Distribution
* Revenue by Segment
* Customers by State

---

## 2️⃣ Customer Segmentation

This page focuses on RFM and customer segments.

Visualizations:

* Customers by Segment
* Revenue by Segment
* Frequency vs Monetary Scatter Plot
* Recency by Segment
* Category × Segment
* Segment Revenue Contribution

---

## 3️⃣ Customer Details

This page provides detailed customer-level analysis.

Filters:

* Segment
* State
* City
* Gender
* Category
* Year
* Month

Visualizations:

* Top 10 Customers by Revenue
* Top 10 Customers by Orders
* Customer Purchase Trend
* At-Risk Customer Table
* Customer Details Matrix

---

# 📌 Key Performance Indicators

The dashboard focuses on important KPIs including:

```text
Total Customers
Total Orders
Total Revenue
Average Order Value
Repeat Customers
Retention %
Champions
Loyal Customers
At-Risk Customers
Lost Customers
Average RFM Score
```

---

# 💡 Business Insights

The project can be used to identify:

### 🏆 High-Value Customers

Customers with high RFM scores can be targeted with:

* Loyalty programs
* Premium offers
* Early product access
* Personalized recommendations

### ⚠️ At-Risk Customers

Customers showing declining activity can be targeted through:

* Re-engagement campaigns
* Personalized discounts
* Email campaigns
* Special offers

### 🆕 New Customers

New customers can be encouraged to make repeat purchases through:

* Welcome campaigns
* Second-purchase discounts
* Product recommendations



# 👨‍💻 Author

**Rishabh Sharma**

B.Tech – Computer Science & Engineering

**Focus:** Data Analytics | Python | SQL | Power BI | MySQL

---

## ⭐ Project Highlights

> **Customer360 combines Python, SQL, RFM Analysis and Power BI to transform raw customer transaction data into actionable customer insights.**

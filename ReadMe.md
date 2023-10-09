# Inventory Management System (SQL)

## Overview

The Inventory Management System is a robust SQL-based solution designed to manage various aspects of inventory, including products, brands, categories, stores, customers, and transactions.
This project provides a well-structured SQL database schema and a set of SQL scripts to create and manage an inventory system.

## Features

### 1. Data Management

- **Brands**: Create and manage brand information.
- **Categories**: Organize products into categories for easy classification.
- **Stores**: Add store details, including name, address, and contact information.
- **Products**: Define product information, including category, brand, stock, and price.
- **Customer Cart**: Maintain customer shopping carts.
- **Selected Products**: Track selected products in customer carts.
- **Transactions**: Manage sales transactions, including total amount, payments, and due amounts.
- **Invoices**: Generate invoices for completed transactions.
- **Inventory User**: Register and manage user accounts for system administration.

### 2. Database Relations

- Establishes relationships between tables for seamless data retrieval and consistency.
- Utilizes primary keys, foreign keys, and indices to maintain data integrity.

### 3. Data Analysis

- SQL queries can be employed to retrieve valuable insights about the inventory, sales, and customer data.

## Getting Started

To set up and use the Inventory Management System:

1. Execute the SQL scripts provided to create the database schema.
2. Populate the tables with data using SQL INSERT statements.
3. Customize the database according to your specific inventory needs.
4. Explore the provided SQL queries for data analysis and management.

## Usage

- Use the system to manage inventory, track sales, and generate invoices.
- Query the database to retrieve information about products, customers, and transactions.
- Modify and extend the system to fit your unique inventory management requirements.

## Analysis
The analysis SQL file performs these analyses.

1. **Retrieve Total Sales per Product Category:**
   - This query calculates the total sales for each product category in the inventory management database (`inv_mgm`).
   - It achieves this by joining the `categories`, `product`, and `transaction` tables using their respective IDs.
   - The result is grouped by `category_name`, and the `SUM` function is used to calculate the total sales (`total_amount`) for each category.

2. **Calculate the Average Discount Offered by Brands:**
   - This query computes the average discount offered by each brand in the database.
   - It involves a join between the `brands` and `provides` tables based on the `bid` (brand ID).
   - The `AVG` function is used to calculate the average discount (`discount`) provided by each brand.
   - The result is grouped by `bname`, displaying the brand names and their respective average discounts.

3. **Calculate Net Profit for Each Transaction:**
   - This query calculates the net profit for each transaction in the database.
   - It subtracts the total amount paid (`paid`) from the total amount of the transaction (`total_amount`).
   - The result includes the transaction ID (`id`) and the computed net profit for each transaction.

4. **Identify Products with Low Stock:**
   - This query retrieves products from the `product` table that have low stock levels, specifically those with less than 5 units in stock (`p_stock < 5`).
   - It selects the product name (`pname`) and the current stock level (`p_stock`) for each product that meets the criteria.

5. **Generate a Report of Top-Selling Products:**
   - This query generates a report of the top-selling products in the inventory management system.
   - It joins the `product` and `select_product` tables using the product ID (`pid`) as the common identifier.
   - The query calculates the total quantity sold (`total_quantity_sold`) for each product by summing the quantities purchased across all transactions.
   - The results are then ordered in descending order of total quantity sold (`ORDER BY total_quantity_sold DESC`) and limited to the top 5 products (`LIMIT 5`).

These SQL queries show various data analysis tasks, including summarizing sales data, calculating averages, identifying low-stock products, and generating reports of top-selling products, which can be valuable skills for a data analyst role.

## Conclusion

The Inventory Management System is a versatile and powerful SQL-based solution that can help businesses of all sizes improve their inventory management, sales tracking, and invoice generation processes. It is also highly customizable, making it a valuable tool for businesses with unique inventory management needs.

-- Create Database Inventory Management
CREATE DATABASE inv_mgm;

-- Create tables in the 'inv_mgm' database
CREATE TABLE inv_mgm.brands (
    bid INT(5), 
    bname VARCHAR(20)
);

ALTER TABLE inv_mgm.brands
ADD PRIMARY KEY (bid);

CREATE TABLE inv_mgm.inv_user(
    user_id VARCHAR(20),
    name VARCHAR(20),
    password VARCHAR(20),
    last_login TIMESTAMP,
    user_type VARCHAR(10)
);

CREATE TABLE inv_mgm.categories(
    cid INT(5),
    category_name VARCHAR(20)
);

ALTER TABLE inv_mgm.categories
ADD PRIMARY KEY (cid);

ALTER TABLE inv_mgm.inv_user
ADD PRIMARY KEY (user_id);

CREATE TABLE inv_mgm.product(
	pid INT(5) primary key,
    cid INT(5) references categories(cid),
    bid INT(5) references brands(bid),
    sid INT(5),
    pname varchar(20),
    p_stock INT(5),
    price INT(5),
    added_date date
);

CREATE TABLE inv_mgm.stores(
    sid INT(5),
    sname VARCHAR(20),
    address VARCHAR(20),
    mobno BIGINT(10)
);

ALTER TABLE inv_mgm.stores
ADD PRIMARY KEY (sid);

ALTER TABLE inv_mgm.product
ADD FOREIGN KEY (sid) REFERENCES inv_mgm.stores(sid);

CREATE TABLE inv_mgm.provides(
    bid INT(5) REFERENCES inv_mgm.brands(bid),
    sid INT(5) REFERENCES inv_mgm.stores(sid),
    discount INT(5)
);

CREATE TABLE inv_mgm.customer_cart (
    cust_id INT(5) PRIMARY KEY,
    name VARCHAR(20),
    mobno BIGINT(10)
);

CREATE TABLE inv_mgm.select_product (
    cust_id INT(5) REFERENCES inv_mgm.customer_cart(cust_id),
    pid INT(5) REFERENCES inv_mgm.product(pid),
    quantity INT(4)
);

CREATE TABLE inv_mgm.transaction (
    id INT(5) PRIMARY KEY,
    total_amount INT(5),
    paid INT(5),
    due INT(5),
    gst INT(3),
    discount INT(5),
    payment_method VARCHAR(10),
    cart_id INT(5) REFERENCES inv_mgm.customer_cart(cust_id)
);

CREATE TABLE inv_mgm.invoice (
    item_no INT(5),
    product_name VARCHAR(20),
    quantity INT(5),
    net_price INT(5),
    transaction_id INT(5) REFERENCES inv_mgm.transaction(id)
);

-- Insert data into tables in the 'inv_mgm' database
-- Brands
INSERT INTO inv_mgm.brands (bid, bname) VALUES
(1, 'Company 1'),
(2, 'Company 2'),
(3, 'Company 3'),
(4, 'Company 4');

-- Inv_user
INSERT INTO inv_mgm.inv_user (user_id, name, password, last_login, user_type) VALUES
('email_id 1', 'Name1', 'Password', '%Y-%M-%D', '%User1'),
('email_id 2', 'Name2', 'Password', 'YYYY-MM-DD HH:MM:SS', 'User_role 2'),
('email_id 3', 'Name3', 'Password', 'YYYY-MM-DD HH:MM:SS', 'User_role 3');

-- Categories
INSERT INTO inv_mgm.categories (cid, category_name) VALUES
(1, 'Category 1'),
(2, 'Category 2'),
(3, 'Category 3');

-- Stores
INSERT INTO inv_mgm.stores (sid, sname, address, mobno) VALUES
(1, 'Name 1', 'City 1', 'Phone Number 1'),
(2, 'Name 2', 'City 2', 'Phone Number 2'),
(3, 'Name 3', 'City 3', 'Phone Number 3');

-- Products
INSERT INTO inv_mgm.product (pid, cid, bid, sid, pname, p_stock, price, added_date) VALUES
(1, 1, 1, 1, 'IPHONE', 4, 45000, '2018-10-31'),
(2, 1, 1, 1, 'Airpods', 3, 19000, '2018-10-27'),
(3, 1, 1, 1, 'Smart Watch', 3, 19000, '2018-10-27'),
(4, 2, 3, 2, 'Air Max', 6, 7000, '2018-10-27'),
(5, 3, 4, 3, 'REFINED OIL', 6, 750, '2018-10-25');

-- Provides
INSERT INTO inv_mgm.provides (bid, sid, discount) VALUES
(1, 1, 12),
(2, 2, 7),
(3, 3, 15),
(1, 2, 7),
(4, 2, 19),
(4, 3, 20);

-- Customer_cart
INSERT INTO inv_mgm.customer_cart (cust_id, name, mobno) VALUES
(1, 'Ram', 9876543210),
(2, 'Shyam', 7777777777),
(3, 'Mohan', 7777777775);

-- Select_product
INSERT INTO inv_mgm.select_product (cust_id, pid, quantity) VALUES
(1, 2, 2),
(1, 3, 1),
(2, 3, 3),
(3, 2, 1);

-- Transaction
INSERT INTO inv_mgm.transaction (id, total_amount, paid, due, gst, discount, payment_method, cart_id) VALUES
(1, 57000, 20000, 5000, 350, 350, 'card', 1),
(2, 57000, 57000, 0, 570, 570, 'cash', 2),
(3, 19000, 17000, 2000, 190, 190, 'cash', 3);

-- Invoice
INSERT INTO inv_mgm.invoice (item_no, product_name, quantity, net_price, transaction_id) VALUES
(1, 'Product1', 2, 100, 1),
(2, 'Product2', 1, 50, 2),
(3, 'Product3', 3, 150, 2);

-- PL/SQL Blocks

-- 1. PL/SQL Block to retrieve 'due' value
DELIMITER //
CREATE PROCEDURE inv_mgm.GetDue(IN c_id INT)
BEGIN
    DECLARE due1 INT;
    DECLARE cart_id1 INT;
    
    SELECT cart_id INTO cart_id1 FROM inv_mgm.customer_cart WHERE cust_id = c_id;
    SELECT due INTO due1 FROM inv_mgm.transaction WHERE cart_id = cart_id1;
    
    SELECT due1 AS 'Due Amount';
END;
//
DELIMITER ;

-- Example usage of the stored procedure
CALL inv_mgm.GetDue(1);

-- 2. PL/SQL Block to display product information using a cursor
DELIMITER //
CREATE PROCEDURE inv_mgm.DisplayProducts()
BEGIN
    DECLARE p_id INT;
    DECLARE p_name VARCHAR(20);
    DECLARE p_stock INT;
    
    DECLARE done INT DEFAULT 0;
    
    -- Declare a cursor for the product table
    DECLARE cur_product CURSOR FOR
        SELECT pid, pname, p_stock FROM inv_mgm.product;
    
    -- Declare handler for NOT FOUND condition
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur_product;
    
    -- Loop to fetch and display product information
    read_loop: LOOP
        FETCH cur_product INTO p_id, p_name, p_stock;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT(p_id, ' ', p_name, ' ', p_stock) AS 'Product Info';
    END LOOP;
    
    CLOSE cur_product;
END;
//
DELIMITER ;

-- Example usage of the stored procedure
CALL inv_mgm.DisplayProducts();

-- 3. PL/SQL Block to check stock
DELIMITER //
CREATE PROCEDURE inv_mgm.CheckStock(IN b INT)
BEGIN
    DECLARE a INT;
    
    SELECT p_stock INTO a FROM inv_mgm.product WHERE pid = b;
    
    IF a < 2 THEN
        SELECT 'Stock is Less';
    ELSE
        SELECT 'Enough Stock';
    END IF;
END;
//
DELIMITER ;

-- Example usage of the stored procedure
CALL CheckStock(2);

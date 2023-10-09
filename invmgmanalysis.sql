-- Retrieve total sales per product category
SELECT c.category_name, SUM(t.total_amount) AS total_sales
FROM inv_mgm.categories c
JOIN inv_mgm.product p ON c.cid = p.cid
JOIN inv_mgm.transaction t ON p.pid = t.cart_id
GROUP BY c.category_name;

-- Calculate the average discount offered by brands
SELECT b.bname, AVG(pr.discount) AS average_discount
FROM inv_mgm.brands b
JOIN inv_mgm.provides pr ON b.bid = pr.bid
GROUP BY b.bname;

-- Calculate net profit for each transaction
SELECT t.id, (t.paid - t.total_amount) AS net_profit
FROM inv_mgm.transaction t;

-- Identify products with low stock
SELECT p.pname, p.p_stock
FROM inv_mgm.product p
WHERE p.p_stock < 5;

-- Generate a report of top-selling products
SELECT p.pname, SUM(sp.quantity) AS total_quantity_sold
FROM inv_mgm.product p
JOIN inv_mgm.select_product sp ON p.pid = sp.pid
GROUP BY p.pname
ORDER BY total_quantity_sold DESC
LIMIT 5;

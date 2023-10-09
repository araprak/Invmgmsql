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



-- Example Queries — E-commerce Inventory System

USE ecommerce_inventory;

-- 1. List all products with their category name
SELECT p.name AS product, c.name AS category, p.price, p.stock_quantity
FROM Product p
JOIN Category c ON p.category_id = c.category_id;

-- 2. Find products supplied by more than one supplier
SELECT p.name, COUNT(ps.supplier_id) AS supplier_count
FROM Product p
JOIN Product_Supplier ps ON p.product_id = ps.product_id
GROUP BY p.product_id, p.name
HAVING COUNT(ps.supplier_id) > 1;

-- 3. Total revenue per customer
SELECT cu.name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM Customer cu
JOIN Orders o ON cu.customer_id = o.customer_id
JOIN Order_Item oi ON o.order_id = oi.order_id
GROUP BY cu.customer_id, cu.name
ORDER BY total_spent DESC;

-- 4. Products that have never been ordered (subquery)
SELECT p.name
FROM Product p
WHERE p.product_id NOT IN (SELECT DISTINCT product_id FROM Order_Item);

-- 5. Best-selling product by quantity
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM Product p
JOIN Order_Item oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_sold DESC
LIMIT 1;

-- 6. Orders with their status and total (using the view)
SELECT * FROM vw_order_summary;

-- 7. Current low-stock alert list (using the view)
SELECT * FROM vw_low_stock_products;

-- 8. Suppliers who supply products in the 'Electronics' category
SELECT DISTINCT s.name
FROM Supplier s
JOIN Product_Supplier ps ON s.supplier_id = ps.supplier_id
JOIN Product p ON ps.product_id = p.product_id
JOIN Category c ON p.category_id = c.category_id
WHERE c.name = 'Electronics';

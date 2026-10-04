-- ============================================================
-- Sample Data — E-commerce Inventory System
-- ============================================================
USE ecommerce_inventory;

-- Categories
INSERT INTO Category (name) VALUES
('Electronics'), ('Apparel'), ('Home & Kitchen'), ('Books'), ('Sports');

-- Products
INSERT INTO Product (name, category_id, price, stock_quantity, reorder_level) VALUES
('Wireless Mouse',        1, 799.00,  50, 10),
('Mechanical Keyboard',   1, 2999.00, 30, 5),
('Cotton T-Shirt',        2, 499.00,  100, 20),
('Denim Jacket',          2, 1999.00, 25, 5),
('Non-stick Pan',         3, 899.00,  40, 8),
('Blender',               3, 1799.00, 15, 5),
('Database Systems Book', 4, 650.00,  60, 10),
('Cricket Bat',           5, 1499.00, 20, 5);

-- Suppliers
INSERT INTO Supplier (name, contact, address) VALUES
('TechDistributors Pvt Ltd', '9876543210', 'Bhopal, MP'),
('FashionHub Wholesale',      '9123456780', 'Indore, MP'),
('HomeEssentials Co.',        '9988776655', 'Bhopal, MP');

-- Product-Supplier mapping
INSERT INTO Product_Supplier (product_id, supplier_id, cost_price, supply_date) VALUES
(1, 1, 550.00, '2026-06-01'),
(2, 1, 2200.00, '2026-06-01'),
(3, 2, 300.00, '2026-06-05'),
(4, 2, 1400.00, '2026-06-05'),
(5, 3, 600.00, '2026-06-10'),
(6, 3, 1200.00, '2026-06-10');

-- Customers
INSERT INTO Customer (name, email, phone, address) VALUES
('Aarav Sharma',  'aarav.sharma@example.com',  '9000011111', 'Bhopal, MP'),
('Priya Nair',    'priya.nair@example.com',    '9000022222', 'Indore, MP'),
('Rohan Mehta',   'rohan.mehta@example.com',   '9000033333', 'Gwalior, MP');

-- Orders
INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2026-08-20', 'Delivered'),
(2, '2026-08-25', 'Shipped'),
(1, '2026-09-01', 'Pending');

-- Order Items
INSERT INTO Order_Item (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 799.00),
(1, 3, 1, 499.00),
(2, 5, 1, 899.00),
(3, 7, 3, 650.00);

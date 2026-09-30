-- ============================================================
-- E-commerce Inventory System — Schema (CSE3001 DBMS Project)
-- ============================================================

DROP DATABASE IF EXISTS ecommerce_inventory;
CREATE DATABASE ecommerce_inventory;
USE ecommerce_inventory;

-- ------------------------------------------------------------
-- Category
-- ------------------------------------------------------------
CREATE TABLE Category (
    category_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(50) NOT NULL UNIQUE
);

-- ------------------------------------------------------------
-- Product
-- ------------------------------------------------------------
CREATE TABLE Product (
    product_id     INT AUTO_INCREMENT PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    category_id    INT NOT NULL,
    price          DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    reorder_level  INT NOT NULL DEFAULT 10,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ------------------------------------------------------------
-- Supplier
-- ------------------------------------------------------------
CREATE TABLE Supplier (
    supplier_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    contact       VARCHAR(20),
    address       VARCHAR(200)
);

-- ------------------------------------------------------------
-- Product_Supplier (resolves M:N between Product and Supplier)
-- ------------------------------------------------------------
CREATE TABLE Product_Supplier (
    product_id    INT NOT NULL,
    supplier_id   INT NOT NULL,
    cost_price    DECIMAL(10,2) NOT NULL CHECK (cost_price >= 0),
    supply_date   DATE NOT NULL,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- Customer
-- ------------------------------------------------------------
CREATE TABLE Customer (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    phone         VARCHAR(20),
    address       VARCHAR(200)
);

-- ------------------------------------------------------------
-- Orders
-- ------------------------------------------------------------
CREATE TABLE Orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT NOT NULL,
    order_date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    status        ENUM('Pending','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ------------------------------------------------------------
-- Order_Item (resolves M:N between Orders and Product)
-- ------------------------------------------------------------
CREATE TABLE Order_Item (
    order_id      INT NOT NULL,
    product_id    INT NOT NULL,
    quantity      INT NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- ------------------------------------------------------------
-- Indexes to speed up common lookups
-- ------------------------------------------------------------
CREATE INDEX idx_product_category ON Product(category_id);
CREATE INDEX idx_order_customer   ON Orders(customer_id);
CREATE INDEX idx_orderitem_product ON Order_Item(product_id);

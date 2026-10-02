-- ============================================================
-- Triggers & Views — E-commerce Inventory System
-- ============================================================
USE ecommerce_inventory;

-- ------------------------------------------------------------
-- Trigger: auto-decrement stock when an order item is placed
-- ------------------------------------------------------------
DELIMITER $$

CREATE TRIGGER trg_reduce_stock_after_order
AFTER INSERT ON Order_Item
FOR EACH ROW
BEGIN
    UPDATE Product
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END$$

DELIMITER ;

-- ------------------------------------------------------------
-- Trigger: prevent negative stock (raises a signal instead)
-- ------------------------------------------------------------
DELIMITER $$

CREATE TRIGGER trg_check_stock_before_order
BEFORE INSERT ON Order_Item
FOR EACH ROW
BEGIN
    DECLARE available INT;
    SELECT stock_quantity INTO available
    FROM Product
    WHERE product_id = NEW.product_id;

    IF available < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this product';
    END IF;
END$$

DELIMITER ;

-- ------------------------------------------------------------
-- View: products below reorder level (low-stock report)
-- ------------------------------------------------------------
CREATE VIEW vw_low_stock_products AS
SELECT p.product_id, p.name, c.name AS category, p.stock_quantity, p.reorder_level
FROM Product p
JOIN Category c ON p.category_id = c.category_id
WHERE p.stock_quantity <= p.reorder_level;

-- ------------------------------------------------------------
-- View: order summary with customer and total value
-- ------------------------------------------------------------
CREATE VIEW vw_order_summary AS
SELECT o.order_id, cu.name AS customer_name, o.order_date, o.status,
       SUM(oi.quantity * oi.unit_price) AS order_total
FROM Orders o
JOIN Customer cu ON o.customer_id = cu.customer_id
JOIN Order_Item oi ON o.order_id = oi.order_id
GROUP BY o.order_id, cu.name, o.order_date, o.status;

-- Whenever there is an update to the 'orders_products' table, then
-- the 'order_balance column' from table 'Orders' gets updated.

DELIMITER ;;
CREATE DEFINER = CURRENT_USER TRIGGER UPDATE_BALANCE_ON_UPDATE_PRODUCTS_ORDERS_TABLE
AFTER UPDATE ON order_tracker.orders_products FOR EACH ROW
BEGIN
    UPDATE order_tracker.orders
    SET order_balance = 
    (SELECT SUM(product_price * order_product_qty) 
    FROM products 
    JOIN orders_products 
    USING (product_id)
    WHERE order_id = OLD.order_id
    GROUP BY order_id)
    WHERE order_id = OLD.order_id;
END;
;;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER = CURRENT_USER TRIGGER UPDATE_BALANCE_ON_INSERT_PRODUCTS_ORDERS_TABLE
AFTER INSERT ON order_tracker.orders_products FOR EACH ROW
BEGIN
    UPDATE order_tracker.orders
    SET order_balance = 
    (SELECT SUM(product_price * order_product_qty) 
    FROM products 
    JOIN orders_products 
    USING (product_id)
    WHERE order_id = NEW.order_id
    GROUP BY order_id)
    WHERE order_id = NEW.order_id;
END;
;;
DELIMITER ;

-- Note:  need to update foreign keys on tables and set those constraints

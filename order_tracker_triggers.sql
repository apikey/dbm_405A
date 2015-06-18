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


DELIMITER ;;
CREATE DEFINER = CURRENT_USER TRIGGER UPDATE_BALANCE_ON_DELETE_PRODUCTS_ORDERS_TABLE
AFTER DELETE ON order_tracker.orders_products FOR EACH ROW
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

-- create a trigger that updates the order_balance when there is a payment
-- applied or payment reversed
DELIMITER ;;
CREATE DEFINER = CURRENT_USER TRIGGER UPDATE_BALANCE_WHEN_PAYMENT_RECEIVED
BEFORE UPDATE ON order_tracker.orders FOR EACH ROW
BEGIN
    IF NEW.order_payment > OLD.order_payment THEN
        SET NEW.order_balance = (NEW.order_balance - NEW.order_payment);
    ELSEIF NEW.order_payment  < OLD.order_payment THEN
        SET NEW.order_balance = (OLD.order_payment + OLD.order_balance);
    END IF;
END;
;;
DELIMITER ;

-- Note:  need to update foreign keys on tables and set those constraints
-- Note: Updating of OLD row is not allowed in trigger













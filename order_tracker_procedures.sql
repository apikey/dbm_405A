DELIMITER ;;
CREATE PROCEDURE addCustomer
(
IN p_lastname   VARCHAR(40), 
IN p_firstname  VARCHAR(30), 
IN p_street     VARCHAR(40),
IN p_city       VARCHAR(40),
IN p_state      CHAR(2),
IN p_zipcode    VARCHAR(10),
IN p_homephone  VARCHAR(20),
IN p_cellphone  VARCHAR(20),
IN p_workphone  VARCHAR(20),
IN p_fax        VARCHAR(20),
IN p_email      VARCHAR(255)
)
BEGIN
    INSERT INTO order_tracker.customers
    (
    cust_lastname, 
    cust_firstname, 
    cust_street, 
    cust_city,
    cust_state,
    cust_zipcode,
    cust_homephone,
    cust_cellphone,
    cust_workphone,
    cust_fax,
    cust_email, 
    cust_created
    )
    VALUES
    (
    p_lastname, 
    p_firstname, 
    p_street,
    p_city, 
    p_state, 
    p_zipcode,
    p_homephone, 
    p_cellphone, 
    p_workphone,
    p_fax,
    p_email,
    CURRENT_DATE()
    );
    BEGIN
        SELECT cust_firstname, cust_lastname
        FROM order_tracker.customers
        WHERE cust_id = (SELECT MAX(cust_id) FROM order_tracker.customers);
    END;
END;
;;
DELIMITER ;


-- procedures for updating different fields in the customers table
DELIMITER ;;
CREATE PROCEDURE updateCustomer(IN p_cust_id INTEGER, IN p_field_to_update INTEGER, IN p_updateValue VARCHAR(255))
BEGIN
    CASE p_field_to_update
    WHEN 1 THEN 
        UPDATE order_tracker.customers
        SET cust_lastname = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 2 THEN
        UPDATE order_tracker.customers
        SET cust_firstname = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 3 THEN
        UPDATE order_tracker.customers
        SET cust_street = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 4 THEN
        UPDATE order_tracker.customers
        SET cust_city = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 5 THEN
        UPDATE order_tracker.customers
        SET cust_state = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 6 THEN
        UPDATE order_tracker.customers
        SET cust_zipcode = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 7 THEN
        UPDATE order_tracker.customers
        SET cust_homephone = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 8 THEN
        UPDATE order_tracker.customers
        SET cust_cellphone = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 9 THEN
        UPDATE order_tracker.customers
        SET cust_workphone = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 10 THEN
        UPDATE order_tracker.customers
        SET cust_fax = p_updateValue
        WHERE cust_id = p_cust_id;
    WHEN 11 THEN
        UPDATE order_tracker.customers
        SET cust_email = p_updateValue
        WHERE cust_id = p_cust_id;
    END CASE;
END;
;;
DELIMITER ;


































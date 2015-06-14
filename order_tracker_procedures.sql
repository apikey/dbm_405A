DELIMITER ;;
CREATE PROCEDURE addCustomer
(
IN p_lastname   VARCHAR(40), 
IN p_firstname  VARCHAR(30), 
IN p_street     VARCHAR(40),
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
    p_sttate, 
    p_zipcode,
    p_homephone, 
    p_cellphone, 
    p_workphone,
    p_fax,
    p_email,
    CURRENT_DATE()
    );
END;
;;
DELIMITER ;

USE sql_invoicing;

DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments(
	client_id INT,
    payment_method TINYINT
)
BEGIN
	SELECT *
    FROM payments p
    WHERE p.client_id = IFNULL(client_id, p.client_id)
	  AND p.payment_method = IFNULL(payment_method, p.payment_method);
END $$ 
DELIMITER ;
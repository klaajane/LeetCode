--------------------------------------- SOLUTION -------------------------------------
-- Find customers with at least one order type 0
WITH customers_0_order_type AS 
    (
    SELECT
        customer_id,
        SUM(CASE WHEN order_type = 0 THEN 1 ELSE 0 END) "0_order_check"
    FROM orders
    GROUP BY 1
    HAVING SUM(CASE WHEN order_type = 0 THEN 1 ELSE 0 END) >= 1
    )
,

records_to_exclude AS 
    (
    SELECT
        order_id,
        customer_id,
        order_type
    FROM orders o
    WHERE (order_type = 1
    AND customer_id IN (SELECT customer_id FROM customers_0_order_type))
    )

SELECT * FROM orders

EXCEPT 

SELECT * FROM records_to_exclude
    
---------------------------------------- NOTES ---------------------------------------
--> query goal: report all orders based on the following criteria:
    --> don't report any order type 1 from customer with COUNT(order(0)) >= 0
    --> otherwise report all order
--------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
WITH order_type AS (
    SELECT
        ---order_id,
        customer_id,
        ---order_type,
        SUM(CASE 
            WHEN order_type = 0 THEN 1
                ELSE 0
            END) AS "ordertype0_count"
    FROM
        Orders
    GROUP BY 1)

SELECT order_id, customer_id, order_type 
FROM orders 
WHERE order_type = 0 AND customer_id IN (SELECT customer_id FROM order_type WHERE ordertype0_count >= 1)
    UNION ALL
SELECT o.order_id, o.customer_id, o.order_type 
FROM orders o 
WHERE EXISTS (SELECT 1 FROM order_type ot WHERE ot.customer_id = o.customer_id AND ordertype0_count = 0)
---------------------------------------------- NOTES --------------------------------------------
--> report all the orders:
    --> customer has at least order of type 0, no type 1
    --> otherwise, report all orders of the customer
-------------------------------------------------------------------------------------------------
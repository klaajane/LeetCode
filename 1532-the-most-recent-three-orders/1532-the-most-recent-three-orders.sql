--------------------------------------------- SOLUTION ------------------------------------------
WITH orders_ranked AS (
    SELECT
        c.name,
        o.customer_id,
        o.order_id,
        o.order_date,
        DENSE_RANK() OVER (PARTITION BY o.customer_id
                            ORDER BY o.order_date DESC) AS rnk
    FROM
        orders o
    INNER JOIN
        customers c
        ON c.customer_id = o.customer_id)

SELECT 
    name "customer_name", 
    customer_id, 
    order_id, 
    order_date 
FROM 
    orders_ranked
WHERE rnk <= 3    
ORDER BY customer_name ASC, customer_id ASC, order_date DESC
---------------------------------------------- NOTES --------------------------------------------
--> return the most recent 3 order for each users (return ALL if total order is LESS than 3)
--> order by customer_name ASC, customer_id ASC, order_date DESC
-------------------------------------------------------------------------------------------------
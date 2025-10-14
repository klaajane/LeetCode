--------------------------------------------- SOLUTION ------------------------------------------
SELECT  
    o.customer_id,
    c.customer_name
    --o.product_name
FROM
    orders o
INNER JOIN
    customers c
    ON o.customer_id = c.customer_id
GROUP BY
    o.customer_id,
    c.customer_name
HAVING
    SUM(CASE WHEN o.product_name = 'A' THEN 1 ELSE 0 END) > 0 -- bought A
    AND SUM(CASE WHEN o.product_name = 'B' THEN 1 ELSE 0 END) > 0 -- bought B
    AND SUM(CASE WHEN o.product_name = 'C' THEN 1 ELSE 0 END) = 0 -- bought C
---------------------------------------------- NOTES --------------------------------------------
--> report customer_id, customer_name of customers who bought product "A", "B" but NOT "C"
--> order by cutomer_id
-------------------------------------------------------------------------------------------------
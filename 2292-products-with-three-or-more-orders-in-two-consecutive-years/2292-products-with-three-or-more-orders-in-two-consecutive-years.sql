--------------------------------------------- SOLUTION ------------------------------------------
WITH products_ordered AS (
    SELECT
        order_id,
        product_id,
        EXTRACT(YEAR FROM purchase_date) AS "year"
    FROM
        orders
),

groups AS (
    SELECT
        year,
        product_id,
        COUNT(*) AS order_count
    FROM
        products_ordered
    GROUP BY 1, 2
)

SELECT DISTINCT 
    g1.product_id 
FROM groups g1
    INNER JOIN groups g2 
    ON g1.product_id = g2.product_id 
    AND g1.year = g2.year + 1
WHERE g1.order_count >= 3 
    AND g2.order_count >= 3
---------------------------------------------- NOTES --------------------------------------------
--> IDs of all products that were ordered 3 or more times in 2 consecutive years
-------------------------------------------------------------------------------------------------
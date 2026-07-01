--------------------------------------------- SOLUTION ------------------------------------------
WITH product_aggreggated AS
    (
    SELECT
        product_id,
        EXTRACT(YEAR FROM purchase_date) "year",
        COUNT(*) "count"
    FROM orders 
    GROUP BY 1, 2
    HAVING COUNT(*) >= 3
    )

SELECT DISTINCT product_id
FROM
    (SELECT
        *,
        year - ROW_NUMBER() OVER (PARTITION BY product_id
                                ORDER BY year) "grp_id"
    FROM product_aggreggated)
GROUP BY product_id, grp_id
HAVING COUNT(*) >= 2
---------------------------------------------- NOTES --------------------------------------------
--> IDs of all products that were ordered 3 or more times in 2 consecutive years
-------------------------------------------------------------------------------------------------
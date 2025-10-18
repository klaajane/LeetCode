--------------------------------------------- SOLUTION ------------------------------------------
WITH product_counts AS (
    SELECT
        o.product_id,
        o.customer_id,
        COUNT(o.*) AS "product_count",
        p.product_name
    FROM
        orders o
    INNER JOIN
        products p
        ON p.product_id = o.product_id
    GROUP BY 1, 2, 4
    ORDER BY 2),

product_count_ranked AS(
    SELECT
        customer_id,
        product_id,
        product_name,
        DENSE_RANK() OVER (PARTITION BY customer_id
                            ORDER BY product_count DESC) AS rnk
    FROM
        product_counts
    ---GROUP BY 1, 2, 3, product_count
    --HAVING product_count = MAX(product_count)
    ORDER BY 1)

SELECT
    customer_id,
    product_id,
    product_name
FROM
    product_count_ranked
WHERE
    rnk = 1
---------------------------------------------- NOTES --------------------------------------------
--> find the most frequently ordered product for each customer
--> report product_id, product_name, and customer_id who ordered at least one order
-------------------------------------------------------------------------------------------------
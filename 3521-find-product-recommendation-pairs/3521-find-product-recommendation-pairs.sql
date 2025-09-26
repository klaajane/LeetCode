-------------------------------------------- SOLUTION -------------------------------------------
WITH paired_products AS (SELECT
                            p1.product_id AS product1_id,
                            p2.product_id AS product2_id,
                            p1.quantity AS product1_quantity,
                            p2.quantity AS product2_quantity
                        FROM
                            ProductPurchases p1
                        INNER JOIN
                            ProductPurchases p2
                            ON
                            p1.user_id = p2.user_id
                        WHERE
                            p1.product_id < p2.product_id),
paired_products_count AS (SELECT
                            p.product1_id,
                            p.product2_id,
                            i1.category AS product1_category,
                            i2.category AS product2_category,
                            COUNT(*) AS customer_count
                        FROM
                            paired_products p
                        INNER JOIN
                            ProductInfo i1
                            ON 
                            p.product1_id = i1.product_id
                        INNER JOIN
                            ProductInfo i2
                            ON 
                            p.product2_id = i2.product_id
                        GROUP BY
                            product1_id,
                            product2_id,
                            i1.category,
                            i2.category)
SELECT 
    * 
FROM 
    paired_products_count
WHERE
    customer_count >= 3
ORDER BY
    customer_count DESC,
    product1_id ASC,
    product2_id ASC
---------------------------------------------- NOTES --------------------------------------------
--> identify DISTINCT product pairs frequently purchased (product1_id < product2_id)
--> determine the # of customers who purchased both products
--> product as a recommendation: if at least 3 different customers have bought it
--> order by customer_count in DESC, tie => product1_id ASC, product2_id ASC
-------------------------------------------------------------------------------------------------
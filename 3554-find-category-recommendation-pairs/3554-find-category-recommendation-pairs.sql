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
                            p1.user_id = p2.user_id),
                        --WHERE
                            --p1.product_id < p2.product_id),
paired_products_count AS (SELECT
                            --p.product1_id,
                            --p.product2_id,
                            i1.category AS category1,
                            i2.category AS category2,
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
                        WHERE
                            i1.category < i2.category
                        GROUP BY
                            --product1_id,
                            --product2_id,
                            i1.category,
                            i2.category),
                            
product_category_table AS (SELECT
                                user_id,
                                category
                            FROM
                                ProductPurchases p
                            INNER JOIN
                                ProductInfo p1 
                                ON
                                p.product_id = p1.product_id),

category_table_final AS (SELECT 
                            p1.category AS category1, 
                            p2.category AS category2, 
                            COUNT(DISTINCT p1.user_id) AS customer_count
                        FROM 
                            product_category_table p1, product_category_table p2
                        WHERE 
                            p1.category < p2.category 
                            AND 
                            p1.user_id = p2.user_id
                        GROUP BY 
                            category1,
                            category2)
SELECT 
    *
FROM
    category_table_final
WHERE
    customer_count >= 3
ORDER BY
    customer_count DESC,
    category1 ASC,
    category2 ASC
---------------------------------------------- NOTES --------------------------------------------
--> find all category pairs (category 1 < category 2)
--> for each pair, determine the # of unqiue customers who purchased products from both categories
--> the count must at least have been purchased by 3 different customers
--> order by customer_count DESC, category1 ASC, category2 ASC
-------------------------------------------------------------------------------------------------
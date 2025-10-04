-------------------------------------------- SOLUTION -------------------------------------------
WITH qualified_stores AS (SELECT
                        store_id,
                        COUNT(DISTINCT product_name) AS product_count
                    FROM
                        inventory
                    GROUP BY
                        store_id
                    HAVING
                        COUNT(DISTINCT product_name) >= 3),
products_ordered AS (SELECT
                        *,
                        DENSE_RANK() OVER (PARTITION BY store_id 
                                           ORDER BY price DESC) AS price_rnk_desc,
                        DENSE_RANK() OVER (PARTITION BY store_id 
                                           ORDER BY price ASC) AS price_rnk_asc,
                        ROW_NUMBER() OVER (PARTITION BY store_id 
                                           ORDER BY price ASC) AS row_rnk
                    FROM
                        inventory),
cheapest_and_expensive_inventory AS (SELECT
                                        p1.store_id,
                                        p1.product_name AS "cheapest_product",
                                        p1.price AS "chepeast_product_price",
                                        p1.quantity AS "cheapest_product_quantity",
                                        p2.product_name AS "most_exp_product",
                                        p2.price AS "most_exp_product_price",
                                        p2.quantity AS "most_exp_product_quantity"
                                    FROM
                                        products_ordered p1
                                    INNER JOIN
                                        products_ordered p2
                                        ON
                                        p1.store_id = p2.store_id
                                    WHERE
                                        p2.quantity < p1.quantity
                                        AND
                                        p1.store_id IN (SELECT store_id FROM qualified_stores)
                                        AND
                                        p2.price_rnk_desc = 1
                                        AND
                                        p1.row_rnk = 1
                                    ORDER BY
                                        p1.price_rnk_desc DESC,
                                        p2.price_rnk_asc DESC),
imbalance_ratio AS (SELECT
                        i.store_id,
                        s.store_name,
                        s.location,
                        i.most_exp_product,
                        i.cheapest_product,
                        ROUND((i.cheapest_product_quantity / i.most_exp_product_quantity)::NUMERIC,2) AS "imbalance_ratio"
                    FROM
                        cheapest_and_expensive_inventory i
                    INNER JOIN
                        stores s
                        ON
                        i.store_id = s.store_id)
SELECT
    *
FROM
    imbalance_ratio
ORDER BY
    imbalance_ratio DESC,
    store_name ASC    
---------------------------------------------- NOTES --------------------------------------------
--> inventory imbalance: expensive products has lower stock than cheap products
--> Find expensive product + quantity
--> Find cheapeast product + quantity
--> calculate imbalance ratio: cheapest_quantity / most_expensive_quantity (round to 2 decimals)
--> only include stores that have at least 3 different products
--> Order by imbalance ratio DESC, store name ASC
-------------------------------------------------------------------------------------------------
-- Write your PostgreSQL query statement below

--- EXIST vs IN
WITH products_ranked AS (
    SELECT
        store_id,
        product_name,
        quantity,
        price,

        DENSE_RANK() OVER (
            PARTITION BY store_id
            ORDER BY price DESC
        ) AS expensive_rnk,

        DENSE_RANK() OVER (
            PARTITION BY store_id
            ORDER BY price ASC
        ) AS cheapest_rnk

    FROM inventory
    WHERE store_id IN (
        SELECT store_id
        FROM inventory
        GROUP BY store_id
        HAVING COUNT(DISTINCT product_name) >= 3
    )
    )
,

most_exp_cheapest_products AS (
    SELECT
        store_id,
        MAX(CASE WHEN expensive_rnk = 1 THEN product_name END) AS most_exp_product,
        MAX(CASE WHEN expensive_rnk = 1 THEN quantity END) AS most_exp_product_quantity,
        MAX(CASE WHEN cheapest_rnk = 1 THEN product_name END) AS cheapest_product,
        MAX(CASE WHEN cheapest_rnk = 1 THEN quantity END) AS cheapest_product_quantity
    FROM products_ranked
    GROUP BY store_id
    )

SELECT
    s.store_id,
    s.store_name,
    s.location,
    m.most_exp_product,
    m.cheapest_product,
    ROUND(
        m.cheapest_product_quantity * 1.0 / m.most_exp_product_quantity -- quantity is INT
        , 2) AS imbalance_ratio
FROM most_exp_cheapest_products m
JOIN stores s
    ON s.store_id = m.store_id
    AND m.most_exp_product_quantity < m.cheapest_product_quantity
ORDER BY
    imbalance_ratio DESC,
    store_name ASC
-- Write your PostgreSQL query statement below

-- self-join : to get the different pairs for each user

WITH pairs_by_users AS (
    SELECT
        p1.user_id,
        p1.product_id AS product1_id,
        p2.product_id AS product2_id
    FROM productpurchases p1
    JOIN productpurchases p2
        ON p1.user_id = p2.user_id
        AND p1.product_id < p2.product_id
)

-- self join: using the pairs to find out the couts
SELECT
    p.product1_id,
    p.product2_id,
    pi1.category AS product1_category,
    pi2.category AS product2_category,
    COUNT(DISTINCT p.user_id) AS customer_count
FROM pairs_by_users p
JOIN productinfo pi1 ON p.product1_id = pi1.product_id
JOIN productinfo pi2 ON p.product2_id = pi2.product_id
GROUP BY
    p.product1_id, p.product2_id,
    pi1.category, pi2.category
HAVING COUNT(DISTINCT p.user_id) >= 3
ORDER BY
    customer_count DESC,
    product1_id ASC,
    product2_id ASC
-- NOTES: 

-- I wouldnt bring in the categories from the category table until I find the qualifying records (count >= 3)
-- use '<' instead of '<>' to avoid duplication
WITH product_pair AS (
    SELECT
        p1.user_id,
        pi1.category AS category1,
        pi2.category AS category2 
    FROM productpurchases p1
    JOIN productpurchases p2
        ON p1.user_id = p2.user_id
    JOIN productinfo pi1
        ON p1.product_id = pi1.product_id
    JOIN productinfo pi2
        ON p2.product_id = pi2.product_id
    WHERE pi1.category < pi2.category
    GROUP BY 
        p1.user_id,
        pi1.category,
        pi2.category
    )
,

product_pair_count AS (
    SELECT 
        category1,
        category2,
        COUNT(*) AS customer_count
    FROM product_pair
    GROUP BY category1, category2
    )

SELECT
    category1,
    category2,
    customer_count 
FROM product_pair_count
WHERE customer_count >= 3
ORDER BY 
    customer_count DESC,
    category1 ASC,
    category2 ASC


-- mistake: using product1 < product2 instead of category1 < category2
-- 
WITH orders_ranked AS (
    SELECT
        o.customer_id,
        o.product_id,
        COUNT(o.product_id) AS order_count,
        DENSE_RANK() OVER (
            PARTITION BY customer_id
            ORDER BY COUNT(o.product_id) DESC
        ) AS rnk
    FROM orders o
    GROUP BY 
        o.customer_id,
        o.product_id
)

SELECT
    o.customer_id,
    o.product_id,
    p.product_name
FROM orders_ranked o
INNER JOIN products p
    ON p.product_id = o.product_id 
WHERE rnk = 1

-- orders table grain is defined as one order per product per day per customer
-- should we return both products in case there's a tie?
-- 
-- first approach is check if customer fit the conditions that don't require an aggreggation
-- aggreggate = losing the level of granularity
WITH customers_conditions_check AS
    (SELECT
        customer_id,
        -- create a column to check if they rated an order
        100.0 * AVG(CASE WHEN order_rating IS NOT NULL THEN 1 ELSE 0 END) AS "orders_rated",
        --- create a column to flag peak_time
        ROUND(100.0 * AVG(CASE
                        WHEN order_timestamp::TIME BETWEEN '11:00'::TIME AND '14:00'::TIME 
                        OR order_timestamp::TIME BETWEEN '18:00'::TIME AND '21:00'::TIME
                        THEN 1
                        ELSE 0
                    END)
            ) AS "peak_hour_percentage"
    FROM restaurant_orders
    GROUP BY customer_id),

qualified_customers AS (
    SELECT
        customer_id,
        orders_rated,
        peak_hour_percentage
    FROM customers_conditions_check
    WHERE orders_rated >= 50 AND peak_hour_percentage >= 60
),

answer AS (
SELECT 
    q.customer_id,
    COUNT(*) AS "total_orders",
    q.peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS "average_rating"
FROM qualified_customers q
JOIN restaurant_orders r ON r.customer_id = q.customer_id
GROUP BY q.customer_id, peak_hour_percentage
HAVING AVG(order_rating) >= 4 AND COUNT(*) >= 3
ORDER BY average_rating DESC, customer_id DESC)

SELECT * FROM answer
-- Golden hour cusomter: 
  -- at least 3 orders 
  -- avg rating for rated orders is at least 4.0 (ROUND to 2 decimals)
  -- at least 60% of order are during peak hours (11:00 - 14:00 or 18:00 - 21:00)
  -- have rated at least 50% of their orders

-- ORDER BY average_rating DESC, customer_id DESC
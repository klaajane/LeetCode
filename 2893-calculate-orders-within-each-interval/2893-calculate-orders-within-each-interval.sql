SELECT 
    test AS "interval_no", 
    SUM(order_count) AS "total_orders"
FROM (
    SELECT
        CEIL(minute / 6) AS "test",
        order_count
    FROM
        orders) t
GROUP BY 
    interval_no
ORDER BY
    interval_no
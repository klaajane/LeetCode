-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    order_date,
    ROUND(
        100.0 * SUM(CASE WHEN customer_pref_delivery_date = order_date THEN 1 ELSE 0 END)
        /
        COUNT(*)
        , 2) AS "immediate_percentage"
FROM
    delivery
GROUP BY order_date
ORDER BY order_date
---------------------------------------------- NOTES --------------------------------------------
--> preferred date = order date = immediate, otherwise scheduled
--> find % of immediate orders on each unique order_date. ROUND to 2 Decimal places
--> order by order_date ASC
-------------------------------------------------------------------------------------------------
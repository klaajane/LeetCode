-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    ROUND( SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END)::numeric
            * 100.0 / COUNT(*)
            ,2) AS immediate_percentage
FROM
    Delivery
WHERE
    order_date IN (SELECT MIN(order_date) FROM Delivery GROUP BY customer_id)
---------------------------------------------- NOTES --------------------------------------------
--> immediate: customer's preferred delivery date = order date (otherwise scheduled)
--> first order: earliest order date
--> customers have unique orders
--> find % of immmediate order in the first orders of all customers
--> round to 2 decimal places
-------------------------------------------------------------------------------------------------

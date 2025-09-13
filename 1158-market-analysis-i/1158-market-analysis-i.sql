--------------------------------------------- SOLUTION ------------------------------------------
WITH nineteen_orders AS (SELECT
                        buyer_id
                        ,COUNT(*) AS orders_in_2019
                     FROM
                        Orders
                     WHERE
                        EXTRACT(YEAR FROM order_date) = 2019
                     GROUP BY
                        buyer_id)
SELECT
     u.user_id AS buyer_id
    ,u.join_date
    ,COALESCE(o.orders_in_2019, 0) AS orders_in_2019
FROM
    users AS u 
LEFT JOIN
    nineteen_orders AS o
    ON
    user_id = buyer_id
---------------------------------------------- NOTES --------------------------------------------
--> find each user, the join date, number of order they made as buyers in 2019
--> order doesn't matter
-------------------------------------------------------------------------------------------------
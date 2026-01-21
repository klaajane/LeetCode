-------------------------------------------- SOLUTION -------------------------------------------
SELECT 
    a2.age_bucket,
    --- send_perc
    ROUND(SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END)
        /
    SUM(time_spent) * 100
        , 2) AS "send_perc",
    --- open_perc
    ROUND(SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END)
        /
    SUM(time_spent) * 100
        , 2) AS "open_perc"
FROM
    activities a1
INNER JOIN
    age a2 ON a1.user_id = a2.user_id
GROUP BY
    a2.age_bucket
---------------------------------------------- NOTES --------------------------------------------
--> calculate % of total spent on spending and opening snaps for each age group
--> round % to 2 decimal places
-------------------------------------------------------------------------------------------------
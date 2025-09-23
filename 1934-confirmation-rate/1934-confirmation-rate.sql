-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    s.user_id,
    ROUND(
        COALESCE(
            SUM(CASE
                    WHEN c.action = 'confirmed' THEN 1 ELSE 0
                END)::NUMERIC
            / NULLIF(COUNT(c.user_id),0) 
         ,0)
        ,2) AS "confirmation_rate"
FROM
    signups s
LEFT JOIN
    confirmations c
    ON
    s.user_id = c.user_id
GROUP BY 
    s.user_id
---------------------------------------------- NOTES --------------------------------------------
--> confirmation rate = 'confirmed' msgs / total msgs
--> confirmation rate of a user that didn't request a confirmation message is 0
--> round confirmation rate to 2 decimal places
-------------------------------------------------------------------------------------------------
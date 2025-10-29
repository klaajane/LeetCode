-------------------------------------------- SOLUTION -------------------------------------------
WITH purchase_history AS (
    SELECT
        *,
        LEAD(created_at) OVER (PARTITION BY user_id 
                                ORDER BY created_at ASC) AS "next_purchase"
    FROM
        users
)

SELECT DISTINCT
    user_id
FROM
    purchase_history
WHERE
    next_purchase - created_at <= 7
---------------------------------------------- NOTES --------------------------------------------
--> active user: made a second purchase within 7 days of any purchase day
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    user_id,
    --- trial average duration:
    ROUND(
        AVG(CASE
                WHEN activity_type = 'free_trial' THEN activity_duration
              END)
        ,2) AS "trial_avg_duration",
    
    --- paid average duration
    ROUND(
        AVG(CASE
                WHEN activity_type = 'paid' THEN activity_duration
              END)
        ,2) AS "paid_avg_duration"
FROM
    UserActivity
WHERE
    activity_type IN ('free_trial','paid')
GROUP BY
    user_id
HAVING 
    COUNT(DISTINCT activity_type) = 2
---------------------------------------------- NOTES --------------------------------------------
--> query: users who converted from free trail to paid subscription
--> calculate AVG daily activity duration during the free trial (round to 2 decimals)
--> calculate AVG daily activity duration during the paid trial (round to 2 decimals)
--> order by user_id ASC
-------------------------------------------------------------------------------------------------
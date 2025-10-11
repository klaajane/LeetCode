--------------------------------------------- SOLUTION ------------------------------------------
WITH login_log AS (SELECT
                        user_id,
                        MIN(activity_date) AS "login_date",
                        '2019-06-30'::DATE AS "current_day"
                    FROM
                        traffic
                    WHERE
                        activity = 'login'
                    GROUP BY 1)
SELECT
    login_date,
    COUNT(DISTINCT user_id) AS "user_count"
FROM
    login_log
WHERE
    login_date BETWEEN current_day - INTERVAL '90 DAYS' AND current_day
GROUP BY 1
ORDER BY 1
---------------------------------------------- NOTES --------------------------------------------
--> report every date within at most 90 days from today, # of users that logged in for 1st time
--> today is 2019-06-30
-------------------------------------------------------------------------------------------------
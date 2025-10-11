-------------------------------------------- SOLUTION -------------------------------------------
WITH removals AS (SELECT
                        action_date,
                        COUNT(DISTINCT r.post_id)::NUMERIC
                        / 
                        COUNT(DISTINCT a.post_id) AS daily_rate
                    FROM 
                        actions a
                    LEFT JOIN
                        removals r ON r.post_id = a.post_id
                    WHERE
                        a.extra = 'spam'
                    GROUP BY
                        action_date)

SELECT ROUND(AVG(daily_rate) * 100, 2) AS average_daily_percent
FROM removals
---------------------------------------------- NOTES --------------------------------------------
--> find avg. daily percent of removed posts AFTER being reported as spam
--> ROUND to 2 decimal places
-------------------------------------------------------------------------------------------------
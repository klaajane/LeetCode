--------------------------------------------- SOLUTION ------------------------------------------
WITH activity_log AS (
    SELECT 
        player_id
        ,event_date
        ,LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date ASC) AS next_event_date
        ,ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date ASC) AS r
    FROM
        Activity)

SELECT
    ROUND(
        1.00 * SUM(CASE
                        WHEN next_event_date = event_date + INTERVAL '1 day'
                        THEN 1
                        ELSE 0
                   END) / COUNT(DISTINCT player_id),
     2
    ) AS "fraction"
FROM
    activity_log
WHERE
    r = 1
---------------------------------------------- NOTES --------------------------------------------
--> fraction of players who logged in again after the day they first logged in
--> round to 2 decimal places
----------------------------------- OPTIMIZATION & ENHANCEMENT ----------------------------------
--> 
-------------------------------------------------------------------------------------------------
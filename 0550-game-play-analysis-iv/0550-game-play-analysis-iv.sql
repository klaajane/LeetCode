--------------------------------------------- SOLUTION ------------------------------------------
WITH first_log AS (
    SELECT
         player_id
        ,MIN(event_date) AS first_login_date
    FROM 
        Activity
    GROUP BY
        player_id)

SELECT
    ROUND(
        1.0 * SUM(CASE
                    WHEN a.player_id IS NOT NULL
                    THEN 1
                    ELSE 0
                  END) / NULLIF(COUNT(1), 0),
     2) AS "fraction"
FROM 
    first_log ft
LEFT JOIN
    activity a
    ON ft.player_id = a.player_id
    AND a.event_date = first_login_date + INTERVAL '1 day'
---------------------------------------------- NOTES --------------------------------------------
--> fraction of players who logged in again after the day they first logged in
--> round to 2 decimal places
-------------------------------------------------------------------------------------------------
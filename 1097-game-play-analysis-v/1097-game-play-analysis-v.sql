-------------------------------------------- SOLUTION -------------------------------------------
WITH activity_logs AS (SELECT
                            player_id,
                            event_date,
                            FIRST_value(event_date) OVER (PARTITION BY player_id
                                                    ORDER BY event_date ASC) AS "first_log",
                            event_date 
                            - 
                            FIRST_value(event_date) OVER (PARTITION BY player_id
                                                            ORDER BY event_date ASC)
                            AS "diff"
                        FROM
                            Activity)
SELECT
    first_log AS "install_dt",
    COUNT(DISTINCT player_id) AS "installs",
    ROUND(COUNT(*) FILTER (WHERE diff = 1) * 1.0/ COUNT(DISTINCT player_id), 2) AS Day1_retention
FROM
    activity_logs
GROUP BY
    first_log
---------------------------------------------- NOTES --------------------------------------------
--> install date: first login day of a player
--> day one retention: # of players who logged back right after the install date / # of players
--> report install_date, # of players, day one retention
--> round to 2 decimal places
-------------------------------------------------------------------------------------------------
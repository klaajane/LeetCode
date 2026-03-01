-------------------------------------------- SOLUTION -------------------------------------------
-- Create a Ranking system for the sessions (start & stop session would have the same rank)
WITH server_ranking AS (
    SELECT
        server_id,
        status_time,
        session_status,
        ROW_NUMBER() OVER (PARTITION BY server_id, session_status
                            ORDER BY status_time) AS "server_id_grp"
    FROM servers),

server_grp_log AS (
    SELECT
        server_id,
        MIN(status_time) AS "start_time",
        MAX(status_time) AS "stop_time"
    FROM server_ranking
    GROUP BY server_id, server_id_grp)

SELECT
    FLOOR(SUM(EXTRACT(epoch FROM (stop_time - start_time)) / 3600) / 24) AS "total_uptime_days"
FROM server_grp_log
---------------------------------------------- NOTES --------------------------------------------
--> find total time when servers were running.
--> output should be rounded down to the nearest number of FULL days
-------------------------------------------------------------------------------------------------
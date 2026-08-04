-------------------------------------------- SOLUTION -------------------------------------------
WITH lagged_sessions AS (
    SELECT 
        user_id,
        LAG(session_end) OVER (PARTITION BY user_id, session_type
                            ORDER BY session_start) AS "previous_session",
        session_start AS "current_session"    
    FROM
        sessions)

SELECT DISTINCT
    user_id
FROM lagged_sessions  
WHERE previous_session IS NOT NULL
  AND ABS(EXTRACT(epoch FROM (current_session - previous_session)) / 3600) <= 12    
ORDER BY user_id             
---------------------------------------------- NOTES --------------------------------------------
--> extract users with at least 2 session of the same type (viewer or streamer)
--> max gap between sessions = 12 hours
--> order by user_id in ASC order
-------------------------------------------------------------------------------------------------
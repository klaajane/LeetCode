-------------------------------------------- SOLUTION -------------------------------------------
SELECT DISTINCT
    s1.user_id
FROM sessions s1
JOIN sessions s2 
    ON s1.user_id = s2.user_id 
    AND s1.session_type = s2.session_type
    AND s1.session_id != s2.session_id -- to avoid including sessions with the same id more than once)
    AND ABS(EXTRACT(epoch FROM (s2.session_end -  s1.session_start)) / 3600)  <= 12
ORDER BY user_id
---------------------------------------------- NOTES --------------------------------------------
--> extract users with at least 2 session of the same type (viewer or streamer)
--> max gap between sessions = 12 hours
--> order by user_id in ASC order
-------------------------------------------------------------------------------------------------
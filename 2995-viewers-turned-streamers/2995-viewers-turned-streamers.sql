-------------------------------------------- SOLUTION -------------------------------------------
-- extract users whose first session was a viewer:
WITH users AS (
    SELECT DISTINCT
        user_id,
        FIRST_VALUE(session_type) OVER (PARTITION BY user_id 
                                        ORDER BY session_start) AS initial_user_time
    FROM
        sessions)

SELECT
    user_id,
    COUNT(session_id) AS "sessions_count"
FROM
    users
INNER JOIN
    sessions
    using(user_id)
WHERE
    initial_user_time = 'Viewer'
    AND
    session_type = 'Streamer'
GROUP BY 1
ORDER BY 2 DESC, 1 DESC
---------------------------------------------- NOTES --------------------------------------------
--> find # of streaming sessions for users whose first session was as a viewer
--> order by count of streaming session, user_id DESC
-------------------------------------------------------------------------------------------------
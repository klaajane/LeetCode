-------------------------------------------- SOLUTION -------------------------------------------
WITH zombie_session AS (SELECT
                            session_id,
                            user_id,
                            COUNT(*) FILTER (WHERE event_type = 'scroll') AS "scroll_count",
                            EXTRACT(EPOCH FROM MAX(event_timestamp)::timestamp - MIN(event_timestamp)::timestamp) / 60
                            AS "session_duration_minutes",
                            COUNT(*) FILTER (WHERE event_type = 'purchase') AS "purchase_count",
                            COUNT(*) FILTER (WHERE event_type = 'click') * 1.0
                            /
                            COUNT(*) FILTER (WHERE event_type = 'scroll')
                            AS "click_to_scroll_ratio"
                         FROM
                            app_events
                         GROUP BY
                            1, 2)
SELECT
    session_id,
    user_id,
    session_duration_minutes,
    scroll_count
FROM
    zombie_session
WHERE
    session_duration_minutes > 30
    AND
    scroll_count >= 5
    AND
    purchase_count = 0
    AND
    click_to_scroll_ratio < 0.20
ORDER BY
    scroll_count DESC,
    session_id ASC
---------------------------------------------- NOTES --------------------------------------------
--> a zombie session:
--> > 30 min
--> at least 5 scroll events
--> click-to-scroll ratio < 0.20
--> No purchases were made during the session
--> Order by scroll_count DESC, session_id ASC
-------------------------------------------------------------------------------------------------
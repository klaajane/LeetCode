------------------------------------------------------ NOTES --------------------------------------------------

--> GOAL:
    --> identify zombie sessions: users appear active but show abnormal behavior patterns
    --> zombie session:
        --> duration > 30 min
            --> window function using MIN and MAX to to compute the duration of the event
            --> or we can use a SUB QUERY to exclude events > 30 min 

        --> at least 5 scroll events
            --> count # of scroll events

        --> click-to-scroll ratio < 0.20
            --> find out the # of clicks and # scrolls ==> obtain the click-to-scroll ratio

        --> no purchases were made during the session
            --> apply a WHERE clause to exclude sesions where a customer made a purchase

------------------------------------------------------ SOLUTION ------------------------------------------------

WITH app_events_details AS (
    SELECT
        user_id,
        session_id,
        event_timestamp,
        event_type,

        CASE WHEN event_type = 'scroll' THEN 1 ELSE 0 END AS is_scroll,
        CASE WHEN event_type = 'click' THEN 1 ELSE 0 END AS is_click
        
    FROM app_events

    -- purchase condition
    WHERE NOT EXISTS (
        SELECT 1 FROM app_events ae2
        WHERE ae2.session_id = app_events.session_id
        AND ae2.event_type = 'purchase'
    )

    AND

    -- session length condition 
    session_id IN (
        SELECT session_id
        FROM app_events
        GROUP BY session_id
        HAVING EXTRACT(EPOCH FROM (MAX(event_timestamp) - MIN(event_timestamp))) / 60 > 30
    )
)
,

app_events_metrics AS (
    SELECT
        user_id,
        session_id,
        SUM(is_scroll) AS scroll_count,

        -- click-to-scroll ratio:  
        SUM(is_click)::NUMERIC / NULLIF(SUM(is_scroll), 0) AS click_to_scroll_ratio,

        -- session_duration_minutes:

        EXTRACT(EPOCH FROM (MAX(event_timestamp) - MIN(event_timestamp))) / 60 AS session_duration_minutes

    FROM app_events_details
    GROUP BY user_id, session_id
    HAVING SUM(is_scroll) >= 5
    )

SELECT
    session_id,
    user_id,
    session_duration_minutes,
    scroll_count
FROM app_events_metrics
WHERE click_to_scroll_ratio < 0.20
ORDER BY
    scroll_count DESC,
    session_id ASC



-- INTERVAL vs Number in Minutes
-- USE NULL IF TO GUARD AGAINST DIVISION BY ZERO
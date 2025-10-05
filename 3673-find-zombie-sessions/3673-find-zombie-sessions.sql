WITH zombie_session AS (
    SELECT
        session_id,
        user_id,

        -- Metrics
        COUNT(*) FILTER (WHERE event_type = 'scroll') AS scroll_count,
        COUNT(*) FILTER (WHERE event_type = 'click') AS click_count,
        COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchase_count,

        -- Session duration in minutes
        EXTRACT(EPOCH FROM MAX(event_timestamp)::timestamp - MIN(event_timestamp)::timestamp) / 60
            AS session_duration_minutes

    FROM app_events
    GROUP BY session_id, user_id
),
zombie_qualified AS (
    SELECT
        session_id,
        user_id,
        scroll_count,
        session_duration_minutes,
        purchase_count,
        click_count,
        -- Calculated ratio
        CASE 
            WHEN scroll_count > 0 THEN ROUND(click_count * 1.0 / scroll_count, 4)
            ELSE NULL
        END AS click_to_scroll_ratio
    FROM zombie_session
)
SELECT
    session_id,
    user_id,
    session_duration_minutes,
    scroll_count
FROM zombie_qualified
WHERE
    session_duration_minutes > 30
    AND scroll_count >= 5
    AND purchase_count = 0
    AND click_to_scroll_ratio < 0.20
ORDER BY
    scroll_count DESC,
    session_id ASC;

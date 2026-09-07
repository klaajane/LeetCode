-- GOAL:
    --> show the second most recent activity for each user

-- pseucode:
    --> DENSE_RANK() vs. RANK():
        --> DENSE_RANK() handles ties better

WITH ranked_activities AS (
    SELECT DISTINCT
        *,
        DENSE_RANK() OVER (
            PARTITION BY username
            ORDER BY startDate DESC
        ) AS rnk
    FROM UserActivity
)
,

answer AS (
SELECT
    username,
    activity,
    startDate,
    endDate
FROM ranked_activities
WHERE rnk = 2

    UNION ALL

SELECT
    *
FROM UserActivity
WHERE username IN (
    SELECT username
    FROM UserActivity
    GROUP BY 1
    HAVING COUNT(*) = 1
))

SELECT * FROM answer
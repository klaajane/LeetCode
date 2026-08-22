WITH duration_hours_by_week AS (
    SELECT
        employee_id,
        EXTRACT(WEEK FROM meeting_date) AS week,
        EXTRACT(YEAR FROM meeting_date) AS year,
        SUM(duration_hours) AS weekly_duration_hours
    FROM meetings
    GROUP BY 
        employee_id, 
        EXTRACT(WEEK FROM meeting_date),
        EXTRACT(YEAR FROM meeting_date)
    )
,

meeting_heavy_employees AS (
    SELECT
        employee_id,
        COUNT(*) AS meeting_heavy_weeks
    FROM duration_hours_by_week
    WHERE weekly_duration_hours > 20
    GROUP BY employee_id, year
    HAVING COUNT(*) >= 2
    )

SELECT
    m.employee_id,
    e.employee_name,
    e.department,
    m.meeting_heavy_weeks
FROM meeting_heavy_employees m
INNER JOIN employees e
    ON e.employee_id = m.employee_id
ORDER BY 
    meeting_heavy_weeks DESC,
    employee_name
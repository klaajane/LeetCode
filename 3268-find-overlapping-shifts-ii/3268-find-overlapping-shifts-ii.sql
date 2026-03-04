-- Write your PostgreSQL query statement below
-- Retrieve shifts that overlap using joins:

WITH shiftslog AS (
    SELECT employee_id, start_time AS "t", 1 AS "delta" FROM employeeshifts
        UNION ALL
    SELECT employee_id, end_time AS "t", -1 AS "delta" FROM employeeshifts),

running_shiftslog AS (
    SELECT
        employee_id,
        t,
        LEAD(t) OVER (PARTITION BY employee_id
                        ORDER BY t) AS "next_t",
        SUM(delta) OVER (PARTITION BY employee_id
                            ORDER BY t) AS "running_delta"
    FROM shiftslog)

SELECT
    employee_id,
    MAX(running_delta) AS "max_overlapping_shifts",
    COALESCE(
        SUM(CASE 
                WHEN running_delta > 1 
                THEN (running_delta * (running_delta - 1) / 2) * EXTRACT(EPOCH FROM (next_t - t)) / 60
                END)
            , 0
            ) AS "total_overlap_duration"
FROM running_shiftslog
GROUP BY employee_id

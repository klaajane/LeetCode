--------------------------------------------- SOLUTION ------------------------------------------
WITH events AS (
    -- +1 when a task starts, -1 when it ends
    SELECT employee_id, start_time AS t,  1 AS delta FROM Tasks
    UNION ALL
    SELECT employee_id, end_time   AS t, -1 AS delta FROM Tasks
),

running AS (
    SELECT
        employee_id,
        t,
        LEAD(t) OVER (PARTITION BY employee_id ORDER BY t) AS next_t,
        SUM(delta) OVER (PARTITION BY employee_id ORDER BY t) AS concurrent
    FROM events
)

SELECT
    employee_id,
    FLOOR(SUM(
        CASE WHEN concurrent > 0                                    -- inside at least 1 task
        THEN EXTRACT(EPOCH FROM (next_t - t)) / 3600
        ELSE 0 END
    )) AS total_task_hours,
    MAX(concurrent) AS max_concurrent_tasks
FROM running
GROUP BY employee_id
ORDER BY employee_id;
---------------------------------------------- NOTES --------------------------------------------
--> find the total duration of tasks for each employee and the maximum # of concurrent tasks
--> round down total duration to nearest full hours
--> order by employee_id ASC
---------------------------------------------THOUGHTS--------------------------------------------
-- Instead of merging intervals explicitly, I convert tasks into timeline events:
-- +1 at start, -1 at end. A running SUM gives the live task count at any moment.
--
-- The gap between each event and the next only counts toward duration if concurrent > 0
-- meaning at least one task is active. This naturally excludes gaps between tasks
-- and deduplicates overlapping time — all in one pass.
--
-- MAX(concurrent) falls out for free from the same running sum.
-------------------------------------------------------------------------------------------------
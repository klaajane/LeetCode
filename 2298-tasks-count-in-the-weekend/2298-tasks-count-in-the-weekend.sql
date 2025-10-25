--------------------------------------------- SOLUTION ------------------------------------------
WITH day_of_week AS (
    SELECT
        task_id,
        CASE
            WHEN EXTRACT(DOW FROM submit_date) BETWEEN 1 AND 5 THEN 'working'
            ELSE 'weekend'
        END AS "day_type"
    FROM
        tasks
)

SELECT
    SUM(CASE WHEN day_type = 'weekend' THEN 1 ELSE 0 END) AS "weekend_cnt",
    SUM(CASE WHEN day_type = 'working' THEN 1 ELSE 0 END) AS "working_cnt"
FROM
    day_of_week
---------------------------------------------- NOTES --------------------------------------------
--> # of tasks submitted during the weekends 
--> # of tasks submitted during working days
-------------------------------------------------------------------------------------------------
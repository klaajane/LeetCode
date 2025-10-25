--------------------------------------------- SOLUTION ------------------------------------------
WITH day_of_week AS (
    SELECT
        task_id,
        EXTRACT(DOW FROM submit_date) AS "day_week_number"
    FROM
        tasks
)

SELECT
    SUM(CASE WHEN day_week_number = 0 OR day_week_number = 6 THEN 1 ELSE 0 END) AS "weekend_cnt",
    SUM(CASE WHEN day_week_number BETWEEN 1 AND 5 THEN 1 ELSE 0 END) AS "working_cnt"
FROM
    day_of_week
---------------------------------------------- NOTES --------------------------------------------
--> # of tasks submitted during the weekends 
--> # of tasks submitted during working days
-------------------------------------------------------------------------------------------------
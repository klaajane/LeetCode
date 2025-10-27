--------------------------------------------- SOLUTION ------------------------------------------
WITH work_hours AS (
    SELECT
        e.employee_id,
        e.needed_hours,
        SUM(CEILING(EXTRACT(epoch FROM(out_time-in_time))/60)) AS "total_worked_minutes"
    FROM
        employees e
        LEFT JOIN
            logs l
            ON l.employee_id = e.employee_id
    GROUP BY 
        e.employee_id, e.needed_hours)

SELECT employee_id
FROM work_hours
WHERE needed_hours > COALESCE(total_worked_minutes / 60, 0)
---------------------------------------------- NOTES --------------------------------------------
--> work hourse = minutes spent on each session (rounded up)
--> report employees that didn't work the hours neede
-------------------------------------------------------------------------------------------------
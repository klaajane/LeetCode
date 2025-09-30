-------------------------------------------- SOLUTION -------------------------------------------
WITH weekly_meetings_count AS (SELECT
                                    m.employee_id,
                                    e.employee_name,
                                    e.department,
                                    SUM(m.duration_hours) AS total_hours
                                FROM
                                    meetings m
                                INNER JOIN
                                    employees e
                                    ON
                                    e.employee_id = m.employee_id
                                GROUP BY
                                    m.employee_id,
                                    e.employee_name,
                                    e.department,
                                    TO_CHAR(meeting_date, 'IYYY-IW'))
SELECT
    employee_id,
    employee_name,
    department,
    COUNT(employee_id) AS meeting_heavy_weeks
FROM
    weekly_meetings_count
WHERE
    total_hours > 20
GROUP BY
    employee_id,
    employee_name,
    department
HAVING
    COUNT(employee_id) >= 2
ORDER BY
    COUNT(employee_id) DESC,
    employee_name ASC
---------------------------------------------- NOTES --------------------------------------------
--> find employees who are meeting_heavy (> 50% of time spent in meetings)
--> calculate total meeting hours per employee / week (M to Sunday)
--> count # of meeting-heavy weeks (only include >= 2 meeting-heavy weeks)
--> order by # of meeting-heavy weeks DESC, employee ASC
-------------------------------------------------------------------------------------------------
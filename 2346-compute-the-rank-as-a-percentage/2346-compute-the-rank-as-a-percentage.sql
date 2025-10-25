--------------------------------------------- SOLUTION ------------------------------------------
WITH students_metrics AS (
    SELECT
        student_id,
        department_id,
        mark,
        RANK() OVER (PARTITION BY department_id
                            ORDER BY mark DESC) AS "rnk",
        COUNT(department_id) OVER (PARTITION BY department_id) AS "cnt"
    FROM
        students)

SELECT
    student_id,
    department_id,
    ROUND((rnk - 1) * 100.0
        / 
        GREATEST((cnt - 1), 1) -- to avoid "division by zero" error 0 / 1 ==> 0 
       ,2) AS "percentage"
FROM
    students_metrics
---------------------------------------------- NOTES --------------------------------------------
--> report rank of the each student in their depart. as a %
--> ROUND to 2 decimal places
--> mark DESC
--> same mark => same rank
-------------------------------------------------------------------------------------------------
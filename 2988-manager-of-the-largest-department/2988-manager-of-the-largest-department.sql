-------------------------------------------- SOLUTION -------------------------------------------
WITH employee_count_by_dep AS (
    SELECT
        emp_name,
        dep_id,
        position,
        COUNT(*) OVER (PARTITION BY dep_id
                        ORDER BY dep_id) AS "employee_count"
    FROM
        employees
)

SELECT
    emp_name AS "manager_name",
    dep_id
FROM
    employee_count_by_dep
WHERE
    position = 'Manager'
    AND
    employee_count = (SELECT MAX(employee_count) FROM employee_count_by_dep)
ORDER BY
    dep_id
---------------------------------------------- NOTES --------------------------------------------
--> find the manager's name from the largest department
--> order by dep_id ASC
-------------------------------------------------------------------------------------------------
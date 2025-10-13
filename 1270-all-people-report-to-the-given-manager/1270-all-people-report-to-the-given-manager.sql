-------------------------------------------- SOLUTION -------------------------------------------
WITH recursive report AS (
    --- base query: direct reports to the heads
    SELECT * FROM employees 
    WHERE manager_id = 1 
    AND employee_id != manager_id

    UNION ALL
    --- recursive case: indirect reports to the head
    SELECT e.* FROM employees e
    JOIN report r ON e.manager_id = r.employee_id
    WHERE e.employee_id != e.manager_id
)

SELECT DISTINCT
    employee_id
FROM report
ORDER BY employee_id
---------------------------------------------- NOTES --------------------------------------------
--> find employee_id of all employees that directly/indirectly report their work to main boss
--> indirect relation between managers won't exceed 3 managers
-------------------------------------------------------------------------------------------------
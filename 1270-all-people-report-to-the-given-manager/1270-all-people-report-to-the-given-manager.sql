-------------------------------------------- SOLUTION -------------------------------------------
SELECT 
    e1.employee_id
FROM 
    Employees e1
LEFT JOIN 
    Employees e2
    ON e1.manager_id = e2.employee_id
LEFT JOIN Employees e3
    ON e2.manager_id = e3.employee_id
WHERE 
    e3.manager_id = 1 AND e1.employee_id != 1
---------------------------------------------- NOTES --------------------------------------------
--> find employee_id of all employees that directly/indirectly report their work to main boss
--> indirect relation between managers won't exceed 3 managers
-------------------------------------------------------------------------------------------------
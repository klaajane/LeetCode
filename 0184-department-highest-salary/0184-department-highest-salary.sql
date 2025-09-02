--------------------------------------------- SOLUTION ------------------------------------------
WITH ranked_salaries AS (
    SELECT 
        *,
        DENSE_RANK() OVER (PARTITION BY departmentID 
                            ORDER BY salary DESC) AS rank
    FROM
        Employee)

SELECT 
     d.name AS Department
    ,r.name AS Employee
    ,r.salary AS Salary
FROM
    ranked_salaries r
INNER JOIN
    Department d
    ON
    r.departmentId = d.id
WHERE
    r.rank = 1
---------------------------------------------- NOTES --------------------------------------------
--> employeees who have the highest salary in each of the departments
------------------------------------------- OPTIMIZATION ----------------------------------------
--> For now, I'm using '*' to pull all the columns from Employee Table since I need all the columns in the table. If the table schema changes, I will update my code to pull only the necessary columns
-------------------------------------------------------------------------------------------------
--------------------------------------------- SOLUTION ------------------------------------------
WITH ranked_salaries AS (
    SELECT
     *
    ,DENSE_RANK() OVER (PARTITION BY departmentId
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
    r.rank <= 3
---------------------------------------------- NOTES --------------------------------------------
--> high earner: employee who has a salary in the top 3 UNIQUE salaries for the department
-------------------------------------------------------------------------------------------------
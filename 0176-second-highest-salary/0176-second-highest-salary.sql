SELECT 
    IFNULL(MAX(salary), NULL) AS SecondHighestSalary 
FROM 
    (SELECT DISTINCT salary FROM Employee) AS distinct_salaries
WHERE 
    salary < (SELECT MAX(salary) FROM Employee)
--------------------------------------------- SOLUTION -------------------------------------------
SELECT 
    MAX(salary) AS SecondHighestSalary 
FROM 
    (SELECT DISTINCT salary FROM Employee) AS distinct_salaries
WHERE 
    salary < (SELECT MAX(salary) FROM Employee)
---------------------------------------------- NOTES --------------------------------------------
--> 2nd highest DISTINCT salary
--> return NULL when no 2nd highest salary exists
------------------------------------------- OPTIMIZATION ----------------------------------------
--> DISTINCT & Subquery: limit unecessary checks, in case the data contains duplicates
--> IFNULL: Handles edge cases if the data only contains one salary
-------------------------------------------------------------------------------------------------
--------------------------------------------- SOLUTION ------------------------------------------
WITH tax_brackets AS(
    SELECT
        company_id,
        employee_id,
        employee_name,
        salary AS "gross_salary",
        CASE
            WHEN MAX(salary) OVER (PARTITION BY company_id) < 1000 THEN 1
            WHEN MAX(salary) OVER (PARTITION BY company_id) BETWEEN  1000 AND 10000 THEN 0.76 -- to calculate net (1-0.24)
            ELSE 0.51  --- to calculate the net (1-0.51)
        END AS tax_prct
    FROM
        salaries)

SELECT 
    company_id,
    employee_id,
    employee_name,
    ROUND(gross_salary * tax_prct, 0) AS salary
FROM
    tax_brackets
---ORDER BY 1
---------------------------------------------- NOTES --------------------------------------------
--> find salaries after applying taxes
--> 0% If the max salary of any employee in the company is less than $1000.
--> 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
--> 49% If the max salary of any employee in the company is greater than $10000.
--> round to the nearest integer
-------------------------------------------------------------------------------------------------
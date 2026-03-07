SELECT
    emp_id,
    dept
FROM
    (
    SELECT
        emp_id,
        salary,
        dept,
        DENSE_RANK() OVER (PARTITION BY dept 
                            ORDER BY salary DESC) AS "salary_rnk"
    FROM employees
    ) ranked_salaries
WHERE salary_rnk = 2
ORDER BY emp_id
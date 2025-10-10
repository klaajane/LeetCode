-------------------------------------------- SOLUTION -------------------------------------------
WITH averge_salary_metrics AS (SELECT
                                s.employee_id,
                                s.amount,
                                TO_CHAR(s.pay_date, 'YYYY-MM') AS pay_month,
                                e.department_id,
                                AVG(amount) OVER (PARTITION BY TO_CHAR(s.pay_date, 'YYYY-MM'), department_id) AS department_salary_avg,
                                AVG(amount) OVER (PARTITION BY TO_CHAR(s.pay_date, 'YYYY-MM')) AS company_salary_avg
                            FROM
                                Salary s
                            INNER JOIN
                                Employee e ON e.employee_id = s.employee_id)
SELECT
    DISTINCT pay_month,
    department_id,
    CASE
        WHEN department_salary_avg > company_salary_avg THEN 'higher'
        WHEN department_salary_avg < company_salary_avg THEN 'lower'
        ELSE 'same'
    END AS "comparison"
FROM
    averge_salary_metrics
ORDER BY
    pay_month DESC
---------------------------------------------- NOTES --------------------------------------------
--> compare avg. salary in a department to the company's avg. salary (higher/lower/same)
-------------------------------------------------------------------------------------------------
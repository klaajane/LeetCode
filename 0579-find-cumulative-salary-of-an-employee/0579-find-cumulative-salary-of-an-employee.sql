-------------------------------------------- SOLUTION -------------------------------------------
WITH cum_salary_metrics AS (SELECT
                                id,
                                month,
                                salary,
                                SUM(Salary) OVER (PARTITION BY id
                                                    ORDER BY month
                                                    RANGE BETWEEN 2 PRECEDING 
                                                        AND CURRENT ROW),
                                ROW_NUMBER() OVER (PARTITION BY id
                                                    ORDER BY month DESC) AS month_rnk
                            FROM
                                Employee)
SELECT
    id,
    month,
    sum AS "salary"
FROM
    cum_salary_metrics
WHERE
    month_rnk != 1
ORDER BY
    id, month DESC
---------------------------------------------- NOTES --------------------------------------------
--> find 3-month sum
--> employee didn't work in a month => salary = 0
--> exclude cum sum for the most recent month
--> exclude cum sum for any month the employee didnt work
--> Order by id ASC, month DESC
-------------------------------------------------------------------------------------------------
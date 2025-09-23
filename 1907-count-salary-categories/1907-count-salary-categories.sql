-------------------------------------------------------- SOLUTION -------------------------------------------------------------
WITH salary_category AS (SELECT 
                            'Low Salary' AS category,
                            SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS "accounts_count"
                        FROM
                            accounts
                            UNION
                        SELECT 
                            'Average Salary' AS category,
                            SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END) AS "accounts_count"
                        FROM
                            accounts
                            UNION
                        SELECT 
                            'High Salary' AS category,
                            SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS "accounts_count"
                        FROM
                            accounts)
SELECT 
    *
FROM
    salary_category
ORDER BY
    accounts_count DESC
-------------------------------------------------------- NOTES -------------------------------------------------------------
--> "Low Salary": All the salaries strictly less than $20000.
--> "Average Salary": All the salaries in the inclusive range [$20000, $50000].
--> "High Salary": All the salaries strictly greater than $50000.
----------------------------------------------------------------------------------------------------------------------------
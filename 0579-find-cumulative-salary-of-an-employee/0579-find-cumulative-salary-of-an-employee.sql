-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    id,
    month,
    SUM(Salary) OVER (PARTITION BY id
                        ORDER BY month
                        RANGE BETWEEN 2 PRECEDING 
                                AND CURRENT ROW)
    AS "Salary"
FROM
    Employee
WHERE
    (id, month) NOT IN (SELECT id, MAX(month) FROM Employee GROUP BY id)
ORDER BY
    id, month DESC
---------------------------------------------- NOTES --------------------------------------------
--> find 3-month sum
--> employee didn't work in a month => salary = 0
--> exclude cum sum for the most recent month
--> exclude cum sum for any month the employee didnt work
--> Order by id ASC, month DESC
-------------------------------------------------------------------------------------------------
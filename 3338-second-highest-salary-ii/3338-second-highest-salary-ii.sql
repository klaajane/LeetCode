--------------------------------------------- SOLUTION ------------------------------------------
--> STEP 1: apply DENSE_RANK() 
WITH ranked_salaries AS (
    SELECT
        emp_id,
        dept,

        DENSE_RANK() OVER (
            PARTITION BY dept
            ORDER BY salary DESC
        ) as rnk

    FROM employees)

--> STEP 2: filter by rnk to display 2nd highest salary
SELECT
    emp_id,
    dept 
FROM ranked_salaries
WHERE rnk = 2
ORDER BY emp_id
---------------------------------------------- NOTES ---------------------------------------------
--> GOAL:
    --> find employees who earnd 2nd salary in each dept
    --> tie ==> return all employees

--> ORDER BY:
    --> emp_id ASC
--------------------------------------------------------------------------------------------------
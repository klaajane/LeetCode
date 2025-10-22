--------------------------------------------- SOLUTION ------------------------------------------
WITH candidates_rolling_salary AS (
    SELECT
        employee_id,
        experience,
        SUM(salary) OVER (PARTITION BY experience
                            ORDER BY salary, employee_id ASC) AS "salary_rolling_sum"
    FROM
        candidates
)

SELECT 'Senior' experience, COUNT(*) "accepted_candidates" 
FROM candidates_rolling_salary 
WHERE experience = 'Senior' AND salary_rolling_sum < 70000
    UNION ALL
SELECT 'Junior' experience, COUNT(*) "accepted_candidates" 
FROM candidates_rolling_salary 
WHERE experience = 'Junior' 
AND salary_rolling_sum <= (SELECT 70000 - COALESCE (MAX(salary_rolling_sum), 0) 
                            FROM candidates_rolling_salary 
                            WHERE experience = 'Senior' AND salary_rolling_sum < 70000)
---------------------------------------------- NOTES --------------------------------------------
--> company wants to hire a new employee, budget is 70,000
--> goal: hiring the largest 3 of seniors
--> use remaining budget to hire juniors
-------------------------------------------------------------------------------------------------
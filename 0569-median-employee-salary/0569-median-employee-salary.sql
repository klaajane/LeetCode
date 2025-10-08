-------------------------------------------- SOLUTION -------------------------------------------
WITH salaries_ranked AS (SELECT
                            id,
                            company,
                            salary,
                            ROW_NUMBER() OVER (PARTITION BY company
                                                ORDER BY salary ASC) as salary_rnk,
                            COUNT(*) OVER(PARTITION BY company) as row_count  
                         FROM
                            employee)
SELECT
    id,
    company,
    salary
FROM
    salaries_ranked
WHERE 
    -- odd case: single middle row
    (row_count % 2 = 1 AND salary_rnk = (row_count + 1) / 2)
    OR
    -- even case: two middle rows
    (row_count % 2 = 0 AND salary_rnk IN (row_count / 2, (row_count / 2) + 1))
---------------------------------------------- NOTES --------------------------------------------
--> find the rows where salary = median salary of the company
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
WITH salaries_ranked AS (SELECT
                            *,
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
    salary_rnk IN (CEILING(row_count / 2.0), (row_count / 2.0) + 1)


---------------------------------------------- NOTES --------------------------------------------
--> find the rows where salary = median salary of the company
-------------------------------------------------------------------------------------------------
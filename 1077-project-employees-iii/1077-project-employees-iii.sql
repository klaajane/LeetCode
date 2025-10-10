-------------------------------------------- SOLUTION -------------------------------------------
WITH emloyee_experience AS (SELECT
                                p.project_id,
                                p.employee_id,
                                e.experience_years,
                                DENSE_RANK() OVER (PARTITION BY p.project_id
                                                    ORDER BY e.experience_years DESC) AS "experience_rnk"
                            FROM
                                Employee e
                            INNER JOIN
                                project p ON p.employee_id = e.employee_id)
SELECT
    project_id,
    employee_id
FROM
    emloyee_experience
WHERE
    experience_rnk = 1
---------------------------------------------- NOTES --------------------------------------------
--> report most exprienced employees in each project (tie => order by years of experience)
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
WITH employee_workload AS (
    SELECT
        p.employee_id,
        p.project_id,
        e.name,
        p.workload,
        AVG(workload) OVER (PARTITION BY team) AS team_workload_avg
    FROM
        project p
    INNER JOIN
        employees e
        ON p.employee_id = e.employee_id)

SELECT
    employee_id,
    project_id,
    name AS "employee_name",
    workload AS "project_workload"
FROM
    employee_workload
WHERE
    team_workload_avg < workload
ORDER BY
    employee_id, project_id 
---------------------------------------------- NOTES --------------------------------------------
--> find employees who are allocated to projects with workload that exceeds the avg team workload
--> ORDER by employee_id, project_id
-------------------------------------------------------------------------------------------------
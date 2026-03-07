-- recursion problem:


-- base query: manager's info
WITH recursive hierarchy AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level 
    FROM employees 
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        h.level + 1
    FROM hierarchy h
    JOIN employees e ON e.manager_id = h.employee_id),

-- now we need to work our way up:

descendants AS (
    SELECT employee_id AS manager, employee_id AS descendant, salary
    FROM hierarchy

    UNION ALL

    SELECT d.manager, h.employee_id, h.salary
    FROM descendants d
    JOIN hierarchy h ON h.manager_id = d.descendant
)

SELECT
    h.employee_id,
    h.employee_name,
    h.level,
    COUNT(d.descendant) - 1 AS team_size,  -- subtract self
    SUM(d.salary) AS budget
FROM hierarchy h
JOIN descendants d ON d.manager = h.employee_id
GROUP BY h.employee_id, h.employee_name, h.level
ORDER BY level, budget DESC, employee_name ASC
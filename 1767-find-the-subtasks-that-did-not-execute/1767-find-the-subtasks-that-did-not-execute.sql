--------------------------------------------- SOLUTION ------------------------------------------
WITH recursive tasks_starter AS (
    SELECT task_id, 1 "subtask_id"
    FROM tasks

    UNION ALL
    
    SELECT t2.task_id, t.subtask_id + 1 AS "subtask_id"
    FROM tasks_starter t
    INNER JOIN tasks t2
    ON t2.task_id = t.task_id
    WHERE t.subtask_id < t2.subtasks_count
)

SELECT task_id, subtask_id
FROM tasks_starter
WHERE (task_id, subtask_id) NOT IN (SELECT task_id, subtask_id FROM executed) 
---------------------------------------------- NOTES --------------------------------------------
--> report the IDs of the missing subtasks for each task_id
-------------------------------------------------------------------------------------------------
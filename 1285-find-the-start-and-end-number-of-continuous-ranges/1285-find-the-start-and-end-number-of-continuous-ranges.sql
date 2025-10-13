-------------------------------------------- SOLUTION -------------------------------------------
WITH log_grp AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY log_id) AS id,
        log_id,
        abs(ROW_NUMBER() OVER (ORDER BY log_id) - log_id) AS grp
    FROM
        logs)

SELECT
    MIN(log_id) AS start_id,
    MAX(log_id) AS end_id
FROM
    log_grp
GROUP BY
    grp
ORDER BY
    start_id
---------------------------------------------- NOTES --------------------------------------------
--> find the start and end number of continuois ranges
--> order by start_id
-------------------------------------------------------------------------------------------------
--------------------------------------------- SOLUTION ------------------------------------------
WITH calls_records AS (
    SELECT
        CASE
            WHEN from_id > to_id THEN to_id
            ELSE from_id
        END AS "person1",

        CASE
            WHEN from_id < to_id THEN to_id
            ELSE from_id
        END AS "person2",
        
        duration
    FROM
        calls)

SELECT
    person1,
    person2,
    COUNT(*) "call_count",
    SUM(duration) "total_duration"
FROM
    calls_records
GROUP BY 1, 2
---------------------------------------------- NOTES --------------------------------------------
--> report # of calls and call duration between each pair of disinct people
-------------------------------------------------------------------------------------------------
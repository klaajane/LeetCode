--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    LEAST(from_id, to_id) "person1",
    GREATEST(from_id, to_id) "person2",
    COUNT(*) "call_count",
    SUM(duration) "total_duration"
FROM
    calls
GROUP BY 1, 2
---------------------------------------------- NOTES --------------------------------------------
--> report # of calls and call duration between each pair of disinct people
-------------------------------------------------------------------------------------------------
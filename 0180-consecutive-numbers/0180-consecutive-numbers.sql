--------------------------------------------- SOLUTION ------------------------------------------
SELECT 
    DISTINCT num AS ConsecutiveNums
FROM (
    SELECT 
        num,
        LEAD(num, 1) OVER (ORDER BY id) AS next_num,
        LEAD(num, 2) OVER (ORDER BY id) AS next_next_num
    FROM 
        Logs
     ) consecutive_nums
WHERE num = next_num
  AND next_num = next_next_num
---------------------------------------------- NOTES --------------------------------------------
-- Find numbers that apprea at least 3 times consecutively
-- order doesn't matter
-------------------------------------------------------------------------------------------------
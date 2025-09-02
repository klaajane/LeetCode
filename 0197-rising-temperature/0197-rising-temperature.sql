--------------------------------------------- SOLUTION ------------------------------------------
SELECT
     w1.id AS "Id"
    ,w1.recordDate AS "Current Date" -- Enhancement
    ,w2.recordDate AS "Previous Date" -- Enhancement
    ,w1.temperature AS "Current Temperature" -- Enhancement
    ,w2.temperature AS "Prev Temperature" -- Enhancement
    ,w1.temperature - w2.temperature AS "Temperature Change (#)" -- Enhancement
FROM
    Weather w1
INNER JOIN 
    Weather w2
    ON
    w1.recordDate = w2.recordDate INTERVAL '1 day'
WHERE
    w1.temperature > w2.temperature
---------------------------------------------- NOTES --------------------------------------------
--> find all dates' id with higher temp compared to yesterday
----------------------------------- OPTIMIZATION & ENHANCEMENT -----------------------------------
--> adding a date column for both current & previous date 
--> current vs previous temperature change
-------------------------------------------------------------------------------------------------

--------------------------------------------- SOLUTION ------------------------------------------
SELECT
     w1.id AS "Id"
FROM
    Weather w1
INNER JOIN 
    Weather w2
    ON
    w1.recordDate- w2.recordDate = 1
    AND
    w1.temperature > w2.temperature
---------------------------------------------- NOTES --------------------------------------------
--> find all dates' id with higher temp compared to yesterday
----------------------------------- OPTIMIZATION & ENHANCEMENT -----------------------------------
--> adding a date column for both current & previous date 
--> current vs previous temperature change
-------------------------------------------------------------------------------------------------
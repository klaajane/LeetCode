--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    id
    ,COALESCE(
        CASE 
            WHEN id % 2 = 0 THEN LAG(student) OVER (ORDER BY id)
            ELSE LEAD(student) OVER (ORDER BY id)
     END, 
     student) 
     AS "student"
FROM
    Seat
---------------------------------------------- NOTES --------------------------------------------
--> swap seat id of every two consecutive students
--> number of last student is odd => don't swap
-------------------------------------------------------------------------------------------------
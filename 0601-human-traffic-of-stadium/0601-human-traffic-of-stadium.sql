--------------------------------------------- SOLUTION ------------------------------------------
WITH row_order (SELECT
                     *
                    ,id - (ROW_NUMBER() OVER (ORDER BY id)) AS diff
                    ,ROW_NUMBER() OVER (ORDER BY id) AS RW
                FROM
                    Stadium
                WHERE
                    people >= 100)

SELECT
     id
    ,visit_date
    ,people
FROM
    row_order
WHERE
    diff IN (SELECT diff
             FROM row_order
             GROUP BY 1
             HAVING COUNT(diff) >= 3)
ORDER BY 
    id
---------------------------------------------- NOTES --------------------------------------------
--> retrieve records with 3 or more rows with consecutive ids
--> & number of ppl greater than or equal to 100 for each
------------------------------------------- OPTIMIZATION ----------------------------------------
--> 
-------------------------------------------------------------------------------------------------
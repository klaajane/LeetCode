-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    ROUND(
         SQRT(
            MIN(POWER(p2.x - p1.x,2) + POWER(p2.y - p1.y, 2))
             )::numeric,
         2
        ) AS shortest 
FROM
    Point2D p1
CROSS JOIN
    Point2D p2 
WHERE 
    (p1.x, p1.y) <> (p2.x, p2.y)
---------------------------------------------- NOTES --------------------------------------------
--> report the SHORTEST distance between two points
--> ROUND to 2 decimal points
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
WITH coordinates_with_id AS (
        SELECT
            x,
            y,
            ROW_NUMBER() OVER () AS "r_id"
        FROM
            coordinates
)

SELECT DISTINCT
    c1.x,
    c1.y
FROM
    coordinates_with_id c1
        INNER JOIN
            coordinates_with_id c2
            ON c1.r_id != c2.r_id
            AND c1.x = c2.y
            AND c1.y = c2.x
WHERE
   c1.x <= c1.y
ORDER BY
   c1.x, c1.y   
---------------------------------------------- NOTES --------------------------------------------
--> find all symmetric UNIQUE coordinates such that x1 == y2 & x2 == y1 
--> order by X and Y ASC
-------------------------------------------------------------------------------------------------
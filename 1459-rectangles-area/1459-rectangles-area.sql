--------------------------------------------- SOLUTION ------------------------------------------
WITH points_combined AS (
    SELECT
        p1.id AS p1,
        p1.x_value AS x1_value,
        p2.x_value AS x2_value,
        p2.id AS p2,
        p1.y_value AS y1_value,
        p2.y_value AS y2_value
    FROM points p1
    CROSS JOIN points p2
    WHERE p1.id < p2.id 
)
,

rectangle_area AS (
    SELECT
        p1,
        p2,
        ABS(x2_value - x1_value) * ABS(y2_value - y1_value) AS area
    FROM points_combined
)

SELECT
    p1 AS P1,
    p2 AS P2,
    area AS AREA
FROM rectangle_area
WHERE area != 0
ORDER BY area DESC, p1, p2
---------------------------------------------- NOTES --------------------------------------------
--> report all possible axis-aligned rectangles with a non-zero area 
-------------------------------------------------------------------------------------------------
--------------------------------------------- SOLUTION ------------------------------------------
WITH points_combined AS (
    SELECT
        p1.id AS "id1",
        p2.id AS "id2",
        p1.x_value AS "x1_value",
        p2.x_value AS "x2_value",
        p1.y_value AS "y1_value",
        p2.y_value AS "y2_value"
    FROM
        points p1
    CROSS JOIN
        points p2),

areas AS (
    SELECT
        *,
        abs(x1_value - x2_value) * abs(y1_value - y2_value) AS area
    FROM
        points_combined)

SELECT DISTINCT
    id1 "P1",
    id2 "P2",
    area "AREA"
FROM 
    areas
WHERE
    area != 0
    AND id1 < id2
ORDER BY
    area DESC, id1, id2
---------------------------------------------- NOTES --------------------------------------------
--> report all possible axis-aligned rectangles with a non-zero area 
-------------------------------------------------------------------------------------------------
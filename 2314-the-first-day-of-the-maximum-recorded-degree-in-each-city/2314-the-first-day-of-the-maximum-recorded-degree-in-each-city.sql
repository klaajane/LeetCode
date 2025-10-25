--------------------------------------------- SOLUTION ------------------------------------------
WITH degrees AS (
    SELECT
        city_id,
        day,
        degree,
        ROW_NUMBER() OVER (PARTITION BY city_id
                            ORDER BY degree DESC, day ASC) AS "rnk"
    FROM
        Weather)

SELECT
    city_id,
    day,
    degree
FROM
    degrees
WHERE rnk = 1
ORDER BY city_id ASC
---------------------------------------------- NOTES --------------------------------------------
--> return max recorded degree b the city
--> if a city has multiple rows for max recorded degree, return earliest day among them
-------------------------------------------------------------------------------------------------
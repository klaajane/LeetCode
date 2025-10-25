--------------------------------------------- SOLUTION ------------------------------------------
WITH degrees AS (
    SELECT
        city_id,
        MIN(day) AS "day",
        degree,
        DENSE_RANK() OVER (PARTITION BY city_id
                            ORDER BY degree DESC) AS "rnk"
    FROM
        Weather
    GROUP BY 1, 3)

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
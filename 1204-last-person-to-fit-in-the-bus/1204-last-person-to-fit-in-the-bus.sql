-------------------------------------------- SOLUTION -------------------------------------------
WITH weight_cumsum AS (SELECT
                            *,
                            SUM(weight) OVER (
                                ORDER BY turn
                                ROWS BETWEEN UNBOUNDED PRECEDING
                                AND CURRENT ROW
                            ) AS "weight_cumsum"
                        FROM
                            queue)
SELECT
    person_name
FROM
    weight_cumsum
WHERE
    weight_cumsum <= 1000
ORDER BY turn DESC
LIMIT 1
---------------------------------------------- NOTES --------------------------------------------
--> find the name of the person of the last person that can't fit in the bus (1000 kg limit)
-------------------------------------------------------------------------------------------------
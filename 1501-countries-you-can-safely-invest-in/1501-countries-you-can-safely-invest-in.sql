--------------------------------------------- SOLUTION ------------------------------------------
WITH calls_records AS(
    SELECT
        ca.*,
        p1.id,
        p2.id,
        c1.name AS "caller_country",
        c2.name AS "callee_country"
    FROM
        calls ca
    INNER JOIN
        person p1
        ON p1.id = ca.caller_id
    INNER JOIN
        person p2
        ON p2.id = ca.callee_id
    LEFT JOIN
        country c1
        ON LEFT(p1.phone_number, 3) = c1.country_code
        AND p1.id = ca.caller_id
    LEFT JOIN
        country c2
        ON LEFT(p2.phone_number, 3) = c2.country_code
        AND p2.id = ca.callee_id),

calls_records_pivoted AS (
    SELECT caller_id AS "id", duration, caller_country AS "country" FROM calls_records
        UNION ALL
    SELECT callee_id AS "id", duration, callee_country AS "country" FROM calls_records)

SELECT
    country
FROM
    calls_records_pivoted
GROUP BY 1
HAVING AVG(duration) > (SELECT AVG(duration)
                        FROM calls_records_pivoted)
---------------------------------------------- NOTES --------------------------------------------
--> calls table may contains duplicates
--> investment critera: avg. call duration of the calls > global avg
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
WITH calls_count_by_hour AS (
    SELECT
        city,
        EXTRACT(HOUR FROM call_time) AS "call_hour",
        COUNT(*) AS "number_of_calls"
    FROM
        Calls
    GROUP BY 1, 2 
)

SELECT 
    city, 
    call_hour AS "peak_calling_hour", 
    number_of_calls
FROM 
    calls_count_by_hour
WHERE 
    (city, number_of_calls) IN (SELECT city, MAX(number_of_calls) 
                                FROM calls_count_by_hour 
                                GROUP BY city)
ORDER BY
    peak_calling_hour DESC , city DESC
---------------------------------------------- NOTES --------------------------------------------
--> find peak calling hours for each city
--> same # of calls => return all those hours
--> order by peak calling hour and city DESC
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    c.patient_id,
    p.patient_name,
    p.age,
    MIN(c1.test_date) - MIN(c.test_date) AS "recovery_time"
FROM
    covid_tests c
INNER JOIN
    covid_tests c1
    ON c.patient_id = c1.patient_id
    AND c.test_date < c1.test_date
    AND c.result = 'Positive'
    AND c1.result = 'Negative'
INNER JOIN
    patients p
    ON c.patient_id = p.patient_id
GROUP BY
    c.patient_id, p.patient_name, p.age
ORDER BY
    recovery_time, p.patient_name
---------------------------------------------- NOTES --------------------------------------------
--> find patients who have recovered from COVID (positive -> negative)
--> calculate recovery time (# of days it took to heal)
--> order by recovery_time ASC, patient_name ASC
-------------------------------------------------------------------------------------------------

DO IT AGAIN

-------------------------------------------- SOLUTION -------------------------------------------
WITH trips_by_half_year AS (SELECT
                                *,
                                CASE
                                    WHEN DATE_PART('MONTH', trip_date) BETWEEN 1 AND 6
                                        THEN 'first_half'
                                        ELSE 'second_half'
                                END AS "time_of_the_year"
                            FROM
                                trips),
trip_avg AS (SELECT
                t.driver_id,
                d.driver_name,
               
                CASE
                    WHEN t.time_of_the_year = 'first_half'
                        THEN AVG(distance_km / fuel_consumed)
                END AS "first_half_avg",


                CASE
                    WHEN t.time_of_the_year = 'second_half'
                        THEN AVG(distance_km / fuel_consumed)
                END AS "second_half_avg"


            FROM
                trips_by_half_year t
            INNER JOIN
                drivers d
                ON
                t.driver_id = d.driver_id
            GROUP BY
                t.driver_id,
                d.driver_name,
                t.time_of_the_year)
SELECT
    t1.driver_ID,
    t1.driver_name,
    ROUND(t1.first_half_avg, 2),
    ROUND(t2.second_half_avg, 2),
    ROUND(t2.second_half_avg, 2) - ROUND(t2.second_half_avg, 2) AS efficiency_improvement
FROM
    trip_avg t1
INNER JOIN
    trip_avg t2
    ON
    t1.driver_name = t2.driver_name
WHERE
    t1.first_half_avg IS NOT NULL
    AND
    t2.second_half_avg IS NOT NULL
---------------------------------------------- NOTES --------------------------------------------
--> find drivers whose fuel efficiency has improved (avg fuel effic. 1/2 of the year > second 1/2)
--> fuel effic. = distance_km / fuel_consumed for each trip
--> First half: January to June, Second half: July to December
--> only include drivers who have trips in both halves of the year
--> effic. improvement = second_half_avg - first_half_avg
--> round to 2 decimal places
--> Order effic. improvement DESC, driver_name ASC
-------------------------------------------------------------------------------------------------




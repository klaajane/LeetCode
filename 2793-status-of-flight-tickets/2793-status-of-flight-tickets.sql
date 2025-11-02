-------------------------------------------- SOLUTION -------------------------------------------
-- join tables
WITH booking_count AS (
    SELECT
        f.flight_id,
        f.capacity,
        p.passenger_id,
        p.booking_time,
        COUNT(p.passenger_id) OVER (PARTITION BY f.flight_id
                                    ORDER BY p.booking_time ASC
                                    ROWS BETWEEN UNBOUNDED PRECEDING
                                    AND CURRENT ROW) AS "cumulative_passenger_count"
    FROM
        flights f
        LEFT JOIN
            passengers p
            ON p.flight_id = f.flight_id
)

SELECT
    passenger_id,
    CASE 
        WHEN cumulative_passenger_count <= capacity THEN 'Confirmed'
        ELSE 'Waitlist'
    END AS "Status"
FROM
    booking_count
WHERE
    passenger_id IS NOT NULL
ORDER BY
    passenger_id ASC
---------------------------------------------- NOTES --------------------------------------------
--> booked before reaching capacity => confirmed
--> booked after reaching capacity => waitlist
--> order by passenger_id ASC
-------------------------------------------------------------------------------------------------
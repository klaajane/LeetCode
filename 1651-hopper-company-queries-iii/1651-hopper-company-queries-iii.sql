------------------------------------------------- SOLUTION ---------------------------------------------
WITH rides_with_months AS (
    SELECT
        ---ri.*,
        EXTRACT(MONTH FROM ri.requested_at) "month",
        ar.ride_distance,
        ar.ride_duration
    FROM
        rides ri
    INNER JOIN
        AcceptedRides ar
        ON ri.ride_id = ar.ride_id
    WHERE
        ri.requested_at BETWEEN '2020-01-01' AND '2020-12-31'),

ride_distance_duration_by_month AS (
    SELECT
        m.month,
        COALESCE(SUM(r.ride_distance), 0) AS "ride_distance",
        COALESCE(SUM(r.ride_duration), 0) AS "ride_duration"
    FROM
        generate_series(1, 12) AS m(month)
    LEFT JOIN
        rides_with_months r
        ON r.month = m.month
    GROUP BY m.month
    ORDER BY m.month)

SELECT
    month,
    ROUND(
        AVG(ride_distance) OVER (ORDER BY month ASC
                            ROWS BETWEEN CURRENT ROW
                            AND 2 FOLLOWING)
        , 2) AS "average_ride_distance",

    ROUND(
        AVG(ride_duration) OVER (ORDER BY month ASC
                                ROWS BETWEEN CURRENT ROW
                                AND 2 FOLLOWING)
        , 2) AS "average_ride_duration" 
FROM
    ride_distance_duration_by_month
LIMIT 10
------------------------------------------------ NOTES ----------------------------------------------
--> compute the avg. ride distance & duration of every 3-month window starting from January
--> round to neareast 2 decimal places
--> order by month ASC
-----------------------------------------------------------------------------------------------------
WITH drivers_by_month AS (
    SELECT
       driver_id,
        CASE    
            WHEN EXTRACT(YEAR FROM join_date) ='2019' AND EXTRACT(MONTH FROM join_date) = '12'
            THEN '1'
            ELSE EXTRACT(MONTH FROM join_date)::INT
        END AS "month"
    FROM
        drivers
    WHERE
        join_date BETWEEN '2019-12-01' AND '2020-12-31'),

drivers_over_12months AS(
    SELECT
        m.month,
        COUNT(DISTINCT d.driver_id) AS "active_drivers_count"
    FROM
        (SELECT month
        FROM generate_series(1, 12) "month") m
    LEFT JOIN   
        drivers_by_month d
        ON m.month = d.month
    GROUP BY
        m.month
    ORDER BY 1),

active_drivers AS (
    SELECT
        month,
        SUM(active_drivers_count) OVER (ORDER BY month ASC) AS "active_drivers"
    FROM
        drivers_over_12months),

accepted_rides_by_month AS (
    SELECT
        ar.ride_id,
        ar.driver_id,
        EXTRACT(MONTH FROM r.requested_at) AS "month"
    FROM
        AcceptedRides ar
    INNER JOIN
        rides r 
        ON r.ride_id = ar.ride_id
    WHERE
        r.requested_at BETWEEN '2020-01-01' AND '2020-12-31'),

accepeted_rides_count AS (
    SELECT
        month,
        COUNT(DISTINCT driver_id) AS "accepted_rides_count"
    FROM
        accepted_rides_by_month
    GROUP BY
        month
)

SELECT
    ad.month,
    --ad.active_drivers,
    COALESCE(
            ROUND(100.0 * accepted_rides_count / active_drivers
            , 2)
        , 0)
    AS "working_percentage"
FROM
    active_drivers ad
LEFT JOIN
    accepeted_rides_count ar
    ON ar.month = ad.month
--------------------------------------------- SOLUTION ------------------------------------------
WITH drivers_history AS (
    SELECT
        driver_id,
        join_date,
        EXTRACT(YEAR FROM join_date) "year",
        --EXTRACT(MONTH FROM join_date) "month",
        CASE
            WHEN EXTRACT(YEAR FROM join_date) = '2019' AND EXTRACT(MONTH FROM join_date) = '12'
            THEN '1'
            ELSE EXTRACT(MONTH FROM join_date)
        END AS "joined_month"
    FROM
        drivers
    WHERE
        join_date BETWEEN '2019-12-01' AND '2020-12-31'
    ORDER BY 4),

active_drivers1 AS (
    SELECT
        m.month,
        d.driver_id,
        COUNT(d.joined_month) AS "monthly_active_drivers"
    FROM
        (SELECT month FROM generate_series(1, 12) "month") m -- generate the serie for the months needed
    LEFT JOIN
        drivers_history d
        ON m.month = d.joined_month
    GROUP BY 1, 2),

active_users2 AS 
    (SELECT
        month,
        driver_id,
        SUM(monthly_active_drivers) OVER (ORDER BY month ASC) AS "active_drivers"
    FROM
        active_drivers1),

rides_history AS (
    SELECT
        ride_id,
        user_id,
        EXTRACT(MONTH FROM requested_at) AS "requested_month"
    FROM
        rides
    WHERE
        requested_at BETWEEN '2020-01-01' AND '2020-12-31'),

accepted_ride1 AS (
    SELECT
        a.ride_id,
        a.driver_id,
        --r.ride_id, -- causes the duplication later on during the join
                     -- SQL treats duplicates as seperate rows
        r.requested_month
    FROM
        rides_history r
    INNER JOIN
        AcceptedRides a
        ON r.ride_id = a.ride_id),

 ---needs to aggregate rows from accepted_rides before joining to avoid duplication
accepted_rides_counts AS (
    SELECT 
        requested_month AS "month",
        COUNT(*) AS "accepted_rides"
    FROM
        accepted_ride1
    GROUP BY requested_month)

SELECT DISTINCT
    a.month,
    a.active_drivers,
    COALESCE(accepted_rides, 0) AS "accepted_rides"
FROM
    active_users2 a 
LEFT JOIN
    accepted_rides_counts ar
    ON ar.month = a.month 
ORDER BY 
    a.month ASC
---------------------------------------------- NOTES --------------------------------------------
--> # of Hopper drivers by the end of the month (active_drivers)
--> # of accepted rides in that month (accepted ride)
--> order by month ASC (1, 2, 3... 12)
-------------------------------------------------------------------------------------------------
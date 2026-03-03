--------------------------------------------- SOLUTION ------------------------------------------
WITH park_summary AS (
    SELECT
        car_id,
        lot_id,
        SUM(fee_paid) AS "total_fee_paid",
        SUM(EXTRACT(EPOCH FROM (exit_time - entry_time)) / 3600) AS "time_spent"
    FROM ParkingTransactions
    GROUP BY car_id, lot_id),

avg_hourly_fees AS (
    SELECT 
        car_id,
        lot_id,
        RANK() OVER (PARTITION BY car_id ORDER BY time_spent DESC) AS "rnk"
    FROM park_summary)

SELECT
    sm.car_id,
    SUM(sm.total_fee_paid) AS "total_fee_paid",
    ROUND(SUM(sm.total_fee_paid) / SUM(sm.time_spent), 2) AS "avg_hourly_fee",
    av.lot_id AS "most_time_lot"
FROM avg_hourly_fees av
JOIN park_summary sm ON sm.car_id = av.car_id
WHERE av.rnk = 1
GROUP BY sm.car_id, av.lot_id
---------------------------------------------- NOTES --------------------------------------------
--> find total parking fee by car across all parking lost
--> find average hourly fee (ROUND to 2 dec) paid by each car
--> find where car spent hte most total time
--> order by car_id ASC
---------------------------------------------THOUGHTS--------------------------------------------
-- 
--------------------------------------------------------------------------------------------------
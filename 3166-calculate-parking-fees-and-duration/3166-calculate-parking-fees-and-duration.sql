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
-- I need stats at two granularities — per car+lot to rank most-visited lot, but per car only
-- for the final totals. That's why I need two CTEs instead of one.
--
-- First CTE groups by car_id + lot_id so I preserve lot-level time_spent. Collapsing to
-- car_id too early would lose the detail I need for ranking.
--
-- Second CTE applies RANK() on top of that — partitioned by car_id, ordered by time_spent
-- desc — so rnk = 1 gives me the lot each car spent the most time in.
--
-- Final SELECT re-aggregates to car level. I divide SUM(fee) / SUM(hours) rather than
-- AVG(avg) — because averaging averages is wrong when time spent per lot varies.
--------------------------------------------------------------------------------------------------
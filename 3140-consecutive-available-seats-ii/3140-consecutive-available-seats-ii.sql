--------------------------------------------- SOLUTION ------------------------------------------

WITH free_seats AS
    (SELECT
        seat_id,
        seat_id - ROW_NUMBER() OVER (ORDER BY seat_id) AS grp
    FROM cinema
    WHERE free = 1)
,
consecutive_seats AS (
    SELECT
        MIN(seat_id) AS "first_seat_id",
        MAX(seat_id) AS "last_seat_id",
        COUNT(*) AS "consecutive_seats_len"
    FROM free_seats
    GROUP BY grp)

SELECT
    first_seat_id,
    last_seat_id,
    consecutive_seats_len
FROM consecutive_seats
WHERE consecutive_seats_len = (SELECT MAX(consecutive_seats_len) FROM consecutive_seats)
ORDER BY first_seat_id
---------------------------------------------- NOTES --------------------------------------------
--> find length of longest consecutive sequence of available seats
---------------------------------------------THOUGHTS--------------------------------------------
-- This is a gaps and islands problem, so the first thing I want to do is isolate only the
-- free seats, since occupied seats don't matter here.
--
-- The trick I'm using is subtracting a row number from each seat_id. The reason this works
-- is that if seats are consecutive, their seat_ids increment by 1 AND their row numbers
-- increment by 1 — so the difference stays the same, naturally grouping them together.
-- The moment there's a gap, that difference changes, creating a new group.
--
-- Once I have those groups, it's just a simple aggregation — MIN gives me where the sequence
-- starts, MAX gives me where it ends, and COUNT tells me how long it is.
--
-- Finally I filter to the group with the longest length to satisfy the problem's requirement.
--------------------------------------------------------------------------------------------------
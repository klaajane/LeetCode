--------------------------------------------- SOLUTION ------------------------------------------
-- all calls:
WITH all_calls AS (
    SELECT caller_id "caller", recipient_id "recipient", call_time FROM calls
        UNION
    SELECT recipient_id "caller", caller_id "recipient", call_time FROM calls
),

-- Find first call:
first_call AS (
    SELECT 
        caller, recipient, call_time::DATE "date"
    FROM (
            SELECT
                *,
                ROW_NUMBER() OVER (PARTITION BY caller, call_time::DATE -- needs to convert to date
                                    ORDER BY call_time ASC) "rnk"
            FROM
                all_calls
            )
    WHERE rnk = 1
),

-- Find last call:
last_call AS (
    SELECT 
        caller, recipient, call_time::DATE "date"
    FROM (
            SELECT
                *,
                ROW_NUMBER() OVER (PARTITION BY caller, call_time::DATE -- needs to convert to date
                                    ORDER BY call_time DESC) "rnk"
            FROM
                all_calls
            )
    WHERE rnk = 1)


SELECT DISTINCT
    f.caller "user_id"
FROM
    first_call f
    JOIN last_call l
        ON f.caller = l.caller
        AND f.recipient = l.recipient
---------------------------------------------- NOTES --------------------------------------------
--> report IDs of users whose first and last calls on any day were the same person
-------------------------------------------------------------------------------------------------
--------------------------------------------- SOLUTION ------------------------------------------
-- all calls:
WITH all_calls AS (
    SELECT caller_id "caller", recipient_id "recipient", call_time FROM calls
        UNION
    SELECT recipient_id "caller", caller_id "recipient", call_time FROM calls
),

-- Find first / last call:
calls_history AS (
    SELECT 
        *,
        first_value(recipient) OVER (PARTITION BY caller, call_time::DATE 
                                        ORDER BY call_time ASC) "first_recipient",
        first_value(recipient) OVER (PARTITION BY caller, call_time::DATE 
                                        ORDER BY call_time DESC) "last_recipient"
    FROM all_calls
    ORDER BY caller
)

SELECT DISTINCT caller "user_id" 
FROM calls_history
WHERE first_recipient = last_recipient
---------------------------------------------- NOTES --------------------------------------------
--> report IDs of users whose first and last calls on any day were the same person
-------------------------------------------------------------------------------------------------
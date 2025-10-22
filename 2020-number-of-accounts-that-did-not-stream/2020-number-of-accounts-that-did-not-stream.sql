-------------------------------------------- SOLUTION -------------------------------------------
WITH qualified_subscriptions AS(
    SELECT
        account_id,
        start_date,
        end_date
    FROM
        subscriptions
    WHERE
        EXTRACT(YEAR FROM end_date) >= '2021'
),

account_with_no_streams AS (
    SELECT
        s.account_id,
        s.stream_date
    FROM
        qualified_subscriptions q
        LEFT JOIN
            streams s
                ON q.account_id = s.account_id
    WHERE
        EXTRACT(YEAR FROM s.stream_date) != '2021')

SELECT COUNT(DISTINCT account_id) AS "accounts_count"
FROM account_with_no_streams  
---------------------------------------------- NOTES --------------------------------------------
--> report # of account that bought 2021 subscriptions, but didn't stream 
-------------------------------------------------------------------------------------------------
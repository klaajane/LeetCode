-- first identify customers who have been suscribers for at least 60 days:
WITH users_subscription_days AS (
    SELECT DISTINCT
        user_id,
        (MAX(event_date) OVER (PARTITION BY user_id) 
        - 
        MIN(event_date) OVER (PARTITION BY user_id)) 
        AS "days_as_subscriber"
    FROM subscription_events
    WHERE event_type != 'cancel')
,

days_condition AS (
    (SELECT user_id, days_as_subscriber
    FROM users_subscription_days
    WHERE days_as_subscriber >= 60))
,

churn_conditions AS (
    SELECT
        d.user_id,
        plan_name,
        LAST_VALUE(monthly_amount) OVER (PARTITION BY d.user_id ORDER BY s.event_date DESC) AS "current_monthly_amount",
        MAX(monthly_amount) OVER (PARTITION BY d.user_id) AS "max_historical_amount",
        CASE 
            WHEN event_type = 'downgrade' 
            THEN 'Yes' ELSE 'No' 
        END AS "plan_is_downgrade",
        LAG(event_type) OVER (PARTITION BY d.user_id ORDER BY event_date DESC) AS "last_event_type",
        days_as_subscriber
    FROM days_condition d
    JOIN subscription_events s ON d.user_id = s.user_id)

SELECT
    user_id,
    plan_name AS "current_plan",
    current_monthly_amount,
    max_historical_amount,
    days_as_subscriber
FROM churn_conditions
WHERE plan_is_downgrade = 'Yes' AND max_historical_amount * 0.5 > current_monthly_amount
ORDER BY days_as_subscriber DESC, user_id


-- find churn risk customers who show signs before churning: 
 --> signs:
    --> last event = active subscription
    --> at least one event_type = downgrade
    --> current plan revenue < 50% of historical max plan revenue
    --> subscriber for at least 60 days (done)
--> ORDER BY days DESC, user_id ASC
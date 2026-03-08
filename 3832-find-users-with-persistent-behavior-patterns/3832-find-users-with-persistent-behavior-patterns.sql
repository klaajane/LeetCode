-- users who  were active for 5 consecutive days:

WITH activity_streak AS (
    SELECT
        *,
        action_date 
        -
        ROW_NUMBER() OVER (PARTITION BY user_id, action 
                            --- need to partition by action too
                            ORDER BY action_date) * INTERVAL '1 day' AS island_id 
                            -- no need to check, we're already partitioning by user_id, action
    FROM activity)

SELECT
    user_id,
    action,
    streak_length,
    start_date,
    end_date
FROM
    (
    SELECT 
        user_id,
        action,
        COUNT(*) AS "streak_length",
        MIN(action_date) AS "start_date",
        MAX(action_date) AS "end_date",
        DENSE_RANK() OVER (PARTITION BY user_id ORDER BY COUNT(*) DESC) AS "streak_rnk"
    FROM activity_streak
    GROUP BY user_id, island_id, action
    HAVING COUNT(*) >= 5) AS users_streaks
WHERE streak_rnk = 1
ORDER BY streak_length DESC, user_id
----------------------------- NOTES -------------------------------
--> retrieve stable users:
 --> at least a sequence of 5 consecutive days such that user performed:
    --> exactly one action per day
    --> the action is the same across all days
 --> only return the sequence with the highest lenght
 --> order by streak_length DESC, user_id ASC 
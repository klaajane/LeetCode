-------------------------------------------- SOLUTION -------------------------------------------
WITH ranked_activity AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY username
                            ORDER BY startDate DESC) AS rnk
    FROM
        UserActivity
),

users_second_most_recent_activity AS (
    SELECT
        username,
        activity,
        startDate,
        endDate
    FROM
        ranked_activity
    WHERE
        rnk = 2
),

user_with_one_activity AS (
    SELECT * FROM UserActivity
    WHERE (username, startDate, endDate) IN ( SELECT 
                                                username,
                                                MAX(startDate),
                                                MIN(endDate)
                                             FROM
                                                UserActivity
                                             GROUP BY 1)
)

SELECT * FROM users_second_most_recent_activity
    UNION
SELECT * FROM user_with_one_activity
---------------------------------------------- NOTES --------------------------------------------
--> write a solution to show the 2nd most recent activity of each user
--> if user has 1 activity, return it. A user cannot perform more than one activity at the same time
-------------------------------------------------------------------------------------------------
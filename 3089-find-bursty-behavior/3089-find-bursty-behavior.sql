-------------------------------------------- SOLUTION -------------------------------------------
WITH consecutive_posts_count AS (
    SELECT
        *,
        COUNT(post_id) OVER (PARTITION BY user_id
                            ORDER BY post_date
                            RANGE BETWEEN 
                                    INTERVAL '6 days' PRECEDING 
                                    -- 6 days before current rows's date 
                                    AND CURRENT ROW) AS "max_7day_count"
    FROM Posts),

weekly_avg AS (
    SELECT 
        *,
        (COUNT(*) OVER (PARTITION BY user_id))::NUMERIC / 4 AS "avg_weekly_posts"
    FROM consecutive_posts_count
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
)

SELECT DISTINCT
    user_id,
    MAX(max_7day_count) AS "max_7day_posts",
    avg_weekly_posts
FROM weekly_avg
WHERE max_7day_count >= 2*avg_weekly_posts
GROUP BY user_id, avg_weekly_posts
ORDER BY user_id
---------------------------------------------- NOTES --------------------------------------------
--> extract users with bursty behaviors during Feb 24
--> Bursty behavior: 7 consecutive days is at least twice to the avg weekly posting in feb 24
--> Common Year(Feb has 28 days)
--> order by user_id ASC
-------------------------------------------------------------------------------------------------
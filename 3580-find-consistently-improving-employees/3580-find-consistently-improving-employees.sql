-- first let's only show the last three review for each employee;

WITH performance_review_schedule AS (
    SELECT
        employee_id,
        rating,
        review_date,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rating_recency_rnk
    FROM performance_reviews
    )
,

performance_review_schedule_filtered AS (
    SELECT
        employee_id,
        rating AS first_recent_rating,
        LEAD(rating) OVER (
            PARTITION BY employee_id
            ORDER BY rating_recency_rnk ASC
        ) AS second_recent_rating,
        LEAD(rating, 2) OVER (
            PARTITION BY employee_id
            ORDER BY rating_recency_rnk ASC
        ) AS third_recent_rating
    FROM performance_review_schedule
    WHERE rating_recency_rnk <= 3
    )

SELECT
    p.employee_id,
    e.name,
    first_recent_rating - third_recent_rating AS improvement_score
    ---first_recent_rating::TEXT || '<-' || second_recent_rating::TEXT || '<-' || third_recent_rating::TEXT
    --AS score_history
FROM performance_review_schedule_filtered p
JOIN employees e
    ON e.employee_id = p.employee_id
WHERE p.third_recent_rating < p.second_recent_rating
  AND  p.second_recent_rating < p.first_recent_rating
ORDER BY    
    improvement_score DESC,
    name ASC
-- MAX() / aggreggation problem:

-- STEP 1: 
SELECT 
    u1.user_id,
    ROUND(AVG(u1.activity_duration) , 2) AS trial_avg_duration,
    ROUND(AVG(u2.activity_duration) , 2) AS paid_avg_duration
FROM useractivity u1
JOIN useractivity u2
    ON u1.activity_type = 'free_trial'
    AND u2.activity_type = 'paid'
    AND u1.user_id = u2.user_id
    AND u1.activity_date < u2.activity_date
GROUP BY u1.user_id
ORDER BY user_id

--- USE AVG(CASE) INSTEAD BETTER APPROCH !!!!!!
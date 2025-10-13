-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    gender,
    day,
    SUM(score_points) OVER (PARTITION BY gender
                            ORDER BY day
                            ROWS BETWEEN UNBOUNDED PRECEDING
                            AND CURRENT ROW) AS "total"
FROM
    scores
---------------------------------------------- NOTES --------------------------------------------
--> find total score for each gender on each day
--> order by gender, day ASC
-------------------------------------------------------------------------------------------------
-------------------------------------------- SOLUTION -------------------------------------------
WITH total_score_by_student AS (
    SELECT
        student_id,
        student_name,
        SUM(assignment1 + assignment2 + assignment3) AS "total_score"
    FROM
        scores
    GROUP BY 1, 2 
)

SELECT
    MAX(total_score) - MIN(total_score) AS "difference_in_score"
FROM
    total_score_by_student
---------------------------------------------- NOTES --------------------------------------------
--> calculate diff in total score (sum of all 3 assignments) between highest and lowest scores
-------------------------------------------------------------------------------------------------
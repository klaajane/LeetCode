--------------------------------------------- SOLUTION ------------------------------------------
WITH highest_lowest_scores AS (
    SELECT
        exam_id,
        student_id,
        score,
        CASE
            WHEN MAX(score) OVER (PARTITION BY exam_id) = score THEN 1
            WHEN MIN(score) OVER (PARTITION BY exam_id) = score THEN 1
            ELSE 0
        END AS "is_highest_lowest_flag"
    FROM
        exam)

SELECT 
    h.student_id,
    s.student_name
    ---SUM(h.is_highest_lowest_flag)
FROM
    highest_lowest_scores h
INNER JOIN
    student s
    ON s.student_id = h.student_id
GROUP BY
    h.student_id, s.student_name
HAVING 
    SUM(h.is_highest_lowest_flag) = 0
ORDER BY
    h.student_id
---------------------------------------------- NOTES --------------------------------------------
--> quiet student: >= 1 exam, didn't score the highest or the lowest score
--> report: student_id, student_name
--> order by student_id
-------------------------------------------------------------------------------------------------
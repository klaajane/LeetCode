-------------------------------------------------- SOLUTION ---------------------------------------------------
WITH exam_score_comparison AS (SELECT
                                    *,
                                    FIRST_VALUE(score) OVER (PARTITION BY student_id, subject
                                                             ORDER BY exam_date ASC) AS first_score,
                                    LAST_VALUE(score) OVER (PARTITION BY student_id, subject 
                                                            ORDER BY exam_date ASC) AS latest_score,
                                    ROW_NUMBER() OVER (PARTITION BY student_id, subject
                                                     ORDER BY exam_date DESC) as rnk
                                FROM
                                    Scores)
SELECT
    student_id,
    subject,
    first_score,
    latest_score
FROM
    exam_score_comparison
WHERE
    rnk = 1 -- to get only the record showing the improvement as of the most recent exam date
    AND
    latest_score > first_score
GROUP BY
    student_id,
    subject,
    first_score,
    latest_score
ORDER BY
    student_id ASC,
    subject ASC
------------------------------------------------------ NOTES --------------------------------------------------
--> find students who have improved
--> improvement => have taken same subject at least two different dates. latest score > 1st score
--> results: student_id, subject in ascending order
----------------------------------------------------------------------------------------------------------------
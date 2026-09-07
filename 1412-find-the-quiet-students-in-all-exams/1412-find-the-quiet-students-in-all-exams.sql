--> GOAL:
    --> report students who took at least one exam but didn't score the highest or lowest score

--> clarifying questions:
    --> am I correct to assume that retakes are not included in the Exam table?
    --> let's say there's only one student who took an exam,
    --> how should we handle this case? should we return the student regardless?\
    --> are we returning the student who have been a quiet student in their exam?
    --> or has never been a quiet student? for example, if 3 wasthe quiet student
    --> in his exam,

--> Pseudocode:
    -- 1./ find out what the MAX and MIN for each EXAM (MAX()/MIN() OVER ())
    WITH max_min_scores_by_exam AS (
        SELECT
            student_id,
            score,
            MAX(score) OVER w AS max_score,
            MIN(score) OVER w AS min_score
        FROM exam 
        WINDOW w AS (
            PARTITION BY exam_id
        ) 
    )
    ,
    -- 2./ Compare scores to the MAX and MIN (CASE)

    quiet_student_check AS (
        SELECT  
            student_id,
            SUM(CASE
                    WHEN score != max_score AND score != min_score 
                    THEN 0
                    ELSE 1
                END) AS is_quiet
        FROM max_min_scores_by_exam
        GROUP BY student_id
    )

    -- 3./ Return students who didn't score the MAX or MIN:

    SELECT 
        q.student_id,
        s.student_name
    FROM quiet_student_check q
    INNER JOIN student s
        ON s.student_id = q.student_id
    WHERE is_quiet = 0
    ORDER BY q.student_id
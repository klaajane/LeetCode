--------------------------------------------- SOLUTION ------------------------------------------
WITH grade_ranked AS (SELECT
                        student_id,
                        course_id,
                        grade,
                        DENSE_RANK() OVER (PARTITION BY student_id
                                            ORDER BY grade DESC, course_id ASC) AS grade_rnk
                     FROM
                        Enrollments)
SELECT
    student_id,
    course_id,
    grade
FROM
    grade_ranked
WHERE
    grade_rnk = 1 
ORDER BY
    student_id,
    course_id

---------------------------------------------- NOTES --------------------------------------------
--> report highest grad, course for each students (tie => retrieve course with smallest course_id)
--> ORDER BY student_id ASC
-------------------------------------------------------------------------------------------------
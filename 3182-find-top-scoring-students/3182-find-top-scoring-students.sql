--------------------------------------------- SOLUTION ------------------------------------------
SELECT
    s.student_id
FROM students s
WHERE NOT EXISTS (
    SELECT 1 FROM courses c --- I can't find any course where
    WHERE c.major = s.major --- it belongs wot the this student's major
    AND NOT EXISTS (        -- AND the student didn't ace it
        SELECT 1 FROM enrollments e
        WHERE e.student_id = s.student_id -- Look up specific student
        AND e.course_id = c.course_id -- for this specific course
        AND e.grade = 'A' -- did they get an A
    )
)
---------------------------------------------- NOTES --------------------------------------------
--> find students who have taken all courses offered in their major and acheived grade A
--> order by student_od ASC
---------------------------------------------THOUGHTS--------------------------------------------
-- Instead of confirming every course is an A, I flip it — I look for a single failure.
-- If I can't find one, the student is perfect.
--
-- The double NOT EXISTS reads as: "show me students where I cannot find a single course
-- in their major that they didn't ace."
--
-- Inner NOT EXISTS → finds courses they didn't ace
-- Outer NOT EXISTS → ensures no such course exists
--------------------------------------------------------------------------------------------------
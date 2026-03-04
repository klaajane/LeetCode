--------------------------------------------- SOLUTION ------------------------------------------
-- This will get me the students who took all mandatory courses and received A's
WITH mandatory_courses_criteria AS (
    SELECT
        s.student_id
    FROM students s
    --outer part: I don't want to see those students
    WHERE NOT EXISTS(
        SELECT 1 FROM courses c
        WHERE s.major = c.major
          AND c.mandatory = 'Yes' -- MISSED THIS REQUIREMENT, READ QUESTION SLOWLY!!!
          -- inner part: find a mandatory course that this student didn't ace
        AND NOT EXISTS (
            SELECT 1 FROM enrollments e
            WHERE s.student_id = e.student_id
            AND e.course_id = c.course_id
            AND e.grade = 'A' -- YOU MISSED THIS REQUIREMENT, READ QUESTION SLOWLY!!!!!
        )
    ))
,
-- I need to use the 2 other conditions to see if those students took at least 2 electives 
-- and received grade B or better and Average GPA >= 2.5 across ALL courses

elective_courses_criteria AS (
    SELECT
        s.student_id
    FROM students s
    LEFT JOIN enrollments e ON s.student_id = e.student_id
    LEFT JOIN courses c ON c.course_id = e.course_id
    WHERE c.mandatory = 'No' 
        AND e.grade IN ('A', 'B') 
        AND c.major = s.major
    GROUP BY s.student_id
    HAVING COUNT(*) >= 2),

gpa_criteria AS (
    SELECT
        student_id,
        AVG(GPA)
    FROM enrollments
    GROUP BY student_id
    HAVING AVG(GPA) >= 2.5)

SELECT DISTINCT
    md.student_id
FROM mandatory_courses_criteria md
INNER JOIN elective_courses_criteria ec ON ec.student_id = md.student_id
INNER JOIN gpa_criteria gp ON gp.student_id = md.student_id
ORDER BY md.student_id
---------------------------------------------- NOTES --------------------------------------------
--> find students who have taken:
--> all mandatory courses and at least two elective courses offered in their major
--> acheived a grade A in all mandatory courses and at least B in elective courses
--> maintained an average GPA of at least 2.5 across all courses
--> order by student_id ASC
-------------------------------------------------------------------------------------------------
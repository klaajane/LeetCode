-- break down this problem into smaller sections:
-- query the students who meet the 1st condition
WITH first_condition_qualifying_students AS (
    (SELECT
        user_id--,
        ---AVG(course_rating) AS "avg_rating",
        ---COUNT(*) AS "courses_count"
    FROM course_completions
    GROUP BY user_id
    HAVING AVG(course_rating) >= 4 AND COUNT(*) >= 5))
,

all_conditions_qualifying_students AS 
    (SELECT
        q.user_id,
        course_name AS "first_course",
        LEAD(course_name) OVER (PARTITION BY q.user_id ORDER BY completion_date) AS "second_course",
        completion_date,
        LEAD(completion_date) OVER (PARTITION BY q.user_id ORDER BY completion_date) AS "next_completion_date"
    FROM course_completions c1
    JOIN first_condition_qualifying_students q ON q.user_id = c1.user_id)


SELECT
    first_course,
    second_course,
    COUNT(*) AS "transition_count"
FROM all_conditions_qualifying_students
WHERE next_completion_date IS NOT NULL
GROUP BY first_course, second_course
ORDER BY transition_count DESC, LOWER(first_course), LOWER(second_course)
--JOIN course_completions c2 ON c1.user_id = c2.user_id
--WHERE c.user_id IN (SELECT user_id FROM qualifying_students)


--> identify skill mastery pathways
  --> consider only top performing students (at least 5 completed with average rating of 4 or higher)
  --> identify the sequence of courses completed in chronological order
  --> find consecutive courses pairs taken by these students
  --> return pair frequency. identify most common course transitions
--> order by frequency DESC, first course name and second course name ASC
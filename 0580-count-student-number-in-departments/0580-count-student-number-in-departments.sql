-------------------------------------------- SOLUTION -------------------------------------------
SELECT
    d.dept_name,
    COUNT(s.dept_id) AS "student_number"
FROM
    Student s
RIGHT JOIN
    Department d ON d.dept_id = s.dept_id
GROUP BY
    d.dept_name
ORDER BY
    student_number DESC, dept_name ASC
---------------------------------------------- NOTES --------------------------------------------
--> report depart. and # of students (even with 0 students)
--> order by student_number DESC, dept_name DESC (in case of a tie)
-------------------------------------------------------------------------------------------------
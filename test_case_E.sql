-- -------------------------------------------------------
-- Show the average final mark per course for completed
-- enrolments where a mark has been recorded.
-- Displays course title, average mark (1 d.p.), and
-- number of students included.
-- Only courses with at least 3 results are shown.
-- -------------------------------------------------------

SELECT
    c.course_title                                       AS course_title,
    ROUND(AVG(se.student_final_mark), 1)                 AS average_mark,
    COUNT(se.enrolment_id)                               AS students_included
FROM `courses` c
INNER JOIN `course_sessions` cs
    ON c.course_id = cs.course_id
INNER JOIN `session_enrolment` se
    ON cs.session_id = se.session_id
WHERE
    se.status = 'COMPLETED'
    AND se.student_final_mark IS NOT NULL
GROUP BY
    c.course_id,
    c.course_title
HAVING
    COUNT(se.enrolment_id) >= 3
ORDER BY
    average_mark DESC;
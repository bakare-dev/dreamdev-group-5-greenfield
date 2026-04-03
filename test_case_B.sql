-- -------------------------------------------------------
-- For each course session in Term 1 of 2024, show the
-- course title, the teacher's full name, and the total
-- number of enrolled students.
-- Ordered by enrolled count descending.
-- -------------------------------------------------------

SELECT
    c.course_title                                       AS course_title,
    ts.full_name                                         AS teacher_name,
    COUNT(se.enrolment_id)                               AS total_enrolled
FROM `course_sessions` cs
INNER JOIN `courses` c
    ON cs.course_id = c.course_id
INNER JOIN `teaching_staff` ts
    ON cs.staff_id = ts.staff_id
LEFT JOIN `session_enrolment` se
    ON cs.session_id = se.session_id
WHERE
    cs.specific_term = 'TERM1'
    AND cs.specific_year = 2024
GROUP BY
    cs.session_id,
    c.course_title,
    ts.full_name
ORDER BY
    total_enrolled DESC;
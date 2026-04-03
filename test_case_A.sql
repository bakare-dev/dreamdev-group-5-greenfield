-- -------------------------------------------------------
-- List every student's full name, year group, and the
-- number of sessions they are currently actively enrolled
-- in. Students with zero active enrolments are included.
-- -------------------------------------------------------

SELECT
    s.full_name                                          AS student_name,
    yg.year_name                                         AS year_group,
    COUNT(se.enrolment_id)                               AS active_enrolments
FROM `students` s
INNER JOIN `year_group` yg
    ON s.year_group_id = yg.year_group_id
LEFT JOIN `session_enrolment` se
    ON s.student_id = se.student_id
    AND se.status = 'ACTIVE'
GROUP BY
    s.student_id,
    s.full_name,
    yg.year_name
ORDER BY
    yg.year_name,
    s.full_name;
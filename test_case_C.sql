-- -------------------------------------------------------
-- Find all students who have at least one 'absent'
-- attendance record. Show their full name, year group,
-- and total number of absences across all sessions.
-- Ordered by absences descending.
-- -------------------------------------------------------

SELECT
    s.full_name                                          AS student_name,
    yg.year_name                                         AS year_group,
    COUNT(sa.attendance_id)                              AS total_absences
FROM `students` s
INNER JOIN `year_group` yg
    ON s.year_group_id = yg.year_group_id
INNER JOIN `student_attendance` sa
    ON s.student_id = sa.student_id
    AND sa.status = 'ABSENT'
GROUP BY
    s.student_id,
    s.full_name,
    yg.year_name
HAVING
    COUNT(sa.attendance_id) >= 1
ORDER BY
    total_absences DESC;
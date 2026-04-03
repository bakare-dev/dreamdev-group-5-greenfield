SELECT 
    s.full_name,

    yg.name AS year_group,

    COUNT(a.id) AS total_absences

FROM students s

JOIN year_groups yg
    ON s.year_group_id = yg.id

JOIN enrolments e
    ON s.id = e.student_id

JOIN attendance a
    ON e.id = a.enrolment_id

WHERE 
    a.attendance_status = 'ABSENT'

GROUP BY 
    s.id,
    s.full_name,
    yg.name

HAVING 
    COUNT(a.id) >= 1

ORDER BY 
    total_absences DESC;
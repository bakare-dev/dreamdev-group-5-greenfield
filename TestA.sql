SELECT 
    s.full_name,
    yg.name AS year_group,

    COUNT(
        CASE 
            WHEN e.status = 'ACTIVE' 
            THEN e.id
        END
    ) AS active_sessions

FROM students s

LEFT JOIN year_groups yg
    ON s.year_group_id = yg.id

LEFT JOIN enrolments e
    ON s.id = e.student_id

GROUP BY 
    s.id,
    s.full_name,
    yg.name

ORDER BY 
    s.full_name;
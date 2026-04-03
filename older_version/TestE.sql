SELECT 
    c.title AS course_title,

    ROUND(AVG(e.final_mark), 1) AS average_mark,

    COUNT(e.final_mark) AS student_count

FROM courses c

JOIN sessions s
    ON c.id = s.course_id

JOIN enrolments e
    ON s.id = e.session_id

WHERE 
    e.status = 'COMPLETED'
    AND e.final_mark IS NOT NULL

GROUP BY 
    c.id,
    c.title

HAVING 
    COUNT(e.final_mark) >= 3

ORDER BY 
    average_mark DESC;
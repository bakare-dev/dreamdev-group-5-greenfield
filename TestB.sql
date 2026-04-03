SELECT 
    c.title AS course_title,

    st.full_name AS teacher_name,

    COUNT(e.id) AS total_students

FROM sessions se

JOIN courses c
    ON se.course_id = c.id

JOIN teachers t
    ON se.teacher_id = t.id

JOIN staff st
    ON t.id = st.id

JOIN terms tr
    ON se.term_id = tr.id

LEFT JOIN enrolments e
    ON se.id = e.session_id

WHERE 
    tr.term_name = 'Term 1'
    AND tr.year = 2025

GROUP BY 
    se.id,
    c.title,
    st.full_name

ORDER BY 
    total_students DESC;
SELECT 
    c.name AS club_name,

    st.full_name AS teacher_name,

    COUNT(cm.id) AS member_count

FROM clubs c

JOIN teachers t
    ON c.teacher_id = t.id

JOIN staff st
    ON t.id = st.id

LEFT JOIN club_memberships cm
    ON c.id = cm.club_id

GROUP BY 
    c.id,
    c.name,
    st.full_name

ORDER BY 
    c.name;
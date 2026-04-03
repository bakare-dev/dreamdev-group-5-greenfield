-- -------------------------------------------------------
-- List every club, the lead teacher's full name, and
-- the number of current student members.
-- Clubs with no members are included.
-- -------------------------------------------------------

SELECT
    ec.club_name                                         AS club_name,
    ts.full_name                                         AS lead_teacher,
    COUNT(sjec.membership_id)                            AS total_members
FROM `extracurricular_club` ec
INNER JOIN `teaching_staff` ts
    ON ec.lead_staff_id = ts.staff_id
LEFT JOIN `student_joined_extracurricular_club` sjec
    ON ec.club_id = sjec.club_id
GROUP BY
    ec.club_id,
    ec.club_name,
    ts.full_name
ORDER BY
    total_members DESC,
    ec.club_name;
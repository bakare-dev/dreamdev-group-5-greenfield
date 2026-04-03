USE greenfield_academy;

-- -----------------------------------------------------
-- Clear existing data (order matters due to FK constraints)
-- -----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `student_joined_extracurricular_club`;
TRUNCATE TABLE `extracurricular_club`;
TRUNCATE TABLE `student_attendance`;
TRUNCATE TABLE `session_enrolment`;
TRUNCATE TABLE `course_sessions`;
TRUNCATE TABLE `courses`;
TRUNCATE TABLE `students`;
TRUNCATE TABLE `teaching_staff`;
TRUNCATE TABLE `specialisation`;
TRUNCATE TABLE `year_group`;
SET FOREIGN_KEY_CHECKS = 1;


-- -----------------------------------------------------
-- year_group
-- -----------------------------------------------------
INSERT INTO `year_group` (`year_name`) VALUES
  ('YEAR7'),
  ('YEAR8'),
  ('YEAR9'),
  ('YEAR10'),
  ('YEAR11');


-- -----------------------------------------------------
-- specialisation
-- -----------------------------------------------------
INSERT INTO `specialisation` (`subject_area`) VALUES
  ('Mathematics'),
  ('English Literature'),
  ('Computer Science'),
  ('Biology'),
  ('Physical Education');


-- -----------------------------------------------------
-- teaching_staff
-- -----------------------------------------------------
INSERT INTO `teaching_staff` (`staff_id_number`, `full_name`, `employment_type`, `contact_phone_number`, `email`, `specialisation_id`) VALUES
  ('ST001', 'Mr. James Okafor',    'PERMANENT', '07700100001', 'j.okafor@greenfield.ac.uk',   1),
  ('ST002', 'Ms. Priya Sharma',    'PERMANENT', '07700100002', 'p.sharma@greenfield.ac.uk',   2),
  ('ST003', 'Mr. Daniel Webb',     'CONTRACT',  '07700100003', 'd.webb@greenfield.ac.uk',     3),
  ('ST004', 'Dr. Amara Nwosu',     'PERMANENT', '07700100004', 'a.nwosu@greenfield.ac.uk',    4),
  ('ST005', 'Ms. Rachel Griffith', 'CONTRACT',  '07700100005', 'r.griffith@greenfield.ac.uk', 5);


-- -----------------------------------------------------
-- students (expanded to 15)
-- -----------------------------------------------------
INSERT INTO `students` (`unique_student_number`, `full_name`, `date_of_birth`, `gender`, `parent_email_address`, `year_group_id`) VALUES
  ('SN1001', 'Ethan Clarke',     '2011-03-14', 'MALE',   'parent.clarke@email.com',     1),
  ('SN1002', 'Sofia Mensah',     '2011-07-22', 'FEMALE', 'parent.mensah@email.com',     1),
  ('SN1003', 'Liam Patel',       '2010-11-05', 'MALE',   'parent.patel@email.com',      2),
  ('SN1004', 'Amelia Johnson',   '2010-01-30', 'FEMALE', 'parent.johnson@email.com',    2),
  ('SN1005', 'Noah Osei',        '2009-06-18', 'MALE',   'parent.osei@email.com',       3),
  ('SN1006', 'Isla Fernandez',   '2009-09-09', 'FEMALE', 'parent.fernandez@email.com',  3),
  ('SN1007', 'Marcus Thompson',  '2008-04-25', 'MALE',   'parent.thompson@email.com',   4),
  ('SN1008', 'Zara Ahmed',       '2007-12-01', 'FEMALE', 'parent.ahmed@email.com',      5),
  ('SN1009', 'Chloe Andersen',   '2011-05-19', 'FEMALE', 'parent.andersen@email.com',   1),
  ('SN1010', 'Kai Nakamura',     '2010-08-03', 'MALE',   'parent.nakamura@email.com',   2),
  ('SN1011', 'Grace Owusu',      '2009-02-11', 'FEMALE', 'parent.owusu@email.com',      3),
  ('SN1012', 'Tyler Brooks',     '2008-11-27', 'MALE',   'parent.brooks@email.com',     4),
  ('SN1013', 'Fatima Al-Hassan', '2007-07-14', 'FEMALE', 'parent.alhassan@email.com',   5),
  ('SN1014', 'Oliver Grant',     '2011-10-30', 'MALE',   'parent.grant@email.com',      1),
  ('SN1015', 'Maya Singh',       '2008-03-22', 'FEMALE', 'parent.singh@email.com',      4);


-- -----------------------------------------------------
-- courses
-- -----------------------------------------------------
INSERT INTO `courses` (`course_title`, `course_code`, `course_description`, `class_size`, `specialisation_id`) VALUES
  ('Foundation Mathematics',  'MATH101', 'Core numeracy, algebra and geometry for Key Stage 3.',        30, 1),
  ('English Literature GCSE', 'ENGL201', 'Analysis of prose, poetry and drama for GCSE examination.',  28, 2),
  ('Introduction to Python',  'COMP101', 'Fundamentals of programming using Python.',                   25, 3),
  ('Human Biology',           'BIOL201', 'Study of body systems, cells and genetics.',                  28, 4),
  ('GCSE Physical Education', 'PE201',   'Theory and practical components of GCSE PE.',                 30, 5);


-- -----------------------------------------------------
-- course_sessions
-- 2 sessions per course: one TERM1, one TERM2 (10 total)
-- -----------------------------------------------------
INSERT INTO `course_sessions` (`course_id`, `staff_id`, `specific_term`, `specific_year`, `location`) VALUES
  (1, 1, 'TERM1', 2024, 'Room 12'),        -- session 1:  Foundation Mathematics TERM1
  (1, 1, 'TERM2', 2024, 'Room 12'),        -- session 2:  Foundation Mathematics TERM2
  (2, 2, 'TERM1', 2024, 'Room 7'),         -- session 3:  English Literature TERM1
  (2, 2, 'TERM2', 2024, 'Room 7'),         -- session 4:  English Literature TERM2
  (3, 3, 'TERM1', 2024, 'IT Lab 2'),       -- session 5:  Introduction to Python TERM1
  (3, 3, 'TERM2', 2024, 'IT Lab 2'),       -- session 6:  Introduction to Python TERM2
  (4, 4, 'TERM1', 2024, 'Science Lab 1'),  -- session 7:  Human Biology TERM1
  (4, 4, 'TERM2', 2024, 'Science Lab 1'),  -- session 8:  Human Biology TERM2
  (5, 5, 'TERM1', 2024, 'Sports Hall'),    -- session 9:  GCSE Physical Education TERM1
  (5, 5, 'TERM2', 2024, 'Sports Hall');    -- session 10: GCSE Physical Education TERM2


-- -----------------------------------------------------
-- session_enrolment
-- Every course has at least 3 COMPLETED records with marks
-- across its sessions to satisfy the average mark query.
-- Mix of ACTIVE and WITHDRAWN for other query test cases.
-- -----------------------------------------------------
INSERT INTO `session_enrolment` (`session_id`, `student_id`, `date_enrolled`, `status`, `student_final_mark`, `letter_grade`) VALUES

  -- Session 1: Foundation Mathematics TERM1
  (1, 1,  '2024-09-02', 'ACTIVE',    NULL,  NULL),
  (1, 2,  '2024-09-02', 'ACTIVE',    NULL,  NULL),
  (1, 3,  '2024-09-02', 'COMPLETED', 87.50, 'A'),
  (1, 4,  '2024-09-02', 'COMPLETED', 74.00, 'B'),
  (1, 9,  '2024-09-02', 'COMPLETED', 61.00, 'C'),
  (1, 14, '2024-09-02', 'WITHDRAWN', NULL,  NULL),

  -- Session 2: Foundation Mathematics TERM2
  (2, 5,  '2024-01-08', 'COMPLETED', 92.00, 'A'),
  (2, 10, '2024-01-08', 'COMPLETED', 55.50, 'D'),
  (2, 11, '2024-01-08', 'COMPLETED', 78.00, 'B'),
  (2, 6,  '2024-01-08', 'ACTIVE',    NULL,  NULL),
  (2, 7,  '2024-01-08', 'WITHDRAWN', NULL,  NULL),

  -- Session 3: English Literature GCSE TERM1
  (3, 2,  '2024-09-02', 'ACTIVE',    NULL,  NULL),
  (3, 5,  '2024-09-02', 'COMPLETED', 72.00, 'B'),
  (3, 6,  '2024-09-02', 'COMPLETED', 58.00, 'C'),
  (3, 7,  '2024-09-02', 'COMPLETED', 83.50, 'A'),
  (3, 12, '2024-09-02', 'WITHDRAWN', NULL,  NULL),

  -- Session 4: English Literature GCSE TERM2
  (4, 8,  '2024-01-08', 'COMPLETED', 67.00, 'C'),
  (4, 13, '2024-01-08', 'COMPLETED', 79.50, 'B'),
  (4, 15, '2024-01-08', 'COMPLETED', 91.00, 'A'),
  (4, 1,  '2024-01-08', 'ACTIVE',    NULL,  NULL),
  (4, 4,  '2024-01-08', 'WITHDRAWN', NULL,  NULL),

  -- Session 5: Introduction to Python TERM1
  (5, 1,  '2024-09-03', 'ACTIVE',    NULL,  NULL),
  (5, 3,  '2024-09-03', 'ACTIVE',    NULL,  NULL),
  (5, 5,  '2024-09-03', 'COMPLETED', 91.00, 'A'),
  (5, 8,  '2024-09-03', 'COMPLETED', 65.50, 'C'),
  (5, 10, '2024-09-03', 'COMPLETED', 73.00, 'B'),
  (5, 14, '2024-09-03', 'WITHDRAWN', NULL,  NULL),

  -- Session 6: Introduction to Python TERM2
  (6, 11, '2024-01-08', 'COMPLETED', 88.00, 'A'),
  (6, 12, '2024-01-08', 'COMPLETED', 52.00, 'E'),
  (6, 13, '2024-01-08', 'COMPLETED', 76.50, 'B'),
  (6, 15, '2024-01-08', 'ACTIVE',    NULL,  NULL),
  (6, 2,  '2024-01-08', 'WITHDRAWN', NULL,  NULL),

  -- Session 7: Human Biology TERM1
  (7, 4,  '2024-09-02', 'ACTIVE',    NULL,  NULL),
  (7, 6,  '2024-09-02', 'COMPLETED', 69.00, 'C'),
  (7, 7,  '2024-09-02', 'COMPLETED', 78.00, 'B'),
  (7, 9,  '2024-09-02', 'COMPLETED', 84.50, 'A'),
  (7, 13, '2024-09-02', 'WITHDRAWN', NULL,  NULL),

  -- Session 8: Human Biology TERM2
  (8, 8,  '2024-01-08', 'COMPLETED', 55.00, 'D'),
  (8, 10, '2024-01-08', 'COMPLETED', 71.00, 'B'),
  (8, 11, '2024-01-08', 'COMPLETED', 63.50, 'C'),
  (8, 12, '2024-01-08', 'ACTIVE',    NULL,  NULL),
  (8, 3,  '2024-01-08', 'WITHDRAWN', NULL,  NULL),

  -- Session 9: GCSE Physical Education TERM1
  (9, 1,  '2024-09-02', 'ACTIVE',    NULL,  NULL),
  (9, 2,  '2024-09-02', 'ACTIVE',    NULL,  NULL),
  (9, 5,  '2024-09-02', 'COMPLETED', 80.00, 'A'),
  (9, 14, '2024-09-02', 'COMPLETED', 66.00, 'C'),
  (9, 15, '2024-09-02', 'COMPLETED', 74.50, 'B'),
  (9, 8,  '2024-09-02', 'WITHDRAWN', NULL,  NULL),

  -- Session 10: GCSE Physical Education TERM2
  (10, 3,  '2024-01-08', 'COMPLETED', 59.00, 'D'),
  (10, 6,  '2024-01-08', 'COMPLETED', 88.50, 'A'),
  (10, 7,  '2024-01-08', 'COMPLETED', 77.00, 'B'),
  (10, 9,  '2024-01-08', 'ACTIVE',    NULL,  NULL),
  (10, 13, '2024-01-08', 'WITHDRAWN', NULL,  NULL);


-- -----------------------------------------------------
-- student_attendance
-- One record per student per session.
-- Spread of PRESENT, ABSENT, LATE across all sessions.
-- Several students have absences across multiple sessions
-- to make the absences query meaningful.
-- -----------------------------------------------------
INSERT INTO `student_attendance` (`session_id`, `student_id`, `status`, `date_of_class`) VALUES

  -- Session 1: Foundation Mathematics TERM1 — 2024-09-09
  (1, 1,  'PRESENT', '2024-09-09'),
  (1, 2,  'LATE',    '2024-09-09'),
  (1, 3,  'ABSENT',  '2024-09-09'),
  (1, 4,  'PRESENT', '2024-09-09'),
  (1, 9,  'PRESENT', '2024-09-09'),
  (1, 14, 'ABSENT',  '2024-09-09'),

  -- Session 2: Foundation Mathematics TERM2 — 2024-01-13
  (2, 5,  'PRESENT', '2024-01-13'),
  (2, 10, 'ABSENT',  '2024-01-13'),
  (2, 11, 'PRESENT', '2024-01-13'),
  (2, 6,  'LATE',    '2024-01-13'),
  (2, 7,  'ABSENT',  '2024-01-13'),

  -- Session 3: English Literature GCSE TERM1 — 2024-09-10
  (3, 2,  'PRESENT', '2024-09-10'),
  (3, 5,  'PRESENT', '2024-09-10'),
  (3, 6,  'LATE',    '2024-09-10'),
  (3, 7,  'ABSENT',  '2024-09-10'),
  (3, 12, 'PRESENT', '2024-09-10'),

  -- Session 4: English Literature GCSE TERM2 — 2024-01-14
  (4, 8,  'PRESENT', '2024-01-14'),
  (4, 13, 'ABSENT',  '2024-01-14'),
  (4, 15, 'PRESENT', '2024-01-14'),
  (4, 1,  'LATE',    '2024-01-14'),
  (4, 4,  'ABSENT',  '2024-01-14'),

  -- Session 5: Introduction to Python TERM1 — 2024-09-11
  (5, 1,  'PRESENT', '2024-09-11'),
  (5, 3,  'PRESENT', '2024-09-11'),
  (5, 5,  'PRESENT', '2024-09-11'),
  (5, 8,  'LATE',    '2024-09-11'),
  (5, 10, 'ABSENT',  '2024-09-11'),
  (5, 14, 'PRESENT', '2024-09-11'),

  -- Session 6: Introduction to Python TERM2 — 2024-01-15
  (6, 11, 'PRESENT', '2024-01-15'),
  (6, 12, 'ABSENT',  '2024-01-15'),
  (6, 13, 'LATE',    '2024-01-15'),
  (6, 15, 'PRESENT', '2024-01-15'),
  (6, 2,  'ABSENT',  '2024-01-15'),

  -- Session 7: Human Biology TERM1 — 2024-09-12
  (7, 4,  'LATE',    '2024-09-12'),
  (7, 6,  'ABSENT',  '2024-09-12'),
  (7, 7,  'PRESENT', '2024-09-12'),
  (7, 9,  'PRESENT', '2024-09-12'),
  (7, 13, 'ABSENT',  '2024-09-12'),

  -- Session 8: Human Biology TERM2 — 2024-01-16
  (8, 8,  'LATE',    '2024-01-16'),
  (8, 10, 'ABSENT',  '2024-01-16'),
  (8, 11, 'PRESENT', '2024-01-16'),
  (8, 12, 'ABSENT',  '2024-01-16'),
  (8, 3,  'PRESENT', '2024-01-16'),

  -- Session 9: GCSE Physical Education TERM1 — 2024-09-13
  (9, 1,  'PRESENT', '2024-09-13'),
  (9, 2,  'PRESENT', '2024-09-13'),
  (9, 5,  'ABSENT',  '2024-09-13'),
  (9, 14, 'LATE',    '2024-09-13'),
  (9, 15, 'PRESENT', '2024-09-13'),
  (9, 8,  'ABSENT',  '2024-09-13'),

  -- Session 10: GCSE Physical Education TERM2 — 2024-01-17
  (10, 3,  'PRESENT', '2024-01-17'),
  (10, 6,  'PRESENT', '2024-01-17'),
  (10, 7,  'LATE',    '2024-01-17'),
  (10, 9,  'ABSENT',  '2024-01-17'),
  (10, 13, 'PRESENT', '2024-01-17');


-- -----------------------------------------------------
-- extracurricular_club
-- -----------------------------------------------------
INSERT INTO `extracurricular_club` (`club_name`, `club_description`, `day_of_the_week`, `lead_staff_id`) VALUES
  ('Coding Club',    'Weekly sessions exploring web development, games and problem solving.', 'WEDNESDAY', 3),
  ('Debate Society', 'Public speaking, argumentation and critical thinking practice.',        'THURSDAY',  2),
  ('Science Squad',  'Hands-on experiments and science fair preparation.',                   'TUESDAY',   4);


-- -----------------------------------------------------
-- student_joined_extracurricular_club
-- -----------------------------------------------------
INSERT INTO `student_joined_extracurricular_club` (`student_id`, `club_id`, `term_join`, `year_join`) VALUES
  -- Coding Club (club 1)
  (1,  1, 'TERM1', 2024),
  (3,  1, 'TERM1', 2024),
  (5,  1, 'TERM1', 2024),
  (8,  1, 'TERM2', 2024),
  (10, 1, 'TERM2', 2024),

  -- Debate Society (club 2)
  (2,  2, 'TERM1', 2024),
  (4,  2, 'TERM1', 2024),
  (6,  2, 'TERM1', 2024),
  (7,  2, 'TERM2', 2024),
  (11, 2, 'TERM2', 2024),
  (15, 2, 'TERM2', 2024),

  -- Science Squad (club 3)
  (1,  3, 'TERM2', 2024),
  (4,  3, 'TERM1', 2024),
  (6,  3, 'TERM2', 2024),
  (8,  3, 'TERM2', 2024),
  (12, 3, 'TERM1', 2024),
  (13, 3, 'TERM1', 2024);
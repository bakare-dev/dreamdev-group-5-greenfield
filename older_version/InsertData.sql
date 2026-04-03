INSERT INTO year_groups (name) VALUES
('Year 7'),
('Year 8'),
('Year 9'),
('Year 10'),
('Year 11');

INSERT INTO staff 
(staff_number, full_name, phone, email)
VALUES
('STF001', 'Mr Okafor', '08030000001', 'okafor@school.com'),
('STF002', 'Mrs Bello', '08030000002', 'bello@school.com'),
('STF003', 'Mr Adeyemi', '08030000003', 'adeyemi@school.com'),
('STF004', 'Ms Yusuf', '08030000004', 'yusuf@school.com'),
('STF005', 'Mr Lawal', '08030000005', 'lawal@school.com');

INSERT INTO teachers (id, specialisation) VALUES
(1, 'Mathematics'),
(2, 'English Language'),
(3, 'Biology'),
(4, 'Economics'),
(5, 'Physics');

INSERT INTO courses 
(title, code, description, max_class_size)
VALUES
('Mathematics', 'MATH-101', 'Core mathematics fundamentals', 30),
('English Language', 'ENG-201', 'Grammar and comprehension', 25),
('Biology', 'BIO-301', 'Introduction to biology', 20);

INSERT INTO terms 
(term_name, year)
VALUES
('Term 1', 2025),
('Term 2', 2025),
('Term 3', 2025);

INSERT INTO students (
student_number,
full_name,
date_of_birth,
gender,
parent_email,
year_group_id
) VALUES

('STD001','John Musa','2012-05-10','MALE','p1@mail.com',1),
('STD002','Amina Bello','2011-08-21','FEMALE','p2@mail.com',2),
('STD003','David Okeke','2010-02-14','MALE','p3@mail.com',3),
('STD004','Grace Ade','2011-11-30','FEMALE','p4@mail.com',2),
('STD005','Samuel Yusuf','2010-07-19','MALE','p5@mail.com',3),
('STD006','Mary Ibrahim','2012-01-09','FEMALE','p6@mail.com',1),
('STD007','Peter Obi','2011-04-25','MALE','p7@mail.com',2),
('STD008','Fatima Lawal','2010-06-13','FEMALE','p8@mail.com',3);

INSERT INTO sessions (
course_id,
term_id,
teacher_id
) VALUES

(1,1,1), 
(2,1,2),
(3,1,3),
(1,2,1),
(2,2,2);


INSERT INTO enrolments (
student_id,
session_id,
enrolment_date,
status,
final_mark,
letter_grade
) VALUES

(1,1,'2025-01-10','COMPLETED',85,'A'),
(2,1,'2025-01-10','COMPLETED',78,'B'),
(3,1,'2025-01-10','COMPLETED',92,'A'),

(4,2,'2025-01-11','COMPLETED',75,'B'),
(5,2,'2025-01-11','COMPLETED',81,'A'),
(6,2,'2025-01-11','COMPLETED',69,'C'),

(7,3,'2025-01-12','COMPLETED',88,'A'),
(8,3,'2025-01-12','COMPLETED',73,'B'),
(1,3,'2025-01-12','COMPLETED',65,'C'),

(2,4,'2025-02-01','ACTIVE',NULL,NULL),
(3,5,'2025-02-01','ACTIVE',NULL,NULL);

INSERT INTO attendance (
enrolment_id,
class_date,
attendance_status
) VALUES

(1,'2025-01-15','PRESENT'),
(1,'2025-01-16','LATE'),

(2,'2025-01-15','ABSENT'),
(2,'2025-01-16','PRESENT'),

(3,'2025-01-15','PRESENT'),

(4,'2025-01-15','ABSENT'),

(5,'2025-01-15','PRESENT'),

(6,'2025-01-15','ABSENT'),

(7,'2025-01-15','PRESENT'),

(8,'2025-01-15','ABSENT'),

(9,'2025-01-15','PRESENT');

INSERT INTO clubs (
name,
description,
meeting_day,
teacher_id
) VALUES

('Science Club','Experiments and research','Wednesday',3),
('Math Club','Math competitions','Friday',1);

INSERT INTO club_memberships (
student_id,
club_id,
joined_term_id
) VALUES

(1,1,1),
(2,1,1),
(3,2,1),
(4,2,2),
(5,1,1),
(6,2,1);
CREATE DATABASE greenfield_academy;

USE greenfield_academy;


CREATE TABLE `year_group` (
  `year_group_id` int PRIMARY KEY AUTO_INCREMENT,
  `year_name` enum('YEAR1','YEAR2','YEAR3','YEAR4','YEAR5','YEAR6','YEAR7','YEAR8','YEAR9','YEAR10','YEAR11') UNIQUE NOT NULL
);

CREATE TABLE `specialisation` (
  `specialisation_id` int PRIMARY KEY AUTO_INCREMENT,
  `subject_area` varchar(100) NOT NULL
);

CREATE TABLE `teaching_staff` (
  `staff_id` int PRIMARY KEY AUTO_INCREMENT,
  `staff_id_number` varchar(20) UNIQUE NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `employment_type` enum('PERMANENT','CONTRACT') NOT NULL,
  `contact_phone_number` varchar(20),
  `email` varchar(100) UNIQUE NOT NULL,
  `specialisation_id` int UNIQUE NOT NULL
);

CREATE TABLE `students` (
  `student_id` int PRIMARY KEY AUTO_INCREMENT,
  `unique_student_number` varchar(20) UNIQUE NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `parent_email_address` varchar(100) NOT NULL,
  `year_group_id` int NOT NULL
);

CREATE TABLE `courses` (
  `course_id` int PRIMARY KEY AUTO_INCREMENT,
  `course_title` varchar(100) NOT NULL,
  `course_code` varchar(20) UNIQUE NOT NULL,
  `course_description` text,
  `class_size` int NOT NULL,
  `specialisation_id` int NOT NULL
);

CREATE TABLE `course_sessions` (
  `session_id` int PRIMARY KEY AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `staff_id` int NOT NULL,
  `specific_term` varchar(20) NOT NULL,
  `specific_year` int NOT NULL,
  `location` varchar(100)
);

CREATE TABLE `session_enrolment` (
  `enrolment_id` int PRIMARY KEY AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `student_id` int NOT NULL,
  `date_enrolled` date NOT NULL,
  `status` enum('ACTIVE','WITHDRAWN','COMPLETED') NOT NULL,
  `student_final_mark` decimal(5,2) DEFAULT NULL,
  `letter_grade` enum('A','B','C','D','E') DEFAULT NULL
);

CREATE TABLE `student_attendance` (
  `attendance_id` int PRIMARY KEY AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `student_id` int NOT NULL,
  `status` enum('PRESENT','ABSENT','LATE') NOT NULL,
  `date_of_class` date NOT NULL
);

CREATE TABLE `extracurricular_club` (
  `club_id` int PRIMARY KEY AUTO_INCREMENT,
  `club_name` varchar(100) NOT NULL,
  `club_description` text,
  `day_of_the_week` varchar(10) NOT NULL,
  `lead_staff_id` int NOT NULL
);

CREATE TABLE `student_joined_extracurricular_club` (
  `membership_id` int PRIMARY KEY AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `club_id` int NOT NULL,
  `term_join` varchar(20) NOT NULL,
  `year_join` int NOT NULL
);


-- Unique constraints

CREATE UNIQUE INDEX `session_enrolment_index_0` ON `session_enrolment` (`student_id`, `session_id`);

CREATE UNIQUE INDEX `student_attendance_index_1` ON `student_attendance` (`session_id`, `student_id`);

CREATE UNIQUE INDEX `club_membership_index_2` ON `student_joined_extracurricular_club` (`student_id`, `club_id`);


-- Foreign keys

ALTER TABLE `students` ADD FOREIGN KEY (`year_group_id`) REFERENCES `year_group` (`year_group_id`);

ALTER TABLE `teaching_staff` ADD FOREIGN KEY (`specialisation_id`) REFERENCES `specialisation` (`specialisation_id`);

ALTER TABLE `courses` ADD FOREIGN KEY (`specialisation_id`) REFERENCES `specialisation` (`specialisation_id`);

ALTER TABLE `course_sessions` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `course_sessions` ADD FOREIGN KEY (`staff_id`) REFERENCES `teaching_staff` (`staff_id`);

ALTER TABLE `session_enrolment` ADD FOREIGN KEY (`session_id`) REFERENCES `course_sessions` (`session_id`);

ALTER TABLE `session_enrolment` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

ALTER TABLE `student_attendance` ADD FOREIGN KEY (`session_id`) REFERENCES `course_sessions` (`session_id`);

ALTER TABLE `student_attendance` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

ALTER TABLE `extracurricular_club` ADD FOREIGN KEY (`lead_staff_id`) REFERENCES `teaching_staff` (`staff_id`);

ALTER TABLE `student_joined_extracurricular_club` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

ALTER TABLE `student_joined_extracurricular_club` ADD FOREIGN KEY (`club_id`) REFERENCES `extracurricular_club` (`club_id`);
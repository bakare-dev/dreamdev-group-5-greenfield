CREATE DATABASE greenfield_academy


CREATE TABLE `year_groups` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(20) UNIQUE NOT NULL
);

CREATE TABLE `staff` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `staff_number` varchar(20) UNIQUE NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20),
  `email` varchar(100) UNIQUE NOT NULL
);

CREATE TABLE `teachers` (
  `id` int PRIMARY KEY,
  `specialisation` varchar(100) NOT NULL
);

CREATE TABLE `courses` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(20) UNIQUE NOT NULL,
  `description` text,
  `max_class_size` int NOT NULL
);

CREATE TABLE `terms` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `term_name` varchar(10) NOT NULL,
  `year` int NOT NULL
);

CREATE TABLE `students` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `student_number` varchar(20) UNIQUE NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `parent_email` varchar(100) NOT NULL,
  `year_group_id` int NOT NULL
);

CREATE TABLE `sessions` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `term_id` int NOT NULL,
  `teacher_id` int NOT NULL
);

CREATE TABLE `enrolments` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `session_id` int NOT NULL,
  `enrolment_date` date NOT NULL,
  `status` enum('ACTIVE','WITHDRAWN','COMPLETED') NOT NULL,
  `final_mark` int,
  `letter_grade` char(2)
);

CREATE TABLE `attendance` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `enrolment_id` int NOT NULL,
  `class_date` date NOT NULL,
  `attendance_status` enum('PRESENT','ABSENT','LATE') NOT NULL
);

CREATE TABLE `clubs` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `meeting_day` varchar(10) NOT NULL,
  `teacher_id` int NOT NULL
);

CREATE TABLE `club_memberships` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `club_id` int NOT NULL,
  `joined_term_id` int NOT NULL
);

CREATE UNIQUE INDEX `enrolments_index_0` ON `enrolments` (`student_id`, `session_id`);

CREATE UNIQUE INDEX `attendance_index_1` ON `attendance` (`enrolment_id`, `class_date`);

CREATE UNIQUE INDEX `club_memberships_index_2` ON `club_memberships` (`student_id`, `club_id`);

ALTER TABLE `students` ADD FOREIGN KEY (`year_group_id`) REFERENCES `year_groups` (`id`);

ALTER TABLE `teachers` ADD FOREIGN KEY (`id`) REFERENCES `staff` (`id`);

ALTER TABLE `sessions` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

ALTER TABLE `sessions` ADD FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`);

ALTER TABLE `sessions` ADD FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

ALTER TABLE `enrolments` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

ALTER TABLE `enrolments` ADD FOREIGN KEY (`session_id`) REFERENCES `sessions` (`id`);

ALTER TABLE `attendance` ADD FOREIGN KEY (`enrolment_id`) REFERENCES `enrolments` (`id`);

ALTER TABLE `clubs` ADD FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`);

ALTER TABLE `club_memberships` ADD FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

ALTER TABLE `club_memberships` ADD FOREIGN KEY (`club_id`) REFERENCES `clubs` (`id`);

ALTER TABLE `club_memberships` ADD FOREIGN KEY (`joined_term_id`) REFERENCES `terms` (`id`);


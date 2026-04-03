# Greenfield Academy — School Management System
### Database Design: Resolution Process

---

## Table of Contents

1. [Overview](#overview)
2. [Resolution Process](#resolution-process)
   - [Phase 1 — Entity Identification](#phase-1--entity-identification)
   - [Phase 2 — Relationship Mapping](#phase-2--relationship-mapping)
   - [Phase 3 — Field Definition](#phase-3--field-definition)
3. [Key Design Problems Identified and Resolved](#key-design-problems-identified-and-resolved)
4. [Iterative Refactoring](#iterative-refactoring)
5. [Final Schema Summary](#final-schema-summary)
6. [Deliverable Files](#deliverable-files)

---

## Overview

This document describes the end-to-end resolution process used to design the relational database schema for the **Greenfield Academy School Management System**. It covers how entities were identified, how relationships were mapped, how fields were defined, and the key design problems that were discovered and resolved through iterative refinement.

The final schema is implemented in **MySQL** (`greenfield_academy`) and supports:

- Student registration and year group assignment
- Course and session management
- Teacher and specialisation tracking
- Student enrolment and grading
- Attendance tracking per session
- Extracurricular club membership

---

## Resolution Process

The design followed a structured **three-phase approach**, with ongoing refactoring applied at each stage as new constraints and edge cases were discovered.

---

### Phase 1 — Entity Identification

The first step was to read the problem statement carefully and identify all real-world objects the system needed to track. The following entities were recognised:

| # | Entity |
|---|--------|
| 1 | Students |
| 2 | Year Group |
| 3 | Teaching Staff |
| 4 | Specialisation |
| 5 | Courses |
| 6 | Course Sessions |
| 7 | Session Enrolment |
| 8 | Student Attendance |
| 9 | Extracurricular Club |
| 10 | Student Joined Extracurricular Club |

> Entities were identified first — **without fields** — to validate the structural logic before adding implementation detail.

---

### Phase 2 — Relationship Mapping

Once the entities were confirmed, the relationships between them were mapped out before any fields were defined.

| Relationship | Cardinality | Notes |
|---|---|---|
| Student → Year Group | Many-to-One | Many students belong to one year group. FK on `students`. |
| Teacher → Specialisation | One-to-One | Each teacher has exactly one specialisation. Enforced with `UNIQUE` constraint. |
| Teacher → Course Session | One-to-Many | One teacher can lead many sessions. |
| Student → Course Session | One-to-Many | Handled via `session_enrolment` junction table. |
| Teacher → Club | One-to-Many | One teacher leads many clubs. |
| Student ↔ Club | Many-to-Many | Handled via `student_joined_extracurricular_club` junction table. |
| Attendance → Student + Session | One-to-One pair | One attendance record per student per session. Enforced with `UNIQUE(session_id, student_id)`. |

---

### Phase 3 — Field Definition

With the entity structure and relationships confirmed, fields were defined for each entity. Enumerations were used wherever a field had a fixed, known set of values to enforce data integrity at the database level.

| Entity | Fields |
|---|---|
| `students` | `unique_student_number` (UK), `full_name`, `date_of_birth`, `gender` *(enum: MALE/FEMALE)*, `parent_email_address`, `year_group_id` (FK) |
| `year_group` | `year_name` *(enum: YEAR1–YEAR11)* |
| `teaching_staff` | `staff_id_number` (UK), `full_name`, `employment_type` *(enum: PERMANENT/CONTRACT)*, `contact_phone_number`, `email` (UK), `specialisation_id` (FK, UNIQUE) |
| `specialisation` | `subject_area` |
| `courses` | `course_title`, `course_code` (UK), `course_description`, `class_size`, `specialisation_id` (FK) |
| `course_sessions` | `course_id` (FK), `staff_id` (FK), `specific_term`, `specific_year`, `location` |
| `session_enrolment` | `session_id` (FK), `student_id` (FK), `date_enrolled`, `status` *(enum: ACTIVE/WITHDRAWN/COMPLETED)*, `student_final_mark` *(nullable)*, `letter_grade` *(enum: A–E)* |
| `student_attendance` | `session_id` (FK), `student_id` (FK), `status` *(enum: PRESENT/ABSENT/LATE)*, `date_of_class` |
| `extracurricular_club` | `club_name`, `club_description`, `day_of_the_week`, `lead_staff_id` (FK) |
| `student_joined_extracurricular_club` | `student_id` (FK), `club_id` (FK), `term_join`, `year_join` |

---

## Key Design Problems Identified

---

### Problem 1 — Student Enrolment Granularity

#### Problem
The initial design attached student enrolments directly to **Course Sessions**. This meant that if a course ran 15 sessions in a term, a student would need to enrol 15 separate times — once per session. This IS impractical.

#### Resolution
We suggest a student should enrol to a course instead. This implies there would be a course enrolment table. With this a student just have to enrol once for a course per term. As opposed to enrolling for 20 sessions under 1 course per term. And case is likely that the student has 20 case to over. This would multiply the student session enrollment by 20. we are looking at 400 records for enrolment for just one student perterm. How about there are 20 student: that multiplies by another 20 this result in 8000 records of enrolment. Hence we termed this problem "The 20-by-20-by-20 issue".  



## Iterative Refactoring

The schema was not finalised in a single pass. Several rounds of refactoring were applied throughout the process:

1. Initial entity and relationship mapping was done **without fields** to validate structure first.
2. Fields were added in a second pass once structural logic was confirmed.
3. Enums were introduced to replace free-text fields wherever the value set was fixed and known.
4. Unique constraints were reviewed and corrected after identifying the attendance cardinality issue.
5. The enrolment granularity problem was identified during use-case review and resolved by re-scoping enrolment from session-level to course-level.
6. Sample data was expanded from **8 to 15 students** and **5 to 10 sessions** to ensure all query test cases returned meaningful results.

---

## Final Schema Summary

The finalised schema consists of **10 tables**:

| Table | Purpose |
|---|---|
| `year_group` | Stores the 11 year groups (YEAR1–YEAR11). |
| `specialisation` | Subject areas that teaching staff specialise in. |
| `teaching_staff` | All staff records, permanent and contract, each linked to one specialisation. |
| `students` | Student records with year group, personal details, and parent contact. |
| `courses` | Course catalogue with title, code, description, and class size. |
| `course_sessions` | Scheduled instances of a course, linked to a term, year, teacher, and location. |
| `session_enrolment` | Records a student's enrolment in a session, including status and final mark. |
| `student_attendance` | One attendance record per student per session with status and class date. |
| `extracurricular_club` | Clubs with description, meeting day, and lead teacher. |
| `student_joined_extracurricular_club` | Junction table tracking which students have joined which clubs and when. |

---

## Deliverable Files

| File | Description |
|---|---|
| `school_erd_v3.mmd` | ERD source — Mermaid diagram of the final schema |
| `school_erd_v3.sql` | MySQL schema — `CREATE TABLE`, indexes, and foreign keys |
| `school_insert.sql` | Seed data — 15 students, 10 sessions, varied statuses across all tables |
| `query_active_enrolments.sql` | Query: active enrolment count per student including zeros |
| `query_term1_2024_enrolments.sql` | Query: Term 1 2024 sessions with teacher name and enrolment count |
| `query_student_absences.sql` | Query: students with at least one absence, ordered by total absences |
| `query_club_members.sql` | Query: all clubs with member counts, including empty clubs |
| `query_avg_final_mark.sql` | Query: average final mark per course for courses with at least 3 results |

---

*Greenfield Academy — School Management System · Database Design v1.0 By Zainab-Bakare-Samuel*
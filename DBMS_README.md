# DBMS Project Report
## Student Course Registration System

---

## Table of Contents

1. [Identification of Project (Title)](#1-identification-of-project-related-to-dbms)
2. [Project Background](#2-project-background)
3. [Description of the Project](#3-description-of-the-project)
4. [Description of ER Diagram](#5-description-of-er-diagram)
5. [Conversion of ER Diagram into Tables](#6-conversion-of-er-diagram-into-tables)
6. [Description of Tables](#7-description-of-tables)
7. [Normalization up to 3-NF](#8-normalization-of-tables-up-to-3-nf)
8. [Creation of Data in Tables](#9-creation-of-data-in-the-tables)
9. [SQL Queries](#10-sql-queries)
10. [Creation of Views](#11-creation-of-views-using-the-tables)

---

## 1. Identification of Project Related to DBMS

| Field | Detail |
|---|---|
| **Project Title** | Student Course Registration System |
| **Domain** | Education / University Management |
| **DBMS Used** | MySQL 8.x |
| **Frontend** | HTML5, CSS3, JavaScript |
| **Backend** | Python 3 (Flask Framework) |
| **Course** | Database Management Systems (DBMS) |

---

## 2. Project Background

In most universities, course registration is still handled manually or through outdated systems that lead to scheduling conflicts, over-enrolled classes, and slow administrative processes. Students often face difficulties when selecting elective courses due to the lack of real-time seat availability.

This project addresses these problems by building a **web-based Course Registration Portal** backed by a fully normalized relational database. The system automates:
- Student authentication and account management
- Automatic enrollment into mandatory (core) courses upon registration
- Manual selection of elective courses with real-time seat tracking
- Enforcement of enrollment rules (max 7 courses, max 2 electives, seat capacity limits)

The database design follows normalization up to **Third Normal Form (3NF)** to eliminate data redundancy and ensure referential integrity. Advanced SQL features such as **Stored Procedures**, **Triggers**, **Views**, and **Indexes** are used for business rule enforcement and performance optimization.

---

## 3. Description of the Project

### 3.1 Objectives
1. Design a normalized relational database schema for student course registration
2. Implement CRUD operations through a web-based interface
3. Enforce enrollment business rules using stored procedures and triggers
4. Provide real-time analytics using SQL views
5. Demonstrate practical application of DBMS concepts

### 3.2 Modules

| Module | Functionality |
|---|---|
| **Authentication** | Student registration with password hashing, login, logout, session management |
| **Dashboard** | Academic summary — enrolled courses, credits, enrollment health |
| **Course Catalog** | Browse all courses with search, filter (Core/Elective), seat availability |
| **Enrollment** | Enroll in elective courses (validated by stored procedure) |
| **Drop** | Drop elective courses via AJAX (updates DB status to 'dropped') |
| **Auto-Enrollment** | Core courses are automatically assigned upon registration |

### 3.3 Technology Stack

| Layer | Technology |
|---|---|
| Database | MySQL 8.x with InnoDB engine |
| Backend | Python 3 · Flask · Jinja2 |
| DB Connector | `mysql-connector-python` (connection pooling) |
| Security | `werkzeug.security` (PBKDF2-SHA256 password hashing) |
| Frontend | HTML5 · CSS3 · Vanilla JavaScript |

---

## 5. Description of ER Diagram

### 5.1 Entities

| Entity | Description | Primary Key |
|---|---|---|
| **Student** | A registered user of the portal | `student_id` |
| **Course** | A subject offered in a semester | `course_id` |
| **Enrollment** | Records a student's participation in a course | `enrollment_id` |

### 5.2 Attributes

**Student Entity:**
- `student_id` (PK), `full_name`, `email` (Unique), `password_hash`, `semester`, `department`, `created_at`

**Course Entity:**
- `course_id` (PK), `course_code` (Unique), `course_name`, `instructor`, `credits`, `max_capacity`, `semester`, `department`, `course_type`, `schedule`, `description`

**Enrollment Entity (Associative / Bridge):**
- `enrollment_id` (PK), `student_id` (FK), `course_id` (FK), `enrollment_type`, `status`, `enrolled_at`

### 5.3 Relationships

| Relationship | Type | Description |
|---|---|---|
| Student — Enrollment | 1 : M | One student can have many enrollments |
| Course — Enrollment | 1 : M | One course can have many enrollments |
| Student — Course | M : N | Many-to-Many resolved via the Enrollment bridge table |

### 5.4 ER Diagram

```
┌──────────────────────┐                    ┌──────────────────────────┐
│       STUDENT         │                    │          COURSE           │
├──────────────────────┤                    ├──────────────────────────┤
│ student_id (PK)      │                    │ course_id (PK)           │
│ full_name            │                    │ course_code (UNIQUE)     │
│ email (UNIQUE)       │                    │ course_name              │
│ password_hash        │                    │ instructor               │
│ semester             │                    │ credits                  │
│ department           │                    │ max_capacity             │
│ created_at           │                    │ semester                 │
└──────────┬───────────┘                    │ department               │
           │                                │ course_type              │
           │ 1                              │ schedule                 │
           │                                │ description              │
           │                                └──────────┬───────────────┘
           │ M                                         │ M
           ▼                                           │
┌──────────────────────────┐                           │
│       ENROLLMENT          │◄──────────────────────────┘
│    (Associative Entity)   │                    1
├──────────────────────────┤
│ enrollment_id (PK)       │
│ student_id (FK)          │
│ course_id (FK)           │
│ enrollment_type          │
│ status                   │
│ enrolled_at              │
└──────────────────────────┘

Cardinality:
  Student ──< 1:M >── Enrollment ──< M:1 >── Course
  (Resolves the M:N relationship between Student and Course)
```

### 5.5 Constraints in the ER Model

| Constraint | Applied On | Purpose |
|---|---|---|
| **Primary Key** | All 3 entities | Unique identification |
| **Foreign Key** | `enrollment.student_id → student.student_id` | Referential integrity |
| **Foreign Key** | `enrollment.course_id → course.course_id` | Referential integrity |
| **UNIQUE** | `student.email`, `course.course_code` | No duplicate emails or course codes |
| **UNIQUE** | `enrollment(student_id, course_id)` | No duplicate enrollments |
| **CHECK** | `semester BETWEEN 1 AND 8` | Valid semester range |
| **CHECK** | `credits BETWEEN 1 AND 6` | Valid credit range |
| **ON DELETE CASCADE** | Both FKs in enrollment | Auto-cleanup on parent delete |

---

## 6. Conversion of ER Diagram into Tables

### 6.1 Mapping Rules Applied

| ER Element | Relational Mapping |
|---|---|
| Strong Entity (Student) | `students` table with `student_id` as PK |
| Strong Entity (Course) | `courses` table with `course_id` as PK |
| M:N Relationship (Enrolls In) | `enrollments` bridge table with FKs to both entities |
| Simple Attributes | Columns in respective tables |
| Composite Key (natural) | `UNIQUE(student_id, course_id)` in enrollments |

### 6.2 Resulting Tables (DDL)

**Table 1: `students`**
```sql
CREATE TABLE students (
    student_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    semester      INT NOT NULL DEFAULT 1 CHECK (semester BETWEEN 1 AND 8),
    department    VARCHAR(50) NOT NULL DEFAULT 'CSE',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
```

**Table 2: `courses`**
```sql
CREATE TABLE courses (
    course_id    INT AUTO_INCREMENT PRIMARY KEY,
    course_code  VARCHAR(10) UNIQUE NOT NULL,
    course_name  VARCHAR(150) NOT NULL,
    instructor   VARCHAR(100) NOT NULL,
    credits      INT NOT NULL CHECK (credits BETWEEN 1 AND 6),
    max_capacity INT NOT NULL DEFAULT 60,
    semester     INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
    department   VARCHAR(50) NOT NULL DEFAULT 'CSE',
    course_type  ENUM('core', 'elective') NOT NULL DEFAULT 'core',
    schedule     VARCHAR(100),
    description  TEXT
) ENGINE=InnoDB;
```

**Table 3: `enrollments`**
```sql
CREATE TABLE enrollments (
    enrollment_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT NOT NULL,
    course_id       INT NOT NULL,
    enrollment_type ENUM('core', 'elective') NOT NULL DEFAULT 'core',
    status          ENUM('active', 'dropped') NOT NULL DEFAULT 'active',
    enrolled_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)  ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id)
) ENGINE=InnoDB;
```

### 6.3 Indexes Created

```sql
CREATE INDEX idx_student_email      ON students(email);
CREATE INDEX idx_course_semester    ON courses(semester);
CREATE INDEX idx_course_type        ON courses(course_type);
CREATE INDEX idx_enrollment_student ON enrollments(student_id);
CREATE INDEX idx_enrollment_status  ON enrollments(status);
```

---

## 7. Description of Tables

### 7.1 `students` Table

Stores registered student information.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `student_id` | INT | PK, AUTO_INCREMENT | Unique student identifier |
| `full_name` | VARCHAR(100) | NOT NULL | Student's full name |
| `email` | VARCHAR(100) | UNIQUE, NOT NULL | Login email address |
| `password_hash` | VARCHAR(255) | NOT NULL | PBKDF2-SHA256 hashed password |
| `semester` | INT | CHECK(1–8), DEFAULT 1 | Current semester (1 through 8) |
| `department` | VARCHAR(50) | DEFAULT 'CSE' | Department code |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Account creation time |

### 7.2 `courses` Table

Stores all courses offered across semesters.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `course_id` | INT | PK, AUTO_INCREMENT | Unique course identifier |
| `course_code` | VARCHAR(10) | UNIQUE, NOT NULL | e.g., CS201, MA101 |
| `course_name` | VARCHAR(150) | NOT NULL | Full course title |
| `instructor` | VARCHAR(100) | NOT NULL | Professor's name |
| `credits` | INT | CHECK(1–6), NOT NULL | Credit hours |
| `max_capacity` | INT | DEFAULT 60 | Maximum students allowed |
| `semester` | INT | CHECK(1–8) | Which semester it belongs to |
| `department` | VARCHAR(50) | DEFAULT 'CSE' | Offering department |
| `course_type` | ENUM | 'core' / 'elective' | Mandatory or optional |
| `schedule` | VARCHAR(100) | — | Day/time info |
| `description` | TEXT | — | Course description |

### 7.3 `enrollments` Table

Bridge table resolving the many-to-many relationship.

| Column | Data Type | Constraints | Description |
|---|---|---|---|
| `enrollment_id` | INT | PK, AUTO_INCREMENT | Unique enrollment record |
| `student_id` | INT | FK → students, NOT NULL | Which student |
| `course_id` | INT | FK → courses, NOT NULL | Which course |
| `enrollment_type` | ENUM | 'core' / 'elective' | How they were enrolled |
| `status` | ENUM | 'active' / 'dropped' | Current state |
| `enrolled_at` | TIMESTAMP | DEFAULT NOW() | Enrollment timestamp |

---

## 8. Normalization of Tables up to 3-NF

### 8.1 First Normal Form (1NF)

**Rules:** Each column must contain atomic (indivisible) values. Each row must be uniquely identifiable. No repeating groups.

**Violation Example (Unnormalized):**
```
students(student_id, name, courses_enrolled)
-- courses_enrolled = "CS101, CS102, CS201"  ← NOT atomic!
```

**Our Design (Satisfies 1NF):**
- Every column holds a single atomic value
- Courses are stored in a separate `courses` table
- Enrollments are individual rows in the `enrollments` table
- Every table has a PRIMARY KEY for unique identification

### 8.2 Second Normal Form (2NF)

**Rules:** Must be in 1NF + no partial dependencies (non-key attributes must depend on the **entire** primary key).

**Violation Example:**
```
enrollments(student_id, course_id, student_name, course_name)
-- student_name depends only on student_id ← partial dependency!
```

**Our Design (Satisfies 2NF):**
- `student_name` lives only in `students` table (depends on `student_id`)
- `course_name` lives only in `courses` table (depends on `course_id`)
- In `enrollments`, every non-key attribute (`enrollment_type`, `status`, `enrolled_at`) depends on the full composite key `(student_id, course_id)`

### 8.3 Third Normal Form (3NF)

**Rules:** Must be in 2NF + no transitive dependencies (non-key → non-key dependencies).

**Violation Example:**
```
students(student_id, department, department_head)
-- department_head depends on department, NOT on student_id
-- Transitive: student_id → department → department_head
```

**Our Design (Satisfies 3NF):**
- In `students`: every attribute (`full_name`, `email`, `semester`, `department`) depends **directly** on `student_id`. No attribute depends on another non-key attribute.
- In `courses`: every attribute depends **directly** on `course_id`.
- In `enrollments`: every attribute depends **directly** on `enrollment_id`.

### 8.4 Normalization Summary Table

| Table | 1NF | 2NF | 3NF | Justification |
|---|---|---|---|---|
| `students` | ✅ | ✅ | ✅ | All atomic values, PK exists, no partial/transitive deps |
| `courses` | ✅ | ✅ | ✅ | All atomic values, PK exists, no partial/transitive deps |
| `enrollments` | ✅ | ✅ | ✅ | Bridge table, FKs reference parent tables, no redundant data |

---

## 9. Creation of Data in the Tables

### 9.1 Sample Data — `students` Table

```sql
-- Students are created via the web portal (password hashed automatically)
-- Example equivalent inserts:
INSERT INTO students (full_name, email, password_hash, semester, department) VALUES
('Sparsh Kumar',  'sparsh@univ.edu',  '<hashed>', 3, 'CSE'),
('Ananya Singh',  'ananya@univ.edu',  '<hashed>', 3, 'CSE'),
('Rohan Mehta',   'rohan@univ.edu',   '<hashed>', 1, 'CSE'),
('Priya Sharma',  'priya@univ.edu',   '<hashed>', 5, 'CSE'),
('Vikram Patel',  'vikram@univ.edu',  '<hashed>', 3, 'CSE');
```

### 9.2 Sample Data — `courses` Table (30 courses across 3 semesters)

```sql
-- Semester 1: 5 Core + 5 Elective
INSERT INTO courses VALUES
(NULL,'CS101','Introduction to Programming','Dr. Ananya Sharma',4,60,1,'CSE','core','Mon/Wed/Fri 9-10','...'),
(NULL,'MA101','Engineering Mathematics I','Prof. Ramesh Gupta',4,60,1,'MATH','core','Tue/Thu 10-11:30','...'),
(NULL,'PH101','Engineering Physics','Dr. Kavita Nair',3,60,1,'PHY','core','Mon/Wed 11-12','...'),
(NULL,'EE101','Basic Electrical Engineering','Prof. Suresh Reddy',3,60,1,'ECE','core','Tue/Thu 2-3:30','...'),
(NULL,'EN101','Technical Communication','Dr. Priya Mehta',2,60,1,'HUM','core','Fri 2-4','...'),
(NULL,'CS191','Web Development Basics','Prof. Arjun Patel',3,40,1,'CSE','elective','Sat 10-1','...'),
(NULL,'CS192','Digital Logic Design','Dr. Meena Iyer',3,40,1,'CSE','elective','Mon/Wed 3-4','...'),
-- ... (5 more electives for Sem 1)

-- Semester 3: 5 Core + 5 Elective
(NULL,'CS201','Data Structures & Algorithms','Dr. Rajesh Kumar',4,60,3,'CSE','core','Mon/Wed/Fri 9-10','...'),
(NULL,'CS202','Database Management Systems','Prof. Neha Agarwal',4,60,3,'CSE','core','Tue/Thu 10-11:30','...'),
(NULL,'CS203','Object Oriented Programming','Dr. Amit Joshi',3,60,3,'CSE','core','Mon/Wed 11-12','...'),
(NULL,'MA201','Probability & Statistics','Prof. Sunita Rao',3,60,3,'MATH','core','Tue/Thu 2-3:30','...'),
(NULL,'CS204','Computer Organization','Dr. Manish Tiwari',3,60,3,'CSE','core','Fri 10-1','...'),
-- ... (5 electives for Sem 3)

-- Semester 5: 5 Core + 5 Elective (similar pattern)
```

### 9.3 Sample Data — `enrollments` Table

```sql
-- Auto-generated when a student registers (core courses)
-- And when a student manually enrolls in electives
INSERT INTO enrollments (student_id, course_id, enrollment_type, status) VALUES
(1, 6, 'core', 'active'),    -- Sparsh → Data Structures
(1, 7, 'core', 'active'),    -- Sparsh → DBMS
(1, 8, 'core', 'active'),    -- Sparsh → OOP
(1, 9, 'core', 'active'),    -- Sparsh → Probability
(1, 10, 'core', 'active'),   -- Sparsh → Computer Org
(1, 13, 'elective', 'active'), -- Sparsh → Competitive Programming
(1, 14, 'elective', 'active'); -- Sparsh → UI/UX Design
```

### 9.4 Data Volume Summary

| Table | Total Records | Description |
|---|---|---|
| `students` | 5+ | Registered via web portal |
| `courses` | 30 | 10 per semester × 3 semesters |
| `enrollments` | 35+ | 7 per student (5 core + 2 elective) |

---

## 10. SQL Queries

### 10.1 Subqueries

**Q1: Find students who are enrolled in more than 5 courses**
```sql
SELECT full_name, email, semester
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE status = 'active'
    GROUP BY student_id
    HAVING COUNT(*) > 5
);
```

**Q2: Find courses where enrollment exceeds the average enrollment across all courses**
```sql
SELECT c.course_code, c.course_name, COUNT(e.enrollment_id) AS enrolled
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id AND e.status = 'active'
GROUP BY c.course_id
HAVING COUNT(e.enrollment_id) > (
    SELECT AVG(cnt) FROM (
        SELECT COUNT(*) AS cnt
        FROM enrollments
        WHERE status = 'active'
        GROUP BY course_id
    ) AS avg_table
);
```

**Q3: Find students NOT enrolled in any elective**
```sql
SELECT full_name, email
FROM students
WHERE student_id NOT IN (
    SELECT DISTINCT student_id
    FROM enrollments
    WHERE enrollment_type = 'elective' AND status = 'active'
);
```

### 10.2 Aggregate Functions

**Q4: Total credits per student**
```sql
SELECT s.full_name, SUM(c.credits) AS total_credits
FROM students s
JOIN enrollments e ON s.student_id = e.student_id AND e.status = 'active'
JOIN courses c ON e.course_id = c.course_id
GROUP BY s.student_id;
```

**Q5: Average, Min, Max capacity across all courses**
```sql
SELECT
    COUNT(*) AS total_courses,
    AVG(max_capacity) AS avg_capacity,
    MIN(max_capacity) AS min_capacity,
    MAX(max_capacity) AS max_capacity,
    SUM(max_capacity) AS total_seats
FROM courses;
```

**Q6: Count of students per department**
```sql
SELECT department, COUNT(*) AS student_count
FROM students
GROUP BY department
ORDER BY student_count DESC;
```

**Q7: Course with highest enrollment**
```sql
SELECT c.course_code, c.course_name, COUNT(e.enrollment_id) AS enrollments
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id AND e.status = 'active'
GROUP BY c.course_id
ORDER BY enrollments DESC
LIMIT 1;
```

### 10.3 Joins

**Q8: INNER JOIN — List all students with their enrolled courses**
```sql
SELECT s.full_name, s.email, c.course_code, c.course_name,
       e.enrollment_type, e.status, e.enrolled_at
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id
WHERE e.status = 'active'
ORDER BY s.full_name, c.course_code;
```

**Q9: LEFT JOIN — Show all courses with enrollment count (including those with 0 enrollments)**
```sql
SELECT c.course_code, c.course_name, c.course_type,
       COUNT(e.enrollment_id) AS enrolled_count,
       c.max_capacity - COUNT(e.enrollment_id) AS seats_remaining
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id AND e.status = 'active'
GROUP BY c.course_id
ORDER BY enrolled_count DESC;
```

**Q10: Multi-table JOIN — Complete enrollment report**
```sql
SELECT
    s.student_id,
    s.full_name AS student_name,
    s.department,
    s.semester,
    c.course_code,
    c.course_name,
    c.instructor,
    c.credits,
    e.enrollment_type,
    e.enrolled_at
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.status = 'active'
ORDER BY s.student_id, e.enrollment_type;
```

---

## 11. Creation of Views Using the Tables

### View 1: `student_enrollments_view`

**Purpose:** Provides a denormalized, read-friendly view joining all three tables. Used by the application to display enrolled courses on the dashboard and My Courses page.

```sql
CREATE VIEW student_enrollments_view AS
SELECT
    s.student_id,
    s.full_name AS student_name,
    s.email,
    s.semester AS student_semester,
    s.department AS student_department,
    c.course_id,
    c.course_code,
    c.course_name,
    c.instructor,
    c.credits,
    c.schedule,
    c.course_type,
    e.enrollment_id,
    e.enrollment_type,
    e.status,
    e.enrolled_at
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
```

**Usage Example:**
```sql
-- Get all active courses for student #1
SELECT course_code, course_name, instructor, credits
FROM student_enrollments_view
WHERE student_id = 1 AND status = 'active';
```

### View 2: `course_enrollment_stats`

**Purpose:** Shows real-time seat availability, enrolled count, and fill percentage for every course. Powers the "Browse Courses" page with live seat data.

```sql
CREATE VIEW course_enrollment_stats AS
SELECT
    c.course_id, c.course_code, c.course_name,
    c.instructor, c.credits, c.max_capacity,
    c.semester, c.course_type, c.schedule, c.description,
    COUNT(CASE WHEN e.status = 'active' THEN 1 END) AS enrolled_count,
    c.max_capacity - COUNT(CASE WHEN e.status = 'active' THEN 1 END) AS seats_remaining,
    ROUND(
        (COUNT(CASE WHEN e.status = 'active' THEN 1 END) / c.max_capacity) * 100, 1
    ) AS fill_percentage
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_code, c.course_name, c.instructor,
         c.credits, c.max_capacity, c.semester, c.course_type,
         c.schedule, c.description;
```

**Usage Example:**
```sql
-- See all Semester 3 courses with seat availability
SELECT course_code, course_name, seats_remaining, fill_percentage
FROM course_enrollment_stats
WHERE semester = 3
ORDER BY fill_percentage DESC;
```

---

## Additional SQL Features

### Stored Procedure: `sp_enroll_student`

Validates all business rules before enrolling a student:

```sql
CREATE PROCEDURE sp_enroll_student(
    IN  p_student_id      INT,
    IN  p_course_id       INT,
    IN  p_enrollment_type VARCHAR(10),
    OUT p_status          INT,
    OUT p_message         VARCHAR(255)
)
```

| Status | Meaning |
|---|---|
| 0 | ✅ Success |
| 1 | ❌ Course does not exist |
| 2 | ❌ Already enrolled |
| 3 | ❌ Course is full |
| 4 | ❌ Max 7 courses reached |
| 5 | ❌ Max 2 electives reached |

### Trigger: `before_enrollment_insert`

Database-level safety net that fires **BEFORE** every INSERT on `enrollments`. Blocks enrollment if the course has reached `max_capacity`.

```sql
CREATE TRIGGER before_enrollment_insert
BEFORE INSERT ON enrollments
FOR EACH ROW
BEGIN
    DECLARE v_max_cap INT;
    DECLARE v_current_count INT;

    SELECT max_capacity INTO v_max_cap FROM courses WHERE course_id = NEW.course_id;
    SELECT COUNT(*) INTO v_current_count FROM enrollments
        WHERE course_id = NEW.course_id AND status = 'active';

    IF v_current_count >= v_max_cap THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot enroll: course has reached maximum capacity.';
    END IF;
END;
```

---

*This project was built as a DBMS course project to demonstrate normalization, ER modeling, relational design, SQL queries (subqueries, aggregates, joins), views, stored procedures, and triggers in a real-world web application.*

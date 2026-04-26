# 🎓 Student Course Registration System
### A Full-Stack DBMS Project — Flask + MySQL

> **Course:** Database Management Systems (DBMS)  
> **Purpose:** Demonstrate normalization, SQL views, stored procedures, triggers, and a complete web-based student portal.

---

## 📋 Table of Contents

1. [Project Overview](#-project-overview)
2. [UI/UX Design](#-uiux-design)
3. [Tech Stack](#-tech-stack)
4. [Project Structure](#-project-structure)
5. [Database Design & Normalization](#-database-design--normalization)
   - [What is Normalization?](#what-is-normalization)
   - [1NF — First Normal Form](#1nf--first-normal-form)
   - [2NF — Second Normal Form](#2nf--second-normal-form)
   - [3NF — Third Normal Form](#3nf--third-normal-form)
   - [How This Project Achieves 3NF](#how-this-project-achieves-3nf)
6. [Database Schema](#-database-schema)
7. [SQL Features Used](#-sql-features-used)
   - [Views](#views)
   - [Stored Procedures](#stored-procedures)
   - [Triggers](#triggers)
   - [Indexes](#indexes)
8. [Backend Architecture](#-backend-architecture)
9. [Routes & API Endpoints](#-routes--api-endpoints)
10. [Models Layer](#-models-layer)
11. [Frontend Templates](#-frontend-templates)
12. [Business Logic & Rules](#-business-logic--rules)
13. [Setup & Installation](#-setup--installation)
14. [How to Run](#-how-to-run)

---

## 🌟 Project Overview

This is a **Student Course Registration Web Portal** — a full-stack DBMS project that allows students to:

- **Register & Log In** securely using hashed passwords
- **Auto-enroll** in exactly 5 core courses upon registration (based on semester/department)
- **Browse and pick 2 elective courses** from a rich course catalog
- **View their dashboard** with a complete academic summary
- **Drop elective courses** they no longer want

The project is designed around real-world database concepts — **normalization**, **relational integrity**, **stored procedures**, **triggers**, and **views** — all implemented in MySQL.

---

## 🎨 UI/UX Design

The portal features a **premium, dark-themed glassmorphic design** built from scratch:

### Authentication Pages
- **Split-screen layout** — Promotional content on the left, frosted-glass login/register form on the right
- **Dark glassmorphic aesthetic** with backdrop blur, bottom-border-only inputs, and neon-accented buttons
- **Custom AI-generated background** for an immersive experience

### Dashboard (Landing Page Style)
- **Hero Banner** with background imagery and call-to-action buttons
- **Feature Grid** displaying student info (Semester, Student ID, Credits, Join Date) with icon accents
- **Stats Bar** — Dark glassmorphic card showing Total Courses, Core, Electives at a glance
- **Course Cards** — Each enrolled course displayed as a visually rich card with AI-generated thumbnails

### Course Catalog & My Courses
- **Card-based grid layout** replacing traditional data tables
- **Search & filter bar** with type toggles (All / Core / Elective)
- **AJAX-powered Drop** — Elective courses can be dropped without page reload, with spinner animation, card fade-out, and success/error toast notifications

### Design System
| Token | Value | Usage |
|---|---|---|
| Background | `#0b0f19` | Page body |
| Card Surface | `#131b2f` | Cards, panels |
| Primary Accent | `#3b82f6` | Links, headings |
| Success/Neon Green | `#20d489` | CTA buttons, gradients |
| Danger/Neon Pink | `#f43f5e` | Drop buttons, errors |
| Cyan Accent | `#06b6d4` | Enroll buttons, stats |
| Font | Inter (Google Fonts) | All UI text |

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Backend Framework** | Python 3 · Flask |
| **Database** | MySQL 8.x |
| **DB Driver** | `mysql-connector-python` (with connection pooling) |
| **Password Security** | `werkzeug.security` (PBKDF2 SHA-256 hashing) |
| **Templating** | Jinja2 (HTML Templates) |
| **Frontend** | HTML5 · CSS3 · Vanilla JavaScript |
| **Session Management** | Flask server-side sessions |

---

## 📁 Project Structure

```
DBMS/
│
├── app.py                      # Flask app factory & entry point
├── config.py                   # DB credentials, enrollment rules
├── requirements.txt            # Python dependencies
│
├── database/                   # All SQL files
│   ├── schema.sql              # Table definitions (DDL)
│   ├── views.sql               # SQL Views
│   ├── procedures.sql          # Stored Procedures
│   ├── triggers.sql            # Triggers
│   ├── seed.sql                # Initial course & student data
│   ├── seed_more_courses.sql   # Extended course catalog
│   └── fix_electives.sql       # Elective course patches
│
├── models/                     # Python data access layer
│   ├── db.py                   # Connection pool, execute_query, call_procedure
│   ├── student.py              # create_student, get_student, verify_password
│   ├── course.py               # get_all_courses, get_elective_courses, search
│   └── enrollment.py           # enroll, drop, get_student_enrollments, summary
│
├── routes/                     # Flask Blueprints (controllers)
│   ├── auth.py                 # /login, /register, /logout
│   ├── courses.py              # /courses, /courses/enroll, /courses/drop
│   └── dashboard.py            # /dashboard
│
├── static/                     # Static assets
│   ├── style.css               # Full custom CSS (dark theme, glassmorphism)
│   └── img/
│       ├── auth-bg.png         # Auth pages background image
│       └── course_thumbnail.png # Course card thumbnail image
│
└── templates/                  # Jinja2 HTML templates
    ├── base.html               # Shared layout (navbar, flash messages)
    ├── login.html              # Split-screen glassmorphic login
    ├── register.html           # Split-screen glassmorphic registration
    ├── dashboard.html          # Landing page style dashboard
    ├── courses.html            # Course catalog with card grid
    └── my_courses.html         # Enrolled courses with AJAX drop
```

---

## 🗃 Database Design & Normalization

### What is Normalization?

**Normalization** is the process of organizing a relational database to:
- **Eliminate redundant data** (storing the same information multiple times)
- **Ensure data dependencies make sense** (only storing related data in a table)
- **Prevent anomalies** — Insert anomaly, Update anomaly, Delete anomaly

It is achieved through a series of rules called **Normal Forms (NF)**:

> 1NF → 2NF → 3NF → BCNF → 4NF → 5NF *(each is stricter than the last)*

This project targets **3NF**, which is the standard for most production systems.

---

### 1NF — First Normal Form

**Rules:**
1. Every column must hold **atomic (indivisible) values** — no lists or sets in a cell
2. Every row must be **uniquely identifiable** (primary key exists)
3. No **repeating groups** of columns (e.g., course1, course2, course3)

**How our project satisfies 1NF:**

❌ **Bad (Un-normalized) design:**
```
students(student_id, name, courses_enrolled)
-- courses_enrolled = "CS101, CS102, CS201"  ← NOT atomic!
```

✅ **Our design (Atomic values, unique rows):**
```sql
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- unique identifier
    full_name  VARCHAR(100) NOT NULL,           -- single value
    email      VARCHAR(100) UNIQUE NOT NULL,    -- single value
    semester   INT NOT NULL,                    -- single value
    department VARCHAR(50) NOT NULL             -- single value
);
```
Each column holds exactly **one value**. Courses are stored separately in their own table — not as a comma-separated list.

---

### 2NF — Second Normal Form

**Rules:**
1. Must already be in **1NF**
2. Every **non-key attribute** must be **fully functionally dependent** on the **entire primary key** (no partial dependencies)

> Partial dependency only matters when you have a **composite primary key**.

**How our project satisfies 2NF:**

The `enrollments` table has a composite natural key: `(student_id, course_id)`. 

❌ **Bad (Partial dependency):**
```
enrollments(student_id, course_id, student_name, course_name)
-- student_name depends only on student_id  ← partial dependency!
-- course_name depends only on course_id    ← partial dependency!
```

✅ **Our design (No partial dependencies):**
```sql
CREATE TABLE enrollments (
    enrollment_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id      INT NOT NULL,     -- FK to students
    course_id       INT NOT NULL,     -- FK to courses
    enrollment_type ENUM('core', 'elective'),
    status          ENUM('active', 'dropped'),
    enrolled_at     TIMESTAMP
);
```
- `student_name` is **not** stored here — it lives in `students`
- `course_name` is **not** stored here — it lives in `courses`
- Every attribute in `enrollments` depends on **the full key** (student + course combo)

---

### 3NF — Third Normal Form

**Rules:**
1. Must already be in **2NF**
2. There must be **no transitive dependencies** — non-key attributes must not depend on other non-key attributes

**What is a transitive dependency?**
```
A → B → C   means C transitively depends on A through B
```

❌ **Bad (Transitive dependency):**
```
students(student_id, department, department_head)
-- department_head depends on department, NOT on student_id
-- This is a transitive dependency: student_id → department → department_head
```

✅ **Our design (No transitive dependencies):**
```sql
CREATE TABLE students (
    student_id  INT PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100),
    password_hash VARCHAR(255),
    semester    INT,
    department  VARCHAR(50)   -- stored as a plain string attribute
    -- NO department_head, NO department_code, etc.
);
```
Every attribute in `students` **directly** depends only on `student_id`.  
Similarly, every attribute in `courses` directly depends only on `course_id`.

---

### How This Project Achieves 3NF

Our three core tables and their relationships:

```
┌─────────────────────┐         ┌──────────────────────────┐
│       students       │         │         courses           │
├─────────────────────┤         ├──────────────────────────┤
│ student_id (PK)     │         │ course_id (PK)            │
│ full_name           │         │ course_code (UNIQUE)      │
│ email (UNIQUE)      │         │ course_name               │
│ password_hash       │         │ instructor                │
│ semester            │         │ credits                   │
│ department          │         │ max_capacity              │
│ created_at          │         │ semester                  │
└──────────┬──────────┘         │ department                │
           │                    │ course_type               │
           │ FK                 │ schedule                  │
           ▼                    │ description               │
┌─────────────────────────┐     └──────────┬───────────────┘
│       enrollments        │               │ FK
├─────────────────────────┤◄──────────────┘
│ enrollment_id (PK)      │
│ student_id (FK)         │  Many-to-Many bridge table
│ course_id (FK)          │  One student → many courses
│ enrollment_type         │  One course → many students
│ status                  │
│ enrolled_at             │
└─────────────────────────┘
```

**Relationships:**
- **Students ↔ Courses** → Many-to-Many (a student takes many courses; a course has many students)
- The `enrollments` table is the **junction/bridge table** that resolves this M:M relationship into two 1:M relationships
- **Foreign Keys** enforce **referential integrity** (`ON DELETE CASCADE`)
- **UNIQUE constraint** on `(student_id, course_id)` prevents duplicate enrollments

---

## 📐 Database Schema

### `students` Table
| Column | Type | Constraints | Description |
|---|---|---|---|
| `student_id` | INT | PK, AUTO_INCREMENT | Unique student identifier |
| `full_name` | VARCHAR(100) | NOT NULL | Student's full name |
| `email` | VARCHAR(100) | UNIQUE, NOT NULL | Login email |
| `password_hash` | VARCHAR(255) | NOT NULL | PBKDF2-hashed password |
| `semester` | INT | CHECK(1-8) | Current semester |
| `department` | VARCHAR(50) | DEFAULT 'CSE' | Department code |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Registration timestamp |

### `courses` Table
| Column | Type | Constraints | Description |
|---|---|---|---|
| `course_id` | INT | PK, AUTO_INCREMENT | Unique course identifier |
| `course_code` | VARCHAR(10) | UNIQUE, NOT NULL | e.g., `CS301` |
| `course_name` | VARCHAR(150) | NOT NULL | Full course name |
| `instructor` | VARCHAR(100) | NOT NULL | Professor name |
| `credits` | INT | CHECK(1-6) | Credit hours |
| `max_capacity` | INT | DEFAULT 60 | Max students allowed |
| `semester` | INT | CHECK(1-8) | Which semester this belongs to |
| `department` | VARCHAR(50) | DEFAULT 'CSE' | Department |
| `course_type` | ENUM | 'core' or 'elective' | Auto or student-chosen |
| `schedule` | VARCHAR(100) | — | Day/time info |
| `description` | TEXT | — | Course description |

### `enrollments` Table
| Column | Type | Constraints | Description |
|---|---|---|---|
| `enrollment_id` | INT | PK, AUTO_INCREMENT | Unique enrollment record |
| `student_id` | INT | FK → students | Which student |
| `course_id` | INT | FK → courses | Which course |
| `enrollment_type` | ENUM | 'core' or 'elective' | How they got enrolled |
| `status` | ENUM | 'active' or 'dropped' | Current enrollment status |
| `enrolled_at` | TIMESTAMP | DEFAULT NOW() | When they enrolled |

---

## ⚙️ SQL Features Used

### Views

Views are **virtual tables** built from SELECT queries. They simplify complex joins and provide a clean query interface.

#### `student_enrollments_view`
Joins all three tables to give a complete picture of which student is in which course:
```sql
CREATE VIEW student_enrollments_view AS
SELECT 
    s.student_id, s.full_name, s.email, s.semester,
    c.course_code, c.course_name, c.instructor, c.credits,
    e.enrollment_type, e.status, e.enrolled_at
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
```

#### `course_enrollment_stats`
Shows live seat availability and fill percentage for every course:
```sql
CREATE VIEW course_enrollment_stats AS
SELECT 
    c.course_id, c.course_code, c.course_name,
    COUNT(CASE WHEN e.status = 'active' THEN 1 END)          AS enrolled_count,
    c.max_capacity - COUNT(CASE WHEN e.status = 'active' THEN 1 END) AS seats_remaining,
    ROUND((COUNT(CASE WHEN e.status = 'active' THEN 1 END) / c.max_capacity) * 100, 1) AS fill_percentage
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id;
```

---

### Stored Procedures

A stored procedure is a **named, saved SQL program** stored in the database. It can take parameters, run logic, and return results — like a function in a programming language.

#### `sp_enroll_student`
The central enrollment procedure. It validates all business rules before inserting:

```sql
CREATE PROCEDURE sp_enroll_student(
    IN  p_student_id      INT,
    IN  p_course_id       INT,
    IN  p_enrollment_type VARCHAR(10),
    OUT p_status          INT,       -- 0=success, 1-5=specific error
    OUT p_message         VARCHAR(255)
)
```

**Checks performed (in order):**
| Status Code | Meaning |
|---|---|
| `0` | ✅ Success — enrolled |
| `1` | ❌ Course does not exist |
| `2` | ❌ Already enrolled in this course |
| `3` | ❌ Course is full (capacity reached) |
| `4` | ❌ Student has 7 courses already |
| `5` | ❌ Student already has 2 electives |

Called from Python with:
```python
result_args = cursor.callproc('sp_enroll_student', (student_id, course_id, 'elective', 0, ''))
status = result_args[3]
message = result_args[4]
```

---

### Triggers

A trigger is **automatic SQL code** that fires when a specific event (INSERT, UPDATE, DELETE) happens on a table. It acts as a **database-level enforcement layer**.

#### `before_enrollment_insert`
Fires **BEFORE** every INSERT into `enrollments`. Acts as a last-resort safety net:

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
END
```

**Why have both a procedure AND a trigger for capacity?**
- The **stored procedure** (application level) checks capacity and returns a friendly error message
- The **trigger** (database level) is a hard wall — even if someone bypasses the app and directly inserts via SQL CLI, the trigger blocks it
- This is called **defense-in-depth** in database design

---

### Indexes

Indexes speed up SELECT queries by creating a sorted lookup structure:

```sql
CREATE INDEX idx_student_email     ON students(email);       -- fast login lookup
CREATE INDEX idx_course_semester   ON courses(semester);     -- fast semester filter
CREATE INDEX idx_course_type       ON courses(course_type);  -- fast type filter
CREATE INDEX idx_enrollment_student ON enrollments(student_id); -- fast enrollment lookup
CREATE INDEX idx_enrollment_status  ON enrollments(status);  -- fast active/dropped filter
```

---

## 🐍 Backend Architecture

The backend follows the **MVC (Model-View-Controller)** pattern:

```
Request → Flask Route (Controller) → Model (DB Query) → Template (View) → Response
```

### `app.py` — Application Factory
Uses Flask's **factory pattern**:
```python
def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # Register route blueprints
    app.register_blueprint(auth_bp)
    app.register_blueprint(courses_bp)
    app.register_blueprint(dashboard_bp)
    
    return app
```
This allows the app to be created fresh (useful for testing) and keeps concerns separated.

### `config.py` — Configuration
Centralizes all configuration:
```python
class Config:
    SECRET_KEY = 'dbms-course-reg-secret-key-2026'
    MYSQL_HOST = 'localhost'
    MYSQL_PORT = 3306
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = '...'
    MYSQL_DATABASE = 'course_registration'
    
    MAX_CORE_COURSES = 5
    MAX_ELECTIVE_COURSES = 2
    MAX_TOTAL_COURSES = 7
```

### `models/db.py` — Database Layer
Manages a **connection pool** (5 connections reused, not opened/closed on every request):
```python
_pool = pooling.MySQLConnectionPool(
    pool_name="course_reg_pool",
    pool_size=5,
    ...
)
```

Key functions:
- `get_db()` — gets a connection from the pool
- `execute_query(query, params, fetch_one, fetch_all, commit)` — generic parameterized query runner
- `call_procedure(proc_name, args)` — calls a MySQL stored procedure
- `init_database()` — reads & executes all `.sql` files in order on first run

**Parameterized queries** (`%s` placeholders) prevent **SQL Injection attacks**.

---

## 🛣 Routes & API Endpoints

### Auth Blueprint (`routes/auth.py`)

| Method | URL | Description |
|---|---|---|
| `GET` | `/login` | Show login form |
| `POST` | `/login` | Validate credentials, create session |
| `GET` | `/register` | Show registration form |
| `POST` | `/register` | Create student, auto-enroll core courses |
| `GET` | `/logout` | Clear session, redirect to login |

**Session Management:**
```python
session['student_id']         = student['student_id']
session['student_name']       = student['full_name']
session['student_email']      = student['email']
session['student_semester']   = student['semester']
session['student_department'] = student['department']
```

**`login_required` decorator** protects private routes:
```python
@login_required
def dashboard():
    # only accessible if logged in
```

### Courses Blueprint (`routes/courses.py`)

| Method | URL | Description |
|---|---|---|
| `GET` | `/courses` | Browse available courses (with search & filter) |
| `POST` | `/courses/enroll/<id>` | Enroll in an elective course |
| `POST` | `/courses/drop/<id>` | Drop an enrolled course |
| `GET` | `/my-courses` | View all enrolled courses |

### Dashboard Blueprint (`routes/dashboard.py`)

| Method | URL | Description |
|---|---|---|
| `GET` | `/dashboard` | Student academic overview |
| `GET` | `/` | Root redirect → dashboard |

---

## 🧩 Models Layer

### `models/student.py`
```python
create_student(full_name, email, password, semester, department)
    → Hashes password with werkzeug, inserts into DB, returns student_id

get_student_by_email(email)
    → Returns student dict or None

verify_password(password_hash, plain_password)
    → Returns True/False using werkzeug.security.check_password_hash
```

### `models/course.py`
```python
get_all_courses(semester)       → All courses for a semester (uses course_enrollment_stats view)
get_elective_courses(semester)  → Only elective courses
get_course_by_id(course_id)     → Single course
search_courses(query, semester) → LIKE search on name/code/instructor
```

### `models/enrollment.py`
```python
enroll_student(student_id, course_id, enrollment_type)
    → Calls sp_enroll_student stored procedure, returns (status_code, message)

enroll_core_courses(student_id, semester)
    → Finds all core courses for the semester, auto-enrolls them all

drop_course(student_id, course_id)
    → Sets enrollment status = 'dropped', returns (success, message)

get_student_enrollments(student_id, status='active')
    → Returns list of enrollment dicts with full course info (uses view)

get_enrollment_summary(student_id)
    → Returns dict: {total, core_count, elective_count, total_credits}

is_enrolled(student_id, course_id)
    → Returns True/False
```

---

## 🖥 Frontend Templates

| Template | Purpose |
|---|---|
| `base.html` | Shared layout — dark theme navbar, flash messages, footer |
| `login.html` | Split-screen glassmorphic login with background image |
| `register.html` | Split-screen glassmorphic registration with neon accents |
| `dashboard.html` | Landing page style: hero banner, feature grid, stats bar, course cards |
| `courses.html` | Course catalog with card grid, search bar, and type filters |
| `my_courses.html` | Enrolled courses as cards with AJAX-powered drop functionality |

All templates extend `base.html` using Jinja2 template inheritance:
```html
{% extends "base.html" %}
{% block content %}
  <!-- page-specific HTML here -->
{% endblock %}
```

---

## 📏 Business Logic & Rules

| Rule | Enforcement |
|---|---|
| Max 5 core courses per semester | Application logic in `enroll_core_courses()` |
| Max 2 elective courses per student | Checked in stored procedure (`p_status = 5`) |
| Max 7 total courses per student | Checked in stored procedure (`p_status = 4`) |
| No duplicate enrollments | UNIQUE KEY `(student_id, course_id)` in DB schema |
| Course capacity limit | Trigger `before_enrollment_insert` + procedure check |
| Core courses cannot be manually enrolled | Route validation in `courses.py` |
| Passwords hashed, never stored plain | `werkzeug.security.generate_password_hash()` |
| SQL Injection prevention | Parameterized queries throughout (`%s` placeholders) |

---

## 🚀 Setup & Installation

### Prerequisites
- Python 3.8+
- MySQL 8.x running locally
- `pip`

### 1. Clone / Download the Project
```bash
git clone https://github.com/EagleEye-xdata/Course_Reg_Sys.git
cd Course_Reg_Sys
```

### 2. Install Python Dependencies
```bash
pip install -r requirements.txt
```
This installs:
- `flask` — web framework
- `mysql-connector-python` — MySQL driver
- `werkzeug` — password hashing utilities

### 3. Configure MySQL Credentials
Open `config.py` and update:
```python
MYSQL_HOST     = 'localhost'
MYSQL_PORT     = 3306
MYSQL_USER     = 'root'
MYSQL_PASSWORD = 'your_mysql_password'
MYSQL_DATABASE = 'course_registration'
```

### 4. Initialize the Database
```bash
python app.py --init-db
```
This automatically runs (in order):
1. `schema.sql` — creates tables
2. `views.sql` — creates views
3. `procedures.sql` — creates stored procedure
4. `triggers.sql` — creates trigger
5. `seed.sql` — populates initial data

---

## ▶️ How to Run

```bash
python app.py
```

The server starts at: **http://127.0.0.1:5000**

| Page | URL |
|---|---|
| Login | http://127.0.0.1:5000/login |
| Register | http://127.0.0.1:5000/register |
| Dashboard | http://127.0.0.1:5000/dashboard |
| Browse Courses | http://127.0.0.1:5000/courses |
| My Courses | http://127.0.0.1:5000/my-courses |

---

## 🔐 Security Notes

- Passwords are **never stored in plain text** — PBKDF2-SHA256 hashing via Werkzeug
- All database queries use **parameterized statements** — immune to SQL injection
- Auth routes are protected by the `@login_required` decorator
- Flask sessions use a **secret key** for HMAC signing

---

## 👨‍💻 Developer Notes

- The `_pool = None` global is reset after `init_database()` so the pool reconnects once the DB exists
- `ON DUPLICATE KEY UPDATE` in the procedure handles race conditions on re-enrollment
- `LEFT JOIN` in `course_enrollment_stats` ensures courses with 0 enrollments still appear
- The `SIGNAL SQLSTATE '45000'` in the trigger is MySQL's way of raising a custom error

---

*This project was built as a DBMS course project to demonstrate practical application of normalization, relational design, SQL procedures, triggers, and views in a real web application.*

-- ============================================
-- Student Course Registration System
-- Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS course_registration;
USE course_registration;

-- Drop tables in reverse dependency order if they exist
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

-- ============================================
-- STUDENTS TABLE
-- ============================================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    semester INT NOT NULL DEFAULT 1 CHECK (semester BETWEEN 1 AND 8),
    department VARCHAR(50) NOT NULL DEFAULT 'CSE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Index for faster login lookups
CREATE INDEX idx_student_email ON students(email);

-- ============================================
-- COURSES TABLE
-- course_type: 'core' (auto-assigned) or 'elective' (student picks)
-- ============================================
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(150) NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits BETWEEN 1 AND 6),
    max_capacity INT NOT NULL DEFAULT 60,
    semester INT NOT NULL CHECK (semester BETWEEN 1 AND 8),
    department VARCHAR(50) NOT NULL DEFAULT 'CSE',
    course_type ENUM('core', 'elective') NOT NULL DEFAULT 'core',
    schedule VARCHAR(100),
    description TEXT
) ENGINE=InnoDB;

CREATE INDEX idx_course_semester ON courses(semester);
CREATE INDEX idx_course_type ON courses(course_type);

-- ============================================
-- ENROLLMENTS TABLE (Many-to-Many Bridge)
-- ============================================
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_type ENUM('core', 'elective') NOT NULL DEFAULT 'core',
    status ENUM('active', 'dropped') NOT NULL DEFAULT 'active',
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Keys
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,

    -- Prevent duplicate enrollments (same student + same course)
    UNIQUE KEY unique_enrollment (student_id, course_id)
) ENGINE=InnoDB;

CREATE INDEX idx_enrollment_student ON enrollments(student_id);
CREATE INDEX idx_enrollment_status ON enrollments(status);

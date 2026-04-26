-- ============================================
-- SQL VIEWS — Joined Data
-- ============================================

USE course_registration;

-- ============================================
-- VIEW 1: Student Enrollment Details
-- Joins students + enrollments + courses for a
-- complete picture of who is enrolled in what.
-- ============================================
DROP VIEW IF EXISTS student_enrollments_view;

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


-- ============================================
-- VIEW 2: Course Enrollment Statistics
-- Shows each course with current active count,
-- remaining seats, and fill percentage.
-- ============================================
DROP VIEW IF EXISTS course_enrollment_stats;

CREATE VIEW course_enrollment_stats AS
SELECT 
    c.course_id,
    c.course_code,
    c.course_name,
    c.instructor,
    c.credits,
    c.max_capacity,
    c.semester,
    c.course_type,
    c.schedule,
    c.description,
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

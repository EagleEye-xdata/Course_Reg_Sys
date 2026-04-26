-- ============================================
-- STORED PROCEDURES
-- ============================================

USE course_registration;

DROP PROCEDURE IF EXISTS sp_enroll_student;

DELIMITER //

-- ============================================
-- Procedure: sp_enroll_student
-- Validates and enrolls a student in a course.
-- Checks:
--   1. Course exists
--   2. Course has available seats
--   3. Student is not already enrolled
--   4. Student hasn't exceeded elective limit (2)
--   5. Student hasn't exceeded total limit (7)
-- Returns: status code (0=success, 1+=error) and message
-- ============================================
CREATE PROCEDURE sp_enroll_student(
    IN p_student_id INT,
    IN p_course_id INT,
    IN p_enrollment_type VARCHAR(10),
    OUT p_status INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    DECLARE v_capacity INT DEFAULT 0;
    DECLARE v_enrolled INT DEFAULT 0;
    DECLARE v_already_enrolled INT DEFAULT 0;
    DECLARE v_student_total INT DEFAULT 0;
    DECLARE v_student_electives INT DEFAULT 0;
    DECLARE v_course_exists INT DEFAULT 0;

    -- Check if course exists
    SELECT COUNT(*) INTO v_course_exists FROM courses WHERE course_id = p_course_id;
    IF v_course_exists = 0 THEN
        SET p_status = 1;
        SET p_message = 'Course does not exist.';
    ELSE
        -- Get course capacity
        SELECT max_capacity INTO v_capacity FROM courses WHERE course_id = p_course_id;

        -- Get current active enrollment count for this course
        SELECT COUNT(*) INTO v_enrolled 
        FROM enrollments 
        WHERE course_id = p_course_id AND status = 'active';

        -- Check if student is already enrolled (active)
        SELECT COUNT(*) INTO v_already_enrolled 
        FROM enrollments 
        WHERE student_id = p_student_id 
          AND course_id = p_course_id 
          AND status = 'active';

        -- Get student's total active enrollments
        SELECT COUNT(*) INTO v_student_total 
        FROM enrollments 
        WHERE student_id = p_student_id AND status = 'active';

        -- Get student's active elective enrollments
        SELECT COUNT(*) INTO v_student_electives 
        FROM enrollments 
        WHERE student_id = p_student_id 
          AND enrollment_type = 'elective' 
          AND status = 'active';

        IF v_already_enrolled > 0 THEN
            SET p_status = 2;
            SET p_message = 'You are already enrolled in this course.';
        ELSEIF v_enrolled >= v_capacity THEN
            SET p_status = 3;
            SET p_message = 'Course is full. No seats available.';
        ELSEIF v_student_total >= 7 THEN
            SET p_status = 4;
            SET p_message = 'Maximum course limit reached (7 courses per semester).';
        ELSEIF p_enrollment_type = 'elective' AND v_student_electives >= 2 THEN
            SET p_status = 5;
            SET p_message = 'Maximum elective limit reached (2 electives per semester).';
        ELSE
            -- All checks passed — enroll the student
            INSERT INTO enrollments (student_id, course_id, enrollment_type, status)
            VALUES (p_student_id, p_course_id, p_enrollment_type, 'active')
            ON DUPLICATE KEY UPDATE status = 'active', enrolled_at = CURRENT_TIMESTAMP;

            SET p_status = 0;
            SET p_message = 'Successfully enrolled in the course!';
        END IF;
    END IF;
END //

DELIMITER ;

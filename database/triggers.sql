-- ============================================
-- TRIGGERS
-- ============================================

USE course_registration;

DROP TRIGGER IF EXISTS before_enrollment_insert;

DELIMITER //

-- ============================================
-- Trigger: before_enrollment_insert
-- Fires BEFORE each enrollment INSERT.
-- Validates that the course has available seats.
-- Raises a SIGNAL (error) if the course is full,
-- acting as a database-level safety net.
-- ============================================
CREATE TRIGGER before_enrollment_insert
BEFORE INSERT ON enrollments
FOR EACH ROW
BEGIN
    DECLARE v_max_cap INT;
    DECLARE v_current_count INT;

    -- Get course max capacity
    SELECT max_capacity INTO v_max_cap
    FROM courses
    WHERE course_id = NEW.course_id;

    -- Count current active enrollments
    SELECT COUNT(*) INTO v_current_count
    FROM enrollments
    WHERE course_id = NEW.course_id AND status = 'active';

    -- Block if full
    IF v_current_count >= v_max_cap THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot enroll: course has reached maximum capacity.';
    END IF;
END //

DELIMITER ;

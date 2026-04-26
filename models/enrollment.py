import mysql.connector
from models.db import execute_query, call_procedure, get_db


def enroll_student(student_id, course_id, enrollment_type='elective'):
    """
    Enroll a student in a course using the stored procedure.
    
    Args:
        student_id: ID of the student
        course_id: ID of the course
        enrollment_type: 'core' or 'elective'
    
    Returns:
        tuple: (status_code, message)
            0 = success
            1 = course not found
            2 = already enrolled
            3 = course full
            4 = max courses reached
            5 = max electives reached
    """
    try:
        result = call_procedure('sp_enroll_student', (
            student_id,
            course_id,
            enrollment_type,
            0,    # OUT p_status
            ''    # OUT p_message
        ))
        status = result[3]
        message = result[4]
        return (int(status), message)
    except mysql.connector.Error as err:
        return (-1, f"Database error: {str(err)}")


def enroll_core_courses(student_id, semester):
    """
    Auto-enroll a student in all core courses for their semester.
    Called during registration.
    
    Returns:
        list of (course_code, status, message) tuples
    """
    from models.course import get_core_courses
    
    core_courses = get_core_courses(semester)
    results = []
    
    for course in core_courses:
        status, message = enroll_student(student_id, course['course_id'], 'core')
        results.append((course['course_code'], status, message))
    
    return results


def drop_course(student_id, course_id):
    """
    Drop a course by updating enrollment status to 'dropped'.
    Only elective courses can be dropped by students.
    
    Returns:
        tuple: (success: bool, message: str)
    """
    # Check if enrollment exists and is active
    query = """
        SELECT enrollment_id, enrollment_type, status 
        FROM enrollments 
        WHERE student_id = %s AND course_id = %s
    """
    enrollment = execute_query(query, (student_id, course_id), fetch_one=True)
    
    if not enrollment:
        return (False, "You are not enrolled in this course.")
    
    if enrollment['status'] == 'dropped':
        return (False, "You have already dropped this course.")
    
    if enrollment['enrollment_type'] == 'core':
        return (False, "Core courses cannot be dropped. Contact your department.")
    
    # Drop the course
    update_query = """
        UPDATE enrollments 
        SET status = 'dropped' 
        WHERE student_id = %s AND course_id = %s AND status = 'active'
    """
    execute_query(update_query, (student_id, course_id), commit=True)
    return (True, "Course dropped successfully.")


def get_student_enrollments(student_id, status='active'):
    """
    Get all courses a student is enrolled in (uses the view).
    
    Returns:
        list of enrollment records with course details
    """
    query = """
        SELECT * FROM student_enrollments_view 
        WHERE student_id = %s AND status = %s
        ORDER BY course_type ASC, course_code ASC
    """
    return execute_query(query, (student_id, status), fetch_all=True)


def get_enrollment_summary(student_id):
    """
    Get a summary of the student's enrollment.
    
    Returns:
        dict with total, core_count, elective_count, total_credits
    """
    query = """
        SELECT 
            COUNT(*) AS total_courses,
            SUM(CASE WHEN enrollment_type = 'core' THEN 1 ELSE 0 END) AS core_count,
            SUM(CASE WHEN enrollment_type = 'elective' THEN 1 ELSE 0 END) AS elective_count
        FROM enrollments
        WHERE student_id = %s AND status = 'active'
    """
    summary = execute_query(query, (student_id,), fetch_one=True)
    
    # Get total credits
    credits_query = """
        SELECT COALESCE(SUM(c.credits), 0) AS total_credits
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = %s AND e.status = 'active'
    """
    credits = execute_query(credits_query, (student_id,), fetch_one=True)
    
    if summary:
        summary['total_credits'] = credits['total_credits'] if credits else 0
    
    return summary


def is_enrolled(student_id, course_id):
    """Check if a student is actively enrolled in a course."""
    query = """
        SELECT COUNT(*) AS cnt FROM enrollments 
        WHERE student_id = %s AND course_id = %s AND status = 'active'
    """
    result = execute_query(query, (student_id, course_id), fetch_one=True)
    return result['cnt'] > 0 if result else False

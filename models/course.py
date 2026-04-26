from models.db import execute_query


def get_all_courses(semester=None):
    """
    Get all courses with enrollment stats (uses the view).
    Optionally filter by semester.
    """
    if semester:
        query = """
            SELECT * FROM course_enrollment_stats 
            WHERE semester = %s 
            ORDER BY course_type ASC, course_code ASC
        """
        return execute_query(query, (semester,), fetch_all=True)
    else:
        query = """
            SELECT * FROM course_enrollment_stats 
            ORDER BY semester ASC, course_type ASC, course_code ASC
        """
        return execute_query(query, fetch_all=True)


def get_core_courses(semester):
    """Get core courses for a specific semester."""
    query = """
        SELECT * FROM course_enrollment_stats 
        WHERE semester = %s AND course_type = 'core'
        ORDER BY course_code ASC
    """
    return execute_query(query, (semester,), fetch_all=True)


def get_elective_courses(semester):
    """Get elective courses for a specific semester."""
    query = """
        SELECT * FROM course_enrollment_stats 
        WHERE semester = %s AND course_type = 'elective'
        ORDER BY course_code ASC
    """
    return execute_query(query, (semester,), fetch_all=True)


def get_course_by_id(course_id):
    """Get a single course by ID with enrollment stats."""
    query = "SELECT * FROM course_enrollment_stats WHERE course_id = %s"
    return execute_query(query, (course_id,), fetch_one=True)


def search_courses(query_str, semester=None):
    """Search courses by name or code."""
    search_param = f"%{query_str}%"
    if semester:
        query = """
            SELECT * FROM course_enrollment_stats 
            WHERE (course_name LIKE %s OR course_code LIKE %s) AND semester = %s
            ORDER BY course_type ASC, course_code ASC
        """
        return execute_query(query, (search_param, search_param, semester), fetch_all=True)
    else:
        query = """
            SELECT * FROM course_enrollment_stats 
            WHERE course_name LIKE %s OR course_code LIKE %s
            ORDER BY semester ASC, course_type ASC, course_code ASC
        """
        return execute_query(query, (search_param, search_param), fetch_all=True)

from werkzeug.security import generate_password_hash, check_password_hash
from models.db import execute_query


def create_student(full_name, email, password, semester=1, department='CSE'):
    """
    Register a new student with hashed password.
    Returns the new student_id, or raises error if email exists.
    """
    password_hash = generate_password_hash(password)
    query = """
        INSERT INTO students (full_name, email, password_hash, semester, department)
        VALUES (%s, %s, %s, %s, %s)
    """
    student_id = execute_query(
        query, (full_name, email, password_hash, semester, department), commit=True
    )
    return student_id


def get_student_by_email(email):
    """Fetch a student by email (for login)."""
    query = "SELECT * FROM students WHERE email = %s"
    return execute_query(query, (email,), fetch_one=True)


def get_student_by_id(student_id):
    """Fetch a student by ID (for session lookups)."""
    query = "SELECT * FROM students WHERE student_id = %s"
    return execute_query(query, (student_id,), fetch_one=True)


def verify_password(stored_hash, password):
    """Verify a password against the stored hash."""
    return check_password_hash(stored_hash, password)

import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', 'dbms-course-reg-secret-key-2026')
    
    # MySQL Database Configuration
    MYSQL_HOST = 'localhost'
    MYSQL_PORT = 3306
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = '12Sparsh@#123'
    MYSQL_DATABASE = 'course_registration'
    
    # Enrollment Rules
    MAX_CORE_COURSES = 5       # Auto-assigned by university per semester
    MAX_ELECTIVE_COURSES = 2   # Chosen by student
    MAX_TOTAL_COURSES = 7      # Total per student per semester

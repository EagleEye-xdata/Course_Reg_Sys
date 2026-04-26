from functools import wraps
from flask import Blueprint, render_template, request, redirect, url_for, flash, session
import mysql.connector
from models.student import create_student, get_student_by_email, verify_password
from models.enrollment import enroll_core_courses

auth_bp = Blueprint('auth', __name__)


# ============================================
# Login Required Decorator
# ============================================
def login_required(f):
    """Decorator to protect routes that require authentication."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'student_id' not in session:
            flash('Please log in to access this page.', 'warning')
            return redirect(url_for('auth.login'))
        return f(*args, **kwargs)
    return decorated_function


# ============================================
# LOGIN
# ============================================
@auth_bp.route('/login', methods=['GET', 'POST'])
def login():
    if 'student_id' in session:
        return redirect(url_for('dashboard.dashboard'))
    
    if request.method == 'POST':
        email = request.form.get('email', '').strip()
        password = request.form.get('password', '')
        
        # Validation
        if not email or not password:
            flash('Please fill in all fields.', 'danger')
            return render_template('login.html')
        
        # Authenticate
        student = get_student_by_email(email)
        
        if student and verify_password(student['password_hash'], password):
            session['student_id'] = student['student_id']
            session['student_name'] = student['full_name']
            session['student_email'] = student['email']
            session['student_semester'] = student['semester']
            session['student_department'] = student['department']
            flash(f'Welcome back, {student["full_name"]}!', 'success')
            return redirect(url_for('dashboard.dashboard'))
        else:
            flash('Invalid email or password.', 'danger')
    
    return render_template('login.html')


# ============================================
# REGISTER
# ============================================
@auth_bp.route('/register', methods=['GET', 'POST'])
def register():
    if 'student_id' in session:
        return redirect(url_for('dashboard.dashboard'))
    
    if request.method == 'POST':
        full_name = request.form.get('full_name', '').strip()
        email = request.form.get('email', '').strip()
        password = request.form.get('password', '')
        confirm_password = request.form.get('confirm_password', '')
        semester = request.form.get('semester', 1, type=int)
        department = request.form.get('department', 'CSE').strip()
        
        # Validation
        errors = []
        if not full_name:
            errors.append('Full name is required.')
        if not email:
            errors.append('Email is required.')
        if not password or len(password) < 6:
            errors.append('Password must be at least 6 characters.')
        if password != confirm_password:
            errors.append('Passwords do not match.')
        if semester < 1 or semester > 8:
            errors.append('Semester must be between 1 and 8.')
        
        if errors:
            for error in errors:
                flash(error, 'danger')
            return render_template('register.html')
        
        # Create student
        try:
            student_id = create_student(full_name, email, password, semester, department)
            
            # Auto-enroll in core courses for the semester
            core_results = enroll_core_courses(student_id, semester)
            core_enrolled = sum(1 for _, status, _ in core_results if status == 0)
            
            flash(f'Registration successful! You have been auto-enrolled in {core_enrolled} core courses.', 'success')
            
            # Auto-login after registration
            student = get_student_by_email(email)
            session['student_id'] = student['student_id']
            session['student_name'] = student['full_name']
            session['student_email'] = student['email']
            session['student_semester'] = student['semester']
            session['student_department'] = student['department']
            
            return redirect(url_for('dashboard.dashboard'))
        
        except mysql.connector.IntegrityError:
            flash('An account with this email already exists.', 'danger')
        except Exception as e:
            flash(f'Registration failed: {str(e)}', 'danger')
    
    return render_template('register.html')


# ============================================
# LOGOUT
# ============================================
@auth_bp.route('/logout')
def logout():
    session.clear()
    flash('You have been logged out.', 'info')
    return redirect(url_for('auth.login'))

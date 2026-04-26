from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from routes.auth import login_required
from models.course import get_all_courses, get_elective_courses, get_course_by_id, search_courses
from models.enrollment import (
    enroll_student, drop_course, get_student_enrollments, 
    is_enrolled, get_enrollment_summary
)

courses_bp = Blueprint('courses', __name__)


# ============================================
# VIEW ALL AVAILABLE COURSES
# ============================================
@courses_bp.route('/courses')
@login_required
def browse_courses():
    semester = session.get('student_semester', 1)
    search_query = request.args.get('search', '').strip()
    filter_type = request.args.get('type', 'all')  # 'all', 'core', 'elective'
    
    if search_query:
        courses = search_courses(search_query, semester)
    else:
        courses = get_all_courses(semester)
    
    # Apply type filter
    if filter_type == 'elective':
        courses = [c for c in courses if c['course_type'] == 'elective']
    elif filter_type == 'core':
        courses = [c for c in courses if c['course_type'] == 'core']
    
    # Mark which courses the student is enrolled in
    student_id = session['student_id']
    for course in courses:
        course['is_enrolled'] = is_enrolled(student_id, course['course_id'])
    
    summary = get_enrollment_summary(student_id)
    
    return render_template(
        'courses.html', 
        courses=courses, 
        semester=semester,
        search_query=search_query,
        filter_type=filter_type,
        summary=summary
    )


# ============================================
# ENROLL IN A COURSE (Elective only via UI)
# ============================================
@courses_bp.route('/courses/enroll/<int:course_id>', methods=['POST'])
@login_required
def enroll(course_id):
    student_id = session['student_id']
    
    # Verify this is an elective course
    course = get_course_by_id(course_id)
    if not course:
        flash('Course not found.', 'danger')
        return redirect(url_for('courses.browse_courses'))
    
    if course['course_type'] == 'core':
        flash('Core courses are auto-enrolled. You cannot manually enroll in core courses.', 'warning')
        return redirect(url_for('courses.browse_courses'))
    
    # Use stored procedure for enrollment
    status, message = enroll_student(student_id, course_id, 'elective')
    
    if status == 0:
        flash(f'Successfully enrolled in {course["course_name"]}!', 'success')
    else:
        flash(message, 'danger')
    
    return redirect(url_for('courses.browse_courses'))


# ============================================
# DROP A COURSE
# ============================================
@courses_bp.route('/courses/drop/<int:course_id>', methods=['POST'])
@login_required
def drop(course_id):
    student_id = session['student_id']
    
    success, message = drop_course(student_id, course_id)
    
    if success:
        flash(message, 'success')
    else:
        flash(message, 'danger')
    
    return redirect(url_for('courses.my_courses'))


# ============================================
# VIEW ENROLLED COURSES
# ============================================
@courses_bp.route('/my-courses')
@login_required
def my_courses():
    student_id = session['student_id']
    
    enrollments = get_student_enrollments(student_id, 'active')
    summary = get_enrollment_summary(student_id)
    
    # Separate core and elective
    core_courses = [e for e in enrollments if e['enrollment_type'] == 'core']
    elective_courses = [e for e in enrollments if e['enrollment_type'] == 'elective']
    
    return render_template(
        'my_courses.html',
        core_courses=core_courses,
        elective_courses=elective_courses,
        summary=summary
    )

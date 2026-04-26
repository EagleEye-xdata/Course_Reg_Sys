from flask import Blueprint, render_template, session
from routes.auth import login_required
from models.enrollment import get_student_enrollments, get_enrollment_summary
from models.student import get_student_by_id

dashboard_bp = Blueprint('dashboard', __name__)


@dashboard_bp.route('/')
@dashboard_bp.route('/dashboard')
@login_required
def dashboard():
    student_id = session['student_id']
    
    student = get_student_by_id(student_id)
    enrollments = get_student_enrollments(student_id, 'active')
    summary = get_enrollment_summary(student_id)
    
    # Separate core and elective
    core_courses = [e for e in enrollments if e['enrollment_type'] == 'core']
    elective_courses = [e for e in enrollments if e['enrollment_type'] == 'elective']
    
    return render_template(
        'dashboard.html',
        student=student,
        core_courses=core_courses,
        elective_courses=elective_courses,
        summary=summary
    )

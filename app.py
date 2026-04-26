"""
Student Course Registration System
Flask Application — Entry Point

Features:
    - Student authentication (login/register)
    - 5 core courses auto-enrolled per semester
    - 2 elective courses chosen by student
    - SQL views, stored procedures, and triggers
    - Duplicate enrollment prevention
    - Course capacity enforcement
"""

from flask import Flask
from config import Config


def create_app():
    """Flask application factory."""
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # Register Blueprints
    from routes.auth import auth_bp
    from routes.courses import courses_bp
    from routes.dashboard import dashboard_bp
    
    app.register_blueprint(auth_bp)
    app.register_blueprint(courses_bp)
    app.register_blueprint(dashboard_bp)
    
    return app


def init_db():
    """Initialize the MySQL database with schema, views, procedures, triggers, and seed data."""
    print("\n[*] Initializing database...")
    from models.db import init_database
    init_database()
    print()


if __name__ == '__main__':
    import sys
    
    app = create_app()
    
    # Initialize DB if --init-db flag is passed or if it's the first run
    if '--init-db' in sys.argv:
        init_db()
    else:
        # Auto-init: try connecting, if DB doesn't exist, initialize
        try:
            from models.db import get_db
            conn = get_db()
            conn.close()
        except Exception:
            print("Database not found. Initializing...")
            init_db()
    
    print("[>>] Starting CourseReg Server...")
    print("     http://127.0.0.1:5000\n")
    app.run(debug=True, host='127.0.0.1', port=5000)

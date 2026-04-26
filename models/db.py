import mysql.connector
from mysql.connector import pooling
from config import Config

# Connection pool for efficient DB access
_pool = None


def get_pool():
    """Get or create the MySQL connection pool."""
    global _pool
    if _pool is None:
        _pool = pooling.MySQLConnectionPool(
            pool_name="course_reg_pool",
            pool_size=5,
            pool_reset_session=True,
            host=Config.MYSQL_HOST,
            port=Config.MYSQL_PORT,
            user=Config.MYSQL_USER,
            password=Config.MYSQL_PASSWORD,
            database=Config.MYSQL_DATABASE,
            autocommit=False
        )
    return _pool


def get_db():
    """Get a connection from the pool."""
    return get_pool().get_connection()


def execute_query(query, params=None, fetch_one=False, fetch_all=False, commit=False):
    """
    Execute a SQL query with proper connection handling.
    
    Args:
        query: SQL query string
        params: tuple of parameters for parameterized queries
        fetch_one: return single row
        fetch_all: return all rows
        commit: commit the transaction
    
    Returns:
        Query result (dict or list of dicts), or None
    """
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    result = None
    
    try:
        cursor.execute(query, params)
        
        if fetch_one:
            result = cursor.fetchone()
        elif fetch_all:
            result = cursor.fetchall()
        
        if commit:
            conn.commit()
            result = cursor.lastrowid if result is None else result
            
    except mysql.connector.Error as err:
        conn.rollback()
        raise err
    finally:
        cursor.close()
        conn.close()
    
    return result


def call_procedure(proc_name, args):
    """
    Call a stored procedure and return OUT parameters.
    
    Args:
        proc_name: Name of the stored procedure
        args: tuple of (IN/OUT parameters)
    
    Returns:
        Tuple of OUT parameter values
    """
    conn = get_db()
    cursor = conn.cursor()
    
    try:
        result_args = cursor.callproc(proc_name, args)
        conn.commit()
        return result_args
    except mysql.connector.Error as err:
        conn.rollback()
        raise err
    finally:
        cursor.close()
        conn.close()


def init_database():
    """
    Initialize the database by running schema, views, procedures, triggers, and seed SQL files.
    Uses a raw connection (not from pool) since DB may not exist yet.
    """
    import os
    
    # First connection: create database if not exists
    conn = mysql.connector.connect(
        host=Config.MYSQL_HOST,
        port=Config.MYSQL_PORT,
        user=Config.MYSQL_USER,
        password=Config.MYSQL_PASSWORD,
        autocommit=True
    )
    cursor = conn.cursor()
    
    sql_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'database')
    
    # Order matters: schema first, then views, procedures, triggers, seed
    sql_files = ['schema.sql', 'views.sql', 'procedures.sql', 'triggers.sql', 'seed.sql']
    
    for sql_file in sql_files:
        filepath = os.path.join(sql_dir, sql_file)
        if os.path.exists(filepath):
            with open(filepath, 'r') as f:
                sql_content = f.read()
            
            # For files with DELIMITER (procedures/triggers), use custom parser
            if 'DELIMITER' in sql_content:
                statements = _parse_delimiter_sql(sql_content)
                for statement in statements:
                    statement = statement.strip()
                    if statement and not _is_only_comments(statement):
                        try:
                            cursor.execute(statement)
                            # Consume any results
                            try:
                                while cursor.nextset():
                                    pass
                            except Exception:
                                pass
                        except mysql.connector.Error as err:
                            print(f"  Warning ({sql_file}): {err}")
            else:
                # For regular SQL files, split by semicolon and execute one by one
                statements = _split_sql(sql_content)
                for statement in statements:
                    statement = statement.strip()
                    if statement and not _is_only_comments(statement):
                        try:
                            cursor.execute(statement)
                            try:
                                while cursor.nextset():
                                    pass
                            except Exception:
                                pass
                        except mysql.connector.Error as err:
                            print(f"  Warning ({sql_file}): {err}")
            
            print(f"  [OK] Executed {sql_file}")
    
    cursor.close()
    conn.close()
    
    # Reset the pool since DB is now ready
    global _pool
    _pool = None
    
    print("  Database initialization complete!")


def _split_sql(sql_content):
    """
    Split SQL content by semicolons, handling comments properly.
    Does NOT handle DELIMITER — use _parse_delimiter_sql for that.
    """
    statements = []
    current = ''
    
    for line in sql_content.split('\n'):
        stripped = line.strip()
        
        # Skip pure comment lines (but keep them if part of a statement)
        if stripped.startswith('--'):
            continue
        
        # Remove inline comments
        if '--' in line:
            line = line[:line.index('--')]
        
        current += line + ' '
        
        if ';' in line:
            # Split on all semicolons in the line
            parts = current.split(';')
            for part in parts[:-1]:
                stmt = part.strip()
                if stmt:
                    statements.append(stmt)
            current = parts[-1]
    
    # Last remaining
    if current.strip():
        statements.append(current.strip())
    
    return statements


def _is_only_comments(text):
    """Check if a text block contains only SQL comments."""
    for line in text.strip().split('\n'):
        line = line.strip()
        if line and not line.startswith('--'):
            return False
    return True


def _parse_delimiter_sql(sql_content):
    """Parse SQL content that uses DELIMITER directives."""
    statements = []
    current_delimiter = ';'
    current_statement = ''
    
    for line in sql_content.split('\n'):
        stripped = line.strip()
        
        # Check for DELIMITER change
        if stripped.upper().startswith('DELIMITER'):
            parts = stripped.split()
            if len(parts) >= 2:
                # If there's a pending statement, add it
                if current_statement.strip() and not _is_only_comments(current_statement):
                    statements.append(current_statement.strip())
                current_statement = ''
                current_delimiter = parts[1]
            continue
        
        current_statement += line + '\n'
        
        # Check if current statement ends with the delimiter
        if current_statement.strip().endswith(current_delimiter):
            stmt = current_statement.strip()
            if current_delimiter != ';':
                stmt = stmt[:-len(current_delimiter)].strip()
            if stmt and not _is_only_comments(stmt):
                statements.append(stmt)
            current_statement = ''
    
    # Any remaining statement
    if current_statement.strip() and not _is_only_comments(current_statement):
        statements.append(current_statement.strip())
    
    return statements

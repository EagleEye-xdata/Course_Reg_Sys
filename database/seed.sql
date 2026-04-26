-- ============================================
-- SEED DATA — Sample Courses
-- 5 Core courses + 5 Electives per semester
-- (Showing Semester 3, CSE Department)
-- ============================================

USE course_registration;

-- ============ SEMESTER 1 ============

-- Core Courses (Semester 1)
INSERT INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS101', 'Introduction to Programming', 'Dr. Ananya Sharma', 4, 60, 1, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Fundamentals of programming using Python. Covers variables, loops, functions, and basic data structures.'),
('MA101', 'Engineering Mathematics I', 'Prof. Ramesh Gupta', 4, 60, 1, 'MATH', 'core', 'Tue/Thu 10:00-11:30', 'Differential calculus, integral calculus, and infinite series.'),
('PH101', 'Engineering Physics', 'Dr. Kavita Nair', 3, 60, 1, 'PHY', 'core', 'Mon/Wed 11:00-12:00', 'Mechanics, waves, optics, and introduction to quantum physics.'),
('EE101', 'Basic Electrical Engineering', 'Prof. Suresh Reddy', 3, 60, 1, 'ECE', 'core', 'Tue/Thu 2:00-3:30', 'DC and AC circuits, network theorems, and electrical machines.'),
('EN101', 'Technical Communication', 'Dr. Priya Mehta', 2, 60, 1, 'HUM', 'core', 'Fri 2:00-4:00', 'Technical writing, presentation skills, and professional communication.');

-- Elective Courses (Semester 1)
INSERT INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS191', 'Web Development Basics', 'Prof. Arjun Patel', 3, 40, 1, 'CSE', 'elective', 'Sat 10:00-1:00', 'Introduction to HTML, CSS, JavaScript, and responsive web design.'),
('CS192', 'Digital Logic Design', 'Dr. Meena Iyer', 3, 40, 1, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'Boolean algebra, logic gates, combinational and sequential circuits.'),
('MA191', 'Discrete Mathematics', 'Prof. Vikram Singh', 3, 40, 1, 'MATH', 'elective', 'Tue/Thu 4:00-5:30', 'Sets, relations, graph theory, and combinatorics.'),
('HU191', 'Indian Constitution & Ethics', 'Dr. Sanjay Verma', 2, 50, 1, 'HUM', 'elective', 'Sat 2:00-4:00', 'Fundamental rights, duties, governance, and professional ethics.'),
('ME191', 'Engineering Graphics', 'Prof. Deepak Kumar', 3, 40, 1, 'MECH', 'elective', 'Wed/Fri 3:00-4:30', 'Orthographic projection, isometric views, and CAD basics.');

-- ============ SEMESTER 3 ============

-- Core Courses (Semester 3)
INSERT INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS201', 'Data Structures & Algorithms', 'Dr. Rajesh Kumar', 4, 60, 3, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Arrays, linked lists, trees, graphs, sorting, and searching algorithms.'),
('CS202', 'Database Management Systems', 'Prof. Neha Agarwal', 4, 60, 3, 'CSE', 'core', 'Tue/Thu 10:00-11:30', 'Relational model, SQL, normalization, transactions, and indexing.'),
('CS203', 'Object Oriented Programming', 'Dr. Amit Joshi', 3, 60, 3, 'CSE', 'core', 'Mon/Wed 11:00-12:00', 'OOP concepts in Java — classes, inheritance, polymorphism, and design patterns.'),
('MA201', 'Probability & Statistics', 'Prof. Sunita Rao', 3, 60, 3, 'MATH', 'core', 'Tue/Thu 2:00-3:30', 'Probability distributions, hypothesis testing, regression, and statistical inference.'),
('CS204', 'Computer Organization', 'Dr. Manish Tiwari', 3, 60, 3, 'CSE', 'core', 'Fri 10:00-1:00', 'CPU architecture, memory hierarchy, instruction sets, and pipelining.');

-- Elective Courses (Semester 3)
INSERT INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS291', 'Python for Data Science', 'Prof. Ritu Sharma', 3, 40, 3, 'CSE', 'elective', 'Sat 10:00-1:00', 'NumPy, Pandas, Matplotlib, and intro to machine learning with scikit-learn.'),
('CS292', 'Linux & Shell Programming', 'Dr. Arun Menon', 3, 40, 3, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'Linux commands, bash scripting, file systems, and process management.'),
('CS293', 'Competitive Programming', 'Prof. Karan Malhotra', 2, 40, 3, 'CSE', 'elective', 'Tue 4:00-6:00', 'Problem-solving techniques, dynamic programming, greedy algorithms.'),
('CS294', 'UI/UX Design Principles', 'Dr. Sneha Kapoor', 2, 40, 3, 'CSE', 'elective', 'Thu 4:00-6:00', 'User research, wireframing, prototyping, and usability testing.'),
('HU291', 'Environmental Science', 'Prof. Geeta Bhat', 2, 50, 3, 'HUM', 'elective', 'Sat 2:00-4:00', 'Ecosystems, pollution, climate change, and sustainable development.');

-- ============ SEMESTER 5 ============

-- Core Courses (Semester 5)
INSERT INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS301', 'Operating Systems', 'Dr. Prakash Yadav', 4, 60, 5, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Process management, memory management, file systems, and synchronization.'),
('CS302', 'Computer Networks', 'Prof. Lakshmi Narayan', 4, 60, 5, 'CSE', 'core', 'Tue/Thu 10:00-11:30', 'OSI model, TCP/IP, routing, switching, and network security.'),
('CS303', 'Software Engineering', 'Dr. Pooja Saxena', 3, 60, 5, 'CSE', 'core', 'Mon/Wed 11:00-12:00', 'SDLC, agile methodology, requirements engineering, and testing.'),
('CS304', 'Theory of Computation', 'Prof. Dinesh Bhatt', 3, 60, 5, 'CSE', 'core', 'Tue/Thu 2:00-3:30', 'Automata theory, regular languages, context-free grammars, and Turing machines.'),
('CS305', 'Design & Analysis of Algorithms', 'Dr. Vivek Chauhan', 3, 60, 5, 'CSE', 'core', 'Fri 10:00-1:00', 'Advanced algorithm design, complexity analysis, NP-completeness.');

-- Elective Courses (Semester 5)
INSERT INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS391', 'Machine Learning', 'Prof. Aditi Jain', 3, 40, 5, 'CSE', 'elective', 'Sat 10:00-1:00', 'Supervised and unsupervised learning, neural networks, and model evaluation.'),
('CS392', 'Cloud Computing', 'Dr. Rohit Bansal', 3, 40, 5, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'Virtualization, AWS/GCP basics, containers, and microservices.'),
('CS393', 'Cyber Security Fundamentals', 'Prof. Harsh Pandey', 3, 40, 5, 'CSE', 'elective', 'Tue/Thu 4:00-5:30', 'Cryptography, network security, ethical hacking, and security protocols.'),
('CS394', 'Mobile App Development', 'Dr. Nisha Gupta', 3, 40, 5, 'CSE', 'elective', 'Thu 4:00-6:00', 'Android development with Kotlin, UI design, APIs, and local storage.'),
('CS395', 'Blockchain Technology', 'Prof. Tarun Sinha', 2, 40, 5, 'CSE', 'elective', 'Sat 2:00-4:00', 'Distributed ledger, consensus mechanisms, smart contracts, and Ethereum.');

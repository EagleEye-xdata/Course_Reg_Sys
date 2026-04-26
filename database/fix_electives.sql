-- ============================================
-- Elective Course Adjustment
-- - DELETE all electives from Sem 1 and Sem 8
-- - ADD courses to bring Sems 2-7 to exactly 12
-- ============================================

USE course_registration;

-- ===== REMOVE SEM 1 AND SEM 8 ELECTIVES =====
DELETE FROM courses WHERE semester = 1 AND course_type = 'elective';
DELETE FROM courses WHERE semester = 8 AND course_type = 'elective';

-- ==============================================
-- SEM 2: currently 6 → need +6 more
-- ==============================================
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS198', 'Android App Development Basics', 'Dr. Preeti Shah', 3, 40, 2, 'CSE', 'elective', 'Sat 10:00-1:00', 'Java-based Android development: activities, intents, layouts, and SQLite storage.'),
('CS199', 'Data Visualization', 'Prof. Suresh Anand', 2, 40, 2, 'CSE', 'elective', 'Mon/Wed 5:00-6:00', 'Charts, graphs, dashboards, and storytelling with data using Python and Matplotlib.'),
('HU194', 'Technical Writing & Documentation', 'Dr. Anita Rao', 2, 50, 2, 'HUM', 'elective', 'Tue 4:00-6:00', 'Writing user manuals, API docs, README files, and engineering reports.'),
('CS200', 'Version Control with Git', 'Prof. Rajiv Nair', 2, 45, 2, 'CSE', 'elective', 'Thu 4:00-6:00', 'Git fundamentals, branching strategies, merge conflicts, rebase, and GitHub workflows.'),
('EE192', 'Embedded Systems Programming', 'Dr. Ramesh Iyer', 3, 40, 2, 'ECE', 'elective', 'Fri 3:00-5:00', 'Programming ARM Cortex-M microcontrollers, timers, interrupts, and RTOS basics.'),
('CS201_2', 'Competitive Coding Basics', 'Prof. Arpit Sharma', 2, 45, 2, 'CSE', 'elective', 'Wed 5:00-7:00', 'Brute force, binary search, prefix sums, greedy, and basic dynamic programming.');

-- ==============================================
-- SEM 3: currently 8 → need +4 more
-- ==============================================
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS297', 'Introductory Machine Learning', 'Dr. Pallavi Desai', 3, 40, 3, 'CSE', 'elective', 'Mon 4:00-6:00', 'Linear regression, logistic regression, decision trees, and k-nearest neighbours using scikit-learn.'),
('CS298', 'Cloud Fundamentals (AWS/GCP)', 'Prof. Manoj Singh', 3, 40, 3, 'CSE', 'elective', 'Tue 4:00-6:00', 'Cloud service models, EC2, S3, Lambda, IAM, and hands-on deployment of a web application.'),
('CS299', 'Database Design Lab', 'Dr. Anjali Menon', 2, 40, 3, 'CSE', 'elective', 'Fri 4:00-6:00', 'Hands-on ER modelling, normalization, MySQL advanced queries, stored procedures, and triggers.'),
('HU292_3', 'Startup & Entrepreneurship Primer', 'Prof. Abhay Khare', 2, 50, 3, 'HUM', 'elective', 'Sat 2:00-4:00', 'Lean startup canvas, MVP thinking, pitching ideas, and understanding funding stages.');

-- ==============================================
-- SEM 4: currently 6 → need +6 more
-- ==============================================
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS296_4', 'Recommender Systems', 'Dr. Kavitha Rajan', 3, 40, 4, 'CSE', 'elective', 'Sat 10:00-1:00', 'Collaborative filtering, content-based filtering, matrix factorization, and Netflix Prize case study.'),
('CS297_4', 'Software Testing & QA', 'Prof. Tarun Mehta', 3, 40, 4, 'CSE', 'elective', 'Mon/Wed 5:00-6:00', 'Unit testing, Selenium automation, test planning, TDD, BDD, and defect lifecycle.'),
('CS298_4', 'DevSecOps', 'Dr. Kavitha Sharma', 2, 40, 4, 'CSE', 'elective', 'Tue 4:00-6:00', 'Integrating security in CI/CD, SAST/DAST tools, container security, and shift-left approach.'),
('CS299_4', 'Search Engine Optimisation & Analytics', 'Prof. Harsha Bhat', 2, 40, 4, 'CSE', 'elective', 'Thu 4:00-6:00', 'SEO fundamentals, Google Analytics, A/B testing, conversion funnels, and digital marketing metrics.'),
('MA203', 'Linear Algebra for Engineers', 'Dr. Geetha Pillai', 3, 45, 4, 'MATH', 'elective', 'Fri 4:00-6:00', 'Eigenvectors, SVD, PCA, linear transformations, and applications in computer graphics and ML.'),
('HU293', 'Psychology of Technology Users', 'Prof. Reshma Kaul', 2, 50, 4, 'HUM', 'elective', 'Wed 4:00-6:00', 'Cognitive load, behavioral biases, persuasive design, dark patterns, and digital well-being.');

-- ==============================================
-- SEM 5: currently 8 → need +4 more
-- ==============================================
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS399', 'Speech Processing & Recognition', 'Dr. Shilpa Verma', 3, 40, 5, 'CSE', 'elective', 'Mon 4:00-6:00', 'Acoustic models, HMMs, deep speech, wake word detection, and building a voice assistant.'),
('CS400', 'API Design & Microservices', 'Prof. Harish Goyal', 3, 40, 5, 'CSE', 'elective', 'Tue 4:00-6:00', 'RESTful API best practices, OpenAPI spec, gRPC, service decomposition, and inter-service communication.'),
('CS401_5', 'Explainable AI (XAI)', 'Dr. Nutan Rao', 2, 40, 5, 'CSE', 'elective', 'Fri 4:00-6:00', 'LIME, SHAP, feature importance, model cards, and building interpretable ML pipelines.'),
('CS402_5', 'Game Theory & Algorithmic Mechanism Design', 'Prof. Siddharth Jha', 2, 45, 5, 'MATH', 'elective', 'Wed 5:00-7:00', 'Nash equilibria, auction theory, voting mechanisms, and applications in networked systems.');

-- ==============================================
-- SEM 6: currently 6 → need +6 more
-- ==============================================
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS397_6', 'Serverless Architecture', 'Prof. Divya Reddy', 3, 40, 6, 'CSE', 'elective', 'Mon/Wed 5:00-6:00', 'AWS Lambda, Azure Functions, event-driven design, cold starts, and cost optimisation.'),
('CS398_6', 'Multi-Agent Systems', 'Dr. Nilesh Patil', 3, 40, 6, 'CSE', 'elective', 'Tue 4:00-6:00', 'Agent architectures, coordination protocols, auctions, and simulation with JADE/NetLogo.'),
('CS399_6', 'UX Research Methods', 'Prof. Shraddha Kulkarni', 2, 40, 6, 'CSE', 'elective', 'Thu 4:00-6:00', 'Interviews, surveys, usability labs, think-aloud protocols, and synthesising research insights.'),
('CS400_6', 'High-Frequency Trading Systems', 'Dr. Anuj Joshi', 2, 35, 6, 'CSE', 'elective', 'Sat 4:00-6:00', 'Low-latency programming, FIX protocol, order books, market microstructure, and backtesting.'),
('MA301', 'Stochastic Processes', 'Prof. Sneha Varma', 3, 40, 6, 'MATH', 'elective', 'Fri 4:00-6:00', 'Markov chains, Poisson processes, Brownian motion, and applications in queuing and finance.'),
('CS401_6', 'Social Network Analysis', 'Dr. Preetham Rao', 2, 40, 6, 'CSE', 'elective', 'Wed 4:00-6:00', 'Community detection, influence propagation, sentiment on Twitter, and graph-based recommendation.');

-- ==============================================
-- SEM 7: currently 6 → need +6 more
-- ==============================================
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS497', 'Advanced Compiler Techniques', 'Dr. Suhas Kamath', 3, 35, 7, 'CSE', 'elective', 'Mon/Wed 5:00-6:00', 'SSA form, loop optimisation, JIT compilation, LLVM IR, and garbage collection algorithms.'),
('CS498', 'Human-Robot Interaction', 'Prof. Lakshmi Rajan', 3, 35, 7, 'CSE', 'elective', 'Tue 4:00-6:00', 'Social robotics, gesture recognition, collaborative manipulation, and safety in HRI.'),
('CS499', 'Quantum Machine Learning', 'Dr. Amith Kapoor', 3, 35, 7, 'CSE', 'elective', 'Thu 4:00-6:00', 'Variational quantum circuits, kernel methods on quantum computers, and hybrid classical-quantum models.'),
('CS500', 'Open Source AI Tools', 'Prof. Ramya Balan', 2, 40, 7, 'CSE', 'elective', 'Fri 4:00-6:00', 'LangChain, Hugging Face ecosystem, LoRA fine-tuning, GGUF quantisation, and local LLM deployment.'),
('CS501', 'IT Audit & Compliance', 'Dr. Kiran Malviya', 2, 40, 7, 'CSE', 'elective', 'Sat 2:00-4:00', 'ISO 27001, SOC 2, GDPR compliance, audit checklists, risk registers, and incident response.'),
('CS502', 'Advanced Operating Systems', 'Prof. Umesh Dandavate', 3, 35, 7, 'CSE', 'elective', 'Wed 4:00-6:00', 'Linux kernel internals, scheduler design, memory management deep-dive, and writing kernel modules.');

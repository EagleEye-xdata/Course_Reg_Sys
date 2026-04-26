-- ============================================
-- ADDITIONAL COURSES — Semesters 2, 4, 6, 7, 8
-- + Extra electives for Sem 1, 3, 5
-- ============================================

USE course_registration;

-- ============ EXTRA ELECTIVES — SEM 1 ============
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS193', 'Introduction to Cybersecurity', 'Dr. Naveen Pillai', 2, 45, 1, 'CSE', 'elective', 'Wed 4:00-6:00', 'Overview of cyber threats, password hygiene, safe browsing, and basic network security concepts.'),
('MA192', 'Numerical Methods Basics', 'Prof. Lalita Menon', 2, 40, 1, 'MATH', 'elective', 'Thu 4:00-6:00', 'Root finding, interpolation, numerical integration, and error analysis.'),
('HU192', 'Creative Problem Solving', 'Dr. Simran Kaur', 2, 50, 1, 'HUM', 'elective', 'Fri 4:00-6:00', 'Design thinking, lateral thinking techniques, brainstorming, and innovation frameworks.');

-- ============ SEMESTER 2 ============

-- Core Courses (Semester 2)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS102', 'Data Structures', 'Dr. Rekha Pillai', 4, 60, 2, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Stacks, queues, linked lists, trees, and hash tables with applications in C.'),
('MA102', 'Engineering Mathematics II', 'Prof. Ramesh Gupta', 4, 60, 2, 'MATH', 'core', 'Tue/Thu 10:00-11:30', 'Linear algebra, vector calculus, Fourier series, and transforms.'),
('PH102', 'Engineering Chemistry', 'Dr. Sundar Rajan', 3, 60, 2, 'CHEM', 'core', 'Mon/Wed 11:00-12:00', 'Electrochemistry, corrosion, polymers, nanomaterials, and water treatment.'),
('EE102', 'Digital Electronics', 'Prof. Mohan Krishnan', 3, 60, 2, 'ECE', 'core', 'Tue/Thu 2:00-3:30', 'Number systems, combinational circuits, flip-flops, registers, and counters.'),
('EN102', 'Environmental Studies', 'Dr. Geeta Bhat', 2, 60, 2, 'HUM', 'core', 'Fri 2:00-4:00', 'Ecosystems, biodiversity, pollution, environmental laws, and sustainable development.');

-- Elective Courses (Semester 2)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS195', 'Python Programming', 'Prof. Arjun Patel', 3, 40, 2, 'CSE', 'elective', 'Sat 10:00-1:00', 'Python fundamentals: lists, dictionaries, file I/O, OOP, and standard library modules.'),
('CS196', 'Computer Hardware Essentials', 'Dr. Rakesh Sharma', 2, 40, 2, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'CPU, RAM, storage devices, motherboard components, and assembling a PC.'),
('MA193', 'Graph Theory', 'Prof. Vikram Singh', 3, 40, 2, 'MATH', 'elective', 'Tue/Thu 4:00-5:30', 'Graph representations, traversals, spanning trees, shortest paths, and network flows.'),
('HU193', 'Economics for Engineers', 'Dr. Anita Narayanan', 2, 50, 2, 'HUM', 'elective', 'Sat 2:00-4:00', 'Engineering economy, time value of money, cost-benefit analysis, and project selection.'),
('EE191', 'IoT Fundamentals', 'Prof. Chetan Mishra', 3, 40, 2, 'ECE', 'elective', 'Wed/Fri 3:00-4:30', 'Sensor networks, Arduino programming, MQTT protocol, and home automation projects.'),
('CS197', 'Game Development Basics', 'Dr. Priya Menon', 2, 35, 2, 'CSE', 'elective', 'Thu 4:00-6:00', 'Introduction to Unity, game physics, 2D sprite animation, and collision detection.');

-- ============ EXTRA ELECTIVES — SEM 3 ============
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS295', 'Open Source Contribution', 'Prof. Aditya Nair', 2, 40, 3, 'CSE', 'elective', 'Wed 4:00-6:00', 'Git workflow, GitHub pull requests, open source licenses, and contributing to real projects.'),
('CS296', 'Introduction to DevOps', 'Dr. Vikash Choudhary', 2, 40, 3, 'CSE', 'elective', 'Thu 4:00-6:00', 'CI/CD pipelines, Docker basics, automated testing, and deployment strategies.'),
('MA291', 'Operation Research', 'Prof. Sudha Goyal', 3, 40, 3, 'MATH', 'elective', 'Fri 4:00-6:00', 'Linear programming, transportation problem, game theory, and queuing theory.');

-- ============ SEMESTER 4 ============

-- Core Courses (Semester 4)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS205', 'Microprocessors & Microcontrollers', 'Dr. Ashok Tiwari', 4, 60, 4, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', '8085/8086 architecture, instruction sets, interfacing, and embedded systems programming.'),
('CS206', 'Formal Languages & Automata', 'Prof. Sheela Nair', 4, 60, 4, 'CSE', 'core', 'Tue/Thu 10:00-11:30', 'Finite automata, regular expressions, context-free grammars, and pushdown automata.'),
('CS207', 'Computer Graphics', 'Dr. Vishal Kumar', 3, 60, 4, 'CSE', 'core', 'Mon/Wed 11:00-12:00', '2D/3D transformations, rasterization, clipping, shading, and OpenGL basics.'),
('MA202', 'Numerical Analysis', 'Prof. Gauri Shankar', 3, 60, 4, 'MATH', 'core', 'Tue/Thu 2:00-3:30', 'Newton-Raphson, Runge-Kutta methods, splines, and matrix decomposition.'),
('CS208', 'Web Technologies', 'Dr. Deepa Pillai', 3, 60, 4, 'CSE', 'core', 'Fri 10:00-1:00', 'HTML5, CSS3, JavaScript ES6+, Node.js basics, REST APIs, and responsive design.');

-- Elective Courses (Semester 4)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS291_4', 'Deep Learning Foundations', 'Dr. Harish Venkat', 3, 40, 4, 'CSE', 'elective', 'Sat 10:00-1:00', 'Perceptrons, backpropagation, CNNs, RNNs, and hands-on with TensorFlow/Keras.'),
('CS292_4', 'Natural Language Processing', 'Prof. Sudha Krishnan', 3, 40, 4, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'Tokenization, stemming, TF-IDF, sentiment analysis, and language models.'),
('CS293_4', 'Full-Stack Web Development', 'Dr. Nikhil Joshi', 3, 40, 4, 'CSE', 'elective', 'Tue/Thu 4:00-5:30', 'React.js, Express.js, MongoDB, authentication, and deployment with Docker.'),
('CS294_4', 'Information Security', 'Prof. Rakesh Pandey', 3, 40, 4, 'CSE', 'elective', 'Thu 4:00-6:00', 'Public key cryptography, SSL/TLS, firewalls, intrusion detection, and OWASP top 10.'),
('HU292', 'Professional Ethics & IPR', 'Dr. Ananya Bose', 2, 50, 4, 'HUM', 'elective', 'Sat 2:00-4:00', 'Engineering ethics, intellectual property rights, patent filing, and legal frameworks.'),
('CS295_4', 'Augmented & Virtual Reality', 'Prof. Preethi Suresh', 2, 35, 4, 'CSE', 'elective', 'Wed 4:00-6:00', 'ARCore/ARKit basics, 3D scene construction, VR headsets, and XR development tools.');

-- ============ EXTRA ELECTIVES — SEM 5 ============
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS396', 'Quantum Computing Intro', 'Dr. Arjun Mehta', 2, 35, 5, 'CSE', 'elective', 'Wed 4:00-6:00', 'Qubits, superposition, quantum gates, Shor algorithm, and Qiskit basics.'),
('CS397', 'Big Data Analytics', 'Prof. Snehal Joshi', 3, 40, 5, 'CSE', 'elective', 'Thu 4:00-6:00', 'Hadoop, Spark, MapReduce, Hive, data warehousing, and visualization with Tableau.'),
('CS398', 'Computer Vision', 'Dr. Kavya Rao', 3, 40, 5, 'CSE', 'elective', 'Fri 4:00-6:00', 'Image processing, feature detection, object recognition, OpenCV, and YOLO.');

-- ============ SEMESTER 6 ============

-- Core Courses (Semester 6)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS306', 'Artificial Intelligence', 'Dr. Ravi Mohan', 4, 60, 6, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Search algorithms, knowledge representation, planning, and machine learning basics.'),
('CS307', 'Compiler Design', 'Prof. Sarala Devi', 4, 60, 6, 'CSE', 'core', 'Tue/Thu 10:00-11:30', 'Lexical analysis, parsing, semantic analysis, code generation, and optimization.'),
('CS308', 'Distributed Systems', 'Dr. Sudhir Kulkarni', 3, 60, 6, 'CSE', 'core', 'Mon/Wed 11:00-12:00', 'Distributed architectures, consistency models, Paxos/Raft, and fault tolerance.'),
('CS309', 'Information Retrieval', 'Prof. Anushka Desai', 3, 60, 6, 'CSE', 'core', 'Tue/Thu 2:00-3:30', 'Inverted index, ranking, vector space model, PageRank, and semantic search.'),
('CS310', 'Human Computer Interaction', 'Dr. Rekha Sharma', 3, 60, 6, 'CSE', 'core', 'Fri 10:00-1:00', 'Usability principles, interaction design, accessibility, and user testing.');

-- Elective Courses (Semester 6)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS391_6', 'Advanced Machine Learning', 'Dr. Prashant Wagh', 3, 40, 6, 'CSE', 'elective', 'Sat 10:00-1:00', 'Ensemble methods, gradient boosting, XGBoost, model interpretability, and ML pipelines.'),
('CS392_6', 'Kubernetes & Microservices', 'Prof. Aditya Reddy', 3, 40, 6, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'Container orchestration, service mesh, Istio, Helm charts, and CI/CD with GitOps.'),
('CS393_6', 'Ethical Hacking & Penetration Testing', 'Dr. Kiran Bajaj', 3, 40, 6, 'CSE', 'elective', 'Tue/Thu 4:00-5:30', 'Reconnaissance, exploitation, privilege escalation, Metasploit, and bug bounty.'),
('CS394_6', 'Data Engineering', 'Prof. Meena Pillai', 3, 40, 6, 'CSE', 'elective', 'Thu 4:00-6:00', 'ETL pipelines, Apache Kafka, Airflow, dbt, and data lake architectures.'),
('CS395_6', 'Bioinformatics', 'Dr. Nidhi Sehgal', 2, 35, 6, 'CSE', 'elective', 'Sat 2:00-4:00', 'DNA sequence analysis, protein structure prediction, BLAST, and genome assembly.'),
('CS396_6', 'Digital Signal Processing', 'Prof. Vikas Soni', 3, 40, 6, 'CSE', 'elective', 'Wed 4:00-6:00', 'Fourier transforms, filters, Z-transforms, speech processing, and image compression.');

-- ============ SEMESTER 7 ============

-- Core Courses (Semester 7)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS401', 'Advanced Database Systems', 'Prof. Suresh Babu', 4, 55, 7, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Query optimization, NoSQL databases, NewSQL, columnar stores, and graph databases.'),
('CS402', 'High Performance Computing', 'Dr. Madhuri Wagle', 4, 55, 7, 'CSE', 'core', 'Tue/Thu 10:00-11:30', 'GPU programming with CUDA, OpenMP, MPI, parallel algorithm design, and benchmarking.'),
('CS403', 'Software Architecture & Design', 'Prof. Rohini Bhatt', 3, 55, 7, 'CSE', 'core', 'Mon/Wed 11:00-12:00', 'Architectural patterns, microservices, event-driven systems, and domain-driven design.'),
('CS404', 'Research Methodology', 'Dr. Ajay Pathak', 2, 55, 7, 'CSE', 'core', 'Tue/Thu 2:00-3:30', 'Literature review, research design, experimental methodology, and technical paper writing.'),
('CS405', 'Major Project Phase I', 'Project Committee', 4, 55, 7, 'CSE', 'core', 'As Scheduled', 'Define project scope, literature survey, SRS document, and initial prototype development.');

-- Elective Courses (Semester 7)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS491', 'Reinforcement Learning', 'Dr. Saket Gupta', 3, 35, 7, 'CSE', 'elective', 'Sat 10:00-1:00', 'Markov decision processes, Q-learning, policy gradient, and OpenAI Gym environments.'),
('CS492', 'Edge Computing & Fog Networks', 'Prof. Divya Krishnan', 3, 35, 7, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'Edge intelligence, latency optimization, federated learning, and 5G applications.'),
('CS493', 'Formal Verification', 'Dr. Bhaskar Rao', 3, 35, 7, 'CSE', 'elective', 'Tue/Thu 4:00-5:30', 'Model checking, theorem proving, TLA+, and verifying concurrent systems.'),
('CS494', 'FinTech & Digital Payments', 'Prof. Himanshu Sethi', 2, 40, 7, 'CSE', 'elective', 'Thu 4:00-6:00', 'Payment gateways, UPI internals, digital wallets, RegTech, and cryptocurrency exchanges.'),
('CS495', 'AR/VR Application Development', 'Dr. Ananya Joshi', 3, 35, 7, 'CSE', 'elective', 'Sat 2:00-4:00', 'Unity XR toolkit, spatial audio, hand tracking, multiplayer VR, and enterprise AR.'),
('CS496', 'Network Science', 'Prof. Sunil Batra', 2, 40, 7, 'CSE', 'elective', 'Wed 4:00-6:00', 'Small-world networks, scale-free graphs, centrality measures, link prediction, and epidemic spread.');

-- ============ SEMESTER 8 ============

-- Core Courses (Semester 8)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS406', 'Major Project Phase II', 'Project Committee', 8, 55, 8, 'CSE', 'core', 'As Scheduled', 'Complete project implementation, testing, documentation, and final presentation & viva.'),
('CS407', 'Entrepreneurship & Startup Ecosystem', 'Prof. Kavita Bhargava', 3, 60, 8, 'CSE', 'core', 'Mon/Wed/Fri 9:00-10:00', 'Business models, lean startup, funding, MVP development, and pitching to investors.'),
('CS408', 'Technology Management', 'Dr. Rahul Agarwal', 3, 60, 8, 'CSE', 'core', 'Tue/Thu 10:00-11:30', 'IT governance, project management, risk assessment, and digital transformation.'),
('CS409', 'Industry Internship (6 weeks)', 'Industry Mentor', 4, 60, 8, 'CSE', 'core', 'As Scheduled', 'Six-week industry internship with a company project and final internship report.'),
('CS410', 'Professional Practice & Ethics', 'Dr. Jyothi Krishnan', 2, 60, 8, 'HUM', 'core', 'Fri 2:00-4:00', 'Professional conduct, workplace ethics, IP law, engineering standards, and career planning.');

-- Elective Courses (Semester 8)
INSERT IGNORE INTO courses (course_code, course_name, instructor, credits, max_capacity, semester, department, course_type, schedule, description)
VALUES
('CS491_8', 'Generative AI & LLMs', 'Dr. Priya Sharma', 3, 40, 8, 'CSE', 'elective', 'Sat 10:00-1:00', 'Transformers, GPT architecture, fine-tuning, RAG pipelines, prompt engineering, and LangChain.'),
('CS492_8', 'Robotics & Autonomous Systems', 'Prof. Kumar Reddy', 3, 40, 8, 'CSE', 'elective', 'Mon/Wed 3:00-4:00', 'ROS, SLAM, robot kinematics, path planning, and sensor fusion for autonomous vehicles.'),
('CS493_8', 'MLOps & Model Deployment', 'Dr. Sonali Desai', 3, 40, 8, 'CSE', 'elective', 'Tue/Thu 4:00-5:30', 'MLflow, model registries, A/B testing, drift detection, and scalable serving with FastAPI.'),
('CS494_8', 'Computational Biology', 'Prof. Narendra Jha', 2, 35, 8, 'CSE', 'elective', 'Thu 4:00-6:00', 'Gene regulatory networks, protein folding, AlphaFold, and systems biology modeling.'),
('CS495_8', 'Digital Twin Technology', 'Dr. Meera Nambiar', 2, 35, 8, 'CSE', 'elective', 'Sat 2:00-4:00', 'IoT + simulation, 3D asset synchronization, predictive maintenance, and smart manufacturing.'),
('CS496_8', 'Space Technology & Applications', 'Prof. Vijaykumar Iyer', 2, 35, 8, 'CSE', 'elective', 'Wed 4:00-6:00', 'Satellite orbits, remote sensing, GPS/GNSS internals, ground station software, and ISRO case studies.');

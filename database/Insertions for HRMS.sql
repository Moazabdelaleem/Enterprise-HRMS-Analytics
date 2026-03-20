
USE `HRMS_Project`;

-- -----------------------------------------------------
-- Level 0: Core Parent Tables
-- -----------------------------------------------------
INSERT INTO UNIVERSITY (University_ID, University_Name, Acronym, Established_Year, Address, Contact_Email, Website_URL) VALUES
(1, 'German International University', 'GIU', 2019, 'New Administrative Capital', 'info@giu.de', 'www.giu.de'),
(2, 'Cairo University', 'CU', 1908, 'Giza', 'info@cu.edu.eg', 'www.cu.edu.eg'),
(3, 'American University in Cairo', 'AUC', 1919, 'New Cairo', 'info@auc.edu', 'www.aucegypt.edu'),
(4, 'Ain Shams University', 'ASU', 1950, 'Abbassia, Cairo', 'info@asu.edu.eg', 'www.asu.edu.eg'),
(5, 'Helwan University', 'HU', 1975, 'Helwan, Cairo', 'info@helwan.edu.eg', 'www.helwan.edu.eg');

INSERT INTO DEPARTMENT (Department_ID, Department_Name, Department_Type, Location, Contact_Email) VALUES
(1, 'Business Informatics', 'Academic', 'B1.01', 'bi@giu.de'),
(2, 'Human Resources', 'Administrative', 'A1.05', 'hr@giu.de'),
(3, 'Finance', 'Administrative', 'A1.06', 'finance@giu.de'),
(4, 'Computer Science', 'Academic', 'B1.02', 'cs@giu.de'),
(5, 'Marketing', 'Academic', 'B2.01', 'marketing@giu.de'),
(6, 'IT Services', 'Administrative', 'A2.01', 'it@giu.de'),
(7, 'Admissions', 'Administrative', 'A1.01', 'admissions@giu.de');

INSERT INTO EMPLOYEE (Employee_ID, First_Name, Last_Name, Gender, DOB, Employment_Status, Work_Email) VALUES
('E1001', 'John', 'Doe', 'Male', '1995-01-01', 'Active', 'john.doe@giu.de'),
('E1002', 'Jane', 'Smith', 'Female', '1998-05-15', 'Active', 'jane.smith@giu.de'),
('E1003', 'Ahmed', 'Ali', 'Male', '1990-11-10', 'Active', 'ahmed.ali@giu.de'),
('E1004', 'Fatima', 'Zahra', 'Female', '1985-07-01', 'Probation', 'fatima.zahra@giu.de'),
('E1005', 'Chris', 'Lee', 'Male', '1999-03-03', 'Leave', 'chris.lee@giu.de'),
('E1006', 'Michael', 'Brown', 'Male', '1992-02-02', 'Active', 'michael.brown@giu.de'),
('E1007', 'Sarah', 'Wilson', 'Female', '1993-03-03', 'Active', 'sarah.wilson@giu.de'),
('E1008', 'David', 'Chen', 'Male', '1988-08-08', 'Active', 'david.chen@giu.de'),
('E1009', 'Emily', 'Wang', 'Female', '1991-09-09', 'Retired', 'emily.wang@giu.de'),
('E1010', 'Omar', 'Hassan', 'Male', '1994-04-04', 'Active', 'omar.hassan@giu.de');

INSERT INTO CONTRACT (Contract_ID, Contract_Name, Type, Work_Modality) VALUES
(1, 'Full-Time Academic Staff', 'Permanent', 'Full Time'),
(2, 'Full-Time Administrative Staff', 'Permanent', 'Full Time'),
(3, 'Part-Time Teaching Assistant', 'Temporary', 'Part Time'),
(4, 'Probationary Employee', 'Probationary', 'Full Time'),
(5, 'Internship Contract', 'Temporary', 'Flexible'),
(6, 'Fixed-Term Researcher', 'Temporary', 'Full Time');

INSERT INTO PERFORMANCE_CYCLE (Cycle_ID, Cycle_Name, Cycle_Type, Start_Date, End_Date, Submission_Deadline) VALUES
(1, 'Annual Review 2024', 'Annual', '2024-01-01', '2024-12-31', '2024-11-30'),
(2, 'Q1 2025 Probation', 'Probation', '2025-01-01', '2025-03-31', '2025-03-15'),
(3, 'Mid-Year Review 2025', 'Bi-Annual', '2025-01-01', '2025-06-30', '2025-06-15'),
(4, 'Annual Review 2025', 'Annual', '2025-01-01', '2025-12-31', '2025-11-30'),
(5, 'Q1 2024 Review', 'Quarterly', '2024-01-01', '2024-03-31', '2024-03-15'),
(6, 'Q2 2024 Review', 'Quarterly', '2024-04-01', '2024-06-30', '2024-06-15');

INSERT INTO TRAINING_PROGRAM (Program_ID, Program_Code, Title, Type, Delivery_Method, Approval_Status) VALUES
(1, 'PY-101', 'Intro to Python', 'Technical', 'Online', 'Approved'),
(2, 'LEAD-101', 'Management Essentials', 'Soft Skills', 'Classroom', 'Approved'),
(3, 'DB-201', 'Advanced SQL', 'Technical', 'Blended', 'Approved'),
(4, 'HR-100', 'HR Policies and Procedures', 'Compliance', 'Online', 'Approved'),
(5, 'SAFE-101', 'Workplace Safety', 'Compliance', 'In-Person', 'Pending'),
(6, 'EXCEL-ADV', 'Advanced Excel', 'Technical', 'Online', 'Approved');

-- -----------------------------------------------------
-- Level 1: Tables dependent on Level 0
-- -----------------------------------------------------
INSERT INTO FACULTY (Faculty_ID, Faculty_Name, Location, Contact_Email, University_ID) VALUES
(1, 'Business Informatics', 'B1', 'bi@giu.de', 1),
(2, 'Engineering', 'B2', 'eng@giu.de', 1),
(3, 'Design', 'B3', 'design@giu.de', 1),
(4, 'Faculty of Arts', 'Main Campus', 'arts@cu.edu.eg', 2),
(5, 'Faculty of Engineering', 'Main Campus', 'eng@cu.edu.eg', 2);

INSERT INTO JOB (Job_ID, Job_Code, Job_Title, Job_Level, Job_Category, Min_Salary, Max_Salary, Department_ID, Reports_To) VALUES
(1, 'PROF-BI', 'Professor BI', 'Senior', 'Academic', 15000.00, 30000.00, 1, NULL),
(2, 'TA-CS', 'Teaching Assistant CS', 'Entry', 'Academic', 5000.00, 9000.00, 4, 1),
(3, 'HR-MGR', 'HR Manager', 'Senior', 'Admin', 12000.00, 25000.00, 2, NULL),
(4, 'HR-SPEC', 'HR Specialist', 'Mid', 'Admin', 8000.00, 15000.00, 2, 3),
(5, 'FIN-ACC', 'Accountant', 'Mid', 'Admin', 7000.00, 14000.00, 3, NULL),
(6, 'IT-SUP', 'IT Support Specialist', 'Entry', 'Admin', 6000.00, 11000.00, 6, NULL),
(7, 'ADM-COORD', 'Admissions Coordinator', 'Mid', 'Admin', 7500.00, 13000.00, 7, NULL),
(8, 'MKT-PROF', 'Marketing Professor', 'Senior', 'Academic', 14000.00, 28000.00, 5, NULL),
(9, 'MKT-ASST', 'Marketing Assistant', 'Entry', 'Academic', 5500.00, 9500.00, 5, 8),
(10, 'FIN-MGR', 'Finance Manager', 'Senior', 'Admin', 14000.00, 27000.00, 3, NULL);

INSERT INTO EMPLOYEE_DISABILITY (Employee_ID, Disability_Type, Severity_Level, Required_Support) VALUES
('E1001', 'Visual Impairment', 'Mild', 'Screen reader software'),
('E1002', 'Mobility Impairment', 'Medium', 'Wheelchair access'),
('E1006', 'Hearing Impairment', 'Severe', 'Sign language interpreter'),
('E1008', 'Dyslexia', 'Mild', 'Text-to-speech software'),
('E1010', 'Mobility Impairment', 'Mild', 'Ergonomic chair');

INSERT INTO SOCIAL_INSURANCE (Employee_ID, Insurance_Number, Start_Date, Status) VALUES
('E1001', 'SN-1001', '2023-01-01', 'Active'),
('E1002', 'SN-1002', '2023-03-01', 'Active'),
('E1003', 'SN-1003', '2022-01-01', 'Active'),
('E1004', 'SN-1004', '2024-01-15', 'Active'),
('E1005', 'SN-1005', '2021-06-01', 'Active'),
('E1006', 'SN-1006', '2023-05-10', 'Active'),
('E1007', 'SN-1007', '2023-07-20', 'Active'),
('E1008', 'SN-1008', '2022-11-01', 'Active'),
('E1009', 'SN-1009', '2020-01-01', 'Active'),
('E1010', 'SN-1010', '2023-09-01', 'Active');

INSERT INTO EDUCATIONAL_QUALIFICATION (Employee_ID, Institution_Name, Major, Degree_Type) VALUES
('E1001', 'GIU', 'Business Informatics', 'BSc'),
('E1002', 'AUC', 'Computer Science', 'BSc'),
('E1003', 'Cairo University', 'Accounting', 'BComm'),
('E1004', 'Ain Shams University', 'Human Resources', 'BA'),
('E1005', 'GIU', 'Marketing', 'BSc'),
('E1006', 'Helwan University', 'IT', 'BSc'),
('E1007', 'AUC', 'Business Administration', 'MBA'),
('E1008', 'Cairo University', 'Finance', 'BComm'),
('E1009', 'GIU', 'Graphic Design', 'BSc'),
('E1010', 'Ain Shams University', 'Law', 'LLB');

INSERT INTO PROFESSIONAL_CERTIFICATE (Employee_ID, Certification_Name, Issuing_Organization, Issue_Date) VALUES
('E1003', 'CPA', 'AICPA', '2015-06-01'),
('E1004', 'SHRM-CP', 'SHRM', '2018-03-15'),
('E1006', 'CompTIA A+', 'CompTIA', '2021-01-10'),
('E1008', 'CFA Level 1', 'CFA Institute', '2019-12-20'),
('E1001', 'PMP', 'PMI', '2022-11-30');

-- -----------------------------------------------------
-- Level 2: Subtype Tables & Job Objectives
-- -----------------------------------------------------
INSERT INTO ACADEMIC_DEPARTMENT (Department_ID, Faculty_ID) VALUES
(1, 1),
(4, 2),
(5, 1);

INSERT INTO ADMINISTRATIVE_DEPARTMENT (Department_ID, University_ID) VALUES
(2, 1),
(3, 1),
(6, 1),
(7, 1);

INSERT INTO JOB_OBJECTIVE (Objective_ID, Job_ID, Objective_Title, Weight, Salary) VALUES
(1, 1, 'Publish 2 research papers', 40.00, NULL),
(2, 1, 'Supervise 3 grad projects', 30.00, NULL),
(3, 1, 'Teach DB course', 30.00, NULL),
(4, 4, 'Process 50 new hires', 50.00, NULL),
(5, 4, 'Reduce time-to-hire by 10%', 50.00, NULL),
(6, 6, 'Resolve 95% of IT tickets within 24h', 60.00, NULL),
(7, 6, 'Implement new backup system', 40.00, NULL),
(8, 8, 'Develop new digital marketing course', 50.00, NULL),
(9, 8, 'Increase student enrollment in Marketing', 50.00, NULL),
(10, 10, 'Complete EOY financial audit', 100.00, NULL);

-- -----------------------------------------------------
-- Level 3: KPIs, Assignments, Training
-- -----------------------------------------------------
INSERT INTO OBJECTIVE_KPI (KPI_ID, Objective_ID, KPI_Name, Target_Value, Weight) VALUES
(1, 1, 'Papers submitted to Q1 journals', 2.00, 100.00),
(2, 2, 'Projects completed on time', 3.00, 100.00),
(3, 4, 'New hire paperwork completion rate', 100.00, 60.00),
(4, 4, 'New hire onboarding satisfaction', 90.00, 40.00),
(5, 5, 'Avg days from posting to offer', 30.00, 100.00),
(6, 6, 'Ticket resolution time (avg hours)', 8.00, 100.00),
(7, 7, 'Backup system implementation deadline', 1.00, 100.00),
(8, 8, 'Course syllabus approval', 1.00, 100.00),
(9, 9, 'Student enrollment increase %', 15.00, 100.00),
(10, 10, 'Audit completion date', 1.00, 100.00);

INSERT INTO JOB_ASSIGNMENT (Assignment_ID, Employee_ID, Job_ID, Contract_ID, Start_Date, Status, Assigned_Salary) VALUES
(1, 'E1001', 1, 1, '2023-01-01', 'Active', 20000.00),
(2, 'E1002', 2, 3, '2023-03-01', 'Active', 7000.00),
(3, 'E1003', 3, 2, '2022-01-01', 'Active', 18000.00),
(4, 'E1004', 4, 4, '2024-01-15', 'Probation', 8000.00),
(5, 'E1005', 4, 2, '2021-06-01', 'Leave', 8500.00),
(6, 'E1006', 6, 2, '2023-05-10', 'Active', 7000.00),
(7, 'E1007', 7, 2, '2023-07-20', 'Active', 9000.00),
(8, 'E1008', 10, 2, '2022-11-01', 'Active', 20000.00),
(9, 'E1009', 9, 3, '2020-01-01', 'Active', 6000.00),
(10, 'E1010', 8, 1, '2023-09-01', 'Active', 16000.00);

INSERT INTO EMPLOYEE_TRAINING (ET_ID, Employee_ID, Program_ID, Completion_Status) VALUES
(1, 'E1001', 1, 'Completed'),
(2, 'E1001', 2, 'In Progress'),
(3, 'E1002', 1, 'Completed'),
(4, 'E1003', 2, 'Completed'),
(5, 'E1004', 4, 'In Progress'),
(6, 'E1006', 3, 'Completed'),
(7, 'E1008', 6, 'Completed'),
(8, 'E1007', 2, 'In Progress'),
(9, 'E1004', 1, 'Dropped'),
(10, 'E1010', 5, 'Completed');

-- -----------------------------------------------------
-- Level 4: Performance & Appraisals
-- -----------------------------------------------------
INSERT INTO EMPLOYEE_KPI_SCORE (Score_ID, Assignment_ID, KPI_ID, Performance_Cycle_ID, Actual_Value, Employee_Score, Weighted_Score, Reviewer_ID) VALUES
(1, 1, 1, 1, 2.00, 5.0, 5.0, 'E1003'),
(2, 1, 2, 1, 3.00, 5.0, 5.0, 'E1003'),
(3, 4, 3, 2, 95.00, 4.0, 2.4, 'E1003'),
(4, 4, 4, 2, 80.00, 3.0, 1.2, 'E1003'),
(5, 6, 6, 1, 10.00, 3.0, 3.0, 'E1003'),
(6, 8, 10, 1, 1.00, 5.0, 5.0, 'E1003'),
(7, 10, 9, 1, 10.00, 3.0, 3.0, 'E1003'),
(8, 2, 1, 1, 0.00, 2.0, 2.0, 'E1001'),
(9, 7, 3, 1, 100.00, 5.0, 3.0, 'E1003'),
(10, 7, 4, 1, 95.00, 5.0, 2.0, 'E1003');

INSERT INTO APPRAISAL (Appraisal_ID, Assignment_ID, Cycle_ID, Appraisal_Date, Overall_Score, Manager_Comments, Reviewer_ID) VALUES
(1, 1, 1, '2024-12-01', 4.8, 'Excellent research output.', 'E1003'),
(2, 2, 1, '2024-12-01', 4.0, 'Good progress, needs more initiative.', 'E1001'),
(3, 4, 2, '2025-03-20', 3.6, 'Met expectations for probation period.', 'E1003'),
(4, 3, 1, '2024-12-05', 5.0, 'Exceeds all expectations.', NULL),
(5, 5, 1, '2024-12-05', 3.0, 'Standard performance.', 'E1003'),
(6, 6, 1, '2024-12-05', 3.5, 'Good technical skills, improve communication.', 'E1003'),
(7, 7, 1, '2024-12-05', 4.5, 'Excellent coordination and teamwork.', 'E1003'),
(8, 8, 1, '2024-12-05', 4.2, 'Strong financial oversight.', NULL),
(9, 9, 1, '2024-12-05', 3.8, 'Reliable performance.', 'E1010'),
(10, 10, 1, '2024-12-05', 4.0, 'Good contributions to the new course.', NULL);

-- -----------------------------------------------------
-- Level 5: Final Dependent Tables
-- -----------------------------------------------------
INSERT INTO APPEAL (Appeal_ID, Appraisal_ID, Submission_Date, Reason, Original_Score, Approval_Status) VALUES
(1, 2, '2024-12-05', 'My contribution was higher than a 4.0.', 4.0, 'Pending'),
(2, 3, '2025-03-22', 'I believe my performance was underrated.', 3.6, 'Approved'),
(3, 5, '2024-12-10', 'Manager comments do not reflect my work.', 3.0, 'Rejected'),
(4, 6, '2024-12-08', 'Asking for re-evaluation of technical skills.', 3.5, 'Pending'),
(5, 9, '2024-12-07', 'My performance was better than 3.8.', 3.8, 'Approved');

INSERT INTO TRAINING_CERTIFICATE (Certificate_ID, ET_ID, Issue_Date, certificate_file_path) VALUES
(1, 1, '2024-03-01', '/certs/E1001-PY-101.pdf'),
(2, 3, '2024-06-01', '/certs/E1002-PY-101.pdf'),
(3, 4, '2023-01-15', '/certs/E1003-LEAD-101.pdf'),
(4, 6, '2024-01-20', '/certs/E1006-DB-201.pdf'),
(5, 7, '2023-05-05', '/certs/E1008-EXCEL-ADV.pdf'),
(6, 10, '2024-02-10', '/certs/E1010-SAFE-101.pdf');

-- =============================================================
-- Additional Insertions for HRMS Database
-- Purpose: 100+ additional rows for a more functional portal
-- Run AFTER: HRMS Tables creation.sql and Insertions for HRMS.sql
-- Employee IDs: E1011-E1050 (40 new employees)
-- =============================================================

USE `HRMS_Project`;

-- -----------------------------------------------------
-- Level 0: Core Parent Tables (Additional Data)
-- -----------------------------------------------------

-- Additional Universities (5 more, IDs 6-10)
INSERT INTO UNIVERSITY (University_Name, Acronym, Established_Year, Address, Contact_Email, Website_URL) VALUES
('British University in Egypt', 'BUE', 2005, 'El Sherouk City', 'info@bue.edu.eg', 'www.bue.edu.eg'),
('Zewail City of Science and Technology', 'ZC', 2011, 'October Gardens', 'info@zewailcity.edu.eg', 'www.zewailcity.edu.eg'),
('Nile University', 'NU', 2006, 'Sheikh Zayed City', 'info@nu.edu.eg', 'www.nu.edu.eg'),
('Future University in Egypt', 'FUE', 2006, 'New Cairo', 'info@fue.edu.eg', 'www.fue.edu.eg'),
('Egyptian Japanese University', 'EJUST', 2010, 'Borg El-Arab', 'info@ejust.edu.eg', 'www.ejust.edu.eg');

-- Additional Departments (5 more, IDs 8-12)
INSERT INTO DEPARTMENT (Department_Name, Department_Type, Location, Contact_Email) VALUES
('Research & Development', 'Academic', 'B3.01', 'rnd@giu.de'),
('Library Services', 'Administrative', 'A3.01', 'library@giu.de'),
('Legal Affairs', 'Administrative', 'A1.10', 'legal@giu.de'),
('Student Affairs', 'Administrative', 'A1.08', 'studentaffairs@giu.de'),
('Industrial Engineering', 'Academic', 'B4.01', 'ie@giu.de');

-- Additional Employees (40 more = E1011 to E1050)
INSERT INTO EMPLOYEE (Employee_ID, First_Name, Middle_Name, Last_Name, Arabic_Name, Gender, Nationality, DOB, Place_of_Birth, Marital_Status, Religion, Employment_Status, Mobile_Phone, Work_Phone, Work_Email, Personal_Email, Emergency_Contact_Name, Emergency_Contact_Phone, Residential_City, Residential_Country) VALUES
('E1011', 'Mohamed', 'Ahmed', 'Ibrahim', 'محمد أحمد إبراهيم', 'Male', 'Egyptian', '1988-03-15', 'Cairo', 'Married', 'Muslim', 'Active', '01512345678', '02-12345678', 'mohamed.ibrahim@giu.de', 'mohamed.i@gmail.com', 'Fatma Ibrahim', '01098765432', 'Cairo', 'Egypt'),
('E1012', 'Nour', NULL, 'El-Din', 'نور الدين', 'Female', 'Egyptian', '1992-07-22', 'Alexandria', 'Single', 'Muslim', 'Active', '01523456789', '02-23456789', 'nour.eldin@giu.de', 'nour.eldin@gmail.com', 'Ahmed El-Din', '01087654321', 'Alexandria', 'Egypt'),
('E1013', 'Youssef', 'Kamal', 'Mansour', 'يوسف كمال منصور', 'Male', 'Egyptian', '1985-11-03', 'Giza', 'Married', 'Muslim', 'Active', '01534567890', '02-34567890', 'youssef.mansour@giu.de', 'youssef.m@yahoo.com', 'Mona Mansour', '01076543210', 'Giza', 'Egypt'),
('E1014', 'Laila', 'Hassan', 'Mahmoud', 'ليلى حسن محمود', 'Female', 'Egyptian', '1990-05-18', 'Aswan', 'Married', 'Muslim', 'Active', '01545678901', '02-45678901', 'laila.mahmoud@giu.de', 'laila.m@hotmail.com', 'Hassan Mahmoud', '01065432109', 'Cairo', 'Egypt'),
('E1015', 'Karim', NULL, 'Samir', 'كريم سمير', 'Male', 'Egyptian', '1994-09-28', 'Luxor', 'Single', 'Muslim', 'Probation', '01556789012', '02-56789012', 'karim.samir@giu.de', 'karim.s@gmail.com', 'Samir Hassan', '01054321098', 'New Cairo', 'Egypt'),
('E1016', 'Hana', 'Ali', 'Fathy', 'هنا علي فتحي', 'Female', 'Egyptian', '1987-01-10', 'Port Said', 'Married', 'Muslim', 'Active', '01567890123', '02-67890123', 'hana.fathy@giu.de', 'hana.fathy@gmail.com', 'Ali Fathy', '01043210987', 'Madinaty', 'Egypt'),
('E1017', 'Tarek', 'Mohamed', 'Aziz', 'طارق محمد عزيز', 'Male', 'Egyptian', '1983-12-05', 'Ismailia', 'Married', 'Muslim', 'Active', '01578901234', '02-78901234', 'tarek.aziz@giu.de', 'tarek.aziz@yahoo.com', 'Fatima Aziz', '01032109876', 'Heliopolis', 'Egypt'),
('E1018', 'Mariam', NULL, 'Youssef', 'مريم يوسف', 'Female', 'Egyptian', '1991-04-20', 'Mansoura', 'Single', 'Christian', 'Active', '01589012345', '02-89012345', 'mariam.youssef@giu.de', 'mariam.y@gmail.com', 'George Youssef', '01021098765', 'Nasr City', 'Egypt'),
('E1019', 'Amr', 'Hassan', 'Khaled', 'عمرو حسن خالد', 'Male', 'Egyptian', '1989-08-14', 'Tanta', 'Married', 'Muslim', 'Leave', '01590123456', '02-90123456', 'amr.khaled@giu.de', 'amr.khaled@hotmail.com', 'Khaled Ahmed', '01010987654', 'October City', 'Egypt'),
('E1020', 'Dina', 'Sherif', 'Abbas', 'دينا شريف عباس', 'Female', 'Egyptian', '1993-02-25', 'Zagazig', 'Single', 'Muslim', 'Active', '01501234567', '02-01234567', 'dina.abbas@giu.de', 'dina.abbas@gmail.com', 'Sherif Abbas', '01009876543', 'Rehab City', 'Egypt'),
('E1021', 'Khaled', NULL, 'Mostafa', 'خالد مصطفى', 'Male', 'Egyptian', '1986-06-30', 'Suez', 'Married', 'Muslim', 'Active', '01612345678', '02-12345679', 'khaled.mostafa@giu.de', 'khaled.m@gmail.com', 'Mostafa Ali', '01198765432', 'Sheikh Zayed', 'Egypt'),
('E1022', 'Salma', 'Ahmed', 'Nabil', 'سلمى أحمد نبيل', 'Female', 'Egyptian', '1995-10-08', 'Cairo', 'Single', 'Muslim', 'Active', '01623456789', '02-23456790', 'salma.nabil@giu.de', 'salma.nabil@yahoo.com', 'Nabil Hassan', '01187654321', 'New Administrative Capital', 'Egypt'),
('E1023', 'Hesham', 'Gamal', 'Farouk', 'هشام جمال فاروق', 'Male', 'Egyptian', '1982-04-15', 'Alexandria', 'Married', 'Muslim', 'Active', '01634567890', '02-34567891', 'hesham.farouk@giu.de', 'hesham.f@gmail.com', 'Gamal Farouk', '01176543210', 'Alexandria', 'Egypt'),
('E1024', 'Rania', NULL, 'Adel', 'رانيا عادل', 'Female', 'Egyptian', '1988-12-20', 'Mahalla', 'Married', 'Christian', 'Active', '01645678901', '02-45678902', 'rania.adel@giu.de', 'rania.adel@hotmail.com', 'Adel Mikhail', '01165432109', 'Mohandessin', 'Egypt'),
('E1025', 'Mahmoud', 'Saeed', 'Omar', 'محمود سعيد عمر', 'Male', 'Egyptian', '1984-07-07', 'Cairo', 'Married', 'Muslim', 'Active', '01656789012', '02-56789013', 'mahmoud.omar@giu.de', 'mahmoud.omar@gmail.com', 'Saeed Omar', '01154321098', 'Maadi', 'Egypt'),
('E1026', 'Yasmine', 'Hany', 'Shawky', 'ياسمين هاني شوقي', 'Female', 'Egyptian', '1996-03-12', 'Damanhour', 'Single', 'Muslim', 'Probation', '01667890123', '02-67890124', 'yasmine.shawky@giu.de', 'yasmine.s@gmail.com', 'Hany Shawky', '01143210987', 'Dokki', 'Egypt'),
('E1027', 'Sherif', NULL, 'Helmy', 'شريف حلمي', 'Male', 'Egyptian', '1980-09-25', 'Fayoum', 'Married', 'Muslim', 'Active', '01678901234', '02-78901235', 'sherif.helmy@giu.de', 'sherif.helmy@yahoo.com', 'Helmy Mohamed', '01132109876', 'Zamalek', 'Egypt'),
('E1028', 'Noha', 'Magdy', 'Amin', 'نهى مجدي أمين', 'Female', 'Egyptian', '1992-01-30', 'Beni Suef', 'Single', 'Muslim', 'Active', '01689012345', '02-89012346', 'noha.amin@giu.de', 'noha.amin@gmail.com', 'Magdy Amin', '01121098765', 'Tagamoa', 'Egypt'),
('E1029', 'Wael', 'Nasser', 'Rizk', 'وائل ناصر رزق', 'Male', 'Egyptian', '1987-05-05', 'Minya', 'Married', 'Christian', 'Active', '01690123456', '02-90123457', 'wael.rizk@giu.de', 'wael.rizk@hotmail.com', 'Nasser Rizk', '01110987654', 'Shorouk City', 'Egypt'),
('E1030', 'Mona', NULL, 'Sayed', 'منى سيد', 'Female', 'Egyptian', '1990-11-18', 'Sohag', 'Married', 'Muslim', 'Active', '01701234567', '02-01234568', 'mona.sayed@giu.de', 'mona.sayed@gmail.com', 'Sayed Hassan', '01209876543', 'Obour City', 'Egypt'),
('E1031', 'Ayman', 'Fawzy', 'Sabry', 'أيمن فوزي صبري', 'Male', 'Egyptian', '1978-08-22', 'Assiut', 'Married', 'Muslim', 'Active', '01712345678', '02-12345680', 'ayman.sabry@giu.de', 'ayman.sabry@yahoo.com', 'Fawzy Sabry', '01298765432', 'Garden City', 'Egypt'),
('E1032', 'Aya', 'Hatem', 'Fouad', 'آية حاتم فؤاد', 'Female', 'Egyptian', '1997-02-14', 'Cairo', 'Single', 'Muslim', 'Active', '01723456789', '02-23456791', 'aya.fouad@giu.de', 'aya.fouad@gmail.com', 'Hatem Fouad', '01287654321', 'Nasr City', 'Egypt'),
('E1033', 'Bassem', NULL, 'Wahba', 'باسم وهبة', 'Male', 'Egyptian', '1985-06-08', 'Alexandria', 'Married', 'Christian', 'Leave', '01734567890', '02-34567892', 'bassem.wahba@giu.de', 'bassem.wahba@hotmail.com', 'Wahba George', '01276543210', 'Smouha', 'Egypt'),
('E1034', 'Farida', 'Osama', 'Talaat', 'فريدة أسامة طلعت', 'Female', 'Egyptian', '1993-09-03', 'Hurghada', 'Single', 'Muslim', 'Active', '01745678901', '02-45678903', 'farida.talaat@giu.de', 'farida.t@gmail.com', 'Osama Talaat', '01265432109', 'New Cairo', 'Egypt'),
('E1035', 'Hazem', 'Medhat', 'Barakat', 'حازم مدحت بركات', 'Male', 'Egyptian', '1981-12-12', 'Sharm El Sheikh', 'Married', 'Muslim', 'Active', '01756789012', '02-56789014', 'hazem.barakat@giu.de', 'hazem.b@yahoo.com', 'Medhat Barakat', '01254321098', 'Heliopolis', 'Egypt'),
('E1036', 'Eman', NULL, 'Hussein', 'إيمان حسين', 'Female', 'Egyptian', '1989-04-28', 'Cairo', 'Married', 'Muslim', 'Active', '01767890123', '02-67890125', 'eman.hussein@giu.de', 'eman.hussein@gmail.com', 'Hussein Ali', '01243210987', 'Maadi', 'Egypt'),
('E1037', 'Tamer', 'Ihab', 'Gaber', 'تامر إيهاب جابر', 'Male', 'Egyptian', '1986-10-16', 'Giza', 'Married', 'Muslim', 'Active', '01778901234', '02-78901236', 'tamer.gaber@giu.de', 'tamer.gaber@hotmail.com', 'Ihab Gaber', '01232109876', 'Dokki', 'Egypt'),
('E1038', 'Heba', 'Ashraf', 'Lotfy', 'هبة أشرف لطفي', 'Female', 'Egyptian', '1994-07-21', 'Kafr El Sheikh', 'Single', 'Muslim', 'Probation', '01789012345', '02-89012347', 'heba.lotfy@giu.de', 'heba.lotfy@gmail.com', 'Ashraf Lotfy', '01221098765', 'Tagamoa', 'Egypt'),
('E1039', 'Ramy', NULL, 'Hossam', 'رامي حسام', 'Male', 'Egyptian', '1983-01-07', 'Damietta', 'Married', 'Muslim', 'Active', '01790123456', '02-90123458', 'ramy.hossam@giu.de', 'ramy.hossam@yahoo.com', 'Hossam Kamel', '01210987654', 'Mohandessin', 'Egypt'),
('E1040', 'Amira', 'Waleed', 'Farag', 'أميرة وليد فرج', 'Female', 'Egyptian', '1991-05-25', 'Qena', 'Married', 'Muslim', 'Active', '01801234567', '02-01234569', 'amira.farag@giu.de', 'amira.farag@gmail.com', 'Waleed Farag', '01309876543', 'Zamalek', 'Egypt'),
('E1041', 'Ashraf', 'Gamal', 'Mokhtar', 'أشرف جمال مختار', 'Male', 'Egyptian', '1979-03-19', 'Cairo', 'Married', 'Muslim', 'Active', '01812345678', '02-12345681', 'ashraf.mokhtar@giu.de', 'ashraf.m@hotmail.com', 'Gamal Mokhtar', '01398765432', 'October City', 'Egypt'),
('E1042', 'Rana', NULL, 'Zaki', 'رنا زكي', 'Female', 'Egyptian', '1998-08-30', 'Alexandria', 'Single', 'Muslim', 'Active', '01823456789', '02-23456792', 'rana.zaki@giu.de', 'rana.zaki@gmail.com', 'Zaki Mohamed', '01387654321', 'Sheikh Zayed', 'Egypt'),
('E1043', 'Fady', 'Wagdy', 'Mikhail', 'فادي وجدي ميخائيل', 'Male', 'Egyptian', '1988-11-11', 'Minya', 'Married', 'Christian', 'Active', '01834567890', '02-34567893', 'fady.mikhail@giu.de', 'fady.mikhail@yahoo.com', 'Wagdy Mikhail', '01376543210', 'Maadi', 'Egypt'),
('E1044', 'Sara', 'Akram', 'Badawy', 'سارة أكرم بدوي', 'Female', 'Egyptian', '1995-04-04', 'Cairo', 'Single', 'Muslim', 'Active', '01845678901', '02-45678904', 'sara.badawy@giu.de', 'sara.badawy@gmail.com', 'Akram Badawy', '01365432109', 'Nasr City', 'Egypt'),
('E1045', 'Adel', NULL, 'Ragab', 'عادل رجب', 'Male', 'Egyptian', '1976-09-09', 'Giza', 'Married', 'Muslim', 'Retired', '01856789012', '02-56789015', 'adel.ragab@giu.de', 'adel.ragab@hotmail.com', 'Ragab Hassan', '01354321098', 'Giza', 'Egypt'),
('E1046', 'Nada', 'Yasser', 'Osman', 'ندى ياسر عثمان', 'Female', 'Egyptian', '1992-12-28', 'Luxor', 'Single', 'Muslim', 'Active', '01867890123', '02-67890126', 'nada.osman@giu.de', 'nada.osman@gmail.com', 'Yasser Osman', '01343210987', 'Heliopolis', 'Egypt'),
('E1047', 'Haitham', 'Reda', 'Soliman', 'هيثم رضا سليمان', 'Male', 'Egyptian', '1984-02-17', 'Tanta', 'Married', 'Muslim', 'Active', '01878901234', '02-78901237', 'haitham.soliman@giu.de', 'haitham.s@yahoo.com', 'Reda Soliman', '01332109876', 'Rehab City', 'Egypt'),
('E1048', 'Mai', NULL, 'Abdelrahman', 'مي عبدالرحمن', 'Female', 'Egyptian', '1990-06-06', 'Cairo', 'Married', 'Muslim', 'Active', '01889012345', '02-89012348', 'mai.abdelrahman@giu.de', 'mai.a@gmail.com', 'Abdelrahman Mostafa', '01321098765', 'Tagamoa', 'Egypt'),
('E1049', 'Kareem', 'Ehab', 'Darwish', 'كريم إيهاب درويش', 'Male', 'Egyptian', '1987-10-23', 'Alexandria', 'Married', 'Muslim', 'Active', '01890123456', '02-90123459', 'kareem.darwish@giu.de', 'kareem.d@hotmail.com', 'Ehab Darwish', '01310987654', 'Smouha', 'Egypt'),
('E1050', 'Hadeer', 'Mohamed', 'Salem', 'هدير محمد سالم', 'Female', 'Egyptian', '1996-01-15', 'Mansoura', 'Single', 'Muslim', 'Active', '01901234567', '02-01234570', 'hadeer.salem@giu.de', 'hadeer.salem@gmail.com', 'Mohamed Salem', '01409876543', 'New Cairo', 'Egypt');

-- Additional Contracts (3 more, IDs 7-9)
INSERT INTO CONTRACT (Contract_Name, Type, Description, Default_Duration, Work_Modality, Eligibility_Criteria) VALUES
('Visiting Professor Contract', 'Temporary', 'For visiting academic staff from partner universities', '6 Months', 'Full Time', 'PhD holder with 5+ years experience'),
('Remote Work Contract', 'Permanent', 'For employees working remotely', 'Indefinite', 'Remote', 'Strong self-management skills required'),
('Consultant Contract', 'Temporary', 'For external consultants and advisors', '3 Months', 'Flexible', 'Industry expertise required');

-- Additional Performance Cycles (4 more, IDs 7-10)
INSERT INTO PERFORMANCE_CYCLE (Cycle_Name, Cycle_Type, Start_Date, End_Date, Submission_Deadline) VALUES
('Q3 2024 Review', 'Quarterly', '2024-07-01', '2024-09-30', '2024-09-15'),
('Q4 2024 Review', 'Quarterly', '2024-10-01', '2024-12-31', '2024-12-15'),
('Mid-Year Review 2024', 'Bi-Annual', '2024-01-01', '2024-06-30', '2024-06-15'),
('Annual Review 2023', 'Annual', '2023-01-01', '2023-12-31', '2023-11-30');

-- Additional Training Programs (8 more, IDs 7-14)
INSERT INTO TRAINING_PROGRAM (Program_Code, Title, Objectives, Type, Subtype, Delivery_Method, Approval_Status) VALUES
('ML-301', 'Machine Learning Fundamentals', 'Learn ML concepts and applications', 'Technical', 'Data Science', 'Blended', 'Approved'),
('CLOUD-201', 'Cloud Computing with AWS', 'Master AWS services and deployment', 'Technical', 'Infrastructure', 'Online', 'Approved'),
('COMM-101', 'Effective Communication Skills', 'Improve verbal and written communication', 'Soft Skills', 'Communication', 'Classroom', 'Approved'),
('PROJ-201', 'Advanced Project Management', 'Learn Agile and Scrum methodologies', 'Soft Skills', 'Management', 'Blended', 'Approved'),
('CYBER-301', 'Cybersecurity Essentials', 'Understand security threats and prevention', 'Technical', 'Security', 'Online', 'Approved'),
('DATA-101', 'Data Analytics with Power BI', 'Create interactive dashboards and reports', 'Technical', 'Analytics', 'Online', 'Pending'),
('ETHICS-100', 'Business Ethics and Compliance', 'Understand ethical standards in business', 'Compliance', 'Ethics', 'Online', 'Approved'),
('TIME-101', 'Time Management and Productivity', 'Optimize work efficiency and focus', 'Soft Skills', 'Productivity', 'Classroom', 'Approved');

-- -----------------------------------------------------
-- Level 1: Tables dependent on Level 0
-- -----------------------------------------------------

-- Additional Faculties (3 more, IDs 6-8)
INSERT INTO FACULTY (Faculty_Name, Location, Contact_Email, University_ID) VALUES
('Faculty of Law', 'B5', 'law@giu.de', 1),
('Faculty of Science', 'B6', 'science@giu.de', 1),
('Faculty of Medicine', 'B7', 'medicine@giu.de', 1);

-- Additional Jobs (10 more, IDs 11-20)
INSERT INTO JOB (Job_Code, Job_Title, Job_Level, Job_Category, Job_Grade, Min_Salary, Max_Salary, Job_Description, Status, Department_ID, Reports_To) VALUES
('RND-LEAD', 'R&D Team Lead', 'Senior', 'Academic', 'A1', 18000.00, 35000.00, 'Lead research and development initiatives', 'Active', 8, NULL),
('RND-RES', 'Research Associate', 'Mid', 'Academic', 'A2', 10000.00, 18000.00, 'Conduct research and publish findings', 'Active', 8, 11),
('LIB-MGR', 'Library Manager', 'Senior', 'Admin', 'B1', 12000.00, 22000.00, 'Manage library operations and resources', 'Active', 9, NULL),
('LIB-ASST', 'Library Assistant', 'Entry', 'Admin', 'B2', 5000.00, 9000.00, 'Assist with library services and cataloging', 'Active', 9, 13),
('LEGAL-ADV', 'Legal Advisor', 'Senior', 'Admin', 'C1', 20000.00, 40000.00, 'Provide legal counsel and contract review', 'Active', 10, NULL),
('STU-COORD', 'Student Coordinator', 'Mid', 'Admin', 'D1', 8000.00, 14000.00, 'Coordinate student activities and support', 'Active', 11, NULL),
('IE-PROF', 'Industrial Engineering Professor', 'Senior', 'Academic', 'A1', 16000.00, 32000.00, 'Teach industrial engineering courses', 'Active', 12, NULL),
('IE-TA', 'Industrial Engineering TA', 'Entry', 'Academic', 'A3', 5000.00, 9000.00, 'Support teaching and lab sessions', 'Active', 12, 17),
('DATA-ANA', 'Data Analyst', 'Mid', 'Admin', 'E1', 10000.00, 18000.00, 'Analyze institutional data and create reports', 'Active', 6, NULL),
('SEC-OFF', 'Security Officer', 'Entry', 'Admin', 'F1', 4000.00, 7000.00, 'Maintain campus security', 'Active', 2, NULL);

-- Additional Employee Disabilities (5 more)
INSERT INTO EMPLOYEE_DISABILITY (Employee_ID, Disability_Type, Severity_Level, Required_Support) VALUES
('E1021', 'Color Blindness', 'Mild', 'Color-adjusted displays'),
('E1027', 'Back Injury', 'Medium', 'Standing desk and ergonomic support'),
('E1033', 'Anxiety Disorder', 'Mild', 'Flexible work hours and quiet workspace'),
('E1043', 'Carpal Tunnel Syndrome', 'Medium', 'Ergonomic keyboard and mouse'),
('E1049', 'Hearing Impairment', 'Mild', 'Hearing aid compatible phone');

-- Additional Social Insurance (30 more for new employees)
INSERT INTO SOCIAL_INSURANCE (Employee_ID, Insurance_Number, Coverage_Details, Start_Date, Status) VALUES
('E1011', 'SN-1011', 'Full medical and dental coverage', '2023-01-15', 'Active'),
('E1012', 'SN-1012', 'Standard medical coverage', '2023-04-01', 'Active'),
('E1013', 'SN-1013', 'Full medical and vision coverage', '2022-06-01', 'Active'),
('E1014', 'SN-1014', 'Family medical coverage', '2023-08-15', 'Active'),
('E1015', 'SN-1015', 'Standard medical coverage', '2024-02-01', 'Active'),
('E1016', 'SN-1016', 'Full comprehensive coverage', '2023-03-01', 'Active'),
('E1017', 'SN-1017', 'Comprehensive family coverage', '2022-01-15', 'Active'),
('E1018', 'SN-1018', 'Standard medical coverage', '2023-07-01', 'Active'),
('E1019', 'SN-1019', 'Full medical coverage', '2022-09-01', 'Active'),
('E1020', 'SN-1020', 'Standard medical coverage', '2024-01-01', 'Active'),
('E1021', 'SN-1021', 'Comprehensive family coverage', '2023-02-15', 'Active'),
('E1022', 'SN-1022', 'Standard medical coverage', '2024-03-01', 'Active'),
('E1023', 'SN-1023', 'Executive health package', '2020-06-01', 'Active'),
('E1024', 'SN-1024', 'Comprehensive family coverage', '2021-11-01', 'Active'),
('E1025', 'SN-1025', 'Full medical and dental coverage', '2022-04-01', 'Active'),
('E1026', 'SN-1026', 'Standard medical coverage', '2024-05-01', 'Active'),
('E1027', 'SN-1027', 'Executive health package', '2019-01-01', 'Active'),
('E1028', 'SN-1028', 'Standard medical coverage', '2023-10-01', 'Active'),
('E1029', 'SN-1029', 'Family medical coverage', '2022-07-01', 'Active'),
('E1030', 'SN-1030', 'Full medical coverage', '2023-05-15', 'Active'),
('E1031', 'SN-1031', 'Executive health package', '2018-01-01', 'Active'),
('E1032', 'SN-1032', 'Standard medical coverage', '2024-06-01', 'Active'),
('E1033', 'SN-1033', 'Full medical coverage', '2022-08-01', 'Active'),
('E1034', 'SN-1034', 'Standard medical coverage', '2024-04-01', 'Active'),
('E1035', 'SN-1035', 'Comprehensive family coverage', '2021-01-01', 'Active'),
('E1036', 'SN-1036', 'Full medical and vision coverage', '2023-06-01', 'Active'),
('E1037', 'SN-1037', 'Family medical coverage', '2022-03-01', 'Active'),
('E1038', 'SN-1038', 'Standard medical coverage', '2024-07-01', 'Active'),
('E1039', 'SN-1039', 'Comprehensive family coverage', '2021-05-01', 'Active'),
('E1040', 'SN-1040', 'Full medical coverage', '2023-09-01', 'Active');

-- Additional Educational Qualifications (30 more)
INSERT INTO EDUCATIONAL_QUALIFICATION (Employee_ID, Institution_Name, Major, Degree_Type) VALUES
('E1011', 'Cairo University', 'Business Administration', 'MBA'),
('E1012', 'GIU', 'Computer Science', 'BSc'),
('E1013', 'AUC', 'Mechanical Engineering', 'MSc'),
('E1014', 'Ain Shams University', 'Psychology', 'BA'),
('E1015', 'GIU', 'Information Systems', 'BSc'),
('E1016', 'Cairo University', 'Accounting', 'BComm'),
('E1017', 'AUC', 'Economics', 'PhD'),
('E1018', 'GIU', 'Media Engineering', 'BSc'),
('E1019', 'Helwan University', 'Architecture', 'BSc'),
('E1020', 'Cairo University', 'Law', 'LLB'),
('E1021', 'GIU', 'Pharmacy', 'BPharm'),
('E1022', 'AUC', 'Political Science', 'BA'),
('E1023', 'Cairo University', 'Civil Engineering', 'PhD'),
('E1024', 'Ain Shams University', 'Marketing', 'MBA'),
('E1025', 'GIU', 'Electrical Engineering', 'MSc'),
('E1026', 'GIU', 'Data Science', 'BSc'),
('E1027', 'AUC', 'Finance', 'PhD'),
('E1028', 'Cairo University', 'Chemistry', 'BSc'),
('E1029', 'Ain Shams University', 'Industrial Engineering', 'MSc'),
('E1030', 'GIU', 'Business Informatics', 'BSc'),
('E1031', 'AUC', 'Management', 'PhD'),
('E1032', 'Cairo University', 'Mathematics', 'BSc'),
('E1033', 'GIU', 'Software Engineering', 'BSc'),
('E1034', 'Ain Shams University', 'English Literature', 'BA'),
('E1035', 'Cairo University', 'Computer Engineering', 'MSc'),
('E1036', 'GIU', 'Human Resources', 'BSc'),
('E1037', 'AUC', 'Operations Management', 'MBA'),
('E1038', 'Cairo University', 'Statistics', 'BSc'),
('E1039', 'Ain Shams University', 'Public Administration', 'MPA'),
('E1040', 'GIU', 'Graphic Design', 'BSc');

-- Additional Professional Certificates (15 more)
INSERT INTO PROFESSIONAL_CERTIFICATE (Employee_ID, Certification_Name, Issuing_Organization, Issue_Date, Expiry_Date, Credential_ID) VALUES
('E1011', 'PMP', 'PMI', '2022-03-15', '2025-03-15', 'PMP-223456'),
('E1012', 'AWS Solutions Architect', 'Amazon', '2023-06-20', '2026-06-20', 'AWS-889012'),
('E1013', 'Six Sigma Black Belt', 'ASQ', '2021-09-10', NULL, 'SS-445678'),
('E1017', 'CFA Level III', 'CFA Institute', '2020-08-15', NULL, 'CFA-001234'),
('E1021', 'CISM', 'ISACA', '2022-11-30', '2025-11-30', 'CISM-667890'),
('E1023', 'PE (Professional Engineer)', 'NSPE', '2015-05-20', NULL, 'PE-223789'),
('E1025', 'Cisco CCNP', 'Cisco', '2023-02-28', '2026-02-28', 'CCNP-556123'),
('E1027', 'ACCA', 'ACCA', '2018-07-10', NULL, 'ACCA-889456'),
('E1029', 'Lean Manufacturing', 'SME', '2022-04-15', NULL, 'LM-112345'),
('E1031', 'SHRM-SCP', 'SHRM', '2019-10-05', '2025-10-05', 'SHRM-778901'),
('E1035', 'Azure Solutions Architect', 'Microsoft', '2023-08-12', '2025-08-12', 'AZURE-334567'),
('E1037', 'CSCP (Supply Chain)', 'APICS', '2021-12-01', '2024-12-01', 'CSCP-990123'),
('E1039', 'Prince2 Practitioner', 'AXELOS', '2022-06-18', '2025-06-18', 'P2-556789'),
('E1043', 'Google Cloud Professional', 'Google', '2023-09-25', '2025-09-25', 'GCP-112378'),
('E1047', 'ITIL v4 Foundation', 'AXELOS', '2023-01-10', NULL, 'ITIL-445012');

-- -----------------------------------------------------
-- Level 2: Subtype Tables & Job Objectives
-- -----------------------------------------------------

-- Additional Academic Departments
INSERT INTO ACADEMIC_DEPARTMENT (Department_ID, Faculty_ID) VALUES
(8, 2),
(12, 2);

-- Additional Administrative Departments
INSERT INTO ADMINISTRATIVE_DEPARTMENT (Department_ID, University_ID) VALUES
(9, 1),
(10, 1),
(11, 1);

-- Additional Job Objectives (15 more, IDs 11-25)
INSERT INTO JOB_OBJECTIVE (Job_ID, Objective_Title, Description, Weight, Salary) VALUES
(11, 'Lead 3 research projects', 'Successfully lead and complete research projects', 50.00, NULL),
(11, 'Publish in Q1 journals', 'Publish at least 2 papers in top-tier journals', 50.00, NULL),
(12, 'Submit 5 grant proposals', 'Write and submit research funding proposals', 60.00, NULL),
(12, 'Collaborate with industry', 'Establish 2 industry partnerships', 40.00, NULL),
(13, 'Improve library catalog system', 'Modernize and digitize library resources', 50.00, NULL),
(13, 'Increase student engagement', 'Increase library visits by 20%', 50.00, NULL),
(15, 'Review all contracts', 'Complete annual contract review', 40.00, NULL),
(15, 'Reduce legal risks', 'Implement compliance training program', 60.00, NULL),
(16, 'Organize 10 student events', 'Plan and execute student activities', 50.00, NULL),
(16, 'Improve student satisfaction', 'Achieve 85% satisfaction rating', 50.00, NULL),
(17, 'Update course curriculum', 'Align courses with industry standards', 40.00, NULL),
(17, 'Increase research output', 'Publish 3 papers annually', 60.00, NULL),
(19, 'Create BI dashboards', 'Develop 5 institutional dashboards', 60.00, NULL),
(19, 'Automate reporting', 'Reduce manual reporting by 50%', 40.00, NULL),
(3, 'Improve employee retention', 'Reduce turnover by 15%', 50.00, NULL);

-- -----------------------------------------------------
-- Level 3: KPIs, Assignments, Training
-- -----------------------------------------------------

-- Additional KPIs (10 more, IDs 11-20)
INSERT INTO OBJECTIVE_KPI (Objective_ID, KPI_Name, Description, Measurement_Unit, Target_Value, Weight) VALUES
(11, 'Research projects completed', 'Number of completed research projects', 'Count', 3.00, 100.00),
(12, 'Q1 journal publications', 'Papers published in top journals', 'Count', 2.00, 100.00),
(13, 'Grant proposals submitted', 'Number of funding proposals submitted', 'Count', 5.00, 100.00),
(14, 'Industry partnerships', 'New industry collaborations established', 'Count', 2.00, 100.00),
(15, 'Digital resources added', 'Number of digitized library items', 'Count', 500.00, 50.00),
(15, 'Library visit increase', 'Percentage increase in library visits', 'Percentage', 20.00, 50.00),
(19, 'Student events organized', 'Number of student events held', 'Count', 10.00, 100.00),
(23, 'Dashboards created', 'Number of BI dashboards deployed', 'Count', 5.00, 100.00),
(24, 'Reporting automation rate', 'Percentage of automated reports', 'Percentage', 50.00, 100.00),
(25, 'Employee turnover reduction', 'Percentage reduction in turnover', 'Percentage', 15.00, 100.00);

-- Additional Job Assignments (25 more, IDs 11-35)
INSERT INTO JOB_ASSIGNMENT (Employee_ID, Job_ID, Contract_ID, Start_Date, End_Date, Status, Assigned_Salary) VALUES
('E1011', 11, 1, '2023-01-15', NULL, 'Active', 25000.00),
('E1012', 12, 1, '2023-04-01', NULL, 'Active', 14000.00),
('E1013', 12, 1, '2022-06-01', NULL, 'Active', 16000.00),
('E1014', 16, 2, '2023-08-15', NULL, 'Active', 10000.00),
('E1015', 18, 3, '2024-02-01', NULL, 'Probation', 6000.00),
('E1016', 5, 2, '2023-03-01', NULL, 'Active', 10000.00),
('E1017', 15, 2, '2022-01-15', NULL, 'Active', 30000.00),
('E1018', 9, 3, '2023-07-01', NULL, 'Active', 7000.00),
('E1019', 12, 7, '2022-09-01', NULL, 'Leave', 15000.00),
('E1020', 14, 2, '2024-01-01', NULL, 'Active', 7000.00),
('E1021', 19, 2, '2023-02-15', NULL, 'Active', 14000.00),
('E1022', 4, 2, '2024-03-01', NULL, 'Active', 9000.00),
('E1023', 17, 1, '2020-06-01', NULL, 'Active', 28000.00),
('E1024', 8, 1, '2021-11-01', NULL, 'Active', 20000.00),
('E1025', 6, 2, '2022-04-01', NULL, 'Active', 9000.00),
('E1026', 4, 4, '2024-05-01', NULL, 'Probation', 8000.00),
('E1027', 10, 2, '2019-01-01', NULL, 'Active', 24000.00),
('E1028', 14, 2, '2023-10-01', NULL, 'Active', 6500.00),
('E1029', 17, 1, '2022-07-01', NULL, 'Active', 26000.00),
('E1030', 2, 3, '2023-05-15', NULL, 'Active', 7500.00),
('E1031', 3, 2, '2018-01-01', NULL, 'Active', 22000.00),
('E1032', 18, 3, '2024-06-01', NULL, 'Active', 6000.00),
('E1033', 6, 2, '2022-08-01', NULL, 'Leave', 8500.00),
('E1034', 7, 2, '2024-04-01', NULL, 'Active', 8000.00),
('E1035', 11, 1, '2021-01-01', NULL, 'Active', 30000.00);

-- Additional Employee Training (20 more, IDs 11-30)
INSERT INTO EMPLOYEE_TRAINING (Employee_ID, Program_ID, Completion_Status) VALUES
('E1011', 7, 'Completed'),
('E1011', 9, 'In Progress'),
('E1012', 7, 'Completed'),
('E1012', 10, 'In Progress'),
('E1013', 7, 'Completed'),
('E1014', 9, 'Completed'),
('E1015', 1, 'In Progress'),
('E1016', 6, 'Completed'),
('E1017', 2, 'Completed'),
('E1018', 1, 'Completed'),
('E1019', 10, 'Dropped'),
('E1020', 13, 'Completed'),
('E1021', 12, 'Completed'),
('E1022', 4, 'In Progress'),
('E1023', 2, 'Completed'),
('E1024', 11, 'Completed'),
('E1025', 3, 'Completed'),
('E1026', 1, 'In Progress'),
('E1027', 2, 'Completed'),
('E1028', 3, 'In Progress');

-- -----------------------------------------------------
-- Level 4: Performance & Appraisals
-- -----------------------------------------------------

-- Additional KPI Scores (15 more, IDs 11-25)
INSERT INTO EMPLOYEE_KPI_SCORE (Assignment_ID, KPI_ID, Performance_Cycle_ID, Actual_Value, Employee_Score, Weighted_Score, Reviewer_ID, Comments, Review_Date) VALUES
(11, 11, 1, 3.00, 5.0, 5.0, 'E1003', 'Excellent research leadership', '2024-12-01'),
(12, 12, 1, 2.00, 5.0, 5.0, 'E1011', 'Met publication targets', '2024-12-01'),
(13, 12, 1, 1.00, 3.0, 3.0, 'E1011', 'Needs to increase output', '2024-12-01'),
(17, 19, 1, 12.00, 5.0, 5.0, 'E1003', 'Exceeded event targets', '2024-12-01'),
(21, 20, 1, 6.00, 4.0, 4.0, 'E1003', 'Good dashboard development', '2024-12-01'),
(23, 17, 1, 3.00, 5.0, 5.0, 'E1011', 'Excellent teaching performance', '2024-12-01'),
(24, 9, 1, 18.00, 5.0, 5.0, 'E1010', 'Exceeded enrollment targets', '2024-12-01'),
(27, 10, 1, 1.00, 5.0, 5.0, 'E1003', 'Audit completed on time', '2024-12-01'),
(29, 17, 1, 2.00, 4.0, 4.0, 'E1011', 'Good research progress', '2024-12-01'),
(31, 3, 1, 100.00, 5.0, 3.0, 'E1017', 'Perfect paperwork completion', '2024-12-01'),
(35, 11, 1, 4.00, 5.0, 5.0, 'E1003', 'Outstanding research output', '2024-12-01'),
(14, 19, 2, 8.00, 4.0, 4.0, 'E1003', 'Good coordination progress', '2025-03-15'),
(15, 1, 2, 0.00, 2.0, 2.0, 'E1023', 'Needs improvement in research', '2025-03-15'),
(22, 4, 1, 92.00, 5.0, 2.0, 'E1003', 'High onboarding satisfaction', '2024-12-01'),
(26, 4, 2, 85.00, 4.0, 1.6, 'E1003', 'Good progress in probation', '2025-03-15');

-- Additional Appraisals (15 more, IDs 11-25)
INSERT INTO APPRAISAL (Assignment_ID, Cycle_ID, Appraisal_Date, Overall_Score, Manager_Comments, HR_Comments, Employee_Comments, Reviewer_ID) VALUES
(11, 1, '2024-12-05', 4.9, 'Outstanding research leadership and team management.', 'Excellent performer, recommend for promotion.', 'Happy with the evaluation.', 'E1003'),
(12, 1, '2024-12-05', 4.5, 'Strong research output and collaboration.', 'Meets all expectations.', 'Looking forward to new challenges.', 'E1011'),
(13, 1, '2024-12-05', 3.8, 'Good work but needs more publications.', 'Recommend additional training.', 'Will work on improving.', 'E1011'),
(14, 1, '2024-12-05', 4.2, 'Excellent student coordination skills.', 'Very reliable employee.', 'Enjoy working with students.', 'E1003'),
(15, 2, '2025-03-20', 3.2, 'Meeting basic expectations during probation.', 'Continue monitoring progress.', 'Learning a lot.', 'E1023'),
(17, 1, '2024-12-05', 4.8, 'Exceptional legal advisory services.', 'Critical asset to the university.', 'Proud of contributions.', 'E1003'),
(21, 1, '2024-12-05', 4.4, 'Great analytical skills and dashboard creation.', 'Strong technical abilities.', 'Enjoying the data work.', 'E1003'),
(23, 1, '2024-12-05', 5.0, 'World-class research and teaching.', 'Top performer in engineering.', 'Grateful for recognition.', 'E1011'),
(24, 1, '2024-12-05', 4.6, 'Strong marketing leadership.', 'Excellent enrollment results.', 'Team effort made this possible.', 'E1010'),
(27, 1, '2024-12-05', 4.7, 'Excellent financial management.', 'Highly recommend for senior role.', 'Ready for more responsibility.', 'E1003'),
(29, 1, '2024-12-05', 4.3, 'Good research contributions.', 'Solid performer.', 'Will continue improving.', 'E1011'),
(31, 1, '2024-12-05', 4.8, 'Outstanding HR leadership.', 'Key driver of HR initiatives.', 'Thankful for the team.', 'E1017'),
(35, 1, '2024-12-05', 5.0, 'Exceptional research achievements.', 'Top researcher in the university.', 'Honored by this evaluation.', 'E1003'),
(22, 1, '2024-12-05', 4.0, 'Good HR support work.', 'Meeting expectations.', 'Learning valuable skills.', 'E1031'),
(26, 2, '2025-03-20', 3.5, 'Satisfactory probation performance.', 'Recommend extending probation.', 'Will work harder.', 'E1003');

-- -----------------------------------------------------
-- Level 5: Final Dependent Tables
-- -----------------------------------------------------

-- Additional Appeals (5 more, IDs 6-10)
INSERT INTO APPEAL (Appraisal_ID, Submission_Date, Reason, Original_Score, Approval_Status, appeal_outcome_Score) VALUES
(13, '2024-12-08', 'My publications were not counted correctly.', 3.8, 'Approved', 4.2),
(15, '2025-03-22', 'Additional achievements were not considered.', 3.2, 'Pending', NULL),
(22, '2024-12-10', 'I believe my contribution deserves higher rating.', 4.0, 'Rejected', NULL),
(24, '2024-12-15', 'Second appeal for reconsideration.', 4.6, 'Pending', NULL),
(25, '2025-03-25', 'Requesting re-evaluation of probation score.', 3.5, 'Pending', NULL);

-- Additional Training Certificates (10 more, IDs 7-16)
INSERT INTO TRAINING_CERTIFICATE (ET_ID, Issue_Date, certificate_file_path) VALUES
(11, '2024-05-15', '/certs/E1011-ML-301.pdf'),
(13, '2024-06-20', '/certs/E1012-ML-301.pdf'),
(14, '2024-07-10', '/certs/E1013-ML-301.pdf'),
(15, '2024-04-25', '/certs/E1014-COMM-101.pdf'),
(17, '2023-08-30', '/certs/E1016-EXCEL-ADV.pdf'),
(18, '2022-11-15', '/certs/E1017-LEAD-101.pdf'),
(19, '2024-03-20', '/certs/E1018-PY-101.pdf'),
(21, '2023-12-10', '/certs/E1020-ETHICS-100.pdf'),
(22, '2024-01-25', '/certs/E1021-DATA-101.pdf'),
(24, '2022-09-05', '/certs/E1023-LEAD-101.pdf');

-- =============================================================
-- Summary of Additional Insertions:
-- =============================================================
-- Universities: +5 (Total: 10)
-- Departments: +5 (Total: 12)
-- Employees: +40 (E1011-E1050) (Total: 50)
-- Contracts: +3 (Total: 9)
-- Performance Cycles: +4 (Total: 10)
-- Training Programs: +8 (Total: 14)
-- Faculties: +3 (Total: 8)
-- Jobs: +10 (Total: 20)
-- Employee Disabilities: +5 (Total: 10)
-- Social Insurance: +30 (Total: 40)
-- Educational Qualifications: +30 (Total: 40)
-- Professional Certificates: +15 (Total: 20)
-- Academic Departments: +2 (Total: 5)
-- Administrative Departments: +3 (Total: 7)
-- Job Objectives: +15 (Total: 25)
-- Objective KPIs: +10 (Total: 20)
-- Job Assignments: +25 (Total: 35)
-- Employee Training: +20 (Total: 30)
-- KPI Scores: +15 (Total: 25)
-- Appraisals: +15 (Total: 25)
-- Appeals: +5 (Total: 10)
-- Training Certificates: +10 (Total: 16)
-- =============================================================
-- GRAND TOTAL: 236 additional rows across all tables
-- =============================================================

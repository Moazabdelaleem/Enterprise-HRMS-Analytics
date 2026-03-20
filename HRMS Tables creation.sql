-- Drop the database if it exists to start fresh, then create and use it.
DROP DATABASE IF EXISTS `HRMS_Project`;
CREATE DATABASE `HRMS_Project` DEFAULT CHARACTER SET utf8mb4;
USE `HRMS_Project`;

-- -----------------------------------------------------
-- Level 0: Core Parent Tables
-- -----------------------------------------------------

CREATE TABLE UNIVERSITY (
    University_ID INT PRIMARY KEY AUTO_INCREMENT,
    University_Name VARCHAR(100) NOT NULL,
    Acronym VARCHAR(20),
    Established_Year YEAR,
    Accreditation_Body VARCHAR(100),
    Address VARCHAR(255),
    Contact_Email VARCHAR(100),
    Website_URL VARCHAR(255)
);

CREATE TABLE DEPARTMENT (
    Department_ID INT PRIMARY KEY AUTO_INCREMENT,
    Department_Name VARCHAR(100) NOT NULL,
    Department_Type VARCHAR(50),
    Location VARCHAR(100),
    Contact_Email VARCHAR(100),
    -- CHECK Constraint 1
    CONSTRAINT chk_dept_type CHECK (Department_Type IN ('Academic', 'Administrative'))
);

CREATE TABLE EMPLOYEE (
    Employee_ID VARCHAR(20) PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Middle_Name VARCHAR(50),
    Last_Name VARCHAR(50) NOT NULL,
    Arabic_Name VARCHAR(150),
    Gender VARCHAR(10),
    Nationality VARCHAR(50),
    DOB DATE,
    Place_of_Birth VARCHAR(100),
    Marital_Status VARCHAR(20),
    Religion VARCHAR(20),
    Employment_Status VARCHAR(20) DEFAULT 'Active',
    Mobile_Phone VARCHAR(20),
    Work_Phone VARCHAR(20),
    Work_Email VARCHAR(100) UNIQUE,
    Personal_Email VARCHAR(100) UNIQUE,
    Emergency_Contact_Name VARCHAR(100),
    Emergency_Contact_Phone VARCHAR(20),
    Emergency_Contact_Relationship VARCHAR(50),
    Residential_City VARCHAR(100),
    Residential_Area VARCHAR(100),
    Residential_Street VARCHAR(255),
    Residential_Country VARCHAR(50),
    Permanent_City VARCHAR(100),
    Permanent_Area VARCHAR(100),
    Permanent_Street VARCHAR(255),
    Permanent_Country VARCHAR(50),
    Medical_Clearance_Status TINYINT(1),
    Criminal_Status TINYINT(1),
     -- check employee status
    CONSTRAINT chk_emp_status CHECK (Employment_Status IN ('Active', 'Probation', 'Leave', 'Retired')),
    -- check gender
    CONSTRAINT chk_gender CHECK (Gender IN ('Male', 'Female'))
);

CREATE TABLE CONTRACT (
    Contract_ID INT PRIMARY KEY AUTO_INCREMENT,
    Contract_Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    Description TEXT,
    Default_Duration VARCHAR(50),
    Work_Modality VARCHAR(50),
    Eligibility_Criteria TEXT,
    -- CHECK type of contract
    CONSTRAINT chk_contract_type CHECK (Type IN ('Permanent', 'Probationary', 'Temporary'))
);

CREATE TABLE PERFORMANCE_CYCLE (
    Cycle_ID INT PRIMARY KEY AUTO_INCREMENT,
    Cycle_Name VARCHAR(100) NOT NULL,
    Cycle_Type VARCHAR(50),
    Start_Date DATE,
    End_Date DATE,
    Submission_Deadline DATE,
    -- CHECK start date is before end date
    CONSTRAINT chk_cycle_dates CHECK (Start_Date <= End_Date)
);

CREATE TABLE TRAINING_PROGRAM (
    Program_ID INT PRIMARY KEY AUTO_INCREMENT,
    Program_Code VARCHAR(20) NOT NULL UNIQUE,
    Title VARCHAR(100) NOT NULL,
    Objectives TEXT,
    Type VARCHAR(50),
    Subtype VARCHAR(50),
    Delivery_Method VARCHAR(50),
    Approval_Status VARCHAR(50),
    -- CHECK training program status
    CONSTRAINT chk_train_approve CHECK (Approval_Status IN ('Pending', 'Approved', 'Rejected'))
);

-- -----------------------------------------------------
-- Level 1: Tables dependent on Level 0
-- -----------------------------------------------------

CREATE TABLE FACULTY (
    Faculty_ID INT PRIMARY KEY AUTO_INCREMENT,
    Faculty_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Contact_Email VARCHAR(100),
    University_ID INT NULL,
    FOREIGN KEY (University_ID) REFERENCES UNIVERSITY(University_ID) ON DELETE SET NULL
);

CREATE TABLE JOB (
    Job_ID INT PRIMARY KEY AUTO_INCREMENT,
    Job_Code VARCHAR(20) NOT NULL UNIQUE,
    Job_Title VARCHAR(100) NOT NULL,
    Job_Level VARCHAR(50),
    Job_Category VARCHAR(50),
    Job_Grade VARCHAR(10),
    Min_Salary DECIMAL(10, 2),
    Max_Salary DECIMAL(10, 2),
    Job_Description TEXT,
    Status VARCHAR(20) DEFAULT 'Active',
    Department_ID INT NULL,
    Reports_To INT NULL,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID) ON DELETE SET NULL,
    FOREIGN KEY (Reports_To) REFERENCES JOB(Job_ID) ON DELETE SET NULL,
    -- CHECK the level of the job title
    CONSTRAINT chk_job_level CHECK (Job_Level IN ('Entry', 'Mid', 'Senior', 'Executive')),
    -- CHECK the salary range where the minimum is bigger than 0 and less than the maximum
    CONSTRAINT chk_salary CHECK (Min_Salary <= Max_Salary AND Min_Salary > 0)
);

CREATE TABLE EMPLOYEE_DISABILITY (
    Disability_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID VARCHAR(20) NULL,
    Disability_Type VARCHAR(100),
    Severity_Level VARCHAR(50),
    Required_Support TEXT,
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL,
    -- CHECK how severe is the disability
    CONSTRAINT chk_severity CHECK (Severity_Level IN ('Mild', 'Medium', 'Severe'))
);

CREATE TABLE SOCIAL_INSURANCE (
    Insurance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID VARCHAR(20) NULL UNIQUE,
    Insurance_Number VARCHAR(50) NOT NULL UNIQUE,
    Coverage_Details TEXT,
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL
);

CREATE TABLE EDUCATIONAL_QUALIFICATION (
    Qualification_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID VARCHAR(20) NULL,
    Institution_Name VARCHAR(100),
    Major VARCHAR(100),
    Degree_Type VARCHAR(100),
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL
);

CREATE TABLE PROFESSIONAL_CERTIFICATE (
    Certificate_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID VARCHAR(20) NULL,
    Certification_Name VARCHAR(100),
    Issuing_Organization VARCHAR(100),
    Issue_Date DATE,
    Expiry_Date DATE,
    Credential_ID VARCHAR(100),
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Level 2: Subtype Tables & Job Objectives
-- -----------------------------------------------------

CREATE TABLE ACADEMIC_DEPARTMENT (
    Department_ID INT PRIMARY KEY,
    Faculty_ID INT NULL,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID) ON DELETE CASCADE,
    FOREIGN KEY (Faculty_ID) REFERENCES FACULTY(Faculty_ID) ON DELETE SET NULL
);

CREATE TABLE ADMINISTRATIVE_DEPARTMENT (
    Department_ID INT PRIMARY KEY,
    University_ID INT NULL,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID) ON DELETE CASCADE,
    FOREIGN KEY (University_ID) REFERENCES UNIVERSITY(University_ID) ON DELETE SET NULL
);

CREATE TABLE JOB_OBJECTIVE (
    Objective_ID INT PRIMARY KEY AUTO_INCREMENT,
    Job_ID INT NULL,
    Objective_Title VARCHAR(255) NOT NULL,
    Description TEXT,
    Weight DECIMAL(5, 2),
    Salary DECIMAL(10, 2),
    FOREIGN KEY (Job_ID) REFERENCES JOB(Job_ID) ON DELETE SET NULL,
    -- CHECK the objective weight is on scale 0:100
    CONSTRAINT chk_obj_weight CHECK (Weight BETWEEN 0 AND 100)
);

-- -----------------------------------------------------
-- Level 3: KPIs, Assignments, Training
-- -----------------------------------------------------

CREATE TABLE OBJECTIVE_KPI (
    KPI_ID INT PRIMARY KEY AUTO_INCREMENT,
    Objective_ID INT NULL,
    KPI_Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Measurement_Unit VARCHAR(50),
    Target_Value DECIMAL(10, 2),
    Weight DECIMAL(5, 2),
    FOREIGN KEY (Objective_ID) REFERENCES JOB_OBJECTIVE(Objective_ID) ON DELETE SET NULL,
    -- CHECK the wieght of the KPI is from 0:100
    CONSTRAINT chk_kpi_weight CHECK (Weight BETWEEN 0 AND 100)
);

CREATE TABLE JOB_ASSIGNMENT (
    Assignment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID VARCHAR(20) NULL,
    Job_ID INT NULL,
    Contract_ID INT NULL,
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    Assigned_Salary DECIMAL(10, 2),
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL,
    FOREIGN KEY (Job_ID) REFERENCES JOB(Job_ID) ON DELETE SET NULL,
    FOREIGN KEY (Contract_ID) REFERENCES CONTRACT(Contract_ID) ON DELETE SET NULL
);

CREATE TABLE EMPLOYEE_TRAINING (
    ET_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID VARCHAR(20) NULL,
    Program_ID INT NULL,
    Completion_Status VARCHAR(50) DEFAULT 'In Progress',
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL,
    FOREIGN KEY (Program_ID) REFERENCES TRAINING_PROGRAM(Program_ID) ON DELETE SET NULL,
    -- CHECK the status of the training for employees 
    CONSTRAINT chk_et_status CHECK (Completion_Status IN ('In Progress', 'Completed', 'Dropped'))
);

-- -----------------------------------------------------
-- Level 4: Performance & Appraisals
-- -----------------------------------------------------

CREATE TABLE EMPLOYEE_KPI_SCORE (
    Score_ID INT PRIMARY KEY AUTO_INCREMENT,
    Assignment_ID INT NULL,
    KPI_ID INT NULL,
    Performance_Cycle_ID INT NULL,
    Actual_Value DECIMAL(10, 2),
    Employee_Score DECIMAL(5, 2),
    Weighted_Score DECIMAL(5, 2),
    Reviewer_ID VARCHAR(20) NULL,
    Comments TEXT,
    Review_Date DATE,
    FOREIGN KEY (Assignment_ID) REFERENCES JOB_ASSIGNMENT(Assignment_ID) ON DELETE SET NULL,
    FOREIGN KEY (KPI_ID) REFERENCES OBJECTIVE_KPI(KPI_ID) ON DELETE SET NULL,
    FOREIGN KEY (Performance_Cycle_ID) REFERENCES PERFORMANCE_CYCLE(Cycle_ID) ON DELETE SET NULL,
    FOREIGN KEY (Reviewer_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL,
    -- CHECK employees can score a kpi between 1 and 5
    CONSTRAINT chk_kpi_score CHECK (Employee_Score BETWEEN 1 AND 5)
);

CREATE TABLE APPRAISAL (
    Appraisal_ID INT PRIMARY KEY AUTO_INCREMENT,
    Assignment_ID INT NULL,
    Cycle_ID INT NULL,
    Appraisal_Date DATE,
    Overall_Score DECIMAL(5, 2),
    Manager_Comments TEXT,
    HR_Comments TEXT,
    Employee_Comments TEXT,
    Reviewer_ID VARCHAR(20) NULL,
    FOREIGN KEY (Assignment_ID) REFERENCES JOB_ASSIGNMENT(Assignment_ID) ON DELETE SET NULL,
    FOREIGN KEY (Cycle_ID) REFERENCES PERFORMANCE_CYCLE(Cycle_ID) ON DELETE SET NULL,
    FOREIGN KEY (Reviewer_ID) REFERENCES EMPLOYEE(Employee_ID) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- Level 5: Final Dependent Tables
-- -----------------------------------------------------

CREATE TABLE APPEAL (
    Appeal_ID INT PRIMARY KEY AUTO_INCREMENT,
    Appraisal_ID INT NULL UNIQUE,
    Submission_Date DATE,
    Reason TEXT,
    Original_Score DECIMAL(5, 2),
    Approval_Status VARCHAR(50) DEFAULT 'Pending',
    appeal_outcome_Score DECIMAL(5, 2),
    FOREIGN KEY (Appraisal_ID) REFERENCES APPRAISAL(Appraisal_ID) ON DELETE SET NULL,
    -- CHECK the appeal status whther pending,approved, or rejected
    CONSTRAINT chk_appeal_status CHECK (Approval_Status IN ('Pending', 'Approved', 'Rejected'))
);

CREATE TABLE TRAINING_CERTIFICATE (
    Certificate_ID INT PRIMARY KEY AUTO_INCREMENT,
    ET_ID INT NULL UNIQUE,
    Issue_Date DATE,
    certificate_file_path VARCHAR(255),
    FOREIGN KEY (ET_ID) REFERENCES EMPLOYEE_TRAINING(ET_ID) ON DELETE SET NULL
);

Select *
from EMPLOYEE_TRAINING;
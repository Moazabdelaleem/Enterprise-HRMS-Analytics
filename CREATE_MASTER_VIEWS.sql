-- ========================================
-- HRMS Power BI - Master Dimension Views (CORRECTED)
-- Database: HRMS_Project
-- ========================================

USE HRMS_Project;

-- 1. Master Employee Dimension (Central Hub)
CREATE OR REPLACE VIEW vw_EmployeeMaster AS
SELECT DISTINCT
    e.Employee_ID,
    e.First_Name,
    e.Last_Name,
    e.Work_Email,
    e.Mobile_Phone,
    e.Employment_Status,
    
    -- Department Info
    d.Department_Name,
    d.Department_ID,
    
    -- Job Info (from current assignment)
    ja.Job_ID,
    j.Job_Title,
    j.Job_Category,
    j.Job_Level,
    ja.Assigned_Salary,
    
    -- Personal Info
    e.Gender,
    e.DOB AS Date_of_Birth,
    TIMESTAMPDIFF(YEAR, e.DOB, CURDATE()) AS Age,
    e.Nationality,
    e.Marital_Status
    
FROM EMPLOYEE e
LEFT JOIN JOB_ASSIGNMENT ja ON e.Employee_ID = ja.Employee_ID 
    AND ja.End_Date IS NULL  -- Only current assignment
LEFT JOIN JOB j ON ja.Job_ID = j.Job_ID
LEFT JOIN DEPARTMENT d ON j.Department_ID = d.Department_ID;


-- 2. Enhanced Gender Distribution (with Employee link)
CREATE OR REPLACE VIEW vw_GenderDistribution_Enhanced AS
SELECT 
    e.Employee_ID,
    e.Gender,
    j.Department_ID,
    d.Department_Name
FROM EMPLOYEE e
LEFT JOIN JOB_ASSIGNMENT ja ON e.Employee_ID = ja.Employee_ID AND ja.End_Date IS NULL
LEFT JOIN JOB j ON ja.Job_ID = j.Job_ID
LEFT JOIN DEPARTMENT d ON j.Department_ID = d.Department_ID;


-- 3. Enhanced Employment Status (with Employee link)
CREATE OR REPLACE VIEW vw_EmploymentStatus_Enhanced AS
SELECT 
    e.Employee_ID,
    e.Employment_Status,
    j.Department_ID,
    d.Department_Name
FROM EMPLOYEE e
LEFT JOIN JOB_ASSIGNMENT ja ON e.Employee_ID = ja.Employee_ID AND ja.End_Date IS NULL
LEFT JOIN JOB j ON ja.Job_ID = j.Job_ID
LEFT JOIN DEPARTMENT d ON j.Department_ID = d.Department_ID;


-- 4. Department Dimension Table
CREATE OR REPLACE VIEW vw_DepartmentDimension AS
SELECT 
    d.Department_ID,
    d.Department_Name,
    d.Department_Type,
    d.Location,
    COUNT(DISTINCT e.Employee_ID) AS Employee_Count
FROM DEPARTMENT d
LEFT JOIN JOB j ON d.Department_ID = j.Department_ID
LEFT JOIN JOB_ASSIGNMENT ja ON j.Job_ID = ja.Job_ID AND ja.End_Date IS NULL
LEFT JOIN EMPLOYEE e ON ja.Employee_ID = e.Employee_ID
GROUP BY d.Department_ID, d.Department_Name, d.Department_Type, d.Location;


-- 5. Job Dimension Table
CREATE OR REPLACE VIEW vw_JobDimension AS
SELECT 
    j.Job_ID,
    j.Job_Code,
    j.Job_Title,
    j.Job_Category,
    j.Job_Level,
    j.Job_Grade,
    j.Min_Salary,
    j.Max_Salary,
    j.Department_ID,
    COUNT(DISTINCT ja.Employee_ID) AS Current_Employees
FROM JOB j
LEFT JOIN JOB_ASSIGNMENT ja ON j.Job_ID = ja.Job_ID AND ja.End_Date IS NULL
GROUP BY j.Job_ID, j.Job_Code, j.Job_Title, j.Job_Category, j.Job_Level, 
         j.Job_Grade, j.Min_Salary, j.Max_Salary, j.Department_ID;


-- ========================================
-- Verification Queries
-- ========================================

-- Test the master view
SELECT COUNT(*) AS Total_Records FROM vw_EmployeeMaster;

-- Check for NULL departments (should be minimal)
SELECT COUNT(*) AS Employees_Without_Department 
FROM vw_EmployeeMaster 
WHERE Department_ID IS NULL;

-- Verify relationships
SELECT 
    COUNT(DISTINCT Employee_ID) AS Unique_Employees,
    COUNT(DISTINCT Department_ID) AS Unique_Departments,
    COUNT(DISTINCT Job_ID) AS Unique_Jobs
FROM vw_EmployeeMaster;

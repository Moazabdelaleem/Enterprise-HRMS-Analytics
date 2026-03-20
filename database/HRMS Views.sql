
USE `HRMS_Project`;

-- -----------------------------------------------------
-- 1. Workforce Views
-- -----------------------------------------------------

-- 1. Employee count by department
CREATE OR REPLACE VIEW vw_EmployeeCountByDept AS
SELECT d.Department_Name, COUNT(ja.Employee_ID) AS Employee_Count
FROM DEPARTMENT d
LEFT JOIN JOB j ON d.Department_ID = j.Department_ID
LEFT JOIN JOB_ASSIGNMENT ja ON j.Job_ID = ja.Job_ID AND ja.Status = 'Active'
GROUP BY d.Department_Name;

-- 2. Gender distribution
CREATE OR REPLACE VIEW vw_GenderDistribution AS
SELECT Gender, COUNT(*) AS Count, 
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM EMPLOYEE)) AS Percentage
FROM EMPLOYEE
GROUP BY Gender;

-- 3. Employment status distribution
CREATE OR REPLACE VIEW vw_EmploymentStatusDist AS
SELECT Employment_Status, COUNT(*) AS Count
FROM EMPLOYEE
GROUP BY Employment_Status;

-- -----------------------------------------------------
-- 2. Job Structure Views
-- -----------------------------------------------------

-- 4. Jobs grouped by job level
CREATE OR REPLACE VIEW vw_JobsByLevel AS
SELECT Job_Level, COUNT(*) AS Total_Jobs, GROUP_CONCAT(Job_Title) AS Job_Titles
FROM JOB
GROUP BY Job_Level;

-- 5. Salary stats per job category
CREATE OR REPLACE VIEW vw_SalaryStatsByCategory AS
SELECT Job_Category, 
       MIN(Min_Salary) AS Min_Sal, 
       MAX(Max_Salary) AS Max_Sal, 
       AVG((Min_Salary + Max_Salary)/2) AS Avg_Sal
FROM JOB
GROUP BY Job_Category;

-- 6. Active job assignments
CREATE OR REPLACE VIEW vw_ActiveJobAssignments AS
SELECT ja.Assignment_ID, e.First_Name, e.Last_Name, j.Job_Title, ja.Start_Date
FROM JOB_ASSIGNMENT ja
JOIN EMPLOYEE e ON ja.Employee_ID = e.Employee_ID
JOIN JOB j ON ja.Job_ID = j.Job_ID
WHERE ja.Status = 'Active';

-- -----------------------------------------------------
-- 3. Performance Views
-- -----------------------------------------------------

-- 7. Summary of KPI scores
CREATE OR REPLACE VIEW vw_KPIScoresSummary AS
SELECT e.First_Name, e.Last_Name, pc.Cycle_Name, k.KPI_Name, eks.Employee_Score
FROM EMPLOYEE_KPI_SCORE eks
JOIN JOB_ASSIGNMENT ja ON eks.Assignment_ID = ja.Assignment_ID
JOIN EMPLOYEE e ON ja.Employee_ID = e.Employee_ID
JOIN OBJECTIVE_KPI k ON eks.KPI_ID = k.KPI_ID
JOIN PERFORMANCE_CYCLE pc ON eks.Performance_Cycle_ID = pc.Cycle_ID;

-- 8. Appraisal scores per cycle
CREATE OR REPLACE VIEW vw_AppraisalsPerCycle AS
SELECT pc.Cycle_Name, AVG(a.Overall_Score) AS Avg_Score, MAX(a.Overall_Score) AS Max_Score
FROM APPRAISAL a
JOIN PERFORMANCE_CYCLE pc ON a.Cycle_ID = pc.Cycle_ID
GROUP BY pc.Cycle_Name;

-- 9. Full appraisal summary
CREATE OR REPLACE VIEW vw_FullAppraisalSummary AS
SELECT e.First_Name, e.Last_Name, j.Job_Title, pc.Cycle_Name, a.Overall_Score, a.Manager_Comments
FROM APPRAISAL a
JOIN JOB_ASSIGNMENT ja ON a.Assignment_ID = ja.Assignment_ID
JOIN EMPLOYEE e ON ja.Employee_ID = e.Employee_ID
JOIN JOB j ON ja.Job_ID = j.Job_ID
JOIN PERFORMANCE_CYCLE pc ON a.Cycle_ID = pc.Cycle_ID;

-- -----------------------------------------------------
-- 4. Training Views
-- -----------------------------------------------------

-- 10. Employee participation in training
CREATE OR REPLACE VIEW vw_TrainingParticipation AS
SELECT tp.Title AS Program_Title, COUNT(et.Employee_ID) AS Participants
FROM TRAINING_PROGRAM tp
LEFT JOIN EMPLOYEE_TRAINING et ON tp.Program_ID = et.Program_ID
GROUP BY tp.Title;

-- 11. Training completion stats
CREATE OR REPLACE VIEW vw_TrainingCompletionStats AS
SELECT tp.Title, 
       SUM(CASE WHEN et.Completion_Status = 'Completed' THEN 1 ELSE 0 END) AS Completed,
       SUM(CASE WHEN et.Completion_Status = 'In Progress' THEN 1 ELSE 0 END) AS In_Progress
FROM TRAINING_PROGRAM tp
JOIN EMPLOYEE_TRAINING et ON tp.Program_ID = et.Program_ID
GROUP BY tp.Title;


USE `HRMS_Project`;

CREATE OR REPLACE VIEW vw_OrgHierarchy AS
SELECT 
    u.University_Name AS Level1_Org,
    -- If Faculty_Name is NULL (meaning it's an Admin dept), label it 'Administration'
    COALESCE(f.Faculty_Name, 'Administration') AS Level2_Unit,
    d.Department_Name AS Level3_Dept,
    -- Count active employees in these departments
    COUNT(ja.Employee_ID) AS Headcount
FROM DEPARTMENT d
-- 1. Join the Subtype tables to get the IDs
LEFT JOIN ACADEMIC_DEPARTMENT acad ON d.Department_ID = acad.Department_ID
LEFT JOIN ADMINISTRATIVE_DEPARTMENT admin ON d.Department_ID = admin.Department_ID
-- 2. Link to Faculty (Only works if it was an Academic Dept)
LEFT JOIN FACULTY f ON acad.Faculty_ID = f.Faculty_ID
-- 3. Link to University (Path A: via Admin Dept, Path B: via Faculty)
LEFT JOIN UNIVERSITY u ON (admin.University_ID = u.University_ID OR f.University_ID = u.University_ID)
-- 4. Link Jobs and Assignments for Headcount
LEFT JOIN JOB j ON d.Department_ID = j.Department_ID
LEFT JOIN JOB_ASSIGNMENT ja ON j.Job_ID = ja.Job_ID AND ja.Status = 'Active'
GROUP BY u.University_Name, f.Faculty_Name, d.Department_Name;
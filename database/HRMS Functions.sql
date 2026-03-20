
USE `HRMS_Project`;

DELIMITER $$

-- 1. Full Name
DROP FUNCTION IF EXISTS GetEmployeeFullName$$
CREATE FUNCTION GetEmployeeFullName(p_EmpID VARCHAR(20)) RETURNS VARCHAR(150)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_Name VARCHAR(150);
    SELECT CONCAT(First_Name, ' ', Last_Name) INTO v_Name FROM EMPLOYEE WHERE Employee_ID = p_EmpID;
    RETURN v_Name;
END$$

-- 2. Age from DOB
DROP FUNCTION IF EXISTS CalculateAge$$
CREATE FUNCTION CalculateAge(p_DOB DATE) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_DOB, CURDATE());
END$$

-- 3. Service Years
DROP FUNCTION IF EXISTS CalculateServiceYears$$
CREATE FUNCTION CalculateServiceYears(p_EmpID VARCHAR(20)) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_Years INT;
    SELECT TIMESTAMPDIFF(YEAR, MIN(Start_Date), CURDATE()) INTO v_Years 
    FROM JOB_ASSIGNMENT WHERE Employee_ID = p_EmpID;
    RETURN COALESCE(v_Years, 0);
END$$

-- -----------------------------------------------------
-- 2. Performance Calculations
-- -----------------------------------------------------

-- 4. KPI Score
DROP FUNCTION IF EXISTS CalculateKPIScore$$
CREATE FUNCTION CalculateKPIScore(p_Actual DECIMAL(10,2), p_Target DECIMAL(10,2)) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    IF p_Target = 0 THEN RETURN 0; END IF;
    -- Simple logic: (Actual / Target) * 5, capped at 5
    RETURN LEAST((p_Actual / p_Target) * 5, 5); 
END$$

-- 5. Weighted KPI Score
DROP FUNCTION IF EXISTS CalculateWeightedScore$$
CREATE FUNCTION CalculateWeightedScore(p_Score DECIMAL(5,2), p_Weight DECIMAL(5,2)) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN (p_Score * p_Weight) / 100;
END$$

-- 6. Total Objective Weight for a Job
DROP FUNCTION IF EXISTS GetTotalJobWeight$$
CREATE FUNCTION GetTotalJobWeight(p_JobID INT) RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_Total DECIMAL(5,2);
    SELECT SUM(Weight) INTO v_Total FROM JOB_OBJECTIVE WHERE Job_ID = p_JobID;
    RETURN COALESCE(v_Total, 0);
END$$

-- 7. Performance Cycle Duration (Days)
DROP FUNCTION IF EXISTS GetCycleDuration$$
CREATE FUNCTION GetCycleDuration(p_CycleID INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_Days INT;
    SELECT DATEDIFF(End_Date, Start_Date) INTO v_Days FROM PERFORMANCE_CYCLE WHERE Cycle_ID = p_CycleID;
    RETURN v_Days;
END$$

-- -----------------------------------------------------
-- 3. Dashboard Summary Calculations
-- -----------------------------------------------------

-- 8. Total Employees
DROP FUNCTION IF EXISTS GetTotalEmployees$$
CREATE FUNCTION GetTotalEmployees() RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(*) INTO v_Count FROM EMPLOYEE;
    RETURN v_Count;
END$$

-- 9. Active Employees
DROP FUNCTION IF EXISTS GetActiveEmployees$$
CREATE FUNCTION GetActiveEmployees() RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(*) INTO v_Count FROM EMPLOYEE WHERE Employment_Status = 'Active';
    RETURN v_Count;
END$$

-- 10. Total Jobs
DROP FUNCTION IF EXISTS GetTotalJobs$$
CREATE FUNCTION GetTotalJobs() RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(*) INTO v_Count FROM JOB;
    RETURN v_Count;
END$$

-- 11. Active Jobs
DROP FUNCTION IF EXISTS GetActiveJobs$$
CREATE FUNCTION GetActiveJobs() RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(DISTINCT Job_ID) INTO v_Count FROM JOB_ASSIGNMENT WHERE Status = 'Active';
    RETURN v_Count;
END$$

-- 12. Total Training Programs
DROP FUNCTION IF EXISTS GetTotalTrainingPrograms$$
CREATE FUNCTION GetTotalTrainingPrograms() RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(*) INTO v_Count FROM TRAINING_PROGRAM;
    RETURN v_Count;
END$$

-- 13. Total Issued Certificates
DROP FUNCTION IF EXISTS GetTotalCertificates$$
CREATE FUNCTION GetTotalCertificates() RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Count INT;
    SELECT COUNT(*) INTO v_Count FROM TRAINING_CERTIFICATE;
    RETURN v_Count;
END$$

-- 14. KPI Completion Rate
DROP FUNCTION IF EXISTS GetKPICompletionRate$$
CREATE FUNCTION GetKPICompletionRate() RETURNS DECIMAL(5,2)
DETERMINISTIC READS SQL DATA
BEGIN
    -- Placeholder logic
    RETURN 85.50; 
END$$

-- 15. Average Appraisal Score
DROP FUNCTION IF EXISTS GetAvgAppraisalScore$$
CREATE FUNCTION GetAvgAppraisalScore() RETURNS DECIMAL(5,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_Avg DECIMAL(5,2);
    SELECT AVG(Overall_Score) INTO v_Avg FROM APPRAISAL;
    RETURN COALESCE(v_Avg, 0);
END$$

DELIMITER ;
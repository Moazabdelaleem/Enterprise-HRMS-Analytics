USE `HRMS_Project`;

DELIMITER $$

-- 1. AddNewEmployee (Simplified Version)
DROP PROCEDURE IF EXISTS AddNewEmployee$$
CREATE PROCEDURE AddNewEmployee(
    IN p_EmployeeID VARCHAR(20), 
    IN p_FirstName VARCHAR(50), 
    IN p_LastName VARCHAR(50),
    IN p_Email VARCHAR(100), 
    IN p_DOB DATE, 
    IN p_Gender VARCHAR(10),
    IN p_InsuranceNumber VARCHAR(50)
)
BEGIN
   
    INSERT INTO EMPLOYEE (Employee_ID, First_Name, Last_Name, Work_Email, DOB, Gender, Employment_Status)
    VALUES (p_EmployeeID, p_FirstName, p_LastName, p_Email, p_DOB, p_Gender, 'Active');
    
    INSERT INTO SOCIAL_INSURANCE (Employee_ID, Insurance_Number, Start_Date, Status)
    VALUES (p_EmployeeID, p_InsuranceNumber, CURDATE(), 'Active');
END$$

-- 2. UpdateEmployeeContactInfo
DROP PROCEDURE IF EXISTS UpdateEmployeeContactInfo$$
CREATE PROCEDURE UpdateEmployeeContactInfo(
    IN p_EmployeeID VARCHAR(20),
    IN p_Mobile VARCHAR(20),
    IN p_WorkEmail VARCHAR(100),
    IN p_PersonalEmail VARCHAR(100),
    IN p_AddressCity VARCHAR(100)
)
BEGIN
    UPDATE EMPLOYEE
    SET Mobile_Phone = p_Mobile,
        Work_Email = p_WorkEmail,
        Personal_Email = p_PersonalEmail,
        Residential_City = p_AddressCity
    WHERE Employee_ID = p_EmployeeID;
END$$

-- 3. AddEmployeeDisability
DROP PROCEDURE IF EXISTS AddEmployeeDisability$$
CREATE PROCEDURE AddEmployeeDisability(
    IN p_EmployeeID VARCHAR(20),
    IN p_Type VARCHAR(100),
    IN p_Severity VARCHAR(50),
    IN p_Support TEXT
)
BEGIN
    INSERT INTO EMPLOYEE_DISABILITY (Employee_ID, Disability_Type, Severity_Level, Required_Support)
    VALUES (p_EmployeeID, p_Type, p_Severity, p_Support);
END$$

-- 4. GetEmployeeFullProfile
DROP PROCEDURE IF EXISTS GetEmployeeFullProfile$$
CREATE PROCEDURE GetEmployeeFullProfile(IN p_EmployeeID VARCHAR(20))
BEGIN
    -- 1. Basic Info
    SELECT * FROM EMPLOYEE WHERE Employee_ID = p_EmployeeID;
    -- 2. Disabilities
    SELECT * FROM EMPLOYEE_DISABILITY WHERE Employee_ID = p_EmployeeID;
    -- 3. Qualifications
    SELECT * FROM EDUCATIONAL_QUALIFICATION WHERE Employee_ID = p_EmployeeID;
    -- 4. Job History
    SELECT * FROM JOB_ASSIGNMENT WHERE Employee_ID = p_EmployeeID;
END$$

-- -----------------------------------------------------
-- B. Job & Assignment Procedures
-- -----------------------------------------------------

-- 5. AddNewJob
DROP PROCEDURE IF EXISTS AddNewJob$$
CREATE PROCEDURE AddNewJob(
    IN p_JobCode VARCHAR(20), 
    IN p_Title VARCHAR(100), 
    IN p_MinSal DECIMAL(10,2), 
    IN p_MaxSal DECIMAL(10,2)
)
BEGIN
    INSERT INTO JOB (Job_Code, Job_Title, Min_Salary, Max_Salary, Status)
    VALUES (p_JobCode, p_Title, p_MinSal, p_MaxSal, 'Active');
END$$

-- 6. AddJobObjective
DROP PROCEDURE IF EXISTS AddJobObjective$$
CREATE PROCEDURE AddJobObjective(
    IN p_JobID INT, 
    IN p_Title VARCHAR(255), 
    IN p_Weight DECIMAL(5,2)
)
BEGIN
    DECLARE current_weight DECIMAL(5,2);
    
    -- Calculate existing weight
    SELECT COALESCE(SUM(Weight), 0) INTO current_weight 
    FROM JOB_OBJECTIVE WHERE Job_ID = p_JobID;
    
    -- Validation
    IF (current_weight + p_Weight) > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Total objective weight cannot exceed 100%';
    ELSE
        INSERT INTO JOB_OBJECTIVE (Job_ID, Objective_Title, Weight)
        VALUES (p_JobID, p_Title, p_Weight);
    END IF;
END$$

-- 7. AddKPIToObjective
DROP PROCEDURE IF EXISTS AddKPIToObjective$$
CREATE PROCEDURE AddKPIToObjective(
    IN p_ObjID INT, 
    IN p_Name VARCHAR(255), 
    IN p_Target DECIMAL(10,2), 
    IN p_Weight DECIMAL(5,2)
)
BEGIN
    INSERT INTO OBJECTIVE_KPI (Objective_ID, KPI_Name, Target_Value, Weight)
    VALUES (p_ObjID, p_Name, p_Target, p_Weight);
END$$

-- 8. AssignJobToEmployee
DROP PROCEDURE IF EXISTS AssignJobToEmployee$$
CREATE PROCEDURE AssignJobToEmployee(
    IN p_EmpID VARCHAR(20), 
    IN p_JobID INT, 
    IN p_ContractID INT, 
    IN p_StartDate DATE
)
BEGIN
    DECLARE active_count INT;
    
    -- Validation A: Contract existence
    IF NOT EXISTS (SELECT 1 FROM CONTRACT WHERE Contract_ID = p_ContractID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Contract does not exist';
    END IF;
    
    -- Validation B: Overlapping active jobs
    SELECT COUNT(*) INTO active_count 
    FROM JOB_ASSIGNMENT 
    WHERE Employee_ID = p_EmpID AND Status = 'Active';
    
    IF active_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Employee already has an active job';
    ELSE
        INSERT INTO JOB_ASSIGNMENT (Employee_ID, Job_ID, Contract_ID, Start_Date, Status)
        VALUES (p_EmpID, p_JobID, p_ContractID, p_StartDate, 'Active');
    END IF;
END$$

-- 9. CloseJobAssignment
DROP PROCEDURE IF EXISTS CloseJobAssignment$$
CREATE PROCEDURE CloseJobAssignment(IN p_AssignID INT, IN p_EndDate DATE)
BEGIN
    UPDATE JOB_ASSIGNMENT
    SET End_Date = p_EndDate, Status = 'Inactive'
    WHERE Assignment_ID = p_AssignID;
END$$

-- -----------------------------------------------------
-- C. Performance Management Procedures
-- -----------------------------------------------------

-- 10. CreatePerformanceCycle
DROP PROCEDURE IF EXISTS CreatePerformanceCycle$$
CREATE PROCEDURE CreatePerformanceCycle(
    IN p_Name VARCHAR(100), 
    IN p_Start DATE, 
    IN p_End DATE
)
BEGIN
    INSERT INTO PERFORMANCE_CYCLE (Cycle_Name, Start_Date, End_Date)
    VALUES (p_Name, p_Start, p_End);
END$$

-- 11. AddEmployeeKPIScore
DROP PROCEDURE IF EXISTS AddEmployeeKPIScore$$
CREATE PROCEDURE AddEmployeeKPIScore(
    IN p_AssignID INT, 
    IN p_KPIID INT, 
    IN p_CycleID INT, 
    IN p_Value DECIMAL(10,2), 
    IN p_Score DECIMAL(5,2)
)
BEGIN
    INSERT INTO EMPLOYEE_KPI_SCORE (Assignment_ID, KPI_ID, Performance_Cycle_ID, Actual_Value, Employee_Score, Review_Date)
    VALUES (p_AssignID, p_KPIID, p_CycleID, p_Value, p_Score, CURDATE());
END$$

-- 12. CalculateEmployeeWeightedScore
DROP PROCEDURE IF EXISTS CalculateEmployeeWeightedScore$$
CREATE PROCEDURE CalculateEmployeeWeightedScore(IN p_AssignID INT, IN p_CycleID INT)
BEGIN
    DECLARE total_score DECIMAL(5,2);
    
    -- Sum up the weighted scores from the trigger-calculated column
    SELECT SUM(Weighted_Score) INTO total_score
    FROM EMPLOYEE_KPI_SCORE
    WHERE Assignment_ID = p_AssignID AND Performance_Cycle_ID = p_CycleID;
    
    -- Update the main Appraisal record
    UPDATE APPRAISAL 
    SET Overall_Score = total_score 
    WHERE Assignment_ID = p_AssignID AND Cycle_ID = p_CycleID;
END$$

-- 13. CreateAppraisal
DROP PROCEDURE IF EXISTS CreateAppraisal$$
CREATE PROCEDURE CreateAppraisal(
    IN p_AssignID INT, 
    IN p_CycleID INT, 
    IN p_ReviewerID VARCHAR(20)
)
BEGIN
    INSERT INTO APPRAISAL (Assignment_ID, Cycle_ID, Reviewer_ID, Appraisal_Date, Overall_Score)
    VALUES (p_AssignID, p_CycleID, p_ReviewerID, CURDATE(), 0);
END$$

-- 14. SubmitAppeal
DROP PROCEDURE IF EXISTS SubmitAppeal$$
CREATE PROCEDURE SubmitAppeal(
    IN p_AppraisalID INT, 
    IN p_Reason TEXT
)
BEGIN
    DECLARE v_OrigScore DECIMAL(5,2);
    
    -- Get original score
    SELECT Overall_Score INTO v_OrigScore FROM APPRAISAL WHERE Appraisal_ID = p_AppraisalID;
    
    INSERT INTO APPEAL (Appraisal_ID, Submission_Date, Reason, Original_Score, Approval_Status)
    VALUES (p_AppraisalID, CURDATE(), p_Reason, v_OrigScore, 'Pending');
END$$

-- -----------------------------------------------------
-- D. Training Procedures
-- -----------------------------------------------------

-- 15. AddTrainingProgram
DROP PROCEDURE IF EXISTS AddTrainingProgram$$
CREATE PROCEDURE AddTrainingProgram(
    IN p_Code VARCHAR(20), 
    IN p_Title VARCHAR(100), 
    IN p_Method VARCHAR(50)
)
BEGIN
    INSERT INTO TRAINING_PROGRAM (Program_Code, Title, Delivery_Method, Approval_Status)
    VALUES (p_Code, p_Title, p_Method, 'Pending');
END$$

-- 16. AssignTrainingToEmployee
DROP PROCEDURE IF EXISTS AssignTrainingToEmployee$$
CREATE PROCEDURE AssignTrainingToEmployee(
    IN p_EmpID VARCHAR(20), 
    IN p_ProgID INT
)
BEGIN
    INSERT INTO EMPLOYEE_TRAINING (Employee_ID, Program_ID, Completion_Status)
    VALUES (p_EmpID, p_ProgID, 'In Progress');
END$$

-- 17. RecordTrainingCompletion
DROP PROCEDURE IF EXISTS RecordTrainingCompletion$$
CREATE PROCEDURE RecordTrainingCompletion(IN p_ETID INT)
BEGIN
    UPDATE EMPLOYEE_TRAINING
    SET Completion_Status = 'Completed'
    WHERE ET_ID = p_ETID;
END$$

-- 18. IssueTrainingCertificate
DROP PROCEDURE IF EXISTS IssueTrainingCertificate$$
CREATE PROCEDURE IssueTrainingCertificate(
    IN p_ETID INT, 
    IN p_Path VARCHAR(255)
)
BEGIN
    -- Logic: Insert record. The Trigger will handle validation of attendance.
    INSERT INTO TRAINING_CERTIFICATE (ET_ID, Issue_Date, certificate_file_path)
    VALUES (p_ETID, CURDATE(), p_Path);
END$$

-- Reset delimiter back to semicolon
DELIMITER ;
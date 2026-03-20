
USE `HRMS_Project`;

DELIMITER $$

-- 1. Validate Objective Weight
DROP TRIGGER IF EXISTS trg_validate_obj_weight$$
CREATE TRIGGER trg_validate_obj_weight
BEFORE INSERT ON JOB_OBJECTIVE
FOR EACH ROW
BEGIN
    DECLARE current_total DECIMAL(5,2);
    SELECT COALESCE(SUM(Weight), 0) INTO current_total 
    FROM JOB_OBJECTIVE WHERE Job_ID = NEW.Job_ID;
    
    IF (current_total + NEW.Weight) > 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Total weight for job cannot exceed 100%';
    END IF;
END$$

-- 2. Prevent Deleting Objective if KPIs Exist
DROP TRIGGER IF EXISTS trg_prevent_obj_delete$$
CREATE TRIGGER trg_prevent_obj_delete
BEFORE DELETE ON JOB_OBJECTIVE
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM OBJECTIVE_KPI WHERE Objective_ID = OLD.Objective_ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cannot delete objective with linked KPIs';
    END IF;
END$$

-- 3. Prevent Deleting Employee with Active Assignments
DROP TRIGGER IF EXISTS trg_prevent_emp_delete$$
CREATE TRIGGER trg_prevent_emp_delete
BEFORE DELETE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM JOB_ASSIGNMENT WHERE Employee_ID = OLD.Employee_ID AND Status = 'Active') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cannot delete employee with active job assignments';
    END IF;
END$$

-- 4. Auto-Calculate Weighted Score
DROP TRIGGER IF EXISTS trg_calc_weighted_score$$
CREATE TRIGGER trg_calc_weighted_score
BEFORE INSERT ON EMPLOYEE_KPI_SCORE
FOR EACH ROW
BEGIN
    DECLARE kpi_weight DECIMAL(5,2);
    
    -- Get weight from the linked KPI
    SELECT Weight INTO kpi_weight FROM OBJECTIVE_KPI WHERE KPI_ID = NEW.KPI_ID;
    
    -- Calculate: (Score * Weight) / 100
    SET NEW.Weighted_Score = (NEW.Employee_Score * kpi_weight) / 100;
END$$

-- 5. Prevent Deleting Training Program if Assigned
DROP TRIGGER IF EXISTS trg_prevent_prog_delete$$
CREATE TRIGGER trg_prevent_prog_delete
BEFORE DELETE ON TRAINING_PROGRAM
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM EMPLOYEE_TRAINING WHERE Program_ID = OLD.Program_ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cannot delete program assigned to employees';
    END IF;
END$$

-- 6. Validate Training Certificate Issue
DROP TRIGGER IF EXISTS trg_validate_cert$$
CREATE TRIGGER trg_validate_cert
BEFORE INSERT ON TRAINING_CERTIFICATE
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM EMPLOYEE_TRAINING WHERE ET_ID = NEW.ET_ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Invalid training attendance record';
    END IF;
    
    IF EXISTS (SELECT 1 FROM EMPLOYEE_TRAINING WHERE ET_ID = NEW.ET_ID AND Completion_Status != 'Completed') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cannot issue certificate for incomplete training';
    END IF;
END$$

DELIMITER ;
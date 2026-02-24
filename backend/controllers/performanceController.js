const db = require('../config/database');

// Get all appraisals
exports.getAllAppraisals = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT a.*, 
                   CONCAT(e.First_Name, ' ', e.Last_Name) as Employee_Name,
                   j.Job_Title,
                   pc.Cycle_Name
            FROM APPRAISAL a
            LEFT JOIN JOB_ASSIGNMENT ja ON a.Assignment_ID = ja.Assignment_ID
            LEFT JOIN EMPLOYEE e ON ja.Employee_ID = e.Employee_ID
            LEFT JOIN JOB j ON ja.Job_ID = j.Job_ID
            LEFT JOIN PERFORMANCE_CYCLE pc ON a.Cycle_ID = pc.Cycle_ID
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching appraisals:', error);
        res.status(500).json({ error: 'Failed to fetch appraisals' });
    }
};

// Get performance cycles
exports.getPerformanceCycles = async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM PERFORMANCE_CYCLE ORDER BY Start_Date DESC');
        res.json(rows);
    } catch (error) {
        console.error('Error fetching performance cycles:', error);
        res.status(500).json({ error: 'Failed to fetch performance cycles' });
    }
};

// Create appraisal
exports.createAppraisal = async (req, res) => {
    try {
        const {
            Assignment_ID, Cycle_ID, Appraisal_Date, Overall_Score,
            Manager_Comments, HR_Comments, Employee_Comments, Reviewer_ID
        } = req.body;

        const [result] = await db.query(
            `INSERT INTO APPRAISAL (
                Assignment_ID, Cycle_ID, Appraisal_Date, Overall_Score,
                Manager_Comments, HR_Comments, Employee_Comments, Reviewer_ID
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
            [Assignment_ID, Cycle_ID, Appraisal_Date, Overall_Score, Manager_Comments, HR_Comments, Employee_Comments, Reviewer_ID]
        );

        res.status(201).json({
            message: 'Appraisal created successfully',
            appraisalId: result.insertId
        });
    } catch (error) {
        console.error('Error creating appraisal:', error);
        res.status(500).json({ error: 'Failed to create appraisal' });
    }
};

// Get dashboard statistics
exports.getDashboardStats = async (req, res) => {
    try {
        const [employeeStats] = await db.query('SELECT COUNT(*) as total FROM EMPLOYEE WHERE Employment_Status = "Active"');
        const [departmentStats] = await db.query('SELECT COUNT(*) as total FROM DEPARTMENT');
        const [jobStats] = await db.query('SELECT COUNT(*) as total FROM JOB WHERE Status = "Active"');
        const [trainingStats] = await db.query('SELECT COUNT(*) as total FROM TRAINING_PROGRAM WHERE Approval_Status = "Approved"');

        res.json({
            employees: employeeStats[0].total,
            departments: departmentStats[0].total,
            jobs: jobStats[0].total,
            trainingPrograms: trainingStats[0].total
        });
    } catch (error) {
        console.error('Error fetching dashboard stats:', error);
        res.status(500).json({ error: 'Failed to fetch dashboard statistics' });
    }
};

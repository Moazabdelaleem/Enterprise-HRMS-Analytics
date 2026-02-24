const db = require('../config/database');

// Get all training programs
exports.getAllTrainingPrograms = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT tp.*,
                   (SELECT COUNT(*) FROM EMPLOYEE_TRAINING WHERE Program_ID = tp.Program_ID) as enrolled_count
            FROM TRAINING_PROGRAM tp
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching training programs:', error);
        res.status(500).json({ error: 'Failed to fetch training programs' });
    }
};

// Get employee training records
exports.getEmployeeTraining = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT et.*, tp.Title, tp.Program_Code, 
                   CONCAT(e.First_Name, ' ', e.Last_Name) as Employee_Name
            FROM EMPLOYEE_TRAINING et
            JOIN TRAINING_PROGRAM tp ON et.Program_ID = tp.Program_ID
            JOIN EMPLOYEE e ON et.Employee_ID = e.Employee_ID
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching employee training:', error);
        res.status(500).json({ error: 'Failed to fetch employee training' });
    }
};

// Create training program
exports.createTrainingProgram = async (req, res) => {
    try {
        const {
            Program_Code, Title, Objectives, Type, Subtype,
            Delivery_Method, Approval_Status
        } = req.body;

        const [result] = await db.query(
            `INSERT INTO TRAINING_PROGRAM (
                Program_Code, Title, Objectives, Type, Subtype,
                Delivery_Method, Approval_Status
            ) VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [Program_Code, Title, Objectives, Type, Subtype, Delivery_Method, Approval_Status || 'Pending']
        );

        res.status(201).json({
            message: 'Training program created successfully',
            programId: result.insertId
        });
    } catch (error) {
        console.error('Error creating training program:', error);
        res.status(500).json({ error: 'Failed to create training program' });
    }
};

// Enroll employee in training
exports.enrollEmployee = async (req, res) => {
    try {
        const { Employee_ID, Program_ID } = req.body;

        const [result] = await db.query(
            'INSERT INTO EMPLOYEE_TRAINING (Employee_ID, Program_ID, Completion_Status) VALUES (?, ?, ?)',
            [Employee_ID, Program_ID, 'In Progress']
        );

        res.status(201).json({
            message: 'Employee enrolled successfully',
            enrollmentId: result.insertId
        });
    } catch (error) {
        console.error('Error enrolling employee:', error);
        res.status(500).json({ error: 'Failed to enroll employee' });
    }
};

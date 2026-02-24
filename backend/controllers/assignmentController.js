const db = require('../config/database');

// Create new assignment
exports.createAssignment = async (req, res) => {
    try {
        const {
            Employee_ID, Job_ID, Contract_ID,
            Start_Date, End_Date, Status, Assigned_Salary
        } = req.body;

        // 1. Basic Validation
        if (!Employee_ID || !Job_ID || !Start_Date) {
            return res.status(400).json({ error: 'Employee, Job, and Start Date are required' });
        }

        if (End_Date && new Date(End_Date) <= new Date(Start_Date)) {
            return res.status(400).json({ error: 'End Date must be after Start Date' });
        }

        // 2. Business Constraint: Check for existing Active assignment
        if (Status === 'Active') {
            const [activeAssignments] = await db.query(
                `SELECT * FROM JOB_ASSIGNMENT 
                 WHERE Employee_ID = ? AND Status = 'Active'`,
                [Employee_ID]
            );

            if (activeAssignments.length > 0) {
                return res.status(409).json({
                    error: 'Employee already has an active assignment. Please terminate the current assignment first.'
                });
            }
        }

        // 3. Business Constraint: Salary Range
        if (Assigned_Salary) {
            const [job] = await db.query('SELECT Min_Salary, Max_Salary, Job_Title FROM JOB WHERE Job_ID = ?', [Job_ID]);

            if (job.length === 0) {
                return res.status(404).json({ error: 'Job not found' });
            }

            const { Min_Salary, Max_Salary, Job_Title } = job[0];

            if (parseFloat(Assigned_Salary) < parseFloat(Min_Salary) || parseFloat(Assigned_Salary) > parseFloat(Max_Salary)) {
                return res.status(400).json({
                    error: `Salary must be between ${Min_Salary} and ${Max_Salary} for ${Job_Title}`
                });
            }
        }

        const [result] = await db.query(
            `INSERT INTO JOB_ASSIGNMENT (
                Employee_ID, Job_ID, Contract_ID,
                Start_Date, End_Date, Status, Assigned_Salary
            ) VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [
                Employee_ID, Job_ID, Contract_ID || null,
                Start_Date, End_Date || null, Status || 'Active', Assigned_Salary || null
            ]
        );

        res.status(201).json({
            message: 'Job assigned successfully',
            assignmentId: result.insertId
        });
    } catch (error) {
        console.error('Error assigning job:', error);
        res.status(500).json({ error: 'Failed to assign job', details: error.message });
    }
};

// Get all assignments with details
exports.getAllAssignments = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT ja.*, 
                   j.Job_Title, j.Job_Code, 
                   e.First_Name, e.Last_Name,
                   d.Department_Name
            FROM JOB_ASSIGNMENT ja
            JOIN JOB j ON ja.Job_ID = j.Job_ID
            JOIN EMPLOYEE e ON ja.Employee_ID = e.Employee_ID
            LEFT JOIN DEPARTMENT d ON j.Department_ID = d.Department_ID
            ORDER BY ja.Start_Date DESC
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching all assignments:', error);
        res.status(500).json({ error: 'Failed to fetch assignments' });
    }
};

// Get assignments by Employee ID
exports.getAssignmentsByEmployee = async (req, res) => {
    try {
        const { employeeId } = req.params;
        const [rows] = await db.query(`
            SELECT ja.*, j.Job_Title, j.Job_Code
            FROM JOB_ASSIGNMENT ja
            JOIN JOB j ON ja.Job_ID = j.Job_ID
            WHERE ja.Employee_ID = ?
            ORDER BY ja.Start_Date DESC
        `, [employeeId]);

        res.json(rows);
    } catch (error) {
        console.error('Error fetching assignments:', error);
        res.status(500).json({ error: 'Failed to fetch assignments' });
    }
};

// Update assignment status (e.g. to Terminate)
exports.updateAssignment = async (req, res) => {
    try {
        const { id } = req.params;
        const { Status, End_Date } = req.body;

        const [result] = await db.query(
            'UPDATE JOB_ASSIGNMENT SET Status = ?, End_Date = ? WHERE Assignment_ID = ?',
            [Status, End_Date || new Date(), id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Assignment not found' });
        }

        res.json({ message: 'Assignment updated successfully' });
    } catch (error) {
        console.error('Error updating assignment:', error);
        res.status(500).json({ error: 'Failed to update assignment' });
    }
};

const db = require('../config/database');

// Get all employees
exports.getAllEmployees = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT e.*, d.Department_Name, j.Job_Title
            FROM EMPLOYEE e
            LEFT JOIN JOB_ASSIGNMENT ja ON e.Employee_ID = ja.Employee_ID AND ja.Status = 'Active'
            LEFT JOIN JOB j ON ja.Job_ID = j.Job_ID
            LEFT JOIN DEPARTMENT d ON j.Department_ID = d.Department_ID
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching employees:', error);
        res.status(500).json({ error: 'Failed to fetch employees' });
    }
};

// Get employee by ID
exports.getEmployeeById = async (req, res) => {
    try {
        const { id } = req.params;
        const [rows] = await db.query('SELECT * FROM EMPLOYEE WHERE Employee_ID = ?', [id]);

        if (rows.length === 0) {
            return res.status(404).json({ error: 'Employee not found' });
        }

        res.json(rows[0]);
    } catch (error) {
        console.error('Error fetching employee:', error);
        res.status(500).json({ error: 'Failed to fetch employee' });
    }
};

// Create new employee
exports.createEmployee = async (req, res) => {
    try {
        const {
            Employee_ID, First_Name, Middle_Name, Last_Name, Arabic_Name,
            Gender, Nationality, DOB, Place_of_Birth, Marital_Status,
            Religion, Employment_Status, Mobile_Phone, Work_Phone,
            Work_Email, Personal_Email, Emergency_Contact_Name,
            Emergency_Contact_Phone, Emergency_Contact_Relationship,
            Residential_City, Residential_Area, Residential_Street, Residential_Country,
            Permanent_City, Permanent_Area, Permanent_Street, Permanent_Country,
            Medical_Clearance_Status, Criminal_Status
        } = req.body;

        const [result] = await db.query(
            `INSERT INTO EMPLOYEE (
                Employee_ID, First_Name, Middle_Name, Last_Name, Arabic_Name,
                Gender, Nationality, DOB, Place_of_Birth, Marital_Status,
                Religion, Employment_Status, Mobile_Phone, Work_Phone,
                Work_Email, Personal_Email, Emergency_Contact_Name,
                Emergency_Contact_Phone, Emergency_Contact_Relationship,
                Residential_City, Residential_Area, Residential_Street, Residential_Country,
                Permanent_City, Permanent_Area, Permanent_Street, Permanent_Country,
                Medical_Clearance_Status, Criminal_Status
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                Employee_ID, First_Name, Middle_Name, Last_Name, Arabic_Name,
                Gender, Nationality, DOB, Place_of_Birth, Marital_Status,
                Religion, Employment_Status || 'Active', Mobile_Phone, Work_Phone,
                Work_Email, Personal_Email, Emergency_Contact_Name,
                Emergency_Contact_Phone, Emergency_Contact_Relationship,
                Residential_City, Residential_Area, Residential_Street, Residential_Country,
                Permanent_City, Permanent_Area, Permanent_Street, Permanent_Country,
                Medical_Clearance_Status, Criminal_Status
            ]
        );

        res.status(201).json({
            message: 'Employee created successfully',
            employeeId: Employee_ID
        });
    } catch (error) {
        console.error('Error creating employee:', error);
        res.status(500).json({ error: 'Failed to create employee', details: error.message });
    }
};

// Update employee
exports.updateEmployee = async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;

        // Build dynamic update query
        const fields = Object.keys(updates).map(key => `${key} = ?`).join(', ');
        const values = [...Object.values(updates), id];

        const [result] = await db.query(
            `UPDATE EMPLOYEE SET ${fields} WHERE Employee_ID = ?`,
            values
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Employee not found' });
        }

        res.json({ message: 'Employee updated successfully' });
    } catch (error) {
        console.error('Error updating employee:', error);
        res.status(500).json({ error: 'Failed to update employee' });
    }
};

// Delete employee
exports.deleteEmployee = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await db.query('DELETE FROM EMPLOYEE WHERE Employee_ID = ?', [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Employee not found' });
        }

        res.json({ message: 'Employee deleted successfully' });
    } catch (error) {
        console.error('Error deleting employee:', error);
        res.status(500).json({ error: 'Failed to delete employee' });
    }
};

// Get employee statistics
exports.getEmployeeStats = async (req, res) => {
    try {
        const [stats] = await db.query(`
            SELECT 
                COUNT(*) as total_employees,
                SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) as male_count,
                SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) as female_count,
                SUM(CASE WHEN Employment_Status = 'Active' THEN 1 ELSE 0 END) as active_count,
                SUM(CASE WHEN Employment_Status = 'Probation' THEN 1 ELSE 0 END) as probation_count,
                SUM(CASE WHEN Employment_Status = 'Leave' THEN 1 ELSE 0 END) as leave_count,
                SUM(CASE WHEN Employment_Status = 'Retired' THEN 1 ELSE 0 END) as retired_count
            FROM EMPLOYEE
        `);

        res.json(stats[0]);
    } catch (error) {
        console.error('Error fetching employee stats:', error);
        res.status(500).json({ error: 'Failed to fetch statistics' });
    }
};

const db = require('../config/database');

// Get all departments
exports.getAllDepartments = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT d.*, 
                   CASE 
                       WHEN ad.Department_ID IS NOT NULL THEN u.University_Name
                       WHEN acd.Department_ID IS NOT NULL THEN f.Faculty_Name
                       ELSE NULL
                   END as Parent_Name
            FROM DEPARTMENT d
            LEFT JOIN ADMINISTRATIVE_DEPARTMENT ad ON d.Department_ID = ad.Department_ID
            LEFT JOIN UNIVERSITY u ON ad.University_ID = u.University_ID
            LEFT JOIN ACADEMIC_DEPARTMENT acd ON d.Department_ID = acd.Department_ID
            LEFT JOIN FACULTY f ON acd.Faculty_ID = f.Faculty_ID
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching departments:', error);
        res.status(500).json({ error: 'Failed to fetch departments' });
    }
};

// Get department by ID
exports.getDepartmentById = async (req, res) => {
    try {
        const { id } = req.params;
        const [rows] = await db.query('SELECT * FROM DEPARTMENT WHERE Department_ID = ?', [id]);

        if (rows.length === 0) {
            return res.status(404).json({ error: 'Department not found' });
        }

        res.json(rows[0]);
    } catch (error) {
        console.error('Error fetching department:', error);
        res.status(500).json({ error: 'Failed to fetch department' });
    }
};

// Create new department
exports.createDepartment = async (req, res) => {
    try {
        const { Department_Name, Department_Type, Location, Contact_Email } = req.body;

        const [result] = await db.query(
            'INSERT INTO DEPARTMENT (Department_Name, Department_Type, Location, Contact_Email) VALUES (?, ?, ?, ?)',
            [Department_Name, Department_Type, Location, Contact_Email]
        );

        res.status(201).json({
            message: 'Department created successfully',
            departmentId: result.insertId
        });
    } catch (error) {
        console.error('Error creating department:', error);
        res.status(500).json({ error: 'Failed to create department' });
    }
};

// Update department
exports.updateDepartment = async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;

        const fields = Object.keys(updates).map(key => `${key} = ?`).join(', ');
        const values = [...Object.values(updates), id];

        const [result] = await db.query(
            `UPDATE DEPARTMENT SET ${fields} WHERE Department_ID = ?`,
            values
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Department not found' });
        }

        res.json({ message: 'Department updated successfully' });
    } catch (error) {
        console.error('Error updating department:', error);
        res.status(500).json({ error: 'Failed to update department' });
    }
};

// Delete department
exports.deleteDepartment = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await db.query('DELETE FROM DEPARTMENT WHERE Department_ID = ?', [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Department not found' });
        }

        res.json({ message: 'Department deleted successfully' });
    } catch (error) {
        console.error('Error deleting department:', error);
        res.status(500).json({ error: 'Failed to delete department' });
    }
};

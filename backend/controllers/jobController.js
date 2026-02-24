const db = require('../config/database');

// Get all jobs
exports.getAllJobs = async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT j.*, d.Department_Name,
                   (SELECT COUNT(*) FROM JOB_ASSIGNMENT WHERE Job_ID = j.Job_ID AND Status = 'Active') as assigned_count
            FROM JOB j
            LEFT JOIN DEPARTMENT d ON j.Department_ID = d.Department_ID
        `);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching jobs:', error);
        res.status(500).json({ error: 'Failed to fetch jobs' });
    }
};

// Get job by ID
exports.getJobById = async (req, res) => {
    try {
        const { id } = req.params;
        const [rows] = await db.query('SELECT * FROM JOB WHERE Job_ID = ?', [id]);

        if (rows.length === 0) {
            return res.status(404).json({ error: 'Job not found' });
        }

        res.json(rows[0]);
    } catch (error) {
        console.error('Error fetching job:', error);
        res.status(500).json({ error: 'Failed to fetch job' });
    }
};

// Create new job
exports.createJob = async (req, res) => {
    try {
        const {
            Job_Code, Job_Title, Job_Level, Job_Category, Job_Grade,
            Min_Salary, Max_Salary, Job_Description, Status, Department_ID, Reports_To
        } = req.body;

        const [result] = await db.query(
            `INSERT INTO JOB (
                Job_Code, Job_Title, Job_Level, Job_Category, Job_Grade,
                Min_Salary, Max_Salary, Job_Description, Status, Department_ID, Reports_To
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                Job_Code, Job_Title, Job_Level, Job_Category, Job_Grade,
                Min_Salary, Max_Salary, Job_Description, Status || 'Active', Department_ID, Reports_To
            ]
        );

        res.status(201).json({
            message: 'Job created successfully',
            jobId: result.insertId
        });
    } catch (error) {
        console.error('Error creating job:', error);
        res.status(500).json({ error: 'Failed to create job', details: error.message });
    }
};

// Update job
exports.updateJob = async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;

        const fields = Object.keys(updates).map(key => `${key} = ?`).join(', ');
        const values = [...Object.values(updates), id];

        const [result] = await db.query(
            `UPDATE JOB SET ${fields} WHERE Job_ID = ?`,
            values
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Job not found' });
        }

        res.json({ message: 'Job updated successfully' });
    } catch (error) {
        console.error('Error updating job:', error);
        res.status(500).json({ error: 'Failed to update job' });
    }
};

// Delete job
exports.deleteJob = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await db.query('DELETE FROM JOB WHERE Job_ID = ?', [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Job not found' });
        }

        res.json({ message: 'Job deleted successfully' });
    } catch (error) {
        console.error('Error deleting job:', error);
        res.status(500).json({ error: 'Failed to delete job' });
    }
};

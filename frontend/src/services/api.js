const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:5000/api';

const api = {
    // Employees
    getEmployees: async () => {
        const response = await fetch(`${API_BASE_URL}/employees`);
        return response.json();
    },

    getEmployee: async (id) => {
        const response = await fetch(`${API_BASE_URL}/employees/${id}`);
        return response.json();
    },

    addEmployee: async (employee) => {
        const response = await fetch(`${API_BASE_URL}/employees`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(employee),
        });
        return response.json();
    },

    deleteEmployee: async (id) => {
        const response = await fetch(`${API_BASE_URL}/employees/${id}`, {
            method: 'DELETE',
        });
        return response.json();
    },

    updateEmployee: async (id, employee) => {
        const response = await fetch(`${API_BASE_URL}/employees/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(employee),
        });
        return response.json();
    },

    // Departments
    getDepartments: async () => {
        const response = await fetch(`${API_BASE_URL}/departments`);
        return response.json();
    },

    // Jobs
    getJobs: async () => {
        const response = await fetch(`${API_BASE_URL}/jobs`);
        return response.json();
    },

    // Training
    getTrainingPrograms: async () => {
        const response = await fetch(`${API_BASE_URL}/training/programs`);
        return response.json();
    },

    getEmployeeTraining: async () => {
        const response = await fetch(`${API_BASE_URL}/training/employee-training`);
        return response.json();
    },

    // Performance
    getAppraisals: async () => {
        const response = await fetch(`${API_BASE_URL}/performance/appraisals`);
        return response.json();
    },

    getKPIScores: async () => {
        const response = await fetch(`${API_BASE_URL}/performance/kpi-scores`);
        return response.json();
    },

    // Employee Statistics
    getEmployeeStats: async () => {
        const response = await fetch(`${API_BASE_URL}/employees/stats`);
        return response.json();
    },

    // Dashboard Stats
    getDashboardStats: async () => {
        try {
            const [employeeStats, departments, jobs, training] = await Promise.all([
                fetch(`${API_BASE_URL}/employees/stats`).then(r => r.json()),
                fetch(`${API_BASE_URL}/departments`).then(r => r.json()),
                fetch(`${API_BASE_URL}/jobs`).then(r => r.json()),
                fetch(`${API_BASE_URL}/training/programs`).then(r => r.json()),
            ]);

            return {
                totalEmployees: employeeStats.total_employees || 0,
                activeEmployees: employeeStats.active_count || 0,
                probationEmployees: employeeStats.probation_count || 0,
                leaveEmployees: employeeStats.leave_count || 0,
                departments: departments.length || 0,
                jobs: jobs.length || 0,
                training: training.length || 0,
            };
        } catch (error) {
            console.error('Error fetching dashboard stats:', error);
            return {
                totalEmployees: 0,
                activeEmployees: 0,
                probationEmployees: 0,
                leaveEmployees: 0,
                departments: 0,
                jobs: 0,
                training: 0
            };
        }
    },

    // Assignments
    getAssignments: async () => {
        const response = await fetch(`${API_BASE_URL}/assignments`);
        return response.json();
    },

    assignJob: async (assignmentData) => {
        const response = await fetch(`${API_BASE_URL}/assignments`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(assignmentData),
        });
        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.error || 'Failed to assign job');
        }
        return response.json();
    },

    updateAssignment: async (id, data) => {
        const response = await fetch(`${API_BASE_URL}/assignments/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        });
        if (!response.ok) {
            const error = await response.json();
            throw new Error(error.error || 'Failed to update assignment');
        }
        return response.json();
    }
};

export default api;

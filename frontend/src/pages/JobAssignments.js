import React, { useState, useEffect } from 'react';
import api from '../services/api';

const JobAssignments = () => {
    const [assignments, setAssignments] = useState([]);
    const [filteredAssignments, setFilteredAssignments] = useState([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [loading, setLoading] = useState(true);
    const [employees, setEmployees] = useState([]);
    const [jobs, setJobs] = useState([]);

    // Modal State
    const [showAssignModal, setShowAssignModal] = useState(false);
    const [assignData, setAssignData] = useState({
        Employee_ID: '',
        Job_ID: '',
        Start_Date: new Date().toISOString().split('T')[0],
        Status: 'Active',
        Assigned_Salary: ''
    });

    // Helper state for salary hint
    const [selectedJobRange, setSelectedJobRange] = useState(null);

    useEffect(() => {
        fetchData();
    }, []);

    useEffect(() => {
        const lowerSearch = searchTerm.toLowerCase();
        setFilteredAssignments(assignments.filter(a =>
            a.First_Name.toLowerCase().includes(lowerSearch) ||
            a.Last_Name.toLowerCase().includes(lowerSearch) ||
            a.Job_Title.toLowerCase().includes(lowerSearch) ||
            a.Employee_ID.toLowerCase().includes(lowerSearch)
        ));
    }, [searchTerm, assignments]);

    const fetchData = async () => {
        try {
            const [employeesData, jobsData, assignmentsData] = await Promise.all([
                api.getEmployees(),
                api.getJobs(),
                api.getAssignments()
            ]);
            setEmployees(Array.isArray(employeesData) ? employeesData : []);
            setJobs(Array.isArray(jobsData) ? jobsData : []);
            const assigns = Array.isArray(assignmentsData) ? assignmentsData : [];
            setAssignments(assigns);
            setFilteredAssignments(assigns);
            setLoading(false);
        } catch (error) {
            console.error('Error fetching data:', error);
            setLoading(false);
        }
    };

    const handleAssignJob = async (e) => {
        e.preventDefault();
        try {
            await api.assignJob(assignData);
            setShowAssignModal(false);
            alert('Job assigned successfully!');
            // Reset form
            setAssignData({
                Employee_ID: '',
                Job_ID: '',
                Start_Date: new Date().toISOString().split('T')[0],
                Status: 'Active',
                Assigned_Salary: ''
            });
            setSelectedJobRange(null);
            fetchData(); // Refresh list
        } catch (error) {
            console.error('Error assigning job:', error);
            alert(error.message);
        }
    };

    const handleTerminate = async (id) => {
        if (!window.confirm('Are you sure you want to terminate this assignment?')) return;
        try {
            await api.updateAssignment(id, { Status: 'Terminated', End_Date: new Date().toISOString().split('T')[0] });
            alert('Assignment terminated successfully.');
            fetchData();
        } catch (error) {
            alert(error.message);
        }
    };

    const formatSalary = (amount) => {
        if (!amount) return 'N/A';
        return new Intl.NumberFormat('en-EG', {
            style: 'currency',
            currency: 'EGP',
            minimumFractionDigits: 0
        }).format(amount);
    };

    if (loading) return <div className="loading"><div className="spinner"></div></div>;

    return (
        <div className="jobs-page">
            <div className="page-header">
                <div>
                    <h1>Job Assignments</h1>
                    <p>Assign jobs to employees</p>
                </div>
                <button className="btn btn-primary" onClick={() => setShowAssignModal(true)}>
                    ➕ New Assignment
                </button>
            </div>

            <div className="data-table-container">
                <div className="table-header">
                    <h2>Current Assignments ({filteredAssignments.length})</h2>
                    <input
                        type="text"
                        className="form-input"
                        placeholder="Search employee or job..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        style={{ width: '250px' }}
                    />
                </div>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>Employee</th>
                            <th>Job Title</th>
                            <th>Department</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Status</th>
                            <th>Salary</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredAssignments.map(assignment => (
                            <tr key={assignment.Assignment_ID}>
                                <td>
                                    {assignment.First_Name} {assignment.Last_Name}
                                    <div style={{ fontSize: '0.85em', color: 'var(--text-secondary)' }}>
                                        {assignment.Employee_ID}
                                    </div>
                                </td>
                                <td>
                                    {assignment.Job_Title}
                                    <div style={{ fontSize: '0.85em', color: 'var(--text-secondary)' }}>
                                        {assignment.Job_Code}
                                    </div>
                                </td>
                                <td>{assignment.Department_Name || '-'}</td>
                                <td>{new Date(assignment.Start_Date).toLocaleDateString()}</td>
                                <td>{assignment.End_Date ? new Date(assignment.End_Date).toLocaleDateString() : '-'}</td>
                                <td>
                                    <span className={`status-badge ${assignment.Status?.toLowerCase()}`}>
                                        {assignment.Status}
                                    </span>
                                </td>
                                <td>{formatSalary(assignment.Assigned_Salary)}</td>
                                <td>
                                    {assignment.Status === 'Active' && (
                                        <button
                                            className="btn-icon delete"
                                            onClick={() => handleTerminate(assignment.Assignment_ID)}
                                            title="Terminate Assignment"
                                        >
                                            🚫
                                        </button>
                                    )}
                                </td>
                            </tr>
                        ))}
                        {filteredAssignments.length === 0 && (
                            <tr>
                                <td colSpan="8" style={{ textAlign: 'center', padding: '40px' }}>
                                    No assignments found.
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>

            {/* Assign Job Modal */}
            {showAssignModal && (
                <div className="modal-overlay" onClick={() => setShowAssignModal(false)}>
                    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                        <div className="modal-header">
                            <h2>Assign Job</h2>
                            <button className="modal-close" onClick={() => setShowAssignModal(false)}>×</button>
                        </div>
                        <form onSubmit={handleAssignJob} className="modal-body">
                            <div className="form-group">
                                <label className="form-label">Employee</label>
                                <select
                                    className="form-select"
                                    value={assignData.Employee_ID}
                                    onChange={(e) => setAssignData({ ...assignData, Employee_ID: e.target.value })}
                                    required
                                >
                                    <option value="">Select Employee...</option>
                                    {employees.map(emp => (
                                        <option key={emp.Employee_ID} value={emp.Employee_ID}>
                                            {emp.First_Name} {emp.Last_Name} ({emp.Employee_ID})
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div className="form-group">
                                <label className="form-label">Job</label>
                                <select
                                    className="form-select"
                                    value={assignData.Job_ID}
                                    onChange={(e) => {
                                        const job = jobs.find(j => j.Job_ID === parseInt(e.target.value));
                                        setAssignData({
                                            ...assignData,
                                            Job_ID: e.target.value,
                                            Assigned_Salary: job ? job.Min_Salary : ''
                                        });
                                        setSelectedJobRange(job ? { min: job.Min_Salary, max: job.Max_Salary } : null);
                                    }}
                                    required
                                >
                                    <option value="">Select a Job...</option>
                                    {jobs.map(job => (
                                        <option key={job.Job_ID} value={job.Job_ID}>
                                            {job.Job_Title} ({job.Job_Code})
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div className="form-row">
                                <div className="form-group">
                                    <label className="form-label">Start Date</label>
                                    <input
                                        className="form-input"
                                        type="date"
                                        value={assignData.Start_Date}
                                        onChange={(e) => setAssignData({ ...assignData, Start_Date: e.target.value })}
                                        required
                                    />
                                </div>
                                <div className="form-group">
                                    <label className="form-label">Status</label>
                                    <select
                                        className="form-select"
                                        value={assignData.Status}
                                        onChange={(e) => setAssignData({ ...assignData, Status: e.target.value })}
                                    >
                                        <option value="Active">Active</option>
                                        <option value="Probation">Probation</option>
                                    </select>
                                </div>
                            </div>
                            <div className="form-group">
                                <label className="form-label">
                                    Assigned Salary
                                    {selectedJobRange && (
                                        <span style={{ fontSize: '0.8em', color: 'var(--text-secondary)', marginLeft: '10px' }}>
                                            (Range: {formatSalary(selectedJobRange.min)} - {formatSalary(selectedJobRange.max)})
                                        </span>
                                    )}
                                </label>
                                <input
                                    className="form-input"
                                    type="number"
                                    value={assignData.Assigned_Salary}
                                    onChange={(e) => setAssignData({ ...assignData, Assigned_Salary: e.target.value })}
                                    placeholder="Enter Salary"
                                    required
                                />
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn" onClick={() => setShowAssignModal(false)} style={{ background: 'var(--bg-elevated)', color: 'var(--text-primary)', border: '1px solid var(--border)' }}>Cancel</button>
                                <button type="submit" className="btn btn-primary">Assign Job</button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </div>
    );
};

export default JobAssignments;

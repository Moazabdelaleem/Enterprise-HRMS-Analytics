import React, { useState, useEffect } from 'react';
import api from '../services/api';

const Jobs = () => {
    const [jobs, setJobs] = useState([]);
    const [filteredJobs, setFilteredJobs] = useState([]);
    const [levelFilter, setLevelFilter] = useState('All');
    const [categoryFilter, setCategoryFilter] = useState('All');
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchJobs = async () => {
            try {
                const data = await api.getJobs();
                const jobsArray = Array.isArray(data) ? data : [];
                setJobs(jobsArray);
                setFilteredJobs(jobsArray);
            } catch (error) {
                console.error('Error fetching jobs:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchJobs();
    }, []);

    // Combined filter effect
    useEffect(() => {
        let filtered = jobs;

        // Apply level filter
        if (levelFilter !== 'All') {
            filtered = filtered.filter(j => j.Job_Level === levelFilter);
        }

        // Apply category filter
        if (categoryFilter !== 'All') {
            filtered = filtered.filter(j => j.Job_Category === categoryFilter);
        }

        setFilteredJobs(filtered);
    }, [jobs, levelFilter, categoryFilter]);

    // Get unique categories for filter dropdown
    const uniqueCategories = [...new Set(jobs.map(j => j.Job_Category).filter(Boolean))];

    const formatSalary = (amount) => {
        if (!amount) return 'N/A';
        return new Intl.NumberFormat('en-EG', {
            style: 'currency',
            currency: 'EGP',
            minimumFractionDigits: 0
        }).format(amount);
    };

    if (loading) {
        return (
            <div className="loading">
                <div className="spinner"></div>
            </div>
        );
    }

    return (
        <div className="jobs-page">
            <div className="page-header">
                <div>
                    <h1>Jobs</h1>
                    <p>Manage job positions</p>
                </div>
                <a href="/jobs/assignments" className="btn btn-primary" style={{ textDecoration: 'none' }}>
                    📋 Job Assignments
                </a>
            </div>

            <div className="data-table-container">
                <div className="table-header">
                    <h2>All Job Positions ({filteredJobs.length} {(levelFilter !== 'All' || categoryFilter !== 'All') ? `of ${jobs.length}` : ''})</h2>
                    <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
                        <select
                            className="form-select"
                            value={levelFilter}
                            onChange={(e) => setLevelFilter(e.target.value)}
                            style={{ width: 'auto', minWidth: '130px' }}
                        >
                            <option value="All">All Levels</option>
                            <option value="Senior">Senior</option>
                            <option value="Mid">Mid</option>
                            <option value="Entry">Entry</option>
                        </select>

                        <select
                            className="form-select"
                            value={categoryFilter}
                            onChange={(e) => setCategoryFilter(e.target.value)}
                            style={{ width: 'auto', minWidth: '150px' }}
                        >
                            <option value="All">All Categories</option>
                            {uniqueCategories.map(cat => (
                                <option key={cat} value={cat}>{cat}</option>
                            ))}
                        </select>
                    </div>
                </div>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Title</th>
                            <th>Level</th>
                            <th>Category</th>
                            <th>Salary Range</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredJobs.map((job) => (
                            <tr key={job.Job_ID}>
                                <td>{job.Job_Code}</td>
                                <td>{job.Job_Title}</td>
                                <td>
                                    <span className={`status-badge ${job.Job_Level === 'Senior' ? 'active' : job.Job_Level === 'Mid' ? 'probation' : 'leave'}`}>
                                        {job.Job_Level}
                                    </span>
                                </td>
                                <td>{job.Job_Category}</td>
                                <td>{formatSalary(job.Min_Salary)} - {formatSalary(job.Max_Salary)}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default Jobs;

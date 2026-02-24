import React, { useState, useEffect } from 'react';
import api from '../services/api';

const Departments = () => {
    const [departments, setDepartments] = useState([]);
    const [filteredDepartments, setFilteredDepartments] = useState([]);
    const [typeFilter, setTypeFilter] = useState('All');
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchDepartments = async () => {
            try {
                const data = await api.getDepartments();
                const deptArray = Array.isArray(data) ? data : [];
                setDepartments(deptArray);
                setFilteredDepartments(deptArray);
            } catch (error) {
                console.error('Error fetching departments:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchDepartments();
    }, []);

    // Type filter effect
    useEffect(() => {
        if (typeFilter === 'All') {
            setFilteredDepartments(departments);
        } else {
            setFilteredDepartments(departments.filter(d => d.Department_Type === typeFilter));
        }
    }, [departments, typeFilter]);

    if (loading) {
        return (
            <div className="loading">
                <div className="spinner"></div>
            </div>
        );
    }

    return (
        <div className="departments-page">
            <div className="page-header">
                <h1>Departments</h1>
                <p>Manage department records</p>
            </div>

            <div className="data-table-container">
                <div className="table-header">
                    <h2>All Departments ({filteredDepartments.length} {typeFilter !== 'All' ? `of ${departments.length}` : ''})</h2>
                    <select
                        className="form-select"
                        value={typeFilter}
                        onChange={(e) => setTypeFilter(e.target.value)}
                        style={{ width: 'auto', minWidth: '150px' }}
                    >
                        <option value="All">All Types</option>
                        <option value="Administrative">Administrative</option>
                        <option value="Academic">Academic</option>
                    </select>
                </div>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Department Name</th>
                            <th>Type</th>
                            <th>Location</th>
                            <th>Contact Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredDepartments.map((dept) => (
                            <tr key={dept.Department_ID}>
                                <td>{dept.Department_ID}</td>
                                <td>{dept.Department_Name}</td>
                                <td>
                                    <span className={`status-badge ${dept.Department_Type === 'Academic' ? 'active' : 'probation'}`}>
                                        {dept.Department_Type}
                                    </span>
                                </td>
                                <td>{dept.Location}</td>
                                <td>{dept.Contact_Email}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default Departments;

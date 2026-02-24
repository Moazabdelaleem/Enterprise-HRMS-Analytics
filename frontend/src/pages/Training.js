import React, { useState, useEffect } from 'react';
import api from '../services/api';

const Training = () => {
    const [programs, setPrograms] = useState([]);
    const [enrollments, setEnrollments] = useState([]);
    const [filteredPrograms, setFilteredPrograms] = useState([]);
    const [filteredEnrollments, setFilteredEnrollments] = useState([]);
    const [loading, setLoading] = useState(true);
    const [activeTab, setActiveTab] = useState('programs');

    // Program filters
    const [typeFilter, setTypeFilter] = useState('All');
    const [deliveryFilter, setDeliveryFilter] = useState('All');
    const [approvalFilter, setApprovalFilter] = useState('All');

    // Enrollment filters
    const [completionFilter, setCompletionFilter] = useState('All');

    useEffect(() => {
        const fetchData = async () => {
            try {
                const [programsData, enrollmentsData] = await Promise.all([
                    api.getTrainingPrograms(),
                    api.getEmployeeTraining()
                ]);
                const progsArray = Array.isArray(programsData) ? programsData : [];
                const enrollsArray = Array.isArray(enrollmentsData) ? enrollmentsData : [];
                setPrograms(progsArray);
                setEnrollments(enrollsArray);
                setFilteredPrograms(progsArray);
                setFilteredEnrollments(enrollsArray);
            } catch (error) {
                console.error('Error fetching training data:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, []);

    // Programs filter effect
    useEffect(() => {
        let filtered = programs;

        if (typeFilter !== 'All') {
            filtered = filtered.filter(p => p.Type === typeFilter);
        }

        if (deliveryFilter !== 'All') {
            filtered = filtered.filter(p => p.Delivery_Method === deliveryFilter);
        }

        if (approvalFilter !== 'All') {
            filtered = filtered.filter(p => p.Approval_Status === approvalFilter);
        }

        setFilteredPrograms(filtered);
    }, [programs, typeFilter, deliveryFilter, approvalFilter]);

    // Enrollments filter effect
    useEffect(() => {
        if (completionFilter === 'All') {
            setFilteredEnrollments(enrollments);
        } else {
            setFilteredEnrollments(enrollments.filter(e => e.Completion_Status === completionFilter));
        }
    }, [enrollments, completionFilter]);

    // Get unique values for dynamic filters
    const uniqueTypes = [...new Set(programs.map(p => p.Type).filter(Boolean))];

    if (loading) {
        return (
            <div className="loading">
                <div className="spinner"></div>
            </div>
        );
    }

    return (
        <div className="training-page">
            <div className="page-header">
                <h1>Training</h1>
                <p>Manage training programs and enrollments</p>
            </div>

            <div className="tabs" style={{ marginBottom: '20px', display: 'flex', gap: '10px' }}>
                <button
                    className={`btn ${activeTab === 'programs' ? 'btn-primary' : ''}`}
                    onClick={() => setActiveTab('programs')}
                    style={{ background: activeTab === 'programs' ? 'linear-gradient(135deg, #8b5cf6, #6366f1)' : '#1a1a3a', color: 'white', border: '1px solid #2a2a4a' }}
                >
                    Programs ({programs.length})
                </button>
                <button
                    className={`btn ${activeTab === 'enrollments' ? 'btn-primary' : ''}`}
                    onClick={() => setActiveTab('enrollments')}
                    style={{ background: activeTab === 'enrollments' ? 'linear-gradient(135deg, #8b5cf6, #6366f1)' : '#1a1a3a', color: 'white', border: '1px solid #2a2a4a' }}
                >
                    Enrollments ({enrollments.length})
                </button>
            </div>

            {activeTab === 'programs' && (
                <div className="data-table-container">
                    <div className="table-header">
                        <h2>Training Programs ({filteredPrograms.length} {(typeFilter !== 'All' || deliveryFilter !== 'All' || approvalFilter !== 'All') ? `of ${programs.length}` : ''})</h2>
                        <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
                            <select
                                className="form-select"
                                value={typeFilter}
                                onChange={(e) => setTypeFilter(e.target.value)}
                                style={{ width: 'auto', minWidth: '130px' }}
                            >
                                <option value="All">All Types</option>
                                {uniqueTypes.map(type => (
                                    <option key={type} value={type}>{type}</option>
                                ))}
                            </select>

                            <select
                                className="form-select"
                                value={deliveryFilter}
                                onChange={(e) => setDeliveryFilter(e.target.value)}
                                style={{ width: 'auto', minWidth: '150px' }}
                            >
                                <option value="All">All Delivery</option>
                                <option value="Online">Online</option>
                                <option value="In-Person">In-Person</option>
                                <option value="Blended">Blended</option>
                            </select>

                            <select
                                className="form-select"
                                value={approvalFilter}
                                onChange={(e) => setApprovalFilter(e.target.value)}
                                style={{ width: 'auto', minWidth: '140px' }}
                            >
                                <option value="All">All Status</option>
                                <option value="Approved">Approved</option>
                                <option value="Pending">Pending</option>
                                <option value="Rejected">Rejected</option>
                            </select>
                        </div>
                    </div>
                    <table className="data-table">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Delivery</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredPrograms.map((prog) => (
                                <tr key={prog.Program_ID}>
                                    <td>{prog.Program_Code}</td>
                                    <td>{prog.Title}</td>
                                    <td>{prog.Type}</td>
                                    <td>{prog.Delivery_Method}</td>
                                    <td>
                                        <span className={`status-badge ${prog.Approval_Status === 'Approved' ? 'active' : 'probation'}`}>
                                            {prog.Approval_Status}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {activeTab === 'enrollments' && (
                <div className="data-table-container">
                    <div className="table-header">
                        <h2>Employee Enrollments ({filteredEnrollments.length} {completionFilter !== 'All' ? `of ${enrollments.length}` : ''})</h2>
                        <select
                            className="form-select"
                            value={completionFilter}
                            onChange={(e) => setCompletionFilter(e.target.value)}
                            style={{ width: 'auto', minWidth: '160px' }}
                        >
                            <option value="All">All Status</option>
                            <option value="Completed">Completed</option>
                            <option value="In Progress">In Progress</option>
                            <option value="Dropped">Dropped</option>
                        </select>
                    </div>
                    <table className="data-table">
                        <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Program ID</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredEnrollments.map((enroll, index) => (
                                <tr key={index}>
                                    <td>{enroll.Employee_ID}</td>
                                    <td>{enroll.Program_ID}</td>
                                    <td>
                                        <span className={`status-badge ${enroll.Completion_Status === 'Completed' ? 'active' :
                                            enroll.Completion_Status === 'In Progress' ? 'probation' : 'retired'
                                            }`}>
                                            {enroll.Completion_Status}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}
        </div>
    );
};

export default Training;

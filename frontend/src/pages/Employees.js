import React, { useState, useEffect } from 'react';
import api from '../services/api';

const Employees = () => {
    const [employees, setEmployees] = useState([]);
    const [filteredEmployees, setFilteredEmployees] = useState([]);
    const [searchQuery, setSearchQuery] = useState('');
    const [statusFilter, setStatusFilter] = useState('All');
    const [genderFilter, setGenderFilter] = useState('All');
    const [loading, setLoading] = useState(true);
    const [showAddModal, setShowAddModal] = useState(false);
    const [showEditModal, setShowEditModal] = useState(false);
    const [editingEmployee, setEditingEmployee] = useState(null);
    const [newEmployee, setNewEmployee] = useState({
        Employee_ID: '',
        First_Name: '',
        Last_Name: '',
        Gender: 'Male',
        DOB: '',
        Employment_Status: 'Active',
        Work_Email: ''
    });


    useEffect(() => {
        fetchEmployees();
    }, []);

    const fetchEmployees = async () => {
        try {
            const data = await api.getEmployees();
            setEmployees(Array.isArray(data) ? data : []);
            setFilteredEmployees(Array.isArray(data) ? data : []);
        } catch (error) {
            console.error('Error fetching employees:', error);
        } finally {
            setLoading(false);
        }
    };

    // Combined filter effect (search + status + gender)
    useEffect(() => {
        let filtered = employees;

        // Apply status filter
        if (statusFilter !== 'All') {
            filtered = filtered.filter(emp => emp.Employment_Status === statusFilter);
        }

        // Apply gender filter
        if (genderFilter !== 'All') {
            filtered = filtered.filter(emp => emp.Gender === genderFilter);
        }

        // Apply search filter
        if (searchQuery.trim() !== '') {
            const query = searchQuery.toLowerCase();
            filtered = filtered.filter(emp =>
                emp.Employee_ID?.toLowerCase().includes(query) ||
                emp.First_Name?.toLowerCase().includes(query) ||
                emp.Last_Name?.toLowerCase().includes(query) ||
                `${emp.First_Name} ${emp.Last_Name}`.toLowerCase().includes(query) ||
                emp.Work_Email?.toLowerCase().includes(query) ||
                emp.Employment_Status?.toLowerCase().includes(query)
            );
        }

        setFilteredEmployees(filtered);
    }, [searchQuery, statusFilter, genderFilter, employees]);

    const handleAddEmployee = async (e) => {
        e.preventDefault();
        try {
            await api.addEmployee(newEmployee);
            setShowAddModal(false);
            setNewEmployee({
                Employee_ID: '',
                First_Name: '',
                Last_Name: '',
                Gender: 'Male',
                DOB: '',
                Employment_Status: 'Active',
                Work_Email: ''
            });
            fetchEmployees();
        } catch (error) {
            console.error('Error adding employee:', error);
            alert('Error adding employee. Please try again.');
        }
    };

    const handleEditClick = (emp) => {
        setEditingEmployee({
            Employee_ID: emp.Employee_ID,
            First_Name: emp.First_Name || '',
            Last_Name: emp.Last_Name || '',
            Gender: emp.Gender || 'Male',
            DOB: emp.DOB ? emp.DOB.split('T')[0] : '',
            Employment_Status: emp.Employment_Status || 'Active',
            Work_Email: emp.Work_Email || ''
        });
        setShowEditModal(true);
    };

    const handleEditEmployee = async (e) => {
        e.preventDefault();
        try {
            await api.updateEmployee(editingEmployee.Employee_ID, editingEmployee);
            setShowEditModal(false);
            setEditingEmployee(null);
            fetchEmployees();
        } catch (error) {
            console.error('Error updating employee:', error);
            alert('Error updating employee. Please try again.');
        }
    };

    const handleDeleteEmployee = async (id) => {
        if (window.confirm(`Are you sure you want to delete employee ${id}?`)) {
            try {
                await api.deleteEmployee(id);
                fetchEmployees();
            } catch (error) {
                console.error('Error deleting employee:', error);
                alert('Error deleting employee. Please try again.');
            }
        }
    };



    const getStatusClass = (status) => {
        switch (status?.toLowerCase()) {
            case 'active': return 'active';
            case 'probation': return 'probation';
            case 'leave': return 'leave';
            case 'retired': return 'retired';
            default: return '';
        }
    };



    if (loading) {
        return <div className="loading"><div className="spinner"></div></div>;
    }

    return (
        <div className="employees-page">
            <div className="page-header">
                <div>
                    <h1>Employees</h1>
                    <p>Manage employee records</p>
                </div>
                <button className="btn btn-primary" onClick={() => setShowAddModal(true)}>
                    ➕ Add Employee
                </button>
            </div>

            <div className="data-table-container">
                <div className="table-header">
                    <h2>All Employees ({filteredEmployees.length} {(searchQuery || statusFilter !== 'All' || genderFilter !== 'All') ? `of ${employees.length}` : ''})</h2>
                    <div style={{ display: 'flex', gap: '10px', alignItems: 'center' }}>
                        <select
                            className="form-select"
                            value={statusFilter}
                            onChange={(e) => setStatusFilter(e.target.value)}
                            style={{ width: 'auto', minWidth: '150px' }}
                        >
                            <option value="All">All Status</option>
                            <option value="Active">Active</option>
                            <option value="Probation">Probation</option>
                            <option value="Leave">Leave</option>
                            <option value="Retired">Retired</option>
                        </select>

                        <select
                            className="form-select"
                            value={genderFilter}
                            onChange={(e) => setGenderFilter(e.target.value)}
                            style={{ width: 'auto', minWidth: '130px' }}
                        >
                            <option value="All">All Genders</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>

                        <div className="search-container">
                            <input
                                type="text"
                                className="search-input"
                                placeholder="Search employees..."
                                value={searchQuery}
                                onChange={(e) => setSearchQuery(e.target.value)}
                            />
                            <span className="search-icon">🔍</span>
                        </div>
                    </div>
                </div>
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Gender</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredEmployees.length === 0 ? (
                            <tr>
                                <td colSpan="6" style={{
                                    textAlign: 'center',
                                    padding: '60px 20px',
                                    color: 'var(--text-tertiary)'
                                }}>
                                    <div style={{ fontSize: '3rem', marginBottom: '12px' }}>🔍</div>
                                    <p>No employees found{searchQuery ? ` matching "${searchQuery}"` : ''}</p>
                                </td>
                            </tr>
                        ) : (
                            filteredEmployees.map((emp) => (
                                <tr key={emp.Employee_ID}>
                                    <td>{emp.Employee_ID}</td>
                                    <td>{emp.First_Name} {emp.Last_Name}</td>
                                    <td>{emp.Work_Email}</td>
                                    <td>{emp.Gender}</td>
                                    <td>
                                        <span className={`status-badge ${getStatusClass(emp.Employment_Status)}`}>
                                            {emp.Employment_Status}
                                        </span>
                                    </td>
                                    <td>
                                        <button
                                            className="btn"
                                            style={{ padding: '6px 10px', marginRight: '6px', color: 'var(--info)', background: 'var(--bg-elevated)' }}
                                            onClick={() => handleEditClick(emp)}
                                            title="Edit"
                                        >
                                            ✏️
                                        </button>

                                        <button
                                            className="btn"
                                            style={{ padding: '6px 10px', color: '#e53935', background: 'var(--bg-elevated)' }}
                                            onClick={() => handleDeleteEmployee(emp.Employee_ID)}
                                            title="Delete"
                                        >
                                            🗑️
                                        </button>
                                    </td>
                                </tr>
                            )))
                        }
                    </tbody>
                </table>
            </div>

            {/* Add Employee Modal */}
            {showAddModal && (
                <div className="modal-overlay" onClick={() => setShowAddModal(false)}>
                    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                        <div className="modal-header">
                            <h2>Add New Employee</h2>
                            <button className="modal-close" onClick={() => setShowAddModal(false)}>×</button>
                        </div>
                        <form onSubmit={handleAddEmployee} className="modal-body">
                            <div className="form-group">
                                <label className="form-label">Employee ID</label>
                                <input className="form-input" type="text" value={newEmployee.Employee_ID}
                                    onChange={(e) => setNewEmployee({ ...newEmployee, Employee_ID: e.target.value })}
                                    placeholder="e.g., E1051" required />
                            </div>
                            <div className="form-row">
                                <div className="form-group">
                                    <label className="form-label">First Name</label>
                                    <input className="form-input" type="text" value={newEmployee.First_Name}
                                        onChange={(e) => setNewEmployee({ ...newEmployee, First_Name: e.target.value })} required />
                                </div>
                                <div className="form-group">
                                    <label className="form-label">Last Name</label>
                                    <input className="form-input" type="text" value={newEmployee.Last_Name}
                                        onChange={(e) => setNewEmployee({ ...newEmployee, Last_Name: e.target.value })} required />
                                </div>
                            </div>
                            <div className="form-group">
                                <label className="form-label">Work Email</label>
                                <input className="form-input" type="email" value={newEmployee.Work_Email}
                                    onChange={(e) => setNewEmployee({ ...newEmployee, Work_Email: e.target.value })}
                                    placeholder="employee@giu.de" required />
                            </div>
                            <div className="form-row">
                                <div className="form-group">
                                    <label className="form-label">Gender</label>
                                    <select className="form-select" value={newEmployee.Gender}
                                        onChange={(e) => setNewEmployee({ ...newEmployee, Gender: e.target.value })}>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                                <div className="form-group">
                                    <label className="form-label">Date of Birth</label>
                                    <input className="form-input" type="date" value={newEmployee.DOB}
                                        onChange={(e) => setNewEmployee({ ...newEmployee, DOB: e.target.value })} required />
                                </div>
                            </div>
                            <div className="form-group">
                                <label className="form-label">Employment Status</label>
                                <select className="form-select" value={newEmployee.Employment_Status}
                                    onChange={(e) => setNewEmployee({ ...newEmployee, Employment_Status: e.target.value })}>
                                    <option value="Active">Active</option>
                                    <option value="Probation">Probation</option>
                                    <option value="Leave">Leave</option>
                                    <option value="Retired">Retired</option>
                                </select>
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn" style={{ background: 'var(--bg-elevated)', color: 'var(--text-primary)', border: '1px solid var(--border)' }}
                                    onClick={() => setShowAddModal(false)}>Cancel</button>
                                <button type="submit" className="btn btn-primary">Add Employee</button>
                            </div>
                        </form>
                    </div>
                </div>
            )}

            {/* Edit Employee Modal */}
            {showEditModal && editingEmployee && (
                <div className="modal-overlay" onClick={() => setShowEditModal(false)}>
                    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                        <div className="modal-header">
                            <h2>Edit Employee</h2>
                            <button className="modal-close" onClick={() => setShowEditModal(false)}>×</button>
                        </div>
                        <form onSubmit={handleEditEmployee} className="modal-body">
                            <div className="form-group">
                                <label className="form-label">Employee ID</label>
                                <input className="form-input" style={{ opacity: 0.6 }} type="text" value={editingEmployee.Employee_ID} disabled />
                            </div>
                            <div className="form-row">
                                <div className="form-group">
                                    <label className="form-label">First Name</label>
                                    <input className="form-input" type="text" value={editingEmployee.First_Name}
                                        onChange={(e) => setEditingEmployee({ ...editingEmployee, First_Name: e.target.value })} required />
                                </div>
                                <div className="form-group">
                                    <label className="form-label">Last Name</label>
                                    <input className="form-input" type="text" value={editingEmployee.Last_Name}
                                        onChange={(e) => setEditingEmployee({ ...editingEmployee, Last_Name: e.target.value })} required />
                                </div>
                            </div>
                            <div className="form-group">
                                <label className="form-label">Work Email</label>
                                <input className="form-input" type="email" value={editingEmployee.Work_Email}
                                    onChange={(e) => setEditingEmployee({ ...editingEmployee, Work_Email: e.target.value })} required />
                            </div>
                            <div className="form-row">
                                <div className="form-group">
                                    <label className="form-label">Gender</label>
                                    <select className="form-select" value={editingEmployee.Gender}
                                        onChange={(e) => setEditingEmployee({ ...editingEmployee, Gender: e.target.value })}>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                                <div className="form-group">
                                    <label className="form-label">Date of Birth</label>
                                    <input className="form-input" type="date" value={editingEmployee.DOB}
                                        onChange={(e) => setEditingEmployee({ ...editingEmployee, DOB: e.target.value })} />
                                </div>
                            </div>
                            <div className="form-group">
                                <label className="form-label">Employment Status</label>
                                <select className="form-select" value={editingEmployee.Employment_Status}
                                    onChange={(e) => setEditingEmployee({ ...editingEmployee, Employment_Status: e.target.value })}>
                                    <option value="Active">Active</option>
                                    <option value="Probation">Probation</option>
                                    <option value="Leave">Leave</option>
                                    <option value="Retired">Retired</option>
                                </select>
                            </div>
                            <div className="modal-footer">
                                <button type="button" className="btn" style={{ background: 'var(--bg-elevated)', color: 'var(--text-primary)', border: '1px solid var(--border)' }}
                                    onClick={() => setShowEditModal(false)}>Cancel</button>
                                <button type="submit" className="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            )}


        </div>
    );
};

export default Employees;

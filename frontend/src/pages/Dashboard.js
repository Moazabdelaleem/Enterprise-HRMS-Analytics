import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';

const Dashboard = () => {
    const navigate = useNavigate();
    const [stats, setStats] = useState({
        totalEmployees: 0,
        activeEmployees: 0,
        probationEmployees: 0,
        leaveEmployees: 0,
        departments: 0,
        jobs: 0,
        training: 0
    });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const data = await api.getDashboardStats();
                setStats(data);
            } catch (error) {
                console.error('Error fetching stats:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    if (loading) {
        return (
            <div className="loading">
                <div className="spinner"></div>
                <p>Loading dashboard...</p>
            </div>
        );
    }

    const statCards = [
        { label: 'Total Employees', value: stats.totalEmployees, icon: '👥', color: 'purple', path: '/employees' },
        { label: 'Departments', value: stats.departments, icon: '🏢', color: 'blue', path: '/departments' },
        { label: 'Job Positions', value: stats.jobs, icon: '💼', color: 'teal', path: '/jobs' },
        { label: 'Training Programs', value: stats.training, icon: '📚', color: 'orange', path: '/training' },
    ];

    return (
        <div className="dashboard">
            <div className="page-header">
                <div>
                    <h1>Dashboard</h1>
                    <p>Welcome back! Here's what's happening with your HRMS today.</p>
                </div>
            </div>

            <div className="stats-grid">
                {statCards.map((card, index) => (
                    <div
                        className="stat-card"
                        key={index}
                        style={{ animationDelay: `${index * 0.1}s`, cursor: 'pointer' }}
                        onClick={() => navigate(card.path)}
                    >
                        <div className={`stat-icon ${card.color}`}>{card.icon}</div>
                        <div className="stat-info">
                            <h3>{card.label}</h3>
                            <div className="value">{card.value}</div>
                        </div>
                    </div>
                ))}
            </div>

            {/* Main Content Grid */}
            <div className="dashboard-grid">

                {/* Quick Stats Column */}
                <div className="dashboard-section col-span-8">
                    <div className="section-title">
                        <span>📊</span> Quick Stats
                    </div>
                    <div className="quick-stats-list">
                        <div className="quick-stat-row">
                            <span style={{ color: 'var(--text-secondary)' }}>Active Employees</span>
                            <span style={{ fontWeight: '700', color: 'var(--success)' }}>{stats.activeEmployees}</span>
                        </div>
                        <div className="quick-stat-row">
                            <span style={{ color: 'var(--text-secondary)' }}>On Probation</span>
                            <span style={{ fontWeight: '700', color: 'var(--warning)' }}>{stats.probationEmployees}</span>
                        </div>
                        <div className="quick-stat-row">
                            <span style={{ color: 'var(--text-secondary)' }}>On Leave</span>
                            <span style={{ fontWeight: '700', color: 'var(--info)' }}>{stats.leaveEmployees}</span>
                        </div>
                        <div className="quick-stat-row">
                            <span style={{ color: 'var(--text-secondary)' }}>Training Completion</span>
                            <span style={{ fontWeight: '700', color: '#8b5cf6' }}>78%</span>
                        </div>
                    </div>
                </div>

                {/* Quick Actions Column */}
                <div className="dashboard-section col-span-4">
                    <div className="section-title">
                        <span>🚀</span> Quick Actions
                    </div>
                    <div className="quick-actions-list">
                        {[
                            { label: 'Add New Employee', icon: '👤', path: '/employees', color: '#8b5cf6', bg: 'rgba(139, 92, 246, 0.1)' },
                            { label: 'View Departments', icon: '🏢', path: '/departments', color: '#3b82f6', bg: 'rgba(59, 130, 246, 0.1)' },
                            { label: 'Manage Training', icon: '📚', path: '/training', color: '#f97316', bg: 'rgba(249, 115, 22, 0.1)' },
                            { label: 'Performance Reviews', icon: '📈', path: '/performance', color: '#22c55e', bg: 'rgba(34, 197, 94, 0.1)' },
                        ].map((action, i) => (
                            <div
                                key={i}
                                onClick={() => navigate(action.path)}
                                className="quick-action-card"
                                style={{ cursor: 'pointer' }}
                            >
                                <div className="action-icon-box" style={{ color: action.color, background: action.bg }}>
                                    {action.icon}
                                </div>
                                <span style={{ fontWeight: '500' }}>{action.label}</span>
                                <span className="action-arrow" style={{ color: action.color }}>→</span>
                            </div>
                        ))}
                    </div>
                </div>

            </div>
        </div>
    );
};

export default Dashboard;

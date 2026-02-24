import React, { useState, useEffect } from 'react';
import api from '../services/api';

const Performance = () => {
    const [appraisals, setAppraisals] = useState([]);
    const [filteredAppraisals, setFilteredAppraisals] = useState([]);
    const [ratingFilter, setRatingFilter] = useState('All');
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const data = await api.getAppraisals();
                const apprArray = Array.isArray(data) ? data : [];
                setAppraisals(apprArray);
                setFilteredAppraisals(apprArray);
                setError(null);
            } catch (err) {
                console.error('Error fetching performance data:', err);
                setError('Failed to load performance data. Please check if the backend is running.');
                setAppraisals([]);
                setFilteredAppraisals([]);
            } finally {
                setLoading(false);
            }
        };
        fetchData();
    }, []);

    // Rating filter effect
    useEffect(() => {
        if (ratingFilter === 'All') {
            setFilteredAppraisals(appraisals);
        } else {
            const filtered = appraisals.filter(a => {
                const score = parseFloat(a.Overall_Score) || 0;
                switch (ratingFilter) {
                    case 'Excellent':
                        return score >= 4.5;
                    case 'Good':
                        return score >= 3.5 && score < 4.5;
                    case 'Satisfactory':
                        return score >= 2.5 && score < 3.5;
                    case 'Needs Improvement':
                        return score < 2.5;
                    default:
                        return true;
                }
            });
            setFilteredAppraisals(filtered);
        }
    }, [appraisals, ratingFilter]);

    const getScoreColor = (score) => {
        const numScore = parseFloat(score) || 0;
        if (numScore >= 4.5) return '#22c55e';
        if (numScore >= 3.5) return '#3b82f6';
        if (numScore >= 2.5) return '#f97316';
        return '#ef4444';
    };

    const getScoreBadge = (score) => {
        const numScore = parseFloat(score) || 0;
        if (numScore >= 4.5) return { label: 'Excellent', color: '#22c55e' };
        if (numScore >= 3.5) return { label: 'Good', color: '#3b82f6' };
        if (numScore >= 2.5) return { label: 'Satisfactory', color: '#f97316' };
        return { label: 'Needs Improvement', color: '#ef4444' };
    };

    const formatScore = (score) => {
        const numScore = parseFloat(score);
        return isNaN(numScore) ? 'N/A' : numScore.toFixed(1);
    };

    if (loading) {
        return (
            <div className="loading">
                <div className="spinner"></div>
                <p>Loading performance data...</p>
            </div>
        );
    }

    if (error) {
        return (
            <div className="performance-page">
                <div className="page-header">
                    <h1>Performance</h1>
                    <p>View appraisals and performance reviews</p>
                </div>
                <div className="data-table-container" style={{ padding: '40px', textAlign: 'center' }}>
                    <p style={{ color: '#ef4444', marginBottom: '16px' }}>⚠️ {error}</p>
                    <button className="btn btn-primary" onClick={() => window.location.reload()}>
                        🔄 Retry
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div className="performance-page">
            <div className="page-header">
                <div>
                    <h1>Performance</h1>
                    <p>View appraisals and performance reviews</p>
                </div>
            </div>

            {/* Summary Cards */}
            <div className="stats-grid" style={{ marginBottom: '24px' }}>
                <div className="stat-card">
                    <div className="stat-icon purple">📊</div>
                    <div className="stat-info">
                        <h3>Total Appraisals</h3>
                        <div className="value">{filteredAppraisals.length}</div>
                    </div>
                </div>
                <div className="stat-card">
                    <div className="stat-icon teal">⭐</div>
                    <div className="stat-info">
                        <h3>Average Score</h3>
                        <div className="value">
                            {filteredAppraisals.length > 0
                                ? (filteredAppraisals.reduce((sum, a) => sum + (parseFloat(a.Overall_Score) || 0), 0) / filteredAppraisals.length).toFixed(1)
                                : 'N/A'}
                        </div>
                    </div>
                </div>
                <div className="stat-card">
                    <div className="stat-icon blue">🏆</div>
                    <div className="stat-info">
                        <h3>Excellent Reviews</h3>
                        <div className="value">
                            {filteredAppraisals.filter(a => parseFloat(a.Overall_Score) >= 4.5).length}
                        </div>
                    </div>
                </div>
            </div>

            <div className="data-table-container">
                <div className="table-header">
                    <h2>📋 Appraisal Records ({filteredAppraisals.length} {ratingFilter !== 'All' ? `of ${appraisals.length}` : ''})</h2>
                    <select
                        className="form-select"
                        value={ratingFilter}
                        onChange={(e) => setRatingFilter(e.target.value)}
                        style={{ width: 'auto', minWidth: '180px' }}
                    >
                        <option value="All">All Ratings</option>
                        <option value="Excellent">Excellent (≥4.5)</option>
                        <option value="Good">Good (3.5-4.4)</option>
                        <option value="Satisfactory">Satisfactory (2.5-3.4)</option>
                        <option value="Needs Improvement">Needs Improvement (&lt;2.5)</option>
                    </select>
                </div>
                {filteredAppraisals.length === 0 ? (
                    <div style={{ padding: '60px', textAlign: 'center', color: 'var(--text-secondary)' }}>
                        <p style={{ fontSize: '3rem', marginBottom: '16px' }}>📭</p>
                        <p>No appraisal records found.</p>
                    </div>
                ) : (
                    <table className="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Employee</th>
                                <th>Job Title</th>
                                <th>Cycle</th>
                                <th>Date</th>
                                <th>Score</th>
                                <th>Rating</th>
                                <th>Manager Comments</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredAppraisals.map((appr) => {
                                const badge = getScoreBadge(appr.Overall_Score);
                                return (
                                    <tr key={appr.Appraisal_ID}>
                                        <td style={{ fontWeight: '600', color: 'var(--accent-purple)' }}>
                                            #{appr.Appraisal_ID}
                                        </td>
                                        <td>{appr.Employee_Name || 'N/A'}</td>
                                        <td>{appr.Job_Title || 'N/A'}</td>
                                        <td>
                                            <span style={{
                                                background: 'rgba(139, 92, 246, 0.1)',
                                                padding: '4px 10px',
                                                borderRadius: '6px',
                                                fontSize: '0.8rem'
                                            }}>
                                                {appr.Cycle_Name || `Cycle ${appr.Cycle_ID}`}
                                            </span>
                                        </td>
                                        <td>
                                            {appr.Appraisal_Date
                                                ? new Date(appr.Appraisal_Date).toLocaleDateString('en-US', {
                                                    year: 'numeric',
                                                    month: 'short',
                                                    day: 'numeric'
                                                })
                                                : 'N/A'}
                                        </td>
                                        <td>
                                            <span style={{
                                                color: getScoreColor(appr.Overall_Score),
                                                fontWeight: '800',
                                                fontSize: '1.2rem'
                                            }}>
                                                {formatScore(appr.Overall_Score)}
                                            </span>
                                        </td>
                                        <td>
                                            <span style={{
                                                background: `${badge.color}20`,
                                                color: badge.color,
                                                padding: '4px 12px',
                                                borderRadius: '20px',
                                                fontSize: '0.75rem',
                                                fontWeight: '600',
                                                border: `1px solid ${badge.color}40`
                                            }}>
                                                {badge.label}
                                            </span>
                                        </td>
                                        <td style={{
                                            maxWidth: '250px',
                                            overflow: 'hidden',
                                            textOverflow: 'ellipsis',
                                            whiteSpace: 'nowrap',
                                            color: 'var(--text-secondary)'
                                        }}>
                                            {appr.Manager_Comments || 'No comments'}
                                        </td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </table>
                )}
            </div>
        </div>
    );
};

export default Performance;

import React, { useContext } from 'react';
import { NavLink } from 'react-router-dom';
import { ThemeContext } from '../App';
import './Sidebar.css';

const Sidebar = () => {
    const { isDarkMode, toggleTheme } = useContext(ThemeContext);

    const menuItems = [
        { path: '/', icon: '🏠', label: 'Dashboard' },
        { path: '/employees', icon: '👥', label: 'Employees' },
        { path: '/departments', icon: '🏢', label: 'Departments' },
        { path: '/jobs', icon: '💼', label: 'Jobs' },
        { path: '/training', icon: '📚', label: 'Training' },
        { path: '/performance', icon: '📈', label: 'Performance' },
    ];

    return (
        <aside className="sidebar">
            <div className="sidebar-header">
                <div className="logo">
                    <img src="/giu-logo.png" alt="GIU Logo" style={{ width: '100%', maxWidth: '180px', borderRadius: '10px' }} />
                </div>
                <div className="portal-name">
                    <h2>HR Management Portal</h2>
                    <span>EMPLOYEE SYSTEM</span>
                </div>
            </div>

            <nav className="sidebar-nav">
                {menuItems.map((item) => (
                    <NavLink
                        key={item.path}
                        to={item.path}
                        className={({ isActive }) => `nav-item ${isActive ? 'active' : ''}`}
                    >
                        <span className="nav-icon">{item.icon}</span>
                        <span className="nav-label">{item.label}</span>
                    </NavLink>
                ))}
            </nav>

            <div className="sidebar-footer">
                <button className="theme-toggle" onClick={toggleTheme}>
                    <span>{isDarkMode ? '☀️' : '🌙'}</span>
                    <span>{isDarkMode ? 'Light Mode' : 'Dark Mode'}</span>
                </button>
            </div>
        </aside>
    );
};

export default Sidebar;

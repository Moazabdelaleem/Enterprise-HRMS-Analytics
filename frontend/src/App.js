import React, { useState, createContext, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import Employees from './pages/Employees';
import Departments from './pages/Departments';
import Jobs from './pages/Jobs';
import JobAssignments from './pages/JobAssignments';
import Training from './pages/Training';
import Performance from './pages/Performance';
import './index.css';

// Create Theme Context
export const ThemeContext = createContext();

function App() {
    const [isDarkMode, setIsDarkMode] = useState(() => {
        const savedTheme = localStorage.getItem('theme');
        if (!savedTheme) return false; // Default to light mode

        // Handle both boolean JSON and string values
        try {
            return JSON.parse(savedTheme);
        } catch {
            // If parsing fails, check if it's a string like "dark" or "light"
            return savedTheme === 'dark' || savedTheme === 'true';
        }
    });

    useEffect(() => {
        localStorage.setItem('theme', JSON.stringify(isDarkMode));
    }, [isDarkMode]);

    const toggleTheme = () => {
        setIsDarkMode(prev => !prev);
    };

    return (
        <ThemeContext.Provider value={{ isDarkMode, toggleTheme }}>
            <Router>
                <div className={`app ${isDarkMode ? 'dark-theme' : 'light-theme'}`}>
                    <Sidebar />
                    <main className="main-content">
                        <Routes>
                            <Route path="/" element={<Dashboard />} />
                            <Route path="/employees" element={<Employees />} />
                            <Route path="/departments" element={<Departments />} />
                            <Route path="/jobs" element={<Jobs />} />
                            <Route path="/jobs/assignments" element={<JobAssignments />} />
                            <Route path="/training" element={<Training />} />
                            <Route path="/performance" element={<Performance />} />
                        </Routes>
                    </main>
                </div>
            </Router>
        </ThemeContext.Provider>
    );
}

export default App;

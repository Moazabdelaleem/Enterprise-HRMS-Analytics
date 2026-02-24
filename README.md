# 🏢 Enterprise HRMS Analytics

A full-stack **Human Resource Management System (HRMS)** web application built with **React** and **Node.js/Express**, backed by a **MySQL** database. The system provides a centralized portal for managing employees, departments, job positions, training programs, performance reviews, and job assignments.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
- [API Endpoints](#-api-endpoints)
- [Screenshots](#-screenshots)
- [License](#-license)

---

## ✨ Features

| Module | Capabilities |
|---|---|
| **Dashboard** | Real-time overview with total employees, departments, jobs, training programs, quick stats (active, probation, on leave), and quick action shortcuts. |
| **Employee Management** | View all employees, add new employees, update information, delete records, and view employee statistics. |
| **Department Management** | Browse and manage organizational departments. |
| **Job Positions** | View and manage available job positions within the organization. |
| **Job Assignments** | Assign employees to job positions, update assignments, and track current placements. |
| **Training Programs** | View training programs and track employee training enrollment and progress. |
| **Performance Reviews** | Manage performance appraisals and track KPI scores. |
| **Theme Switching** | Toggle between Light and Dark modes with persistent preference via `localStorage`. |

---

## 🛠 Tech Stack

### Frontend
| Technology | Purpose |
|---|---|
| **React 18** | UI library |
| **React Router v6** | Client-side routing |
| **React Icons** | Icon library |
| **Axios** | HTTP client |
| **Vanilla CSS** | Styling with CSS variables for theming |

### Backend
| Technology | Purpose |
|---|---|
| **Node.js** | JavaScript runtime |
| **Express.js** | Web framework |
| **MySQL2** | Database driver (connection pooling) |
| **dotenv** | Environment variable management |
| **CORS** | Cross-origin resource sharing |
| **body-parser** | Request body parsing |
| **nodemon** | Development auto-restart |

### Database
| Technology | Purpose |
|---|---|
| **MySQL** | Relational database (HRMS_Project schema) |

---

## 📁 Project Structure

```
hrms-web-app/
├── backend/
│   ├── config/
│   │   └── database.js          # MySQL connection pool configuration
│   ├── controllers/
│   │   ├── assignmentController.js
│   │   ├── departmentController.js
│   │   ├── employeeController.js
│   │   ├── jobController.js
│   │   ├── performanceController.js
│   │   └── trainingController.js
│   ├── routes/
│   │   ├── assignmentRoutes.js
│   │   ├── departmentRoutes.js
│   │   ├── employeeRoutes.js
│   │   ├── jobRoutes.js
│   │   ├── performanceRoutes.js
│   │   └── trainingRoutes.js
│   ├── .env.example             # Environment variables template
│   ├── package.json
│   └── server.js                # Express app entry point
│
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   │   ├── Sidebar.js       # Navigation sidebar with theme toggle
│   │   │   └── Sidebar.css
│   │   ├── pages/
│   │   │   ├── Dashboard.js     # Overview & quick stats
│   │   │   ├── Employees.js     # Employee CRUD
│   │   │   ├── Departments.js   # Department listing
│   │   │   ├── Jobs.js          # Job positions
│   │   │   ├── JobAssignments.js# Assign employees to jobs
│   │   │   ├── Training.js      # Training programs & enrollment
│   │   │   └── Performance.js   # Appraisals & KPI scores
│   │   ├── services/
│   │   │   └── api.js           # API service layer (fetch-based)
│   │   ├── App.js               # Root component with routing & theme context
│   │   ├── index.js             # React entry point
│   │   └── index.css            # Global styles (light/dark themes)
│   └── package.json
│
└── README.md
```

---

## 📌 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v16 or higher) — [Download](https://nodejs.org/)
- **npm** (comes with Node.js)
- **MySQL Server** (v8.0+) — [Download](https://dev.mysql.com/downloads/)
- **Git** — [Download](https://git-scm.com/)

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Moazabdelaleem/Enterprise-HRMS-Analytics.git
cd Enterprise-HRMS-Analytics
```

### 2. Set Up the Database

1. Start your MySQL server.
2. Create the `HRMS_Project` database and run the schema/seed scripts to populate the required tables (employees, departments, jobs, training programs, performance data, etc.).

### 3. Configure the Backend

```bash
cd backend
cp .env.example .env
```

Edit the `.env` file with your MySQL credentials:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password_here
DB_NAME=HRMS_Project
PORT=5000
```

### 4. Install Dependencies

**Backend:**
```bash
cd backend
npm install
```

**Frontend:**
```bash
cd frontend
npm install
```

### 5. Run the Application

**Start the backend server:**
```bash
cd backend
npm run dev
```
The API will be available at `http://localhost:5000/api`

**Start the frontend (in a separate terminal):**
```bash
cd frontend
npm start
```
The app will open at `http://localhost:3000`

---

## 📡 API Endpoints

### Health Check
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/health` | Server health check |

### Employees
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/employees` | Get all employees |
| `GET` | `/api/employees/stats` | Get employee statistics |
| `GET` | `/api/employees/:id` | Get employee by ID |
| `POST` | `/api/employees` | Create a new employee |
| `PUT` | `/api/employees/:id` | Update an employee |
| `DELETE` | `/api/employees/:id` | Delete an employee |

### Departments
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/departments` | Get all departments |

### Jobs
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/jobs` | Get all job positions |

### Assignments
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/assignments` | Get all job assignments |
| `POST` | `/api/assignments` | Create a new assignment |
| `PUT` | `/api/assignments/:id` | Update an assignment |

### Training
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/training/programs` | Get all training programs |
| `GET` | `/api/training/employee-training` | Get employee training records |

### Performance
| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/performance/appraisals` | Get all appraisals |
| `GET` | `/api/performance/kpi-scores` | Get KPI scores |

---

## 🖼 Screenshots

> _Screenshots coming soon._

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Built with ❤️ for the GIU Databases Course — 5th Semester
</p>

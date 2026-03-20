# Enterprise HR Management System (HRMS)

> A full-stack Human Resource Management System built on a rigorous relational database architecture. The system manages employee records, job assignments, performance appraisals, and training programs — with a Node.js web interface and Power BI executive dashboards.

---

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Tech Stack](#tech-stack)
3. [Database Schema](#database-schema)
4. [Database Objects](#database-objects)
5. [Web Application](#web-application)
6. [Setup & Running the Project](#setup--running-the-project)
7. [SQL Files Reference](#sql-files-reference)
8. [Project Structure](#project-structure)

---

## Project Overview

The HRMS manages the full HR lifecycle for a university environment:

| Module | Description |
|--------|-------------|
| **Employee Management** | Profiles, disabilities, qualifications, insurance |
| **Organizational Structure** | Universities → Faculties → Departments → Jobs |
| **Job Assignments** | Assign employees to jobs with contracts |
| **Performance Management** | KPI-based appraisals, scoring, appeals |
| **Training & Development** | Programs, enrollments, certificates |

**Database Stats**: 23 tables · 6 triggers · 15 functions · 18 stored procedures · 12 views · 356+ sample records

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| **Database** | MySQL 8.0+ |
| **Backend API** | Node.js 18+ · Express.js 4 |
| **Frontend** | React 18 · React Router · Axios |
| **Analytics** | Power BI Desktop (ODBC connection) |

---

## Database Schema

### Table Hierarchy (load order)

The schema uses a **level-based design** to prevent circular foreign key dependencies:

```
Level 0 (Independent):   UNIVERSITY, DEPARTMENT, EMPLOYEE, CONTRACT,
                          PERFORMANCE_CYCLE, TRAINING_PROGRAM

Level 1 (→ Level 0):     FACULTY, JOB, EMPLOYEE_DISABILITY,
                          SOCIAL_INSURANCE, EDUCATIONAL_QUALIFICATION,
                          PROFESSIONAL_CERTIFICATE

Level 2 (→ Level 1):     ACADEMIC_DEPARTMENT, ADMINISTRATIVE_DEPARTMENT,
                          JOB_OBJECTIVE

Level 3 (→ Level 2):     OBJECTIVE_KPI, JOB_ASSIGNMENT, EMPLOYEE_TRAINING

Level 4 (→ Level 3):     EMPLOYEE_KPI_SCORE, APPRAISAL

Level 5 (→ Level 4):     APPEAL, TRAINING_CERTIFICATE
```

### Key Relationships

```
UNIVERSITY (1) ──> (N) FACULTY (1) ──> (N) ACADEMIC_DEPARTMENT
UNIVERSITY (1) ──> (N) ADMINISTRATIVE_DEPARTMENT

EMPLOYEE (1) ──> (N) JOB_ASSIGNMENT (N) <── (1) JOB
JOB (1) ──> (N) JOB_OBJECTIVE (1) ──> (N) OBJECTIVE_KPI

JOB_ASSIGNMENT (1) ──> (N) APPRAISAL
APPRAISAL    (1) ──> (0/1) APPEAL

EMPLOYEE (1) ──> (N) EMPLOYEE_TRAINING (N) <── (1) TRAINING_PROGRAM
EMPLOYEE_TRAINING (1) ──> (0/1) TRAINING_CERTIFICATE
```

---

## Database Objects

### Triggers (6)

| Trigger | Event | Purpose |
|---------|-------|---------|
| `trg_validate_obj_weight` | BEFORE INSERT on JOB_OBJECTIVE | Prevents objective weights exceeding 100% |
| `trg_prevent_obj_delete` | BEFORE DELETE on JOB_OBJECTIVE | Blocks deletion if KPIs exist |
| `trg_prevent_emp_delete` | BEFORE DELETE on EMPLOYEE | Blocks deletion if active assignments exist |
| `trg_calc_weighted_score` | BEFORE INSERT on EMPLOYEE_KPI_SCORE | Auto-calculates `(Score × Weight) / 100` |
| `trg_prevent_prog_delete` | BEFORE DELETE on TRAINING_PROGRAM | Blocks deletion if employees are enrolled |
| `trg_validate_cert` | BEFORE INSERT on TRAINING_CERTIFICATE | Ensures training is completed before issuing cert |

### Functions (15)

| Category | Functions |
|----------|-----------|
| **Employee Info** | `GetEmployeeFullName`, `CalculateAge`, `CalculateServiceYears` |
| **Performance** | `CalculateKPIScore`, `CalculateWeightedScore`, `GetTotalJobWeight`, `GetCycleDuration` |
| **Dashboard Metrics** | `GetTotalEmployees`, `GetActiveEmployees`, `GetTotalJobs`, `GetActiveJobs`, `GetTotalTrainingPrograms`, `GetTotalCertificates`, `GetKPICompletionRate`, `GetAvgAppraisalScore` |

### Stored Procedures (18)

| Category | Procedures |
|----------|-----------|
| **Employee** | `AddNewEmployee`, `UpdateEmployeeContactInfo`, `AddEmployeeDisability`, `GetEmployeeFullProfile` |
| **Job & Assignment** | `AddNewJob`, `AddJobObjective`, `AssignJobToEmployee` |
| **Performance** | `CreatePerformanceCycle`, `AddEmployeeKPIScore`, `CalculateEmployeeWeightedScore`, `SubmitAppeal` |
| **Training** | `AddTrainingProgram`, `AssignTrainingToEmployee`, `RecordTrainingCompletion`, `IssueTrainingCertificate` |

### Views (12)

| View | Purpose |
|------|---------|
| `vw_EmployeeCountByDept` | Headcount per department |
| `vw_GenderDistribution` | Gender breakdown with % |
| `vw_EmploymentStatusDist` | Active/Leave/Retired breakdown |
| `vw_JobsByLevel` | Jobs grouped by level |
| `vw_SalaryStatsByCategory` | Min/Max/Avg salary per category |
| `vw_ActiveJobAssignments` | All current employee-job mappings |
| `vw_KPIScoresSummary` | KPI scores with employee and cycle info |
| `vw_AppraisalsPerCycle` | Average scores per performance cycle |
| `vw_FullAppraisalSummary` | Complete appraisal details |
| `vw_TrainingParticipation` | Enrollment count per program |
| `vw_TrainingCompletionStats` | Completion/In-Progress stats |
| `vw_OrgHierarchy` | University → Faculty → Dept headcount |

---

## Web Application

### Architecture

```
Browser (http://localhost:3000)
    │
    ▼ HTTP REST API
React Frontend (Port 3000)
    │
    ▼ JSON
Express Backend (Port 5000)
    │
    ▼ SQL
MySQL Database (HRMS_Project)
```

### Pages (6)

| Route | Page | Features |
|-------|------|---------|
| `/` | Dashboard | Summary cards, stats (uses DB functions) |
| `/employees` | Employees | Full CRUD · search · profile view |
| `/departments` | Departments | CRUD · Academic/Admin type badges |
| `/jobs` | Jobs | CRUD · salary ranges · job hierarchy |
| `/performance` | Performance | Appraisals · KPI scores · appeals |
| `/training` | Training | Programs · enrollments · certificates |

### REST API Endpoints (25+)

```
GET/POST/PUT/DELETE  /api/employees
GET/POST/PUT/DELETE  /api/departments
GET/POST/PUT/DELETE  /api/jobs
GET                  /api/performance/appraisals
GET                  /api/performance/cycles
GET                  /api/performance/appeals
GET/POST             /api/training/programs
GET/POST/PUT         /api/training/enrollments
```

---

## Setup & Running the Project

### Prerequisites

```
✅ MySQL 8.0+
✅ Node.js 18+
✅ npm
```

### Step 1 — Set Up the Database

Open MySQL Workbench or any MySQL client and run the SQL files **in this order**:

```sql
-- 1. Create schema and all 23 tables
SOURCE "HRMS Tables creation.sql";

-- 2. Load initial data
SOURCE "Insertions for HRMS.sql";

-- 3. Load additional sample data
SOURCE "Additional Insertions for HRMS.sql";

-- 4. Create triggers (automation + validation)
SOURCE "HRMS Triggers.sql";

-- 5. Create functions (calculations + metrics)
SOURCE "HRMS Functions.sql";

-- 6. Create stored procedures (complex operations)
SOURCE "HRMS Procedures.sql";

-- 7. Create views (reporting + dashboards)
SOURCE "HRMS Views.sql";

-- 8. Create master views (Power BI analytics)
SOURCE "CREATE_MASTER_VIEWS.sql";
```

> **Note**: Run these from the HRMS_Project database:
> ```sql
> CREATE DATABASE IF NOT EXISTS HRMS_Project;
> USE HRMS_Project;
> ```

### Step 2 — Configure the Backend

```bash
cd hrms-web-app/backend
```

Create a `.env` file:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=HRMS_Project
PORT=5000
```

### Step 3 — Start the Backend

```bash
cd hrms-web-app/backend
npm install
npm start
```

Backend runs at: `http://localhost:5000`

### Step 4 — Start the Frontend

```bash
cd hrms-web-app/frontend
npm install
npm start
```

Frontend runs at: `http://localhost:3000`

### Step 5 — Verify

Open `http://localhost:3000` in your browser. The Dashboard should show live employee and job counts pulled directly from the database.

---

## SQL Files Reference

| File | Contents | Run Order |
|------|----------|-----------|
| `HRMS Tables creation.sql` | 23 table definitions · CHECK constraints · FK constraints | 1st |
| `Insertions for HRMS.sql` | Core seed data (~150 records) | 2nd |
| `Additional Insertions for HRMS.sql` | Extended sample data (~200 records) | 3rd |
| `HRMS Triggers.sql` | 6 triggers for automation and validation | 4th |
| `HRMS Functions.sql` | 15 user-defined functions | 5th |
| `HRMS Procedures.sql` | 18 stored procedures | 6th |
| `HRMS Views.sql` | 12 reporting views | 7th |
| `CREATE_MASTER_VIEWS.sql` | Analytics views for Power BI | 8th |

---

## Project Structure

```
Enterprise-HRMS-Analytics/
│
├── 📂 hrms-web-app/            # Full-stack web application
│   ├── backend/                # Node.js + Express API
│   │   ├── server.js
│   │   ├── config/database.js
│   │   ├── routes/             # 5 route modules
│   │   ├── controllers/        # 5 controller modules
│   │   └── .env.example
│   └── frontend/               # React SPA
│       └── src/
│           ├── pages/          # 6 page components
│           ├── components/     # Reusable UI
│           └── services/api.js # Axios HTTP client
│
├── 📄 HRMS Tables creation.sql
├── 📄 Insertions for HRMS.sql
├── 📄 Additional Insertions for HRMS.sql
├── 📄 HRMS Triggers.sql
├── 📄 HRMS Functions.sql
├── 📄 HRMS Procedures.sql
├── 📄 HRMS Views.sql
└── 📄 CREATE_MASTER_VIEWS.sql
```

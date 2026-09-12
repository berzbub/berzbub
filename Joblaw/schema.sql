-- schema.sql
-- Database schema for Joblaw Pro-Bono Legal Matching Platform

CREATE TABLE IF NOT EXISTS lawyers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    roll_number TEXT UNIQUE NOT NULL,
    specialty_sector TEXT NOT NULL,
    is_verified BOOLEAN DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cases (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_alias TEXT NOT NULL,
    bureaucratic_agency TEXT NOT NULL,
    case_details TEXT NOT NULL,
    status TEXT DEFAULT 'PENDING',
    assigned_lawyer_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_lawyer_id) REFERENCES lawyers (id)
);

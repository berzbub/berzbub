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
-- schema.sql (Advanced Version for Joblaw Pro-Bono Platform)
-- Includes DICT KYC Verification, Privacy Protection, Agency Routing, and Global Embassies Directory

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
    encrypted_real_name TEXT NOT NULL, -- Protected for privacy, revealed only to verified lawyers
    phone_number TEXT NOT NULL,
    preferred_language TEXT DEFAULT 'Tagalog', -- Supports Tagalog and English
    bureaucratic_agency TEXT NOT NULL,       -- Target agency (e.g., DOLE, DSWD, DFA)
    case_details TEXT NOT NULL,
    intake_channel TEXT DEFAULT 'text',      -- Supports 'text' or 'voice' intake
    dict_verified BOOLEAN DEFAULT 0,         -- DICT KYC verification status
    status TEXT DEFAULT 'PENDING',
    assigned_lawyer_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assigned_lawyer_id) REFERENCES lawyers (id)
);

CREATE TABLE IF NOT EXISTS philippine_embassies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    country TEXT NOT NULL,
    city TEXT NOT NULL,
    office_type TEXT NOT NULL, -- 'Embassy', 'Consulate General', or 'MWO/POLO'
    address TEXT NOT NULL,
    contact_numbers TEXT NOT NULL,
    email TEXT,
    jurisdiction TEXT
);

-- Initial insertion of key global Philippine diplomatic posts for international triage
INSERT OR IGNORE INTO philippine_embassies (country, city, office_type, address, contact_numbers, email, jurisdiction) VALUES
('Canada', 'Ottawa', 'Embassy', '30 Murray Street, Ottawa, ON K1N 5M4', '+1 (613) 233-1121', 'ottawa.pe@dfa.gov.ph', 'Eastern Ontario, Ottawa-Gatineau'),
('Canada', 'Vancouver', 'Consulate General', 'Suite 660, 999 Canada Place, Vancouver, BC V6C 3E1', '+1 (604) 685-1619', 'vancouver.pcg@dfa.gov.ph', 'British Columbia, Yukon, NWT'),
('United States', 'Washington D.C.', 'Embassy', '1600 Massachusetts Ave NW, Washington, D.C. 20036', '+1 (202) 467-9300', 'info@philippineembassy-dc.org', 'District of Columbia and assigned states'),
('United States', 'Los Angeles', 'Consulate General', '3435 Wilshire Blvd, Suite 1600, Los Angeles, CA 90010', '+1 (213) 637-3010', 'losangeles.pcg@dfa.gov.ph', 'Southern California, Arizona, etc.'),
('Saudi Arabia', 'Riyadh', 'Embassy', 'Diplomatic Quarter, Riyadh, Saudi Arabia', '+966 1 488-3888', 'riyadh.pe@dfa.gov.ph', 'Central and Northern Saudi Arabia'),
('United Arab Emirates', 'Dubai', 'Consulate General', 'Beirut Street, Al Qusais 3, Dubai, UAE', '+971 4 220-7100', 'dubai.pcg@dfa.gov.ph', 'Dubai and Northern Emirates');

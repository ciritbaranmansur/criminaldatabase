-- ============================================================
-- CRIMINAL DATABASE FOR LAW ENFORCEMENT
-- CSE 204 - Spring 2026 - Group Project (FINAL VERSION)
-- Akdeniz University, Department of Computer Engineering
-- ============================================================
-- Redesigned based on customer/professor feedback:
--   - Many-to-many: Officers ↔ Crimes (multiple officers per crime)
--   - Many-to-many: Suspects ↔ Crimes (multiple suspects per crime)
--   - Expanded sentence types: Prison, Fine, Community Service, etc.
--   - 5 required UI queries included
--   - Views included
--   - ALTER TABLE demonstrations included
-- ============================================================

-- ============================================================
-- DROP TABLES (clean re-run, reverse FK order)
-- ============================================================
DROP TABLE IF EXISTS sentence;
DROP TABLE IF EXISTS evidence;
DROP TABLE IF EXISTS arrest;
DROP TABLE IF EXISTS crime_suspect;
DROP TABLE IF EXISTS crime_officer;
DROP TABLE IF EXISTS crime;
DROP TABLE IF EXISTS officer;
DROP TABLE IF EXISTS suspect;
DROP TABLE IF EXISTS officer_rank;
DROP TABLE IF EXISTS unit;

-- ============================================================
-- PART A: TABLE DEFINITIONS
-- ============================================================

-- ---------------------
-- LOOKUP TABLES
-- ---------------------

CREATE TABLE officer_rank (
    rank_id     INT PRIMARY KEY AUTO_INCREMENT,
    rank_name   VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE unit (
    unit_id     INT PRIMARY KEY AUTO_INCREMENT,
    unit_name   VARCHAR(100) NOT NULL UNIQUE
);

-- ---------------------
-- CORE ENTITY TABLES
-- ---------------------

CREATE TABLE suspect (
    suspect_id      INT PRIMARY KEY,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    date_of_birth   DATE         NOT NULL,
    gender          CHAR(1)      NOT NULL CHECK (gender IN ('M', 'F')),
    nation_id       VARCHAR(20)  NOT NULL UNIQUE,
    height_cm       INT,
    weight_kg       INT,
    eye_color       VARCHAR(20),
    hair_color      VARCHAR(20),
    address         VARCHAR(255),
    phone           VARCHAR(20)
);

CREATE TABLE officer (
    officer_id      INT PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    badge_number    VARCHAR(20) NOT NULL UNIQUE,
    rank_id         INT NOT NULL,
    unit_id         INT NOT NULL,
    phone           VARCHAR(20),
    FOREIGN KEY (rank_id) REFERENCES officer_rank(rank_id),
    FOREIGN KEY (unit_id) REFERENCES unit(unit_id)
);

CREATE TABLE crime (
    crime_id            INT PRIMARY KEY,
    crime_type          VARCHAR(50)  NOT NULL,
    crime_date          DATE         NOT NULL,
    crime_time          TIME         NOT NULL,
    crime_location      VARCHAR(100) NOT NULL,
    city                VARCHAR(100) NOT NULL,
    district            VARCHAR(100),
    crime_description   TEXT,
    crime_status        VARCHAR(30)  NOT NULL DEFAULT 'Open'
);

-- ---------------------
-- JUNCTION / BRIDGE TABLES (M:N relationships)
-- ---------------------

-- Multiple officers can work the same crime
-- Multiple crimes can be worked by the same officer
CREATE TABLE crime_officer (
    crime_id    INT NOT NULL,
    officer_id  INT NOT NULL,
    role        VARCHAR(30) DEFAULT 'Assigned',  -- 'Lead', 'Assigned', 'Support'
    assigned_date DATE,
    PRIMARY KEY (crime_id, officer_id),
    FOREIGN KEY (crime_id)  REFERENCES crime(crime_id),
    FOREIGN KEY (officer_id) REFERENCES officer(officer_id)
);

-- Multiple suspects can be linked to the same crime
-- A suspect can be involved in multiple crimes
CREATE TABLE crime_suspect (
    crime_id    INT NOT NULL,
    suspect_id  INT NOT NULL,
    suspect_role VARCHAR(30) DEFAULT 'Suspect',  -- 'Suspect', 'Accomplice', 'Cleared'
    PRIMARY KEY (crime_id, suspect_id),
    FOREIGN KEY (crime_id)   REFERENCES crime(crime_id),
    FOREIGN KEY (suspect_id) REFERENCES suspect(suspect_id)
);

-- ---------------------
-- DEPENDENT TABLES
-- ---------------------

CREATE TABLE arrest (
    arrest_id           INT PRIMARY KEY,
    crime_id            INT NOT NULL,
    suspect_id          INT NOT NULL,
    arresting_officer_id INT NOT NULL,
    arrest_date         DATE NOT NULL,
    arrest_location     VARCHAR(255),
    FOREIGN KEY (crime_id)            REFERENCES crime(crime_id),
    FOREIGN KEY (suspect_id)          REFERENCES suspect(suspect_id),
    FOREIGN KEY (arresting_officer_id) REFERENCES officer(officer_id)
);

CREATE TABLE evidence (
    evidence_id             INT PRIMARY KEY,
    crime_id                INT NOT NULL,
    evidence_type           VARCHAR(50) NOT NULL,
    evidence_description    TEXT,
    FOREIGN KEY (crime_id)  REFERENCES crime(crime_id)
);

-- Expanded sentence table: supports Prison, Fine, Community Service, etc.
CREATE TABLE sentence (
    sentence_id         INT PRIMARY KEY AUTO_INCREMENT,
    court_case_no       INT NOT NULL UNIQUE,
    crime_id            INT NOT NULL,
    suspect_id          INT NOT NULL,
    hearing_date        DATE,
    verdict             VARCHAR(30),
    sentence_type       VARCHAR(30),      -- 'Prison', 'Fine', 'Community Service', 'Probation', 'Combined'
    prison_duration     VARCHAR(30),      -- e.g. '5 Years', '6 Months', NULL if no prison
    fine_amount         DECIMAL(12,2),    -- monetary fine, NULL if no fine
    community_service_hours INT,          -- NULL if not applicable
    notes               TEXT,
    FOREIGN KEY (crime_id)   REFERENCES crime(crime_id),
    FOREIGN KEY (suspect_id) REFERENCES suspect(suspect_id)
);


-- ============================================================
-- PART B: ALTER TABLE DEMONSTRATIONS
-- (Showing ability to modify schema after creation)
-- ============================================================

-- Add email column to officer table
ALTER TABLE officer ADD COLUMN email VARCHAR(100);

-- Add status column to suspect (Active, Incarcerated, Released, Wanted)
ALTER TABLE suspect ADD COLUMN status VARCHAR(20) DEFAULT 'Active';

-- Drop the phone column from suspect (example of dropping a column)
ALTER TABLE suspect DROP COLUMN phone;

-- Rename column: crime_description → description in crime table
ALTER TABLE crime CHANGE COLUMN crime_description description TEXT;

-- Add a constraint: fine_amount must be positive if provided
ALTER TABLE sentence ADD CONSTRAINT chk_fine_positive CHECK (fine_amount IS NULL OR fine_amount >= 0);

-- Add index for faster lookups
ALTER TABLE crime ADD INDEX idx_crime_city (city);
ALTER TABLE crime ADD INDEX idx_crime_status (crime_status);
ALTER TABLE arrest ADD INDEX idx_arrest_date (arrest_date);


-- ============================================================
-- PART C: MOCK DATA
-- ============================================================

-- ---------------------
-- OFFICER RANKS
-- ---------------------
INSERT INTO officer_rank (rank_id, rank_name) VALUES
(1, 'Detective'),
(2, 'Sergeant'),
(3, 'Officer'),
(4, 'Captain'),
(5, 'Lieutenant');

-- ---------------------
-- UNITS
-- ---------------------
INSERT INTO unit (unit_id, unit_name) VALUES
(1, 'Homicide Unit'),
(2, 'Fraud Unit'),
(3, 'Narcotics Unit'),
(4, 'Cyber Unit');

-- ---------------------
-- SUSPECTS (23 unique)
-- ---------------------
INSERT INTO suspect (suspect_id, first_name, last_name, date_of_birth, gender, nation_id, height_cm, weight_kg, eye_color, hair_color, address, status) VALUES
(1,  'James',   'Mitchell',    '1985-03-12', 'M', 'US-482931', 182, 85,  'Brown',  'Black',  '123 Elm Street, New York',       'Incarcerated'),
(2,  'Sarah',   'Connor',      '1990-07-24', 'F', 'UK-119283', 165, 60,  'Blue',   'Blonde', '456 Oak Avenue, London',         'Active'),
(3,  'Carlos',  'Mendoza',     '1978-11-05', 'M', 'MX-334521', 175, 78,  'Brown',  'Brown',  '789 Pine Road, Mexico City',     'Incarcerated'),
(4,  'Aisha',   'Rahman',      '1995-01-30', 'F', 'TR-229384', 160, 55,  'Black',  'Black',  '321 Cedar Lane, Istanbul',       'Active'),
(5,  'Ivan',    'Petrov',      '1982-09-18', 'M', 'RU-558821', 180, 90,  'Grey',   'Brown',  '654 Birch Blvd, Moscow',         'Incarcerated'),
(6,  'Emily',   'Zhang',       '1993-04-22', 'F', 'CN-774412', 158, 52,  'Black',  'Black',  '987 Maple Street, Shanghai',     'Released'),
(7,  'Omar',    'Hassan',      '1975-08-14', 'M', 'EG-991023', 178, 82,  'Brown',  'Black',  '147 Walnut Ave, Cairo',          'Incarcerated'),
(8,  'Laura',   'Bianchi',     '1988-12-03', 'F', 'IT-663312', 167, 62,  'Green',  'Brown',  '258 Olive Street, Rome',         'Released'),
(9,  'Marcus',  'Williams',    '1970-06-27', 'M', 'US-103847', 190, 95,  'Blue',   'Grey',   '369 Chestnut Road, Chicago',     'Incarcerated'),
(10, 'Yuki',    'Tanaka',      '1997-02-15', 'F', 'JP-447821', 155, 48,  'Brown',  'Black',  '741 Sakura Lane, Tokyo',         'Active'),
(11, 'Ali',     'Yilmaz',      '1980-05-10', 'M', 'TR-881234', 177, 80,  'Brown',  'Black',  '55 Ataturk Blvd, Ankara',        'Incarcerated'),
(12, 'Sofia',   'Rossi',       '1992-08-20', 'F', 'IT-224433', 163, 57,  'Green',  'Brown',  '99 Via Roma, Milan',             'Active'),
(13, 'Viktor',  'Kozlov',      '1968-12-01', 'M', 'RU-334455', 185, 100, 'Blue',   'Brown',  '12 Lenin Street, St Petersburg', 'Active'),
(14, 'Chen',    'Wei',         '1983-03-25', 'M', 'CN-556677', 172, 75,  'Brown',  'Black',  '200 Nanjing Road, Beijing',      'Incarcerated'),
(15, 'Maria',   'Garcia',      '1991-07-14', 'F', 'MX-667788', 161, 58,  'Brown',  'Black',  '333 Insurgentes, Guadalajara',   'Active'),
(16, 'John',    'Smith',       '1975-11-30', 'M', 'US-778899', 180, 88,  'Blue',   'Blonde', '500 Broadway, Los Angeles',      'Active'),
(17, 'Fatima',  'Al-Rashid',   '1988-06-05', 'F', 'EG-889900', 158, 54,  'Black',  'Black',  '77 Tahrir Square, Alexandria',   'Released'),
(18, 'David',   'Brown',       '1979-09-12', 'M', 'UK-990011', 183, 87,  'Green',  'Brown',  '88 Baker Street, Manchester',    'Active'),
(19, 'Hana',    'Nakamura',    '1996-01-18', 'F', 'JP-112233', 157, 50,  'Brown',  'Black',  '22 Ginza Street, Osaka',         'Released'),
(20, 'Lena',    'Muller',      '1987-04-08', 'F', 'DE-223344', 166, 61,  'Blue',   'Blonde', '14 Unter den Linden, Berlin',    'Active'),
(21, 'Pedro',   'Alvarez',     '1984-10-22', 'M', 'MX-334566', 174, 79,  'Brown',  'Black',  '400 Reforma, Monterrey',         'Incarcerated'),
(22, 'Nina',    'Johansson',   '1993-02-28', 'F', 'SE-445566', 168, 63,  'Blue',   'Blonde', '9 Stortorget, Stockholm',        'Active'),
(23, 'Grace',   'Obi',         '1990-11-11', 'F', 'NG-556677', 162, 60,  'Brown',  'Black',  '15 Lagos Island, Lagos',         'Incarcerated');

-- ---------------------
-- OFFICERS (5 unique, now with real names and badge numbers)
-- ---------------------
INSERT INTO officer (officer_id, first_name, last_name, badge_number, rank_id, unit_id, phone, email) VALUES
(1, 'Robert',   'Clarke',   'B-1001', 1, 1, '555-101-0001', 'r.clarke@police.gov'),
(2, 'Angela',   'Price',    'B-1002', 2, 2, '555-101-0002', 'a.price@police.gov'),
(3, 'Thomas',   'Reed',     'B-1003', 3, 3, '555-101-0003', 't.reed@police.gov'),
(4, 'Diana',    'Foster',   'B-1004', 4, 4, '555-101-0004', 'd.foster@police.gov'),
(5, 'Samuel',   'Grant',    'B-1005', 5, 1, '555-101-0005', 's.grant@police.gov');

-- ---------------------
-- CRIMES (30)
-- ---------------------
INSERT INTO crime (crime_id, crime_type, crime_date, crime_time, crime_location, city, district, description, crime_status) VALUES
(1,  'Robbery',      '2023-01-15', '14:30:00', 'City Bank',           'New York',      'Manhattan',       'Armed robbery at gunpoint',                    'Closed'),
(2,  'Fraud',        '2023-02-20', '09:15:00', 'Downtown Office',     'London',        'Westminster',     'Identity fraud using stolen documents',         'Under Investigation'),
(3,  'Drug Offense', '2023-03-10', '22:45:00', 'Back Alley',          'Mexico City',   'Tepito',          'Found with 2kg of cocaine',                    'Closed'),
(4,  'Assault',      '2023-04-05', '18:00:00', 'Central Park',        'Istanbul',      'Beyoglu',         'Physical assault on a pedestrian',             'Under Investigation'),
(5,  'Cybercrime',   '2023-05-12', '11:30:00', 'Online',              'Moscow',        'Central',         'Hacked into government database',              'Closed'),
(6,  'Robbery',      '2023-06-18', '16:45:00', 'Jewelry Store',       'New York',      'Brooklyn',        'Stole jewelry worth $50000',                   'Closed'),
(7,  'Shoplifting',  '2023-07-22', '13:00:00', 'Shopping Mall',       'Shanghai',      'Pudong',          'Stole clothes worth $500',                     'Closed'),
(8,  'Murder',       '2023-08-30', '02:15:00', 'Harbor District',     'Cairo',         'Downtown',        'Suspected murder near the harbor',             'Under Investigation'),
(9,  'Fraud',        '2023-09-14', '10:00:00', 'Bank Branch',         'Rome',          'Trastevere',      'Credit card skimming operation',               'Closed'),
(10, 'Drug Offense', '2023-10-25', '23:59:00', 'Warehouse District',  'Mexico City',   'Iztapalapa',      'Drug distribution warehouse raid',             'Under Investigation'),
(11, 'Murder',       '2023-11-03', '03:30:00', 'Dark Alley',          'Chicago',       'Southside',       'Victim found stabbed in alley',                'Closed'),
(12, 'Cybercrime',   '2023-11-18', '08:00:00', 'Online',              'Tokyo',         'Shibuya',         'Phishing scam targeting bank customers',       'Under Investigation'),
(13, 'Drug Offense', '2023-12-01', '20:00:00', 'Street Corner',       'Chicago',       'Northside',       'Selling narcotics on street corner',           'Closed'),
(14, 'Assault',      '2023-12-15', '21:00:00', 'Night Club',          'Ankara',        'Cankaya',         'Bar fight resulting in serious injury',        'Closed'),
(15, 'Fraud',        '2024-01-08', '11:00:00', 'Office Building',     'Milan',         'Centro',          'Tax evasion scheme uncovered',                 'Under Investigation'),
(16, 'Murder',       '2024-01-22', '01:00:00', 'Riverside',           'St Petersburg', NULL,              'Body discovered by riverside',                 'Under Investigation'),
(17, 'Fraud',        '2024-02-05', '14:00:00', 'Online',              'Istanbul',      'Sisli',           'Online shopping fraud scheme',                 'Closed'),
(18, 'Drug Offense', '2024-02-18', '17:30:00', 'Airport',             'Beijing',       'Chaoyang',        'Caught smuggling drugs at airport',            'Closed'),
(19, 'Assault',      '2024-03-01', '19:45:00', 'Parking Lot',         'Guadalajara',   'Zapopan',         'Attacked victim in parking lot',               'Under Investigation'),
(20, 'Robbery',      '2024-03-15', '15:00:00', 'Convenience Store',   'Los Angeles',   'Hollywood',       'Robbed store at knifepoint',                  'Closed'),
(21, 'Fraud',        '2024-04-02', '10:30:00', 'Bank',                'Alexandria',    'Downtown',        'Attempted bank fraud',                         'Closed'),
(22, 'Cybercrime',   '2024-04-20', '09:00:00', 'Online',              'Manchester',    'City Centre',     'Ransomware attack on hospital',               'Under Investigation'),
(23, 'Drug Offense', '2024-05-10', '23:00:00', 'Nightclub',           'Osaka',         'Namba',           'Distributing MDMA at nightclub',              'Closed'),
(24, 'Assault',      '2024-05-25', '20:30:00', 'Restaurant',          'Cairo',         'Zamalek',         'Assault with deadly weapon',                  'Closed'),
(25, 'Fraud',        '2024-06-12', '13:15:00', 'Insurance Office',    'Berlin',        'Mitte',           'Insurance fraud worth $200000',               'Under Investigation'),
(26, 'Cybercrime',   '2024-07-01', '16:00:00', 'Online',              'Ankara',        'Kecioren',        'Credit card cloning ring',                    'Closed'),
(27, 'Drug Offense', '2024-07-18', '21:30:00', 'Highway',             'Monterrey',     'San Nicolas',     'Drug trafficking on highway',                 'Closed'),
(28, 'Cybercrime',   '2024-08-05', '07:45:00', 'Online',              'Stockholm',     'Gamla Stan',      'Data breach of government servers',           'Under Investigation'),
(29, 'Murder',       '2024-09-01', '00:30:00', 'Hotel Room',          'Los Angeles',   'Downtown',        'Victim found dead in hotel room',             'Under Investigation'),
(30, 'Fraud',        '2024-09-20', '12:00:00', 'Office',              'Lagos',         'Victoria Island', 'Ponzi scheme defrauding 200 victims',         'Closed');

-- ---------------------
-- CRIME ↔ OFFICER (M:N) — multiple officers per crime
-- ---------------------
INSERT INTO crime_officer (crime_id, officer_id, role, assigned_date) VALUES
-- Some crimes have 1 officer, some have 2-3 (showing M:N)
(1,  1, 'Lead',     '2023-01-15'),
(1,  3, 'Support',  '2023-01-15'),
(2,  2, 'Lead',     '2023-02-20'),
(3,  3, 'Lead',     '2023-03-10'),
(3,  5, 'Support',  '2023-03-11'),
(4,  1, 'Lead',     '2023-04-05'),
(5,  4, 'Lead',     '2023-05-12'),
(6,  2, 'Lead',     '2023-06-18'),
(6,  1, 'Support',  '2023-06-19'),
(7,  3, 'Lead',     '2023-07-22'),
(8,  5, 'Lead',     '2023-08-30'),
(8,  1, 'Support',  '2023-09-01'),
(8,  4, 'Support',  '2023-09-05'),
(9,  4, 'Lead',     '2023-09-14'),
(10, 5, 'Lead',     '2023-10-25'),
(10, 3, 'Support',  '2023-10-26'),
(11, 1, 'Lead',     '2023-11-03'),
(12, 2, 'Lead',     '2023-11-18'),
(12, 4, 'Support',  '2023-11-19'),
(13, 3, 'Lead',     '2023-12-01'),
(14, 5, 'Lead',     '2023-12-15'),
(15, 4, 'Lead',     '2024-01-08'),
(15, 2, 'Support',  '2024-01-09'),
(16, 1, 'Lead',     '2024-01-22'),
(16, 5, 'Support',  '2024-01-23'),
(17, 2, 'Lead',     '2024-02-05'),
(18, 3, 'Lead',     '2024-02-18'),
(19, 5, 'Lead',     '2024-03-01'),
(20, 1, 'Lead',     '2024-03-15'),
(21, 2, 'Lead',     '2024-04-02'),
(22, 4, 'Lead',     '2024-04-20'),
(22, 2, 'Support',  '2024-04-21'),
(23, 3, 'Lead',     '2024-05-10'),
(24, 1, 'Lead',     '2024-05-25'),
(24, 5, 'Support',  '2024-05-26'),
(25, 5, 'Lead',     '2024-06-12'),
(26, 2, 'Lead',     '2024-07-01'),
(26, 4, 'Support',  '2024-07-02'),
(27, 3, 'Lead',     '2024-07-18'),
(28, 4, 'Lead',     '2024-08-05'),
(29, 5, 'Lead',     '2024-09-01'),
(29, 1, 'Support',  '2024-09-02'),
(30, 1, 'Lead',     '2024-09-20');

-- ---------------------
-- CRIME ↔ SUSPECT (M:N) — multiple suspects per crime
-- ---------------------
INSERT INTO crime_suspect (crime_id, suspect_id, suspect_role) VALUES
-- Original 1:1 mappings from CSV
(1,  1,  'Suspect'),
(2,  2,  'Suspect'),
(3,  3,  'Suspect'),
(4,  4,  'Suspect'),
(5,  5,  'Suspect'),
(6,  1,  'Suspect'),
(7,  6,  'Suspect'),
(8,  7,  'Suspect'),
(9,  8,  'Suspect'),
(10, 3,  'Suspect'),
(11, 9,  'Suspect'),
(12, 10, 'Suspect'),
(13, 9,  'Suspect'),
(14, 11, 'Suspect'),
(15, 12, 'Suspect'),
(16, 13, 'Suspect'),
(17, 4,  'Suspect'),
(18, 14, 'Suspect'),
(19, 15, 'Suspect'),
(20, 16, 'Suspect'),
(21, 17, 'Suspect'),
(22, 18, 'Suspect'),
(23, 19, 'Suspect'),
(24, 7,  'Suspect'),
(25, 20, 'Suspect'),
(26, 11, 'Suspect'),
(27, 21, 'Suspect'),
(28, 22, 'Suspect'),
(29, 16, 'Suspect'),
(30, 23, 'Suspect'),
-- Additional suspects per crime (showing M:N capability)
(1,  16, 'Accomplice'),    -- Crime 1: John Smith was accomplice in bank robbery
(3,  21, 'Accomplice'),    -- Crime 3: Pedro Alvarez helped with drug deal
(8,  13, 'Suspect'),       -- Crime 8: Viktor Kozlov also suspected in harbor murder
(10, 21, 'Accomplice'),    -- Crime 10: Pedro Alvarez in warehouse raid
(11, 3,  'Suspect'),       -- Crime 11: Carlos Mendoza also suspected in alley murder
(16, 7,  'Suspect'),       -- Crime 16: Omar Hassan also suspected in riverside case
(22, 5,  'Accomplice'),    -- Crime 22: Ivan Petrov helped with ransomware
(27, 3,  'Accomplice'),    -- Crime 27: Carlos Mendoza in highway drug trafficking
(29, 9,  'Suspect');       -- Crime 29: Marcus Williams also suspected in hotel murder

-- ---------------------
-- ARRESTS (30 + extra for multi-suspect crimes)
-- ---------------------
INSERT INTO arrest (arrest_id, crime_id, suspect_id, arresting_officer_id, arrest_date, arrest_location) VALUES
(1,  1,  1,  1, '2023-01-16', 'City Bank'),
(2,  2,  2,  2, '2023-03-01', 'Downtown Office'),
(3,  3,  3,  3, '2023-03-11', 'Back Alley'),
(4,  4,  4,  1, '2023-04-06', 'Central Park'),
(5,  5,  5,  4, '2023-05-13', 'Suspects Home'),
(6,  6,  1,  2, '2023-06-19', 'Jewelry Store'),
(7,  7,  6,  3, '2023-07-22', 'Shopping Mall'),
(8,  8,  7,  5, '2023-09-01', 'Harbor District'),
(9,  9,  8,  4, '2023-09-15', 'Bank Branch'),
(10, 10, 3,  5, '2023-10-26', 'Warehouse'),
(11, 11, 9,  1, '2023-11-04', 'Dark Alley'),
(12, 12, 10, 2, '2023-11-20', 'Suspects Home'),
(13, 13, 9,  3, '2023-12-02', 'Street Corner'),
(14, 14, 11, 5, '2023-12-16', 'Night Club'),
(15, 15, 12, 4, '2024-01-10', 'Office Building'),
(16, 16, 13, 1, '2024-01-23', 'Riverside'),
(17, 17, 4,  2, '2024-02-07', 'Suspects Home'),
(18, 18, 14, 3, '2024-02-18', 'Airport'),
(19, 19, 15, 5, '2024-03-02', 'Parking Lot'),
(20, 20, 16, 1, '2024-03-16', 'Convenience Store'),
(21, 21, 17, 2, '2024-04-03', 'Bank'),
(22, 22, 18, 4, '2024-04-22', 'Suspects Home'),
(23, 23, 19, 3, '2024-05-11', 'Nightclub'),
(24, 24, 7,  1, '2024-05-26', 'Restaurant'),
(25, 25, 20, 5, '2024-06-14', 'Insurance Office'),
(26, 26, 11, 2, '2024-07-03', 'Suspects Home'),
(27, 27, 21, 3, '2024-07-19', 'Highway'),
(28, 28, 22, 4, '2024-08-07', 'Suspects Home'),
(29, 29, 16, 5, '2024-09-02', 'Hotel'),
(30, 30, 23, 1, '2024-09-22', 'Office'),
-- Additional arrests for accomplices
(31, 1,  16, 3, '2023-01-17', 'Brooklyn Apartment'),
(32, 3,  21, 5, '2023-03-12', 'Monterrey Safe House'),
(33, 10, 21, 3, '2023-10-27', 'Highway Checkpoint');

-- ---------------------
-- EVIDENCE (30)
-- ---------------------
INSERT INTO evidence (evidence_id, crime_id, evidence_type, evidence_description) VALUES
(1,  1,  'Weapon',    '9mm pistol found at scene'),
(2,  2,  'Document',  'Forged passport recovered'),
(3,  3,  'Substance', '2kg cocaine in black bag'),
(4,  4,  'CCTV',      'CCTV footage of the incident'),
(5,  5,  'Digital',   'Laptop with hacking tools'),
(6,  6,  'Weapon',    'Crowbar used to break display'),
(7,  7,  'CCTV',      'Mall CCTV footage'),
(8,  8,  'Forensic',  'Blood sample matching suspect'),
(9,  9,  'Document',  'Skimming device recovered'),
(10, 10, 'Substance', 'Large quantity of narcotics found'),
(11, 11, 'Forensic',  'Knife with fingerprints'),
(12, 12, 'Digital',   'Computer with phishing scripts'),
(13, 13, 'Substance', 'Bags of heroin recovered'),
(14, 14, 'CCTV',      'Club security footage'),
(15, 15, 'Document',  'Falsified tax documents'),
(16, 16, 'Forensic',  'DNA sample from crime scene'),
(17, 17, 'Digital',   'Mobile phone with fraud app'),
(18, 18, 'Substance', 'Drugs hidden in luggage'),
(19, 19, 'CCTV',      'Parking lot camera footage'),
(20, 20, 'Weapon',    'Knife recovered near scene'),
(21, 21, 'Document',  'Fake identity papers'),
(22, 22, 'Digital',   'Multiple hard drives seized'),
(23, 23, 'Substance', 'MDMA tablets in handbag'),
(24, 24, 'Weapon',    'Broken bottle used as weapon'),
(25, 25, 'Document',  'Falsified insurance claims'),
(26, 26, 'Digital',   'Card cloning equipment'),
(27, 27, 'Substance', '10kg of methamphetamine'),
(28, 28, 'Digital',   'Server logs and USB drives'),
(29, 29, 'Forensic',  'Toxicology report and hair samples'),
(30, 30, 'Document',  'Financial records and receipts');

-- ---------------------
-- SENTENCES — Expanded with Fine, Community Service, Combined types
-- ---------------------
INSERT INTO sentence (court_case_no, crime_id, suspect_id, hearing_date, verdict, sentence_type, prison_duration, fine_amount, community_service_hours, notes) VALUES
(1001, 1,  1,  '2023-06-01', 'Guilty',     'Prison',             '5 Years',   NULL,       NULL, NULL),
(1002, 2,  2,  '2023-07-15', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Awaiting trial'),
(1003, 3,  3,  '2023-08-20', 'Guilty',     'Prison',             '8 Years',   NULL,       NULL, NULL),
(1004, 4,  4,  '2023-09-10', 'Not Guilty', NULL,                 NULL,        NULL,       NULL, 'Acquitted due to insufficient evidence'),
(1005, 5,  5,  '2023-10-05', 'Guilty',     'Combined',           '3 Years',   50000.00,   NULL, 'Prison + fine for government hacking'),
(1006, 6,  1,  '2023-11-12', 'Guilty',     'Prison',             '4 Years',   NULL,       NULL, NULL),
(1007, 7,  6,  '2023-12-01', 'Guilty',     'Fine',               NULL,        2500.00,    NULL, 'Monetary fine only'),
(1008, 8,  7,  '2024-01-15', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Murder investigation ongoing'),
(1009, 9,  8,  '2024-02-20', 'Guilty',     'Combined',           '2 Years',   25000.00,   NULL, 'Prison + fine for skimming operation'),
(1010, 10, 3,  '2024-03-10', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Drug raid under investigation'),
(1011, 11, 9,  '2024-04-05', 'Guilty',     'Prison',             '15 Years',  NULL,       NULL, 'First degree murder'),
(1012, 12, 10, '2024-05-01', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Phishing investigation ongoing'),
(1013, 13, 9,  '2024-06-10', 'Guilty',     'Prison',             '6 Years',   NULL,       NULL, NULL),
(1014, 14, 11, '2024-07-15', 'Guilty',     'Community Service',  NULL,        NULL,       500,  '500 hours community service for bar fight'),
(1015, 15, 12, '2024-08-20', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Tax evasion investigation ongoing'),
(1016, 16, 13, '2024-09-01', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Murder investigation ongoing'),
(1017, 17, 4,  '2024-10-05', 'Guilty',     'Fine',               NULL,        15000.00,   NULL, 'Online fraud - monetary penalty only'),
(1018, 18, 14, '2024-11-10', 'Guilty',     'Prison',             '10 Years',  NULL,       NULL, 'Drug smuggling at international airport'),
(1019, 19, 15, '2024-12-01', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Assault investigation ongoing'),
(1020, 20, 16, '2025-01-10', 'Guilty',     'Combined',           '3 Years',   10000.00,   200,  'Prison + fine + community service'),
(1021, 21, 17, '2025-02-14', 'Guilty',     'Fine',               NULL,        30000.00,   NULL, 'Bank fraud - fine only'),
(1022, 22, 18, '2025-03-01', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Ransomware investigation ongoing'),
(1023, 23, 19, '2025-04-05', 'Guilty',     'Combined',           '2 Years',   5000.00,    NULL, 'Drug distribution - prison + fine'),
(1024, 24, 7,  '2025-05-10', 'Guilty',     'Prison',             '2 Years',   NULL,       NULL, NULL),
(1025, 25, 20, '2025-06-15', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Insurance fraud investigation ongoing'),
(1026, 26, 11, '2025-07-20', 'Guilty',     'Combined',           '4 Years',   75000.00,   NULL, 'Card cloning ring - prison + fine'),
(1027, 27, 21, '2025-08-01', 'Guilty',     'Prison',             '12 Years',  NULL,       NULL, 'Major drug trafficking'),
(1028, 28, 22, '2025-09-10', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Government data breach investigation'),
(1029, 29, 16, '2025-10-05', 'Pending',    NULL,                 NULL,        NULL,       NULL, 'Hotel murder investigation'),
(1030, 30, 23, '2025-11-01', 'Guilty',     'Combined',           '7 Years',   100000.00,  NULL, 'Ponzi scheme - prison + heavy fine'),
-- Extra sentences for accomplices
(1031, 1,  16, '2023-06-15', 'Guilty',     'Probation',          NULL,        NULL,       300,  'Accomplice in robbery - probation + community service'),
(1032, 3,  21, '2023-09-01', 'Guilty',     'Prison',             '5 Years',   NULL,       NULL, 'Accomplice in drug deal');


-- ============================================================
-- PART D: VIEWS
-- ============================================================

-- VIEW 1: Full case overview (joins all major tables)
CREATE VIEW vw_full_case_overview AS
SELECT
    c.crime_id,
    c.crime_type,
    c.crime_date,
    c.crime_time,
    c.crime_location,
    c.city,
    c.district,
    c.description,
    c.crime_status,
    s.suspect_id,
    s.first_name   AS suspect_first_name,
    s.last_name    AS suspect_last_name,
    s.gender       AS suspect_gender,
    cs.suspect_role,
    sn.court_case_no,
    sn.hearing_date,
    sn.verdict,
    sn.sentence_type,
    sn.prison_duration,
    sn.fine_amount
FROM crime c
JOIN crime_suspect cs ON c.crime_id = cs.crime_id
JOIN suspect s        ON cs.suspect_id = s.suspect_id
LEFT JOIN sentence sn ON c.crime_id = sn.crime_id AND s.suspect_id = sn.suspect_id;

-- VIEW 2: Repeat offenders
CREATE VIEW vw_repeat_offenders AS
SELECT
    s.suspect_id,
    s.first_name,
    s.last_name,
    COUNT(cs.crime_id)  AS total_crimes,
    GROUP_CONCAT(c.crime_type ORDER BY c.crime_date SEPARATOR ', ') AS crime_types
FROM suspect s
JOIN crime_suspect cs ON s.suspect_id = cs.suspect_id
JOIN crime c          ON cs.crime_id = c.crime_id
GROUP BY s.suspect_id, s.first_name, s.last_name
HAVING COUNT(cs.crime_id) > 1;

-- VIEW 3: Crime statistics by type
CREATE VIEW vw_crime_stats AS
SELECT
    crime_type,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN crime_status = 'Closed' THEN 1 ELSE 0 END)              AS closed_cases,
    SUM(CASE WHEN crime_status = 'Under Investigation' THEN 1 ELSE 0 END) AS open_cases
FROM crime
GROUP BY crime_type
ORDER BY total_cases DESC;

-- VIEW 4: Officer workload (how many crimes each officer is assigned to)
CREATE VIEW vw_officer_workload AS
SELECT
    o.officer_id,
    CONCAT(o.first_name, ' ', o.last_name) AS officer_name,
    r.rank_name,
    u.unit_name,
    COUNT(co.crime_id) AS assigned_cases,
    SUM(CASE WHEN c.crime_status = 'Closed' THEN 1 ELSE 0 END)              AS closed_cases,
    SUM(CASE WHEN c.crime_status = 'Under Investigation' THEN 1 ELSE 0 END) AS open_cases
FROM officer o
JOIN officer_rank r   ON o.rank_id = r.rank_id
JOIN unit u           ON o.unit_id = u.unit_id
LEFT JOIN crime_officer co ON o.officer_id = co.officer_id
LEFT JOIN crime c     ON co.crime_id = c.crime_id
GROUP BY o.officer_id, o.first_name, o.last_name, r.rank_name, u.unit_name;


-- ============================================================
-- PART E: REQUIRED CUSTOMER QUERIES (5 UI Features)
-- ============================================================

-- ---------------------------------------------------------------
-- QUERY 1: All suspects and crime info appearing in court on a certain date
-- (Parameterize the date: replace '2024-07-15' with desired date)
-- ---------------------------------------------------------------
SELECT
    sn.court_case_no,
    sn.hearing_date,
    s.suspect_id,
    s.first_name,
    s.last_name,
    s.gender,
    c.crime_id,
    c.crime_type,
    c.crime_date,
    c.city,
    c.description,
    sn.verdict,
    sn.sentence_type
FROM sentence sn
JOIN crime c   ON sn.crime_id   = c.crime_id
JOIN suspect s ON sn.suspect_id = s.suspect_id
WHERE sn.hearing_date = '2024-07-15'
ORDER BY sn.court_case_no;


-- ---------------------------------------------------------------
-- QUERY 2: Officers and how many suspects of each gender were arrested by each officer
-- ---------------------------------------------------------------
SELECT
    o.officer_id,
    CONCAT(o.first_name, ' ', o.last_name) AS officer_name,
    r.rank_name,
    SUM(CASE WHEN s.gender = 'M' THEN 1 ELSE 0 END) AS male_arrests,
    SUM(CASE WHEN s.gender = 'F' THEN 1 ELSE 0 END) AS female_arrests,
    COUNT(*) AS total_arrests
FROM arrest a
JOIN officer o ON a.arresting_officer_id = o.officer_id
JOIN suspect s ON a.suspect_id = s.suspect_id
JOIN officer_rank r ON o.rank_id = r.rank_id
GROUP BY o.officer_id, o.first_name, o.last_name, r.rank_name
ORDER BY total_arrests DESC;


-- ---------------------------------------------------------------
-- QUERY 3: Change the hearing date for a particular case
-- (Example: Change court_case_no 1008 hearing to '2024-04-20')
-- ---------------------------------------------------------------
UPDATE sentence
SET hearing_date = '2024-04-20'
WHERE court_case_no = 1008;


-- ---------------------------------------------------------------
-- QUERY 4: Add a new arrest of a suspect
-- (Example: Arrest suspect 22 (Nina Johansson) for crime 28, by officer 4)
-- ---------------------------------------------------------------
INSERT INTO arrest (arrest_id, crime_id, suspect_id, arresting_officer_id, arrest_date, arrest_location)
VALUES (34, 28, 22, 4, '2024-08-10', 'Stockholm Police Station');


-- ---------------------------------------------------------------
-- QUERY 5: Remove a suspect from a crime (they did not do it)
-- (Example: Remove suspect 13 (Viktor Kozlov) from crime 8)
-- ---------------------------------------------------------------
DELETE FROM crime_suspect
WHERE crime_id = 8 AND suspect_id = 13;


-- ============================================================
-- END OF SCRIPT
-- ============================================================

-- ============================================================
-- data.sql — Populate CrimeDB3 from denormalized CSV data
-- Uses INSERT IGNORE so re-runs are safe
-- Run CrimeDB3.sql first to create the schema
-- ============================================================

-- -------------------------------------------------------
-- Suspect (20 unique suspects)
-- -------------------------------------------------------
INSERT IGNORE INTO Suspect (SuspectId, FirstName, LastName, DateOfBirth, Gender, NationId, HeightInCm, WeightInKg, EyeColor, HairColor, Adress, Phone) VALUES
(1,  'James',   'Wilson',    '1985-03-15', 'M', 'ID100000001', 178, 82.5, 'Brown', 'Black',  '12 Oak Street, Downtown, Chicago',      '555-0101'),
(2,  'Emily',   'Carter',    '1990-07-22', 'F', 'ID100000002', 165, 58.0, 'Green', 'Brown',  '5 Maple Ave, Westside, Chicago',         '555-0102'),
(3,  'Michael', 'Brown',     '1978-11-03', 'M', 'ID100000003', 182, 90.0, 'Brown', 'Black',  '45 Broadway, Manhattan, New York',       '555-0103'),
(4,  'Sarah',   'Davis',     '1995-01-18', 'F', 'ID100000004', 160, 52.0, 'Blue',  'Blonde', '8 Pine Road, Georgetown, Washington DC', '555-0104'),
(5,  'Robert',  'Martinez',  '1988-06-30', 'M', 'ID100000005', 175, 78.0, 'Brown', 'Brown',  '22 Beach Blvd, Venice, Los Angeles',     '555-0105'),
(6,  'Jessica', 'Taylor',    '1992-09-12', 'F', 'ID100000006', 168, 62.0, 'Hazel', 'Black',  '17 Elm Street, Buckhead, Atlanta',       '555-0106'),
(7,  'Daniel',  'Anderson',  '1983-04-25', 'M', 'ID100000007', 185, 95.0, 'Brown', 'Black',  '33 Harbor Drive, Downtown, Miami',       '555-0107'),
(8,  'Ashley',  'Thomas',    '1997-12-08', 'F', 'ID100000008', 170, 55.0, 'Green', 'Red',    '9 Market Street, SoMa, San Francisco',   '555-0108'),
(9,  'William', 'Garcia',    '1980-02-14', 'M', 'ID100000009', 172, 80.0, 'Brown', 'Gray',   '50 Congress Ave, Capitol Hill, Austin',  '555-0109'),
(10, 'Olivia',  'Rodriguez', '1993-08-19', 'F', 'ID100000010', 163, 56.0, 'Blue',  'Brown',  '120 Lake Shore Dr, Lincoln Park, Chicago','555-0110'),
(11, 'Kevin',   'Lee',       '1986-05-28', 'M', 'ID100000011', 180, 85.0, 'Brown', 'Black',  '75 Peachtree St, Midtown, Atlanta',      '555-0111'),
(12, 'Megan',   'Harris',    '1994-03-11', 'F', 'ID100000012', 167, 60.0, 'Hazel', 'Blonde', '200 Collins Ave, South Beach, Miami',    '555-0112'),
(13, 'Anthony', 'Clark',     '1979-09-05', 'M', 'ID100000013', 176, 88.0, 'Brown', 'Brown',  '18 Bourbon St, French Quarter, New Orleans','555-0113'),
(14, 'Rachel',  'Lewis',     '1991-11-30', 'F', 'ID100000014', 162, 54.0, 'Green', 'Black',  '42 State Street, Back Bay, Boston',      '555-0114'),
(15, 'Marcus',  'Walker',    '1984-07-17', 'M', 'ID100000015', 188, 92.0, 'Brown', 'Black',  '66 Central Ave, Downtown, Denver',       '555-0115'),
(16, 'Sophia',  'Hall',      '1996-02-25', 'F', 'ID100000016', 158, 50.0, 'Blue',  'Brown',  '30 Pike Place, Capitol Hill, Seattle',   '555-0116'),
(17, 'Brandon', 'Young',     '1982-12-09', 'M', 'ID100000017', 174, 79.0, 'Brown', 'Gray',   '88 Main Street, Old Town, Portland',     '555-0117'),
(18, 'Lauren',  'King',      '1993-06-14', 'F', 'ID100000018', 171, 57.0, 'Hazel', 'Red',    '15 River Road, Germantown, Nashville',   '555-0118'),
(19, 'Derek',   'Wright',    '1987-01-22', 'M', 'ID100000019', 183, 91.0, 'Brown', 'Black',  '55 Fremont St, Downtown, Las Vegas',     '555-0119'),
(20, 'Nicole',  'Scott',     '1998-08-03', 'F', 'ID100000020', 164, 53.0, 'Green', 'Blonde', '7 Ocean Drive, Pacific Beach, San Diego','555-0120');

-- -------------------------------------------------------
-- Officer (10 unique officers)
-- -------------------------------------------------------
INSERT IGNORE INTO Officer (OfficerId, OfficerRank, OfficerName, OfficerUnit) VALUES
(1,  'Detective',  'John Parker',     'Homicide Division'),
(2,  'Sergeant',   'Maria Gonzalez',  'Narcotics Unit'),
(3,  'Lieutenant', 'David Chen',      'Cyber Crimes Unit'),
(4,  'Detective',  'Karen Mitchell',  'Theft & Burglary Unit'),
(5,  'Captain',    'Robert Hughes',   'Organized Crime Division'),
(6,  'Detective',  'Lisa Campbell',   'Assault & Battery Unit'),
(7,  'Sergeant',   'Thomas Reed',     'Counter-Terrorism Unit'),
(8,  'Officer',    'Jennifer Lopez',  'Narcotics Unit'),
(9,  'Detective',  'Steven Adams',    'Financial Crimes Unit'),
(10, 'Lieutenant', 'Patricia Moore',  'Traffic Division');

-- -------------------------------------------------------
-- Crime (20 unique crimes)
-- -------------------------------------------------------
INSERT IGNORE INTO Crime (CrimeId, CrimeType, CrimeDate, CrimeTime, CrimeLocation, City, District, CrimeDescription, CrimeStatus) VALUES
(1,  'Theft',           '2024-01-15', '14:30:00', 'Walmart Supercenter',    'Chicago',       'Downtown',      'Shoplifting electronics worth $2,500 from retail store',               'Closed'),
(2,  'Assault',         '2024-02-20', '22:15:00', 'Lincoln Park',           'Chicago',       'Lincoln Park',  'Aggravated assault during late night altercation',                     'Closed'),
(3,  'Fraud',           '2024-03-10', '10:00:00', 'Online',                 'New York',      'Manhattan',     'Identity theft and credit card fraud scheme totaling $150,000',        'Closed'),
(4,  'Burglary',        '2024-04-05', '03:45:00', 'Residential Apartment',  'Washington DC', 'Georgetown',    'Forced entry residential burglary, jewelry and cash stolen',           'Closed'),
(5,  'Drug Possession', '2024-05-18', '16:20:00', 'Venice Boardwalk',       'Los Angeles',   'Venice',        'Possession of controlled substance - 200g cocaine',                    'Closed'),
(6,  'Vandalism',       '2024-06-22', '01:30:00', 'Piedmont Park',          'Atlanta',       'Buckhead',      'Graffiti and destruction of public property causing $15,000 damage',  'Closed'),
(7,  'Armed Robbery',   '2024-07-08', '19:00:00', 'First National Bank',    'Miami',         'Downtown',      'Armed bank robbery with firearm, $85,000 stolen',                      'Closed'),
(8,  'Cybercrime',      '2024-08-14', '11:30:00', 'Online',                 'San Francisco', 'SoMa',          'Unauthorized access to corporate banking systems',                     'Closed'),
(9,  'Forgery',         '2024-09-01', '09:00:00', 'County Clerk Office',    'Austin',        'Capitol Hill',  'Forgery of government-issued documents and certificates',              'Closed'),
(10, 'Vehicle Theft',   '2024-10-12', '20:45:00', 'Parking Garage',         'Chicago',       'Westside',      'Grand theft auto - stolen luxury vehicle worth $65,000',               'Closed'),
(11, 'Drug Trafficking','2024-10-25', '02:00:00', 'Warehouse District',     'Atlanta',       'Midtown',       'Distribution of illegal narcotics - large scale operation',            'Closed'),
(12, 'Money Laundering','2024-11-03', '13:00:00', 'Shell Corporation Office','Miami',        'South Beach',   'Laundering $2.3M through fictitious business accounts',                'Closed'),
(13, 'Arson',           '2024-11-15', '23:30:00', 'Abandoned Factory',      'New Orleans',   'French Quarter','Deliberate arson causing $500,000 in property damage',                'Closed'),
(14, 'Embezzlement',    '2024-12-01', '10:00:00', 'Tech Corp HQ',           'Boston',        'Back Bay',      'Embezzlement of $750,000 from employer over 3 years',                  'Closed'),
(15, 'Assault',         '2024-12-10', '21:00:00', 'Downtown Bar',           'Denver',        'Downtown',      'Bar fight resulting in serious bodily injury',                         'Closed'),
(16, 'Theft',           '2025-01-05', '15:30:00', 'Shopping Mall',          'Seattle',       'Capitol Hill',  'Organized retail theft ring targeting electronics',                    'Closed'),
(17, 'Fraud',           '2025-01-20', '09:00:00', 'Online',                 'Portland',      'Old Town',      'Ponzi scheme defrauding 45 investors of $3.2M total',                  'Closed'),
(18, 'Kidnapping',      '2025-02-14', '18:00:00', 'Residential Area',       'Nashville',     'Germantown',    'Attempted kidnapping of minor, suspect fled scene',                    'Closed'),
(19, 'Robbery',         '2025-03-01', '22:30:00', 'Casino Floor',           'Las Vegas',     'Downtown',      'Armed robbery at casino cashier cage, $120,000 taken',                 'Closed'),
(20, 'Hit and Run',     '2025-03-15', '07:45:00', 'Highway I-5',            'San Diego',     'Pacific Beach', 'Hit and run accident causing severe injury to pedestrian',             'Closed');

-- -------------------------------------------------------
-- Arrest (20 unique arrests — must follow Crime inserts)
-- -------------------------------------------------------
INSERT IGNORE INTO Arrest (ArrestId, ArrestDate, ArrestLocation, CrimeId) VALUES
(1,  '2024-01-17', 'Chicago PD Downtown Station',     1),
(2,  '2024-03-15', 'NYPD Manhattan Precinct',         3),
(3,  '2024-05-20', 'LAPD Venice Division',            5),
(4,  '2024-07-09', 'Miami-Dade PD HQ',               7),
(5,  '2024-09-03', 'Austin PD Central',               9),
(6,  '2024-10-15', 'Chicago PD Westside Station',    10),
(7,  '2024-10-28', 'Atlanta PD Midtown Precinct',    11),
(8,  '2024-11-18', 'NOPD French Quarter Station',    13),
(9,  '2024-12-12', 'Denver PD Downtown',             15),
(10, '2025-01-25', 'Portland PD Central Precinct',   17),
(11, '2025-03-03', 'LVMPD Downtown Command',         19),
(12, '2024-02-23', 'Chicago PD Central Station',      2),
(13, '2024-04-08', 'NYPD Midtown Precinct',           4),
(14, '2024-06-25', 'LAPD Hollywood Division',         6),
(15, '2024-08-17', 'Miami-Dade PD South Station',     8),
(16, '2024-11-06', 'Atlanta PD Eastside Precinct',   12),
(17, '2024-12-04', 'Boston PD District A-1',         14),
(18, '2025-01-08', 'Seattle PD West Precinct',       16),
(19, '2025-02-17', 'Denver PD District 3',           18),
(20, '2025-03-18', 'Austin PD South Precinct',       20);

-- -------------------------------------------------------
-- Evidence (24 unique evidence items — must follow Crime)
-- -------------------------------------------------------
INSERT IGNORE INTO Evidence (EvidenceId, EvidenceType, EvidenceDescription, CrimeId) VALUES
(1,  'Video',     'CCTV footage from store security cameras showing suspect',       1),
(2,  'Physical',  'Blood sample collected from assault scene',                       2),
(3,  'Digital',   'Fraudulent website screenshots, IP logs, and email trails',       3),
(4,  'Physical',  'Broken door lock fragments and fingerprint samples',              4),
(5,  'Physical',  'Seized controlled substance - 200g cocaine in plastic bags',     5),
(6,  'Video',     'Park surveillance camera footage of vandalism act',              6),
(7,  'Physical',  'Firearm, ski mask, and dye-stained cash found at scene',         7),
(8,  'Digital',   'Server access logs, IP addresses, and malware samples',          8),
(9,  'Document',  'Forged government certificates and notary stamps',               9),
(10, 'Video',     'Parking garage security camera recording of vehicle theft',     10),
(11, 'Physical',  'Stolen electronics with original store barcodes attached',       1),
(12, 'Testimony', 'Eyewitness statement describing assault at Lincoln Park',        2),
(13, 'Physical',  'Large quantity of narcotics and packaging material',            11),
(14, 'Digital',   'Wiretap recordings of drug distribution phone calls',           11),
(15, 'Document',  'Fraudulent bank statements and shell company records',          12),
(16, 'Physical',  'Gasoline container and matchbox found near arson scene',        13),
(17, 'Document',  'Falsified financial records spanning 3 years',                  14),
(18, 'Testimony', 'Multiple witness statements from bar fight incident',           15),
(19, 'Video',     'Mall security footage showing organized theft operation',       16),
(20, 'Digital',   'Digital trail of Ponzi scheme transactions and emails',         17),
(21, 'Testimony', 'Neighbor eyewitness account of kidnapping attempt',            18),
(22, 'Video',     'Casino security camera footage of armed robbery',               19),
(23, 'Physical',  'Vehicle paint transfer and debris from hit and run scene',      20),
(24, 'Video',     'Highway traffic camera footage capturing license plate',        20);

-- -------------------------------------------------------
-- CourtInformation (20 unique cases — must follow Crime)
-- -------------------------------------------------------
INSERT IGNORE INTO CourtInformation (CourtCaseNo, HearingDate, Verdict, SentenceLenght, CrimeId, Fine) VALUES
(2001, '2024-04-10', 'Guilty', '2 years',   1,  5000),
(2002, '2024-06-20', 'Guilty', '5 years',   3, 50000),
(2003, '2024-08-15', 'Guilty', '3 years',   5, 25000),
(2004, '2024-10-05', 'Guilty', '10 years',  7,  5000),
(2005, '2024-11-20', 'Guilty', '4 years',   9, 30000),
(2006, '2024-05-30', 'Guilty', '1 year',    2,  5000),
(2007, '2024-12-10', 'Guilty', '1 year',    4,  5000),
(2008, '2025-01-15', 'Guilty', '8 years',  11, 75000),
(2009, '2025-02-10', 'Guilty', '6 years',  13,100000),
(2010, '2025-01-20', 'Guilty', '1 year',   15,  5000),
(2011, '2025-03-05', 'Guilty', '12 years', 17,500000),
(2012, '2025-04-01', 'Guilty', '15 years', 19,  5000),
(2013, '2024-09-20', 'Guilty', '1 year',    6,  5000),
(2014, '2024-11-12', 'Guilty', '2 years',   8, 10000),
(2015, '2025-01-10', 'Guilty', '3 years',  10, 15000),
(2016, '2025-02-01', 'Guilty', '6 months', 12, 20000),
(2017, '2025-03-01', 'Guilty', '18 months',14, 25000),
(2018, '2025-04-05', 'Guilty', '4 years',  16, 30000),
(2019, '2025-05-15', 'Guilty', '1 year',   18, 50000),
(2020, '2025-06-13', 'Guilty', '2 years',  20,  5000);

-- -------------------------------------------------------
-- Crime_Officer junction table
-- -------------------------------------------------------
INSERT IGNORE INTO Crime_Officer (CrimeId, OfficerId) VALUES
(1, 1), (1, 4),
(2, 1), (2, 6),
(3, 3), (3, 9),
(4, 4),
(5, 2), (5, 8),
(6, 6),
(7, 1), (7, 5),
(8, 3),
(9, 4), (9, 9),
(10, 4), (10, 6),
(11, 2), (11, 5), (11, 8),
(12, 5), (12, 9),
(13, 1), (13, 6),
(14, 9),
(15, 6),
(16, 4),
(17, 9), (17, 3),
(18, 1), (18, 6),
(19, 5), (19, 7),
(20, 10);

-- -------------------------------------------------------
-- OfficerArrest junction table
-- -------------------------------------------------------
INSERT IGNORE INTO OfficerArrest (OfficerId, ArrestId) VALUES
(1, 1), (4, 1),
(1, 12), (6, 12),
(3, 2), (9, 2),
(4, 13),
(2, 3), (8, 3),
(6, 14),
(1, 4), (5, 4),
(3, 15),
(4, 5), (9, 5),
(4, 6), (6, 6),
(2, 7), (5, 7), (8, 7),
(5, 16), (9, 16),
(1, 8), (6, 8),
(9, 17),
(6, 9),
(4, 18),
(9, 10), (3, 10),
(1, 19), (6, 19),
(5, 11), (7, 11),
(10, 20);

-- -------------------------------------------------------
-- SuspectArrest junction table
-- -------------------------------------------------------
INSERT IGNORE INTO SuspectArrest (ArrestId, SuspectId) VALUES
(1, 1), (1, 16),
(12, 2),
(2, 3), (2, 12),
(13, 4),
(3, 5), (3, 11),
(14, 6),
(4, 7), (4, 19),
(15, 8),
(5, 9), (5, 17),
(6, 10),
(7, 11),
(16, 12),
(8, 13),
(17, 14),
(9, 15),
(18, 16),
(10, 17),
(19, 18),
(11, 19),
(20, 20);

-- -------------------------------------------------------
-- SuspectCrime junction table
-- -------------------------------------------------------
INSERT IGNORE INTO SuspectCrime (SuspectId, CrimeId) VALUES
(1, 1), (16, 1),
(2, 2),
(3, 3), (12, 3),
(4, 4),
(5, 5), (11, 5),
(6, 6),
(7, 7), (19, 7),
(8, 8),
(9, 9), (17, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

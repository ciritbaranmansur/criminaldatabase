
SELECT *
FROM `unf_crime`;

INSERT INTO Suspect (SuspectId, FirstName, LastName, DateOfBirth, Gender, NationId, HeightInCm, WeightInKg, EyeColor, HairColor, Adress, Phone)
SELECT DISTINCT SuspectId, FirstName, LastName, DateOfBirth, Gender, NationId, HeightInCm, WeightInKg, EyeColor, HairColor, Adress, Phone
FROM `unf_crime`;



ALTER TABLE UNF_Crime
DROP COLUMN FirstName,
DROP COLUMN LastName,
DROP COLUMN DateOfBirth,
DROP COLUMN Gender,
DROP COLUMN NationId,
DROP COLUMN HeightInCm,
DROP COLUMN WeightInKg,
DROP COLUMN EyeColor,
DROP COLUMN HairColor,
DROP COLUMN Adress,
DROP COLUMN Phone;

SELECT *
FROM `Suspect`;

INSERT INTO Officer (OfficerId, OfficerRank, OfficerName, OfficerUnit)
SELECT DISTINCT OfficerId, OfficerRank, OfficerName, OfficerUnit
FROM UNF_Crime;

ALTER TABLE UNF_Crime
DROP COLUMN OfficerRank,
DROP COLUMN OfficerName,
DROP COLUMN OfficerUnit;

SELECT *
FROM `Officer`;




INSERT INTO Crime (CrimeId, CrimeType, CrimeDate, CrimeTime, CrimeLocation, City, District, CrimeDescription, CrimeStatus)
SELECT DISTINCT CrimeId, CrimeType, CrimeDate, CrimeTime, CrimeLocation, City, District, CrimeDescription, CrimeStatus
FROM UNF_Crime;

ALTER TABLE UNF_Crime
DROP COLUMN CrimeType,
DROP COLUMN CrimeDate,
DROP COLUMN CrimeTime,
DROP COLUMN CrimeLocation,
DROP COLUMN City,
DROP COLUMN District,
DROP COLUMN CrimeDescription,
DROP COLUMN CrimeStatus;

SELECT *
FROM `Crime`;


INSERT INTO Arrest (ArrestId, ArrestDate, ArrestLocation, CrimeId)
SELECT DISTINCT u.ArrestId, u.ArrestDate, u.ArrestLocation, c.CrimeId
FROM UNF_Crime u
JOIN Crime c ON u.CrimeId = c.CrimeId
WHERE u.ArrestDate IS NOT NULL;

ALTER TABLE UNF_Crime
DROP COLUMN ArrestDate,
DROP COLUMN ArrestLocation;

SELECT *
FROM Arrest;



INSERT INTO Evidence (EvidenceId, EvidenceType, EvidenceDescription, CrimeId)
SELECT DISTINCT u.EvidenceId, u.EvidenceType, u.EvidenceDescription, c.CrimeId
FROM UNF_Crime u
JOIN Crime c ON u.CrimeId = c.CrimeId
WHERE u.EvidenceType IS NOT NULL;

ALTER TABLE UNF_Crime
DROP COLUMN EvidenceType,
DROP COLUMN EvidenceDescription,
DROP COLUMN EvidenceId;

SELECT *
FROM `evidence`;

SELECT *
FROM `CourtInformation`;




INSERT INTO CourtInformation (CourtCaseNo, HearingDate, Verdict, SentenceLenght, CrimeId, Fine)
SELECT u.CourtCaseNo, MIN(u.HearingDate), MIN(u.Verdict), MIN(u.SentenceLength), c.CrimeId, MIN(u.Fine)
FROM UNF_Crime u
JOIN Crime c ON u.CrimeId = c.CrimeId
WHERE u.CourtCaseNo IS NOT NULL
GROUP BY u.CourtCaseNo, c.CrimeId;

ALTER TABLE UNF_Crime
DROP COLUMN CourtCaseNo,
DROP COLUMN HearingDate,
DROP COLUMN Verdict,
DROP COLUMN SentenceLength,
DROP COLUMN Fine;



ALTER TABLE UNF_Crime
DROP COLUMN EvidenceId;

SELECT *
FROM `courtinformation`;

INSERT INTO Crime_Officer (CrimeId, OfficerId)
SELECT DISTINCT u.CrimeId, u.OfficerId
FROM UNF_Crime u;



INSERT INTO OfficerArrest (OfficerId, ArrestId)
SELECT DISTINCT u.OfficerId, u.ArrestId
FROM UNF_Crime u
WHERE u.ArrestId IS NOT NULL;

INSERT INTO SuspectArrest (ArrestId, SuspectId)
SELECT DISTINCT u.ArrestId, u.SuspectId
FROM UNF_Crime u
WHERE u.ArrestId IS NOT NULL;

INSERT INTO SuspectCrime (SuspectId, CrimeId)
SELECT DISTINCT u.SuspectId, u.CrimeId
FROM UNF_Crime u;

SELECT *
FROM `OfficerArrest`;

SELECT *
FROM `SuspectArrest`;



ALTER TABLE unf_crime
DROP COLUMN SuspectId,
DROP COLUMN CrimeId,
DROP COLUMN OfficerId,
DROP COLUMN ArrestId,
DROP COLUMN EvidenceId;


SELECT *
FROM `unf_crime`;

CREATE VIEW UNF_View AS
SELECT 
    s.SuspectId, s.FirstName, s.LastName, s.DateOfBirth, s.Gender, s.NationId, 
    s.HeightInCm, s.WeightInKg, s.EyeColor, s.HairColor, s.Adress, s.Phone,
    c.CrimeId, c.CrimeType, c.CrimeDate, c.CrimeTime, c.CrimeLocation, 
    c.City, c.District, c.CrimeDescription, c.CrimeStatus,
    o.OfficerId, o.OfficerRank, o.OfficerName, o.OfficerUnit,
    a.ArrestId, a.ArrestDate, a.ArrestLocation,
    e.EvidenceId, e.EvidenceType, e.EvidenceDescription,
    ci.CourtCaseNo, ci.HearingDate, ci.Verdict, ci.SentenceLenght, ci.Fine
FROM SuspectCrime sc
JOIN Suspect s ON sc.SuspectId = s.SuspectId
JOIN Crime c ON sc.CrimeId = c.CrimeId
JOIN Crime_Officer co ON c.CrimeId = co.CrimeId
JOIN Officer o ON co.OfficerId = o.OfficerId
LEFT JOIN Arrest a ON c.CrimeId = a.CrimeId
LEFT JOIN Evidence e ON c.CrimeId = e.CrimeId
LEFT JOIN CourtInformation ci ON c.CrimeId = ci.CrimeId;

SELECT *
FROM unf_view;


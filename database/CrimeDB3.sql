DROP DATABASE IF EXISTS CrimeDB3;
CREATE DATABASE CrimeDB3;
USE CrimeDB3;

CREATE TABLE UNF_Crime (
    RowId INT AUTO_INCREMENT PRIMARY KEY,
    SuspectId INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    DateOfBirth DATE,
    Gender VARCHAR(1),
    NationId VARCHAR(255),
    HeightInCm DOUBLE,
    WeightInKg DOUBLE,
    EyeColor VARCHAR(255),
    HairColor VARCHAR(255),
    Adress VARCHAR(255),
    Phone VARCHAR(255),
    CrimeId INT,
    CrimeType VARCHAR(255),
    CrimeDate DATE,
    CrimeTime TIME,
    CrimeLocation VARCHAR(255),
    City VARCHAR(255),
    District VARCHAR(255),
    CrimeDescription TEXT,
    CrimeStatus VARCHAR(255),
    OfficerId INT,
    OfficerRank VARCHAR(255),
    OfficerName VARCHAR(255),
    OfficerUnit VARCHAR(255),
    ArrestId INT,
    ArrestDate DATE,
    ArrestLocation VARCHAR(255),
    EvidenceId INT,
    EvidenceType VARCHAR(255),
    EvidenceDescription TEXT,
    CourtCaseNo INT,
    HearingDate DATE,
    Verdict VARCHAR(255),
    SentenceLength VARCHAR(255),
    Fine INT
);

CREATE TABLE `Suspect`(
    `SuspectId` INT UNSIGNED NOT NULL PRIMARY KEY,
    `FirstName` VARCHAR(255) NULL,
    `LastName` VARCHAR(255) NULL,
    `DateOfBirth` DATE NULL,
    `Gender` VARCHAR(1) NULL,
    `NationId` VARCHAR(255) NULL,
    `HeightInCm` DOUBLE NULL,
    `WeightInKg` DOUBLE NULL,
    `EyeColor` VARCHAR(255) NULL,
    `HairColor` VARCHAR(255) NULL,
    `Adress` VARCHAR(255) NULL,
    `Phone` VARCHAR(255) NULL
);
CREATE TABLE `Crime`(
    `CrimeId` INT UNSIGNED NOT NULL PRIMARY KEY,
    `CrimeType` VARCHAR(255) NOT NULL,
    `CrimeDate` DATE NULL,
    `CrimeTime` TIME NULL,
    `CrimeLocation` VARCHAR(255) NULL,
    `City` VARCHAR(255) NULL,
    `District` VARCHAR(255) NULL,
    `CrimeDescription` TEXT NOT NULL,
    `CrimeStatus` VARCHAR(255) NOT NULL DEFAULT 'Under Investigation'
);
CREATE TABLE `Officer`(
    `OfficerId` INT UNSIGNED NOT NULL PRIMARY KEY,
    `OfficerRank` VARCHAR(255) NOT NULL,
    `OfficerName` VARCHAR(255) NULL DEFAULT 'Restricted',
    `OfficerUnit` VARCHAR(255) NOT NULL
);
CREATE TABLE `Arrest`(
    `ArrestId` INT UNSIGNED NOT NULL PRIMARY KEY,
    `ArrestDate` DATE NOT NULL,
    `ArrestLocation` VARCHAR(255) NOT NULL,
    `CrimeId` INT UNSIGNED NOT NULL
);
CREATE TABLE `Evidence`(
    `EvidenceId` INT UNSIGNED NOT NULL PRIMARY KEY,
    `EvidenceType` VARCHAR(255) NOT NULL,
    `EvidenceDescription` TEXT NOT NULL,
    `CrimeId` INT UNSIGNED NOT NULL
);
CREATE TABLE `CourtInformation`(
    `CourtCaseNo` INT NOT NULL,
    `HearingDate` DATE NULL,
    `Verdict` VARCHAR(255) NULL,
    `SentenceLenght` VARCHAR(255) NULL,
    `CrimeId` INT UNSIGNED NOT NULL,
    `Fine` INT NULL,
    PRIMARY KEY(`CourtCaseNo`)
);
CREATE TABLE `Crime_Officer`(
    `CrimeId` INT UNSIGNED NOT NULL,
    `OfficerId` INT UNSIGNED NOT NULL,
    PRIMARY KEY(`CrimeId`, `OfficerId`)
);

CREATE TABLE `OfficerArrest`(
    `OfficerId` INT UNSIGNED NOT NULL,
    `ArrestId` INT UNSIGNED NOT NULL,
    PRIMARY KEY(`OfficerId`, `ArrestId`)
);

CREATE TABLE `SuspectArrest`(
    `ArrestId` INT UNSIGNED NOT NULL,
    `SuspectId` INT UNSIGNED NOT NULL,
    PRIMARY KEY(`ArrestId`, `SuspectId`)
);

CREATE TABLE `SuspectCrime`(
    `SuspectId` INT UNSIGNED NOT NULL,
    `CrimeId` INT UNSIGNED NOT NULL,
    PRIMARY KEY(`SuspectId`, `CrimeId`)
);

ALTER TABLE
    `Crime_Officer` ADD CONSTRAINT `crime_officer_crimeid_foreign` FOREIGN KEY(`CrimeId`) REFERENCES `Crime`(`CrimeId`);
ALTER TABLE
    `SuspectCrime` ADD CONSTRAINT `suspectcrime_suspectid_foreign` FOREIGN KEY(`SuspectId`) REFERENCES `Suspect`(`SuspectId`);
ALTER TABLE
    `Crime_Officer` ADD CONSTRAINT `crime_officer_officerid_foreign` FOREIGN KEY(`OfficerId`) REFERENCES `Officer`(`OfficerId`);
ALTER TABLE
    `OfficerArrest` ADD CONSTRAINT `officerarrest_arrestid_foreign` FOREIGN KEY(`ArrestId`) REFERENCES `Arrest`(`ArrestId`);
ALTER TABLE
    `SuspectCrime` ADD CONSTRAINT `suspectcrime_crimeid_foreign` FOREIGN KEY(`CrimeId`) REFERENCES `Crime`(`CrimeId`);
ALTER TABLE
    `Evidence` ADD CONSTRAINT `evidence_crimeid_foreign` FOREIGN KEY(`CrimeId`) REFERENCES `Crime`(`CrimeId`);
ALTER TABLE
    `SuspectArrest` ADD CONSTRAINT `suspectarrest_arrestid_foreign` FOREIGN KEY(`ArrestId`) REFERENCES `Arrest`(`ArrestId`);
ALTER TABLE
    `Arrest` ADD CONSTRAINT `arrest_crimeid_foreign` FOREIGN KEY(`CrimeId`) REFERENCES `Crime`(`CrimeId`);
ALTER TABLE
    `SuspectArrest` ADD CONSTRAINT `suspectarrest_suspectid_foreign` FOREIGN KEY(`SuspectId`) REFERENCES `Suspect`(`SuspectId`);
ALTER TABLE
    `CourtInformation` ADD CONSTRAINT `courtinformation_crimeid_foreign` FOREIGN KEY(`CrimeId`) REFERENCES `Crime`(`CrimeId`);
ALTER TABLE
    `OfficerArrest` ADD CONSTRAINT `officerarrest_officerid_foreign` FOREIGN KEY(`OfficerId`) REFERENCES `Officer`(`OfficerId`);
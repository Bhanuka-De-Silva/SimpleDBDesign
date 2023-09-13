-- Create the database
DROP DATABASE IF EXISTS SuwapiyasaDB;
CREATE DATABASE SuwapiyasaDB;
USE SuwapiyasaDB;

-- Create the Staff table
CREATE TABLE Staff (
    employeeNumber INT PRIMARY KEY,
    name VARCHAR(100) not null,
    telephoneNumber VARCHAR(20) not null,
    gender VARCHAR(10),
    address VARCHAR(200)
);

-- Create the Nurse table
CREATE TABLE Nurse (
    employeeNumber INT,
    grade VARCHAR(20),
    yearsOfExperience INT,
    surgerySkillType VARCHAR(50),
    monthlySalary DECIMAL(10, 2),
    FOREIGN KEY (employeeNumber) REFERENCES Staff(employeeNumber) on delete cascade on update cascade
);

-- Create the Surgeon table
CREATE TABLE Surgeon (
    employeeNumber INT,
    specialty VARCHAR(50),
    typeOfContract VARCHAR(50),
    lengthOfContract VARCHAR(20),
    FOREIGN KEY (employeeNumber) REFERENCES Staff(employeeNumber) on delete cascade on update cascade,
    CONSTRAINT chk_typeOfContract CHECK (typeOfContract in ('Full Time', 'Part Time', 'Internship'))
);

-- Create the Doctor table
CREATE TABLE Doctor (
    employeeNumber INT,
    specialty VARCHAR(50),
    monthlySalary DECIMAL(10, 2),
    monitorId VARCHAR(10) not null,
    HDNumber VARCHAR(10) unique,
    FOREIGN KEY (employeeNumber) REFERENCES Staff(employeeNumber) on delete cascade on update cascade
);

-- Create the Assign table
CREATE TABLE Assign (
    employeeNumber INT,
    assignDate DATE not null,
    FOREIGN KEY (employeeNumber) REFERENCES Nurse(employeeNumber) on delete cascade on update cascade
);

-- Create the Perform table
CREATE TABLE Perform (
    employeeNumber INT,
    threatre VARCHAR(50),
    FOREIGN KEY (employeeNumber) REFERENCES Surgeon(employeeNumber) on delete cascade on update cascade
);

-- Create the Patient table
CREATE TABLE Patient (
    parientIdentificationNumber INT PRIMARY KEY,
    telephoneNumber VARCHAR(20),
    bloodType VARCHAR(2),
    surname VARCHAR(50),
    initialName VARCHAR(50),
    age INT,
    address VARCHAR(200),
    CONSTRAINT chk_bloodType CHECK (bloodType in ('A', 'B', 'AB', 'O'))
);

-- Create the Allergies table
CREATE TABLE Allergies (
    parientIdentificationNumber INT,
    allergi VARCHAR(100),
    FOREIGN KEY (parientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade
);

-- Create the Surgery table
CREATE TABLE Surgery (
    parientIdentificationNumber INT,
    surgeryName VARCHAR(100) unique not null,
    date DATE not null,
    time TIME not null,
    category VARCHAR(50),
    FOREIGN KEY (parientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade
);

-- Create the specialNeeds table
CREATE TABLE specialNeeds (
    parientIdentificationNumber INT,
    surgeryName VARCHAR(100),
    specialNeeds VARCHAR(200),
    FOREIGN KEY (parientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade, 
    FOREIGN KEY (surgeryName) REFERENCES Surgery(surgeryName) on delete cascade on update cascade
);

-- Create the Interaction table
CREATE TABLE Interaction (
    parientIdentificationNumber INT,
    code VARCHAR(20),
    interactionSeverity VARCHAR(50),
    FOREIGN KEY (parientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade
);

-- Create the Medication table
CREATE TABLE Medication (
    parientIdentificationNumber INT,
    code VARCHAR(20) unique,
    quantityOnHand INT,
    quantityOrdered INT,
    name VARCHAR(100) not null,
    expirationDate DATE not null,
    cost DECIMAL(10, 2),
    FOREIGN KEY (parientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade
);

-- Create the Location table
CREATE TABLE Location (
    parientIdentificationNumber INT,
    bedNumber INT UNIQUE,
    roomNumber INT,
    nursingUnit VARCHAR(50),
    FOREIGN KEY (parientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade
);

-- Create the patientMedication table
CREATE TABLE patientMedication (
    patientIdentificationNumber INT,
    code VARCHAR(20),
    FOREIGN KEY (patientIdentificationNumber) REFERENCES Patient(parientIdentificationNumber) on delete cascade on update cascade,
    FOREIGN KEY (code) REFERENCES Medication(code) on delete cascade on update cascade
);

-- Insert data into Staff table
INSERT INTO Staff (employeeNumber, name, telephoneNumber, gender, address)
VALUES
    (1, 'John Doe', '123-456-7890', 'Male', '123 Main St'),
    (2, 'Jane Smith', '987-654-3210', 'Female', '456 Elm St'),
    (3, 'Michael Johnson', '555-555-5555', 'Male', '789 Oak St'),
    (4, 'Emily Williams', '111-222-3333', 'Female', '789 Pine St'),
    (5, 'Robert Brown', '444-555-6666', 'Male', '987 Maple Ave');

select * from Staff;

-- Insert data into Nurse table
INSERT INTO Nurse (employeeNumber, grade, yearsOfExperience, surgerySkillType, monthlySalary)
VALUES
    (1, 'Senior', 8, 'Cardiovascular', 6000.00),
    (2, 'Junior', 3, 'Orthopedic', 4500.00),
    (2, 'Junior', 2, 'Neurological', 4700.00),
    (5, 'Senior', 10, 'Gastrointestinal', 6200.00),
    (5, 'Junior', 1, 'Cardiovascular', 4300.00);

select * from Nurse;

-- Insert data into Surgeon table
INSERT INTO Surgeon (employeeNumber, specialty, typeOfContract, lengthOfContract)
VALUES
    (3, 'Neurology', 'Full Time', 'Permanent'),
    (4, 'Orthopedics', 'Part Time', '2 years'),
    (4, 'Cardiovascular', 'Full Time', '5 years'),
    (1, 'Gastroenterology', 'Part Time', '3 years'),
    (2, 'Neurology', 'Internship', '6 months');

select * from Surgeon;

-- Insert data into Doctor table
INSERT INTO Doctor (employeeNumber, specialty, monthlySalary, monitorId, HDNumber)
VALUES
    (5, 'Pediatrics', 5500.00, 'H123', 'H123'),
    (5, 'Internal Medicine', 5800.00, 'H123', null),
    (1, 'Ophthalmology', 5200.00, 'H101', null),
    (2, 'Dermatology', 5300.00, 'H123', 'H101'),
    (3, 'Oncology', 5700.00, 'H101', null);

select * from Doctor;

-- Insert data into Assign table
INSERT INTO Assign (employeeNumber, assignDate)
VALUES
    (1, '2023-01-15'),
    (2, '2023-02-20'),
    (5, '2023-03-10'),
    (5, '2023-04-05'),
    (1, '2023-05-25');

select * from Assign;

-- Insert data into Perform table
INSERT INTO Perform (employeeNumber, threatre)
VALUES
    (3, 'Main Theater'),
    (4, 'Operating Room A'),
    (4, 'Operating Room B'),
    (3, 'Main Theater'),
    (1, 'Operating Room C');

select * from Perform;

-- Insert data into Patient table
INSERT INTO Patient (parientIdentificationNumber, telephoneNumber, bloodType, surname, initialName, age, address)
VALUES
    (101, '555-123-4567', 'A', 'Johnson', 'M.', 35, '123 Pine St'),
    (102, '777-987-6543', 'B', 'Smith', 'J.', 45, '456 Oak St'),
    (103, '888-111-2222', 'O', 'Williams', 'E.', 28, '789 Elm St'),
    (104, '999-555-8888', 'AB', 'Brown', 'R.', 62, '987 Maple Ave'),
    (105, '333-666-9999', 'A', 'Davis', 'L.', 50, '789 Cedar Rd'),
    (106, '999-555-7777', 'AB', 'Brown', 's.', 60, '987 Maple Ave');

select * from Patient;

-- Insert data into Allergies table
INSERT INTO Allergies (parientIdentificationNumber, allergi)
VALUES
    (101, 'Peanuts'),
    (102, 'Penicillin'),
    (103, 'Dust Mites'),
    (104, 'Shellfish'),
    (105, 'Pollen');

select * from Allergies;

-- Insert data into Surgery table
INSERT INTO Surgery (parientIdentificationNumber, surgeryName, date, time, category)
VALUES
    (101, 'Appendectomy', '2023-03-20', '09:00:00', 'General'),
    (102, 'Knee Replacement', '2023-04-10', '11:30:00', 'Orthopedic'),
    (103, 'Cataract Surgery', '2023-05-15', '14:00:00', 'Ophthalmology'),
    (104, 'Colonoscopy', '2023-06-05', '10:45:00', 'Gastroenterology'),
    (105, 'Laser Eye Surgery', '2023-07-10', '13:15:00', 'Ophthalmology');

select * from Surgery;

-- Insert data into specialNeeds table
INSERT INTO specialNeeds (parientIdentificationNumber, surgeryName, specialNeeds)
VALUES
    (101, 'Appendectomy', 'None'),
    (102, 'Knee Replacement', 'Requires wheelchair assistance'),
    (103, 'Cataract Surgery', 'Special glasses needed'),
    (104, 'Colonoscopy', 'None'),
    (105, 'Laser Eye Surgery', 'Sensitivity to light');

select * from specialNeeds;

-- Insert data into Interaction table
INSERT INTO Interaction (parientIdentificationNumber, code, interactionSeverity)
VALUES
    (101, 'INT001', 'Moderate'),
    (102, 'INT002', 'Severe'),
    (103, 'INT003', 'Mild'),
    (104, 'INT004', 'Moderate'),
    (105, 'INT005', 'Mild');

select * from Interaction;

-- Insert data into Medication table
INSERT INTO Medication (parientIdentificationNumber, code, quantityOnHand, quantityOrdered, name, expirationDate, cost)
VALUES
    (101, 'MED001', 100, 20, 'Painkiller', '2024-05-01', 15.99),
    (102, 'MED002', 75, 15, 'Antibiotic', '2023-12-31', 10.50),
    (103, 'MED003', 50, 10, 'Antihistamine', '2023-11-15', 8.75),
    (104, 'MED004', 90, 18, 'Laxative', '2023-09-30', 9.25),
    (105, 'MED005', 120, 24, 'Eye Drops', '2023-10-20', 12.50),
    (101, 'MED010', 80, 10, 'Painkiller3', '2024-05-02', 20.99);

select * from Medication;

-- Insert data into Location table
INSERT INTO Location (parientIdentificationNumber, bedNumber, roomNumber, nursingUnit)
VALUES
    (101, 101, 10, 'Cardiology'),
    (102, 102, 12, 'Orthopedics'),
    (103, 103, 15, 'Ophthalmology'),
    (104, 104, 8, 'Gastroenterology'),
    (105, 105, 5, 'Ophthalmology');

select * from Location;

-- Insert data into patientMedication table
INSERT INTO patientMedication (patientIdentificationNumber, code)
VALUES
    (101, 'MED001'),
    (102, 'MED002'),
    (103, 'MED003'),
    (104, 'MED004'),
    (105, 'MED005'),
    (101, 'MED010');
    
select * from patientMedication; 

# Mini Project 
# Q1 - 221426413 - s92066413
CREATE VIEW patientDetails AS
SELECT P.parientIdentificationNumber, 
	   CONCAT(P.initialName, ' ', P.surname) AS Patient_Name, 
       CONCAT(L.bedNumber, ' ', L.roomNumber) AS Location,  
	   S.surgeryName, S.date
FROM patient P 
JOIN location L ON P.parientIdentificationNumber = L.parientIdentificationNumber
JOIN surgery S ON P.parientIdentificationNumber = S.parientIdentificationNumber;

select * from patientDetails;   

# Q2 - 221426413 - s92066413
-- create MedInfo table
CREATE TABLE MedInfo (
    MedName VARCHAR(150),
    QuantityAvailable INT,
    ExpirationDate DATE
);

# Q2,i - 221426413 - s92066413
-- trigger to load data from medication table
DELIMITER ;;
CREATE TRIGGER InsertMedInfo AFTER INSERT ON Medication FOR EACH ROW
BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
    VALUES (NEW.name, NEW.quantityOnHand, NEW.expirationDate);
END;;
DELIMITER ;

-- insert data to medication table 
INSERT INTO Medication (parientIdentificationNumber, code, quantityOnHand, quantityOrdered, name, expirationDate, cost)
VALUES (106, 'MED011', 100, 20, 'Painkiller2', '2024-05-02', 20.99);
    
select * from MedInfo;

# Q2,ii - 221426413 - s92066413
-- trigger to update data from medication table
DELIMITER ;;
CREATE TRIGGER UpdateMedInfo AFTER UPDATE ON Medication FOR EACH ROW
BEGIN
    UPDATE MedInfo
    SET QuantityAvailable = NEW.quantityOnHand, ExpirationDate = NEW.expirationDate
    WHERE MedName = NEW.name;
END;;
DELIMITER ;

-- update data in medication table
UPDATE Medication
SET quantityOnHand = 55
WHERE parientIdentificationNumber = 106;

select * from MedInfo;

# Q2,iii - 221426413 - s92066413
-- trigger to delete data from medication table
DELIMITER ;;
CREATE TRIGGER DeleteMedInfo AFTER DELETE ON Medication FOR EACH ROW
BEGIN
    DELETE FROM MedInfo
    WHERE MedName = OLD.name;
END;;
DELIMITER ;

-- delete data in medication table
DELETE FROM Medication WHERE parientIdentificationNumber = 106;

select * from MedInfo; 

# Q3 - 221426413 - s92066413
-- stored procedure to get the number of medications taken by a patient
DELIMITER ;;
CREATE PROCEDURE GetMedicationCount(IN patientID INT, INOUT medicationCount INT)
BEGIN
    SELECT COUNT(*) INTO medicationCount
    FROM patientMedication
    WHERE patientIdentificationNumber = patientID;
END;;
DELIMITER ;

-- call procedure
CALL GetMedicationCount(101, @outputCount);
SELECT @outputCount AS MedicationCount;

# Q4 - 221426413 - s92066413
-- function to calculate the remaining days to expire
DELIMITER ;;
CREATE FUNCTION CalculateDaysRemaining(expirationDate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE daysRemaining INT;
    SET daysRemaining = DATEDIFF(expirationDate, CURDATE());
    RETURN daysRemaining;
END;;
DELIMITER ;

-- call function
SELECT m.*, CalculateDaysRemaining(m.expirationDate) AS DaysRemaining
FROM Medication m
WHERE CalculateDaysRemaining(m.expirationDate) <= 30;

# Q5 - 221426413 - s92066413
select * from staff;
select * from patient;




CREATE DATABASE BarwonHealthDB;
GO

USE BarwonHealthDB;
GO

CREATE SCHEMA clinical;
GO

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Specialty VARCHAR(100),
    YearsOfExperience INT CHECK (YearsOfExperience >= 0)
);

CREATE TABLE PharmaceuticalCompany (
    CompanyName VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(255),
    Phone VARCHAR(20)
);

CREATE TABLE Drug (
    DrugID INT PRIMARY KEY,
    TradeName VARCHAR(100) NOT NULL,
    Strength VARCHAR(50),
    CompanyName VARCHAR(100),
    CONSTRAINT FK_Drug_Company
        FOREIGN KEY (CompanyName)
        REFERENCES PharmaceuticalCompany(CompanyName)
        ON DELETE CASCADE
);

CREATE TABLE Patient (
    UR_Number INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Age INT CHECK (Age >= 0),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    MedicareCardNumber VARCHAR(30),
    DoctorID INT NOT NULL,
    CONSTRAINT FK_Patient_Doctor
        FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID)
);

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    DoctorID INT,
    UR_Number INT,
    DrugID INT,
    CONSTRAINT FK_Prescription_Doctor
        FOREIGN KEY (DoctorID)
        REFERENCES Doctor(DoctorID),

    CONSTRAINT FK_Prescription_Patient
        FOREIGN KEY (UR_Number)
        REFERENCES Patient(UR_Number),

    CONSTRAINT FK_Prescription_Drug
        FOREIGN KEY (DrugID)
        REFERENCES Drug(DrugID)
);

INSERT INTO clinical.PharmaceuticalCompany(CompanyName, Address, Phone)
VALUES 
('Pfizer', 'New York, USA', '111111111'),
('Novartis', 'Basel, Switzerland', '222222222'),
('Roche', 'Basel, Switzerland', '333333333');


INSERT INTO clinical.Doctor(DoctorID, Name, Email, Phone, Specialty, YearsOfExperience)
VALUES
(1, 'Ahmed Hassan', 'ahmed@hospital.com', '0101111111', 'Cardiology', 10),
(2, 'Sara Ali', 'sara@hospital.com', '0102222222', 'Dermatology', 6),
(3, 'Mohamed Tarek', 'tarek@hospital.com', '0103333333', 'Oncology', 8),
(4, 'Mona Adel', 'mona@hospital.com', '0104444444', 'Neurology', 4),
(5, 'Khaled Samy', 'khaled@hospital.com', '0105555555', 'Cardiology', 12);

INSERT INTO clinical.Drug (DrugID, TradeName, Strength, CompanyName)
VALUES
(1, 'Panadol', '500mg', 'Pfizer'),
(2, 'Aspirin', '100mg', 'Novartis'),
(3, 'Lipitor', '20mg', 'Pfizer'),
(4, 'Herceptin', '150mg', 'Roche');

INSERT INTO clinical.Patient (UR_Number, Name, Address, Age, Email, Phone, MedicareCardNumber, DoctorID)
VALUES
(101, 'Omar Khaled', 'Cairo', 25, 'omar@gmail.com', '0111111111', 'MC1001', 1),
(102, 'Youssef Ahmed', 'Giza', 30, NULL, '0112222222', 'MC1002', 2),
(103, 'Ali Mahmoud', 'Alexandria', 19, 'ali@gmail.com', '0113333333', 'MC1003', 1),
(104, 'Hassan Mostafa', 'Cairo', 40, NULL, '0114444444', 'MC1004', 3),
(105, 'Mahmoud Adel', 'Mansoura', 28, 'mahmoud@gmail.com', '0115555555', 'MC1005', 5);


INSERT INTO clinical.Prescription(PrescriptionID, Date, Quantity, DoctorID, UR_Number, DrugID)
VALUES
(1, '2025-01-10', 2, 1, 101, 1),
(2, '2025-01-11', 1, 2, 102, 2),
(3, '2025-01-12', 3, 1, 103, 3),
(4, '2025-01-13', 2, 3, 104, 4),
(5, '2025-01-14', 1, 5, 105, 1);


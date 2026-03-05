--Solve Queries

--1- SELECT: Retrieve all columns from the Doctor table.

select *
from clinical.Doctor

--2- ORDER BY: List patients in the Patient table in ascending order of their ages.

select *
from clinical.Patient
order by Age

--3- OFFSET FETCH: Retrieve the first 10 patients from the Patient table, starting from the 5th record.

SELECT *
FROM clinical.Patient
ORDER BY UR_Number  
OFFSET 4 ROWS     
FETCH NEXT 10 ROWS ONLY; 

--4- SELECT TOP: Retrieve the top 5 doctors from the Doctor table. 

select top 5 * 
from clinical.Doctor
ORDER BY DoctorID;

--5- SELECT DISTINCT: Get a list of unique address from the Patient table.

select distinct Address
from clinical.Patient

--6- WHERE: Retrieve patients from the Patient table who are aged 25

select *
from clinical.Patient
where Age = 25

--7- NULL: Retrieve patients from the Patient table whose email is not provided.

select *
from clinical.Patient
where Email IS NULL

--8- AND: Retrieve doctors from the Doctor table who have experience greater than 5 years and specialize in 'Cardiology'.


select *
from clinical.Doctor
where YearsOfExperience>5
and Specialty = 'Cardiology'

--9- IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology' or 'Oncology'.
select *
from clinical.Doctor
where Specialty in ('Dermatology' , 'Oncology')

--10- BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.

select *
from clinical.Patient
where Age between 18 and 30

--11- LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'.

select *
from clinical.Doctor
where Name like 'Dr.%'

--12- Column & Table Aliases: Select the name and email of doctors, aliasing them as 'DoctorName' and 'DoctorEmail'.

select 
Name as DoctorName,Email as DoctorEmail
from clinical.Doctor

--13- Joins: Retrieve all prescriptions with corresponding patient names.

SELECT 
    p.PrescriptionID,
    p.Date,
    p.Quantity,
    pa.Name AS PatientName
FROM clinical.Prescription p
JOIN clinical.Patient pa
ON p.UR_Number = pa.UR_Number;


--14- GROUP BY: Retrieve the count of patients grouped by their cities.

select 
Address as city, 
count(*) as NumberOfPatient
from clinical.Patient
group by Address

--15- HAVING: Retrieve cities with more than 3 patients.


select 
Address as city, 
count(*) as NumberOfPatient
from clinical.Patient
group by Address
having count (*) > 3


--16- EXISTS: Retrieve patients who have at least one prescription.

SELECT *
FROM clinical.Patient p
WHERE EXISTS (
SELECT 1
FROM clinical.Prescription pr
WHERE pr.UR_Number = p.UR_Number
)

--17- UNION: Retrieve a combined list of doctors and patients.
select name
from clinical.Doctor
union 
select name
from clinical.Patient

--18- INSERT: Insert a new doctor into the Doctor table.

insert into clinical.Doctor
values(6,'abdo','reyad.com','01093754915','Benhaology',100)


--19- INSERT Multiple Rows: Insert multiple patients into the Patient table.

INSERT INTO clinical.Patient 
VALUES
(201, 'Karim Adel', 'Cairo', 27, 'karim@gmail.com', '0121111111', 'MC2001', 1),
(202, 'Hassan Ali', 'Giza', 35, NULL, '0122222222', 'MC2002', 2),
(203, 'Mostafa Ahmed', 'Alexandria', 22, 'mostafa@gmail.com', '0123333333', 'MC2003', 3);

--20- UPDATE: Update the phone number of a doctor.
 
update 
clinical.Doctor
set Phone ='01501044123'
where DoctorID = 6

--21- UPDATE JOIN: Update the city of patients who have a prescription from a specific doctor.

UPDATE p
SET p.Address = 'New Cairo'
FROM clinical.Patient p
JOIN clinical.Prescription pr
  ON p.UR_Number = pr.UR_Number
WHERE pr.DoctorID = 1;

--22- DELETE: Delete a patient from the Patient table.

delete 
from clinical.Patient
where UR_Number = 203


--23- Transaction: Insert a new doctor and a patient, ensuring both operations succeed or fail together.

BEGIN TRANSACTION;
INSERT INTO clinical.Doctor (DoctorID, Name, Email, Phone, Specialty, YearsOfExperience)
VALUES (7, 'Ali Samir', 'ali@hospital.com', '0107777777', 'Neurology', 5);
INSERT INTO clinical.Patient (UR_Number, Name, Address, Age, Email, Phone, MedicareCardNumber, DoctorID)
VALUES (205, 'Laila Omar', 'Giza', 24, 'laila@gmail.com', '0127777777', 'MC2005', 7);
COMMIT TRANSACTION;


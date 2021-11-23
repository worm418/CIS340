CREATE TABLE Wards(
WardNumber int PRIMARY KEY,
WardName varchar(60),
numberOfBeds int,
Location varchar(60),
TelephoneExtension int
);

CREATE TABLE Staff(
StaffID int PRIMARY KEY,
address varchar(100),
Telephone varchar(10),
dateOfBirth date,
sex varchar(10),
NIN int,
Position varchar(20),
CurrentSalary decimal(9,2),
SalaryScale decimal(9,2)
);

CREATE TABLE Patient(
PatientID int PRIMARY KEY,
Address varchar(100),
phoneNumber int,
dateOfBirth date,
Sex varchar(10),
dateRegistered date,
nextOfKinPhone varchar(10),
ClinicNumber int,
FOREIGN KEY (nextOfKinPhone) REFERENCES PatientsNextOfKin (PhoneNumber),
FOREIGN KEY (ClinicNumber) REFERENCES LocalDoctors(ClinicNumber)
);

CREATE TABLE PatientsNextOfKin(
FullName varchar(60),
RelationToPatient varchar(60),
Address varchar(100),
PhoneNumber varchar(10),
PRIMARY KEY (PhoneNumber, FullName)
);

CREATE TABLE StaffAllocation (
ChargeNurseID int,
WardID int,
StaffID int,
WeekStartDate date,
ShiftType varchar(10),
PRIMARY KEY (WardID, StaffID),
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
FOREIGN KEY (WardID) REFERENCES Wards(WardNumber)
);

CREATE TABLE Inpatients(
DatePlaced DATE,
BedID int UNIQUE,
PlacedInWard DATE,
ReleaseDate DATE,
WardID INT,
PatientID INT PRIMARY KEY,
FOREIGN KEY (DatePlaced) REFERENCES Patient(dateRegistered),
FOREIGN KEY (WardID) REFERENCES Wards(WardID)
);

CREATE TABLE PatientMedication(
PatientID INT,
DrugID INT,
StartDate DATE,
FinDate DATE,
PRIMARY KEY (PatientID, DrugID),
FOREIGN KEY (DrugID) REFERENCES PharmaceuticalSupplies(DrugID),
FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE SurgNonSurgSupplies(
SupplyID INT,
ItemID INT PRIMARY KEY,
ItemName VARCHAR(100),
QuantityInStock INT,
CostPerUnit DECIMAL(4, 2),
ReorderLevel INT,
FOREIGN KEY (SupplyID) REFERENCES Suppliers (ID)
);

CREATE TABLE StaffEducation(
StaffID INT,
QualificationName VARCHAR(60),
QualificationDate DATE,
InstitutionName VARCHAR(60),
PRIMARY KEY (StaffID, QualificationName),
FOREIGN KEY (StaffID) references Staff(StaffID)
);

CREATE TABLE LocalDoctors(
Name VARCHAR(50),
ClinicNumber INT,
ClinicAddress VARCHAR(50),
ClinicPhoneNumber CHAR(10),
PRIMARY KEY (ClinicNumber)
);

CREATE TABLE PatientAppointments(
AppointmentNumber INT,
PatientNumber INT,
StaffNumber INT,
AppointmentDate DATE,
AppointmentTime TIME,
PRIMARY KEY (AppointmentNumber),
FOREIGN KEY (StaffNumber) REFERENCES Staff(StaffID),
FOREIGN KEY (PatientNumber) REFERENCES Patient(PatientID)
);

CREATE TABLE Outpatients(
PatientNumber INT,
PatientDate DATE,
PatientTime TIME,
ClinicNumber int,
PRIMARY KEY (PatientNumber, PatientTime),
FOREIGN KEY (PatientNumber) REFERENCES Patient(PatientID),
FOREIGN  KEY(PatientNumber) REFERENCES LocalDoctors(ClinicNumber)
);

CREATE TABLE StaffExperience(
StaffID INT,
NameOfOrganization VARCHAR(100),
Position VARCHAR(60),
StartDate DATE,
FinishDate DATE,
Primary Key (StaffID, StartDate),
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE PharmaceuticalSupplies(
DrugID int, 
DrugName varchar(50), 
SupplierID int, 
Description varchar(50), 
Dosage int, 
MOA varchar(50),
Stock int, 
ReOrderLevel int,
CostPerUnit Decimal(4,2), 
PRIMARY KEY (DrugID),
FOREIGN KEY (SupplierID) REFERENCES Suppliers(ID)
);

CREATE TABLE WardRequisitions(
SupplyID int,
DrugID int,
DateOrdered Date,
Description varchar(100),
QuantityRequired int,
StaffID int,
WardID int,
PRIMARY KEY(WardID,DateOrdered),
FOREIGN KEY (SupplyID) REFERENCES SurgNonSurgSupplies(ItemID),
FOREIGN KEY (DrugID) REFERENCES PharmaceuticalSupplies(DrugID),
FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Suppliers(
Name varchar(50),
ID int,
Address varchar(50),
Telephone char(10),
FaxNumber varchar(50),
PRIMARY KEY (ID)
);

CREATE TABLE StaffWorkInfo(
StaffID int,
WeeklyHours Decimal (3,2),
TypeOfContract varchar(10),
SalaryType varchar(8),
PRIMARY KEY(StaffID),
FOREIGN KEY(StaffID) REFERENCES Staff(StaffID)
);

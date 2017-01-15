CREATE TABLE Towns
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(30) NOT NULL
)

CREATE TABLE Addresses
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	AddressText NVARCHAR(200) NOT NULL,
	TownId INT NOT NULL
)

CREATE TABLE Departments
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Employees
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	MiddleName NVARCHAR(20),
	LastName NVARCHAR(20) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	DepartmentId INT NOT NULL,
	HireDate DATE NOT NULL,
	Salary INT NOT NULL,
	AddressId INT NOT NULL
)

ALTER TABLE Addresses
ADD CONSTRAINT FK_TownId
FOREIGN KEY (TownId)
REFERENCES Towns(Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_DepartmentId
FOREIGN KEY (DepartmentId)
REFERENCES Departments(Id)

ALTER TABLE Employees
ADD CONSTRAINT FK_AddressId
FOREIGN KEY (AddressId)
REFERENCES Addresses(Id)

USE master
-- backup, delete and restore
USE SoftUni

INSERT INTO Towns
	(Name)
	VALUES
		('Sofia'),
		('Plovdiv'),
		('Varna'),
		('Burgas')

INSERT INTO Departments
	(Name)
	VALUES
		('Engineering'),
		('Sales'),
		('Software Development'),
		('Quality Assurance')

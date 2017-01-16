USE SoftUni

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
	Salary FLOAT NOT NULL,
	AddressId INT
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

--USE master
--ALTER TABLE Addresses
--DROP CONSTRAINT FK_TownId

--ALTER TABLE Employees
--DROP CONSTRAINT FK_DepartmentId

--ALTER TABLE Employees
--DROP CONSTRAINT FK_AddressId


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
		('Marketing'),
		('Software Development'),
		('Quality Assurance')


INSERT INTO Employees
	(FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary)
	VALUES
		('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500),
		('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000),
		('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
		('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000),
		('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88)

--19.
SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

--20.

SELECT * FROM Towns
ORDER BY Name

SELECT * FROM Departments
ORDER BY Name

SELECT * FROM Employees
ORDER BY Salary DESC

--21.

SELECT Name FROM Towns
ORDER BY Name

SELECT Name FROM Departments
ORDER BY Name

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--22.

UPDATE Employees
SET Salary = Salary + Salary * 10 / 100

SELECT Salary from Employees


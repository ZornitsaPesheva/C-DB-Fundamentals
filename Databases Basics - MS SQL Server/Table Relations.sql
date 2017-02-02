CREATE DATABASE TableRelations

-- 01. One-To-One Relationship

CREATE TABLE Passports(
PassportID INT NOT NULL,
PassportNumber NVARCHAR(10) NOT NULL
)

CREATE TABLE Persons(
PersonID INT NOT NULL,
FirstName NVARCHAR(20) NOT NULL,
Salary DECIMAL(10,2),
PassportID INT NOT NULL)

INSERT INTO Passports (PassportID, PassportNumber)
VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')

INSERT INTO Persons (PersonID, FirstName, Salary, PassportID)
VALUES
	(1, 'Roberto', 43300.00, 102),
	(2, 'Tom', 56100.00, 103),
	(3, 'Yana', 60200.00, 101)

ALTER TABLE Persons
ADD PRIMARY KEY (PersonID)

ALTER TABLE Passports
ADD PRIMARY KEY (PassportID)

ALTER TABLE Persons
ADD CONSTRAINT FK_Persons_Passports
FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID)

-- 02. One-To-Many Relationship

CREATE TABLE Models(
ModelID INT NOT NULL,
Name NVARCHAR(30) NOT NULL,
ManufacturerID INT NOT NULL)

CREATE TABLE Manufacturers(
ManufacturerID INT NOT NULL,
Name NVARCHAR(30) NOT NULL,
EstablishedOn DATE)

INSERT INTO Models (ModelID, Name, ManufacturerID)
VALUES
	(101,'X1', 1),
	(102, 'i6', 1),
	(103, 'Model S', 2),
	(104, 'Model X', 2),
	(105, 'Model 3', 2),
	(106, 'Nova', 3)
 
 INSERT INTO Manufacturers (ManufacturerID, Name, EstablishedOn)
 VALUES
	(1, 'BMW', '1916-03-07'),
	(2, 'Tesla', '2003-01-01'),
	(3, 'Lada', '1966-05-01')

ALTER TABLE Models
ADD PRIMARY KEY (ModelID)

ALTER TABLE Manufacturers
ADD PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
ADD CONSTRAINT FK_Models_Manufacturers
FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)

-- 03. Many-To-Many Relationship

CREATE TABLE Students(
StudentID INT NOT NULL,
Name NVARCHAR(30) NOT NULL)

CREATE TABLE Exams(
ExamID INT NOT NULL,
Name NVARCHAR(50) NOT NULL)

INSERT INTO Students (StudentID, Name)
VALUES
	(1, 'Mila'), (2, 'Toni'), (3, 'Ron')

INSERT INTO Exams (ExamID, Name)
VALUES
	(101, 'SpringMVC'), (102, 'Neo4j'), (103, 'Oracle 11g')

ALTER TABLE Students
ADD PRIMARY KEY (StudentID)

ALTER TABLE Exams
ADD PRIMARY KEY (ExamID)

CREATE TABLE StudentsExams(
StudentID INT,
ExamID INT,
CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID),
CONSTRAINT FK_StudentsExams_Students 
	FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
CONSTRAINT FK_StudentsExams_Exams 
	FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO StudentsExams (StudentID, ExamID)
VALUES
	(1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103)

-- 04. Self-Referencing

CREATE TABLE Teachers(
TeacherID INT NOT NULL,
Name NVARCHAR(30) NOT NULL,
ManagerID INT)

INSERT INTO Teachers (TeacherID, Name, ManagerID)
VALUES
	(101, 'John', NULL),
	(102, 'Maya', 106),
	(103, 'Silvia', 106),
	(104, 'Ted', 105),
	(105, 'Mark', 101),
	(106, 'Greta', 101)

ALTER TABLE Teachers
ADD PRIMARY KEY (TeacherID)

ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_Teachers
FOREIGN KEY (ManagerID)
REFERENCES Teachers(TeacherID)

-- 05. Online Store Database

--CREATE DATABASE OnlineStore

--USE OnlineStore

CREATE TABLE Cities(
CityID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL)

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Birthday DATE,
CityID INT NOT NULL,
CONSTRAINT FK_Customers_Cities
	FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT NOT NULL,
CONSTRAINT FK_Orders_Customers
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE ItemTypes(
ItemTypeID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL)

CREATE TABLE Items(
ItemID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
ItemTypeID INT NOT NULL,
CONSTRAINT FK_Items_ItemTypes
	FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems(
OrderID INT NOT NULL,
ItemID INT NOT NULL,
CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ItemID),
CONSTRAINT FK_OrderItems_Orders
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_OrderItems_Items
	FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)

-- 06. University Database

CREATE DATABASE University

USE University

CREATE TABLE Majors(
MajorID INT PRIMARY KEY,
Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Students(
StudentID INT PRIMARY KEY,
StudentNumber INT NOT NULL,
StudentName NVARCHAR(50) NOT NULL,
MajorID INT NOT NULL,
CONSTRAINT FK_Students_Majors FOREIGN KEY (MajorID)
REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
PaymentID INT PRIMARY KEY,
PaymentDate DATE NOT NULL,
PaymentAmount DECIMAL(10,2),
StudentID INT NOT NULL,
CONSTRAINT FK_Payments_Students FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)
)

CREATE TABLE Subjects(
SubjectID INT PRIMARY KEY,
SubjectName NVARCHAR(50) NOT NULL
)

CREATE TABLE Agenda(
StudentID INT NOT NULL,
SubjectID INT NOT NULL,
CONSTRAINT PK_Agenda PRIMARY KEY (StudentID, SubjectID),
CONSTRAINT FK_Agenda_Students FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID),
CONSTRAINT FK_Agenda_Subjects FOREIGN KEY (SubjectID)
	REFERENCES Subjects(SubjectID)
)

-- 09. *Peaks in Rila

SELECT Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation
FROM Mountains
RIGHT JOIN Peaks
ON Mountains.ID = Peaks.MountainID
WHERE Mountains.ID = 17
ORDER BY Peaks.Elevation DESC



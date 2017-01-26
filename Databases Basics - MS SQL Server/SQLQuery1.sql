CREATE TABLE Employees
(
Id INT IDENTITY(1,1) PRIMARY KEY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Title NVARCHAR(50) NOT NULL,
Notes NVARCHAR(max)
)

INSERT INTO Employees
	(FirstName, LastName, Title, Notes)
	VALUES
		('Zornitsa', 'Serbezova', 'Manager', 'some notes here'),
		('Zivko', 'Serbezov', 'worker', 'no notes here'),
		('Plamen', 'Peshev', 'owner', 'note nuber 1')

CREATE TABLE Customers
(
	AccountNumber INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	PhoneNumber NVARCHAR(20) NOT NULL,
	EmergencyName NVARCHAR(50),
	EmergencyNumber NVARCHAR(20),
	Notes NVARCHAR(max)
)

INSERT INTO Customers
	(FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
	VALUES
		('Maria', 'Ilcheva', '0778412456', 'Marin','0778412455', 'some note here' ),
		('Elena', 'Mincheva', '0778454556', 'Pencho','0778555455', 'some note for this customer' ),
		('Galina', 'Petrova', '0778455556', 'Galin','0778444455', 'a note here' )

CREATE TABLE RoomStatus
(
	RoomStatus NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO RoomStatus
	(RoomStatus, Notes)
	VALUES
		('opravena', 'podredena i izcistena'),
		('neopravena', 'nepodredena i neizcistena'),
		('za remont', 'ima nujda ot remont')

CREATE TABLE RoomTypes
(
	RoomType NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(max),
)

INSERT INTO RoomTypes
	(RoomType, Notes)
	VALUES
		('lux', 'mnogo extri'),
		('normalni', 'na normalni ceni'),
		('evtini', 'naniski ceni')

CREATE TABLE BedTypes
(
	BedType NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO BedTypes
	(BedType, Notes)
	VALUES
		('big double', 'golqmo dvoyno leglo'),
		('double', 'dvoyno leglo'),
		('single', 'edinichno leglo')

CREATE TABLE Rooms
(
	RoomNumber INT PRIMARY KEY,
	RoomType NVARCHAR(20) NOT NULL,
	BedType NVARCHAR(20) NOT NULL,
	Rate INT,
	RoomStatus NVARCHAR(20) NOT NULL,
	Notes NVARCHAR(max)
)

INSERT INTO Rooms
	(RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
	VALUES
		(1, 'lux', 'big double', 6, 'opravena', 'nqma zabelejki'),
		(3, 'normalna', 'double', 6, 'opravena', 'nqma zabelejki'),
		(5, 'evtina', 'single', 6, 'neopravena', 'nqkakvi zabelejki')

CREATE TABLE Payments
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeId INT NOT NULL,
	PaymentDate DATE NOT NULL,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATE NOT NULL,
	LastDateOccupied DATE NOT NULL,
	TotalDays INT NOT NULL,
	AmoumtCharged FLOAT NOT NULL,
	TaxRate FLOAT NOT NULL,
	TaxAmount FLOAT NOT NULL,
	PaymentTotal FLOAT NOT NULL,
	Notes NVARCHAR(max)
)	

INSERT INTO Payments
	(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, 
	TotalDays, AmoumtCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
	VALUES
		(1, '2016-01-25', 1, '2016-01-20', '2016-01-25', 6, 600, 10, 60, 660, 'some notes'),
		(2, '2016-01-25', 2, '2016-01-20', '2016-01-26', 7, 700, 10, 70, 770, 'some notes'),
		(3, '2016-01-25', 3, '2016-01-20', '2016-01-27', 8, 800, 10, 80, 880, 'some notes')

CREATE TABLE Occupancies
(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeId INT NOT NULL,
	DateOccupied DATE NOT NULL,
	AccountNumber INT NOT NULL,
	RoomNumber INT NOT NULL,
	RateApplied INT,
	PhoneCharge FLOAT,
	Notes NVARCHAR(max)
)

INSERT INTO Occupancies
	(EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
	VALUES
		(1, '2015-06-05', 1, 1, 6, 10, 'some notes here'),
		(2, '2015-03-15', 2, 2, 5, 5, 'no notes here'),
		(3, '2015-06-05', 3, 3, 3, 0, 'any note here')


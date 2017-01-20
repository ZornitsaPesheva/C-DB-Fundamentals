CREATE TABLE Users
(
Id INT IDENTITY(1,1) PRIMARY KEY,
Username NVARCHAR(30) NOT NULL,
Pasword NVARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(max),
LastLoginTime DATE,
isDeleted BIT  
)

INSERT INTO Users (Username, Pasword, LastLoginTime, isDeleted)
VALUES
	('Zornitsa', 123456, '2016-12-29', 0),
	('Plamena', 123456, '2016-12-28', 0),
	('Maria', 123456, '2016-12-27', 1),
	('Gosho', 123456, '2016-12-18', 0),
	('Misho', 123456, '2016-12-20', 1),

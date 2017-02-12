-- 01. Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT FirstName AS 'First Name', LastName AS 'Last Name'
	FROM Employees
	WHERE Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

-- 02. Employees with Salary Above Number
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@number Money)
AS
BEGIN
	SELECT FirstName AS 'First Name', LastName AS 'Last Name'
	FROM Employees
	WHERE Salary >= @number
END

EXEC usp_GetEmployeesSalaryAboveNumber 48100

-- 03. Town Names Starting With
CREATE PROCEDURE usp_GetTownsStartingWith (@parameter NVARCHAR(30))
AS
BEGIN
	SELECT Name AS Town FROM Towns
	WHERE Name LIKE @parameter + '%'
END

EXEC usp_GetTownsStartingWith b

-- 04. Employees from Town
CREATE PROCEDURE usp_GetEmployeesFromTown (@townName NVARCHAR(30))
AS
BEGIN
	SELECT e.FirstName AS 'First Name', e.LastName AS 'Last Name'
	FROM Employees e
	JOIN Addresses a
	ON e.AddressID = a.AddressID
	JOIN Towns t
	ON t.TownID = a.TownID
	WHERE t.Name = @townName
END

EXEC usp_GetEmployeesFromTown Sofia

-- 05. Salary Level Function
CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
RETURNS NVARCHAR(10)
AS
BEGIN
	RETURN
		CASE 
			WHEN @salary < 30000 THEN 'Low'
			WHEN @salary BETWEEN 30000 AND 50000 THEN 'Average'
			WHEN @salary > 50000 THEN 'High'
		END
END

SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) AS 'Salary Level'
FROM Employees

-- 06. Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel (@level NVARCHAR(10))
AS 
BEGIN
	SELECT 
		s.FirstName AS 'First Name',
		s.LastName AS 'Last Name'
	FROM (SELECT FirstName, LastName, Salary, 
				dbo.ufn_GetSalaryLevel(Salary) AS sLevel
			FROM Employees) s
	WHERE s.sLevel = @level
END
 
EXEC usp_EmployeesBySalaryLevel Low

-- 07. Define Function
CREATE FUNCTION ufn_IsWordComprised (@setOfLetters NVARCHAR(20), @word NVARCHAR(20))
RETURNS BIT
AS
BEGIN
	DECLARE @comprised BIT = 1
	DECLARE @index INT = 1
 	WHILE (@comprised = 1) AND (@index <= len(@word))
	BEGIN
		IF(CHARINDEX(LOWER(SUBSTRING(@word, @index, 1)), LOWER(@setOfLetters)) NOT BETWEEN 1 AND LEN(@setOfLetters))
			BEGIN
				SET @comprised = 0	
			END
		ELSE SET @index += 1
	END
	RETURN @comprised
END

SELECT dbo.ufn_IsWordComprised('pppp', 'Guy')

-- 08. Delete Employees and Departments

BEGIN TRANSACTION 
ALTER TABLE EmployeesProjects
DROP CONSTRAINT FK_EmployeesProjects_Employees
ALTER TABLE Departments
DROP CONSTRAINT FK_Departments_Employees
ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Employees
DELETE FROM Employees
WHERE DepartmentID IN (7,8)
DELETE FROM Departments
WHERE DepartmentID IN (7,8)

ROLLBACK

-- 09. Employees with Three Projects
CREATE PROCEDURE usp_AssignProject(@emloyeeId INT, @projectID INT)
AS
BEGIN
	BEGIN TRANSACTION
		INSERT INTO EmployeesProjects
			(EmployeeID, ProjectID)
		VALUES
			(@emloyeeId, @projectID)
		IF (SELECT COUNT(EmployeeID) FROM EmployeesProjects
			WHERE EmployeeID = @emloyeeId) > 3
		BEGIN
			RAISERROR('The employee has too many projects!', 16, 1)
			ROLLBACK
		END
	COMMIT
END

EXEC usp_AssignProject 1, 6

-- 10. Find Full Name
CREATE PROCEDURE usp_GetHoldersFullName
AS
BEGIN
	SELECT FirstName + ' ' + LastName AS 'Full Name'
	FROM AccountHolders
END

EXEC usp_GetHoldersFullName

-- 11. People with Balance Higher Than
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@number MONEY)
AS
BEGIN
	SELECT FirstName AS 'First Name', LastName AS 'Last Name' 
	FROM (SELECT FirstName, LastName,
				SUM(a.Balance) AS TotalBalance 
			FROM AccountHolders AS ah
			JOIN Accounts AS a
			ON a.AccountHolderId = ah.Id
			GROUP BY ah.FirstName, ah.LastName
		) AS tb
	WHERE tb.TotalBalance > @number
END

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 2 

-- 12. Future Value Function
CREATE FUNCTION ufn_CalculateFutureValue(@sum MONEY, @yir FLOAT, @ny INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @i INT = 1 
	WHILE (@i <= @ny)
	BEGIN
		SET @sum = @sum + @sum*@yir
		SET @i += 1
	END
	RETURN @sum
END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)

-- 13. Calculating Interest
CREATE PROCEDURE usp_CalculateFutureValueForAccount(@accId INT, @rate FLOAT)
AS
BEGIN
	SELECT ah.Id AS [Account Id], 
		ah.FirstName AS [First Name],
		ah.LastName AS [LastName],
		a.Balance AS [Current Balanse], 
		dbo.ufn_CalculateFutureValue(a.Balance, @rate, 5)
	FROM AccountHolders ah
	RIGHT JOIN Accounts a
	ON ah.Id = a.AccountHolderId
	WHERE a.Id = @accId
END

EXEC usp_CalculateFutureValueForAccount 1, 0.1

-- 14. Deposit Money Procedure
CREATE PROCEDURE usp_DepositMoney (@accountId INT, @moneyAmount MONEY)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance = Balance + @moneyAmount
	WHERE Accounts.Id = @AccountId
	COMMIT 
END 

EXEC usp_DepositMoney 1, 10000

-- 15. Withdraw Money Procedure
CREATE PROCEDURE usp_WithdrawMoney (@accountId INT, @moneyAmount MONEY)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance = Balance - @moneyAmount
	WHERE Accounts.Id = @AccountId
	COMMIT 
END 

EXEC usp_WithdrawMoney 1, 10000

-- 16. Money Transfer
CREATE PROCEDURE usp_TransferMoney(@senderId INT, @receiverId INT, @amount MONEY)
AS
BEGIN
	BEGIN TRANSACTION
	UPDATE Accounts
	SET Balance = Balance - @amount
	WHERE Accounts.Id = @senderId
	UPDATE Accounts
	SET Balance = Balance + @amount
	WHERE Accounts.Id = @receiverId
	IF (SELECT Balance FROM Accounts WHERE Accounts.Id = @senderId) < 0
		ROLLBACK
	ELSE COMMIT 
END

EXEC usp_TransferMoney 1, 2, 10000

-- 17. Create Table Logs
CREATE TABLE Logs(
LogId INT IDENTITY PRIMARY KEY,
AccountId INT,
OldSum MONEY,
NewSum Money)

CREATE TRIGGER tr_SumChanges ON Accounts AFTER UPDATE
AS
BEGIN
	INSERT INTO Logs (AccountId, OldSum, NewSum)
	SELECT i.Id, d.Balance, i.Balance 
	FROM inserted AS i
	INNER JOIN deleted AS d
	ON i.AccountHolderId = d.AccountHolderId
END

UPDATE Accounts
SET Balance += 10
WHERE Id = 1

-- 18. Create Table Emails
CREATE TABLE NotificationEmails(
Id INT IDENTITY PRIMARY KEY,
Recipient NVARCHAR(50),
Subject NVARCHAR(256),
Body NVARCHAR(MAX)
)

CREATE TRIGGER tr_LogToEmail ON Logs AFTER INSERT
AS
BEGIN
	INSERT INTO NotificationEmails
		(Recipient, Subject, Body)
	SELECT AccountId,
		'Balance change for account: ' 
		+ CONVERT(varchar(10), AccountId),
		'On ' + CONVERT(varchar(30), GETDATE()) + ' your balance was changed from '
		+ CONVERT(varchar(30), OldSum) + ' to ' 
		+ CONVERT(varchar(30), NewSum) 
	  FROM Logs
END

UPDATE Accounts
SET Balance += 10
WHERE Id = 1

-- 19. *Cash in User Games Odd Rows
CREATE FUNCTION ufn_CashInUsersGames (@gameName NVARCHAR(50))
RETURNS @Result TABLE(
SumCash MONEY
)
AS
BEGIN
	INSERT INTO @Result
	SELECT SUM(sc.Cash) as SumCash
	FROM
		(SELECT Cash,
		ROW_NUMBER() OVER(ORDER BY Cash DESC) AS RowNumber
		FROM UsersGames ug
		RIGHT JOIN Games g
		ON ug.GameId = g.Id
		WHERE g.Name = @gameName) sc
	WHERE RowNumber % 2 != 0
	RETURN
END

-- 21. *Massive Shopping
BEGIN TRANSACTION
DECLARE @sum1 MONEY = (SELECT SUM(i.Price)
						FROM Items i
						WHERE MinLevel BETWEEN 11 AND 12)

IF (SELECT Cash FROM UsersGames WHERE Id = 110) < @sum1
ROLLBACK
ELSE BEGIN
		UPDATE UsersGames
		SET Cash = Cash - @sum1
		WHERE Id = 110

		INSERT INTO UserGameItems (UserGameId, ItemId)
		SELECT 110, Id 
		FROM Items 
		WHERE MinLevel BETWEEN 11 AND 12
		COMMIT
	END

BEGIN TRANSACTION
DECLARE @sum2 MONEY = (SELECT SUM(i.Price)
						FROM Items i
						WHERE MinLevel BETWEEN 19 AND 21)

IF (SELECT Cash FROM UsersGames WHERE Id = 110) < @sum2
ROLLBACK
ELSE BEGIN
		UPDATE UsersGames
		SET Cash = Cash - @sum2
		WHERE Id = 110

		INSERT INTO UserGameItems (UserGameId, ItemId)
			SELECT 110, Id 
			FROM Items 
			WHERE MinLevel BETWEEN 19 AND 21
		COMMIT
	END

SELECT i.Name AS 'Item Name' 
FROM UserGameItems ugi
JOIN Items i
ON ugi.ItemId = i.Id
WHERE ugi.UserGameId = 110

-- 22. Number of Users for Email Provider
SELECT SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email))  AS [Email Provider], 
	COUNT(Email) AS [Number Of Users]
FROM Users
GROUP BY SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email))
ORDER BY COUNT(Email) DESC, SUBSTRING(Email, CHARINDEX('@', Email)+1, len(Email)) 

-- 23. All Users in Games
SELECT g.Name, gt.Name AS [Game Type], 
	u.Username, ug.Level, ug.Cash, c.Name
FROM Games g
JOIN GameTypes gt
ON gt.Id = g.GameTypeId
JOIN UsersGames ug
ON ug.GameId = g.Id
JOIN Users u
ON u.Id = ug.UserId
JOIN Characters c
ON ug.CharacterId = c.Id
ORDER BY ug.Level DESC, u.Username, g.Name

-- 24. Users in Games with Their Items
SELECT u.Username, g.Name AS Game, COUNT(i.Name), SUM(i.Price)
FROM Users u
JOIN UsersGames ug
ON u.Id = ug.UserId
JOIN Games g
ON ug.GameId = g.Id
JOIN UserGameItems ugi
ON ugi.UserGameId = ug.Id
JOIN Items i
ON i.Id = ugi.ItemId
GROUP BY u.Username, g.Name
HAVING COUNT(i.Name) >= 10
ORDER BY COUNT(i.Name) DESC,
	SUM(i.Price) DESC,
	u.Username

-- 25. * User in Games with Their Statistics
SELECT u.Username, g.Name AS Game, MAX(c.Name) AS Character,
SUM(its.Strength) + MAX(gts.Strength) + MAX(cs.Strength) AS Strength,
SUM(its.Defence) + MAX(gts.Defence) + MAX(cs.Defence) AS Defence,
SUM(its.Speed) + MAX(gts.Speed) + MAX(cs.Speed) as Speed,
SUM(its.Mind) + MAX(gts.Mind) + MAX(cs.Mind) AS Mind,
SUM(its.Luck) + MAX(gts.Luck) + MAX(cs.Luck) AS Luck
FROM Users u
JOIN UsersGames ug
ON u.Id = ug.UserId
JOIN Games g
ON ug.GameId = g.Id
JOIN GameTypes gt
ON gt.Id = g.GameTypeId
JOIN [dbo].[Statistics] gts
ON gts.Id = gt.BonusStatsId
JOIN Characters c
ON ug.CharacterId = c.Id
JOIN [dbo].[Statistics] cs
ON cs.Id = c.StatisticId
JOIN UserGameItems ugi
ON ugi.UserGameId = ug.Id
JOIN Items i
ON i.Id = ugi.ItemId
JOIN [dbo].[Statistics] its
ON its.Id = i.StatisticId
GROUP BY u.Username, g.Name
ORDER BY Strength DESC, Defence DESC, Speed DESC, Mind DESC, Luck DESC

-- 26. All Items with Greater than Average Statistics












	
	

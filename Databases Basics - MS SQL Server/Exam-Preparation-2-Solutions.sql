CREATE DATABASE TheNerdHerd
GO

USE TheNerdHerd
GO

-- 01. DDL
CREATE TABLE Locations
(
Id INT IDENTITY,
Latitude FLOAT,
Longitude FLOAT,
CONSTRAINT PK_Locations PRIMARY KEY(Id)
)

CREATE TABLE Credentials
(
Id INT IDENTITY,
Email VARCHAR(30),
Password VARCHAR(20),
CONSTRAINT PK_Credentials PRIMARY KEY (Id)
)

CREATE TABLE Users
(
Id INT IDENTITY,
Nickname VARCHAR(25),
Gender CHAR(1),
Age INT,
LocationId INT,
CredentialId INT,
CONSTRAINT PK_Users PRIMARY KEY (Id),
CONSTRAINT FK_Users_Credentials FOREIGN KEY(CredentialId) REFERENCES Credentials(Id),
CONSTRAINT FK_Users_Locations FOREIGN KEY(LocationId) REFERENCES Locations(Id),
CONSTRAINT U_Users_CredentialId UNIQUE(CredentialId)
)

CREATE TABLE Chats
(
Id INT IDENTITY,
Title VARCHAR(32),
StartDate DATE,
IsActive BIT,
CONSTRAINT PK_Chats PRIMARY KEY(Id)
)


CREATE TABLE Messages
(
Id INT IDENTITY,
Content VARCHAR(200),
ChatId INT,
UserId INT,
SentOn DATE,
CONSTRAINT PK_Messages PRIMARY KEY(Id),
CONSTRAINT FK_Messages_Chats FOREIGN KEY (ChatId) REFERENCES Chats(Id),
CONSTRAINT FK_Messages_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
)

CREATE TABLE UsersChats
(
UserId INT,
ChatId INT,
CONSTRAINT PK_UsersChats PRIMARY KEY(ChatId, UserId),
CONSTRAINT FK_UsersChats_Users FOREIGN KEY (UserId) REFERENCES Users(Id),
CONSTRAINT FK_UsersChats_Chats FOREIGN KEY (ChatId) REFERENCES Chats(Id),
)

-- Make sure to insert the data from Data.sql script.
-- 02. Insert
INSERT INTO Messages (Id,Content, ChatId, UserId, SentOn)
SELECT
CONCAT(Age, '-', Gender, '-', l.Latitude, '-', l.Longitude ),
CASE 
	WHEN Gender = 'F' THEN CEILING(SQRT(Age * 2))
	WHEN Gender = 'M' THEN CEILING(POWER(Age / 18, 3))
END,
u.Id,
'2016-12-15'
FROM Users AS u
INNER JOIN Locations AS l ON l.Id = u.LocationId
WHERE u.Id BETWEEN 10 AND 20

-- 03. Update
UPDATE Chats
SET StartDate = (
				SELECT MIN(m.SentOn) FROM Chats AS C
				INNER JOIN Messages AS m ON m.ChatId = c.Id
				WHERE c.Id = Chats.Id
				)
WHERE Chats.Id IN (
					SELECT c.Id FROM Chats AS c
					INNER JOIN Messages AS m ON m.ChatId = c.Id
					GROUP BY c.Id, c.StartDate
					HAVING c.StartDate > MIN(m.SentOn)
				)

-- 04. Delete

DELETE FROM Locations 
WHERE Id NOT IN (SELECT DISTINCT LocationId FROM Users)

-- For the rest of the tasks  start with fresh copy of the database.
-- Use only the inserted data from Data.sql script.
-- 07. Chats
SELECT Title, IsActive FROM Chats
WHERE (IsActive = 0 AND LEN(Title) < 5) OR Title LIKE '__tl%'
ORDER BY Title DESC

-- 08. Chat Messages
SELECT c.Id, c.Title, m.Id FROM Chats AS C
INNER JOIN Messages AS m ON m.ChatId = c.Id
WHERE m.SentOn < '20120326' AND RIGHT(Title, 1) = 'x'
ORDER BY c.Id, m.Id

-- 10.
SELECT u.Nickname, cr.Email, cr.Password FROM Users AS u
INNER JOIN Credentials AS cr ON cr.Id = u.CredentialId
WHERE cr.Email LIKE '%co.uk'
ORDER BY cr.Email

-- 12. Left Users
SELECT m.Id, m.ChatId, m.UserId FROM Messages AS m
WHERE m.ChatId = 17 AND (m.UserId NOT IN (SELECT UserId FROM UsersChats WHERE ChatId = 17) OR m.UserId IS NULL)
ORDER BY m.Id DESC

-- 13. Users from Bulgaria
SELECT u.Nickname, c.Title, l.Latitude, l.Longitude FROM Users AS u
INNER JOIN Locations AS l ON l.Id = u.LocationId
INNER JOIN UsersChats AS uc ON uc.UserId = u.Id
INNER JOIN Chats AS c ON c.Id = uc.ChatId
WHERE (l.Latitude BETWEEN 41.13999 AND 44.12999) AND (l.Longitude BETWEEN 22.209999 AND 28.35999)
ORDER BY c.Title 

-- 14. Last Chat
SELECT 
TOP 1 WITH TIES c.Title
 FROM Chats AS c
LEFT JOIN Messages AS m ON m.ChatId = c.Id
ORDER BY StartDate DESC, m.SentOn ASC

-- 14. Last Chat (1)
SELECT TOP 1 WITH TIES c.Title, m.Content FROM (
				SELECT 
				 TOP 1 WITH TIES c.Id
				FROM Chats AS c
				ORDER BY StartDate DESC
				) AS LastChat
INNER JOIN Chats AS c ON c.Id = LastChat.Id
LEFT JOIN Messages AS m ON m.ChatId = LastChat.Id
ORDER BY m.SentOn

-- 15. Radians
GO
CREATE FUNCTION udf_GetRadians (@degrees FLOAT)
RETURNS FLOAT
AS 
BEGIN
	RETURN @degrees * PI()/180
END
GO

SELECT dbo.udf_GetRadians(22.12) AS Radians

-- 16. Change Password
GO
CREATE PROC udp_ChangePassword(@email VARCHAR(MAX), @newPassword VARCHAR(MAX))
AS
BEGIN
	BEGIN TRANSACTION

	UPDATE Credentials
	SET Password = @newPassword
	WHERE Email = @email

	IF(@@ROWCOUNT <> 1)
	BEGIN
		ROLLBACK;
		RAISERROR('The email does''t exist!', 16, 1)
	END
	ELSE
	BEGIN
		COMMIT
	END
END

exec udp_ChangePassword 'abarnes0@sogou.com','new_pass'

-- 17. Send Message
GO
CREATE PROC udp_SendMessage (@userId INT, @chatId INT, @content VARCHAR(MAX))
AS
BEGIN
	DECLARE @chatsCount INT = (SELECT COUNT(*) FROM UsersChats WHERE UserId = @userId AND ChatId = @chatId)

	IF(@chatsCount <> 1)
	BEGIN
		RAISERROR('There is no chat with that user!', 16, 1)
	END
	ELSE
	BEGIN
		INSERT INTO Messages (UserId, ChatId, Content, SentOn)
		VALUES (@userId, @chatId, @content, GETDATE())
	END
END

EXEC dbo.udp_SendMessage 19, 17, 'Awesome'

-- 18. Log Messages
GO
CREATE TRIGGER T_Messages_After_Delete ON Messages AFTER DELETE
AS
	INSERT INTO MessageLogs
	SELECT * FROM deleted


DELETE FROM [Messages]
       WHERE [Messages].Id = 1

SELECT * FROM [dbo].[MessagesLogs]

-- 19. Delete Users
GO
CREATE TRIGGER T_Users_InsteadOF_Delete ON Users INSTEAD OF DELETE
AS
	UPDATE Users
	SET CredentialId = NULL
	WHERE Id IN (SELECT Id FROM deleted)
	
	DELETE FROM Credentials
	WHERE Id IN (SELECT CredentialId FROM deleted)

	DELETE FROM UsersChats
	WHERE UserId IN (SELECT Id FROM deleted)

	UPDATE Messages
	SET UserId = NULL
	WHERE UserId IN (SELECT Id FROM deleted)
	
	DELETE FROM Users
	WHERE Id IN (SELECT Id FROM deleted)
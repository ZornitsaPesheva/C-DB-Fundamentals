-- Section 1: DDL
CREATE TABLE Flights(
FlightID INT PRIMARY KEY,
DepartureTime DATETIME NOT NULL,
ArrivalTime DATETIME NOT NULL,
Status VARCHAR(9),
CONSTRAINT chk_Status 
	CHECK (Status IN ('Departing', 'Delayed', 'Arrived', 'Cancelled')),
OriginAirportID INT,
CONSTRAINT FK_Flights_Airports1
	FOREIGN KEY (OriginAirportID) REFERENCES Airports(AirportID),
DestinationAirportID INT,
CONSTRAINT FK_Flights_Airports2
	FOREIGN KEY (DestinationAirportID) REFERENCES Airports(AirportID),
AirlineID INT,
CONSTRAINT FK_Flights_Airlines
	FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
)

CREATE TABLE Tickets(
TicketID INT PRIMARY KEY,
Price DECIMAL(8,2) NOT NULL,
Class VARCHAR(6),
CONSTRAINT chk_Class
	CHECK (Class IN ('First', 'Second', 'Third')),
Seat VARCHAR(5) NOT NULL,
CustomerID INT,
CONSTRAINT FK_Tickets_Customers
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FlightID INT,
CONSTRAINT FK_Tickets_Flights
	FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
)

-- Section 2: DML - 01. Data Insertion
INSERT INTO Flights ([FlightID], [DepartureTime], [ArrivalTime], [Status], 
	[OriginAirportID], [DestinationAirportID], [AirlineID])
VALUES
	(1, '2016-10-13 06:00 AM', '2016-10-13 10:00 AM', 
	'Delayed', 1, 4, 1),
	(2, '2016-10-12 12:00 PM', '2016-10-12 12:01 PM', 
	'Departing', 1, 3, 2),
	(3, '2016-10-14 03:00 PM', '2016-10-20 04:00 AM', 
	'Delayed', 4, 2, 4),
	(4, '2016-10-12 01:24 PM', '2016-10-12 4:31 PM', 
	'Departing', 3, 1, 3),
	(5, '2016-10-12 08:11 AM', '2016-10-12 11:22 PM', 
	'Departing', 4, 1, 1),
	(6, '1995-06-21 12:30 PM', '1995-06-22 08:30 PM', 
	'Arrived', 2, 3, 5),
	(7, '2016-10-12 11:34 PM', '2016-10-13 03:00 AM', 
	'Departing', 2, 4, 2),
	(8, '2016-11-11 01:00 PM', '2016-11-12 10:00 PM', 
	'Delayed', 4, 3, 1),
	(9, '2015-10-01 12:00 PM', '2015-12-01 01:00 AM', 
	'Arrived', 1, 2, 1),
	(10, '2016-10-12 07:30 PM', '2016-10-13 12:30 PM', 
	'Departing', 2, 1, 7)

INSERT INTO Tickets ([TicketID], [Price], [Class], [Seat], [CustomerID], [FlightID])
VALUES
	(1, 3000.00, 'First', '233-A', 3, 8),
	(2, 1799.90, 'Second', '123-D', 1, 1),
	(3, 1200.50, 'Second', '12-Z', 2, 5),
	(4, 410.68, 'Third', '45-Q', 2, 8),
	(5, 560.00, 'Third', '201-R', 4, 6),
	(6, 2100.00, 'Second', '13-T', 1, 9),
	(7, 5500.00, 'First', '98-O', 2, 7)

-- Section 2: DML - 02. Update Flights
UPDATE Flights
SET AirlineID = 1
WHERE Status = 'Arrived'

-- Section 2: DML - 03. Update Tickets
UPDATE Tickets
SET Price += Price/2
WHERE FlightID IN (SELECT FlightID FROM Flights
					WHERE AirlineID = (SELECT AirlineID FROM Airlines 
										WHERE Rating = (SELECT MAX(Rating) 
														FROM Airlines)))

-- Section 2: DML - 04. Table Creation
CREATE TABLE CustomerReviews(
ReviewID INT PRIMARY KEY,
ReviewContent VARCHAR(255) NOT NULL,
ReviewGrade INT, 
CONSTRAINT chk_ReviewGrade
	CHECK (ReviewGrade BETWEEN 0 AND 10),
AirlineID INT,
CONSTRAINT FK_CustomerReviews_Airlines
	FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID),
CustomerID INT,
CONSTRAINT FK_CustomerReviews_Customers
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

CREATE TABLE CustomerBankAccounts(
AccountID INT PRIMARY KEY,
AccountNumber VARCHAR(10) NOT NULL UNIQUE,
Balance DECIMAL(10, 2) NOT NULL,
CustomerID INT,
CONSTRAINT FK_CustomerBankAccounts_Customers
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
)

-- Section 2: DML - 05. Fillin New Tables
INSERT INTO CustomerReviews ([ReviewID], [ReviewContent], 
	[ReviewGrade], [AirlineID], [CustomerID])
VAlUES
	(1, 'Me is very happy. Me likey this airline. Me good.', 10, 1, 1),
	(2, 'Ja, Ja, Ja... Ja, Gut, Gut, Ja Gut! Sehr Gut!', 10, 1, 4),
	(3, 'Meh...', 5, 4, 3),
	(4, 'Well Ive seen better, but Ive certainly seen a lot worse...', 7, 3, 5)

INSERT INTO CustomerBankAccounts ([AccountID], [AccountNumber],
	[Balance], [CustomerID])
VALUES
	(1, '123456790', 2569.23, 1),
	(2, '18ABC23672', 14004568.23, 2),
	(3, 'F0RG0100N3', 19345.20, 5)

-- Section 3: Querying - 01. Extract All Tickets
SELECT TicketID, Price, Class, Seat
FROM Tickets
ORDER BY TicketID

-- Section 3: Querying - 02. Extract All Customers
SELECT CustomerID, FirstName + ' ' + LastName AS FullName, Gender 
FROM Customers
ORDER BY FullName, CustomerID

-- Section 3: Querying - 03. Extract Delayed Flights
SELECT FlightID, DepartureTime, ArrivalTime
FROM Flights
WHERE Status = 'Delayed'
ORDER BY FlightID

-- Section 3: Querying - 04. Top 5 Airlines
SELECT TOP 5 AirlineID, AirlineName, Nationality, Rating
FROM Airlines
WHERE AirlineID IN (SELECT AirlineID FROM Flights)
ORDER BY Rating DESC, AirlineID

-- Section 3: Querying - 05. All Tickets Below 5000
SELECT t.TicketID, a.AirportName AS Destination, 
c.FirstName + ' ' + c.LastName AS CustomerName
FROM Tickets t
JOIN Flights f
ON f.FlightID = t.FlightID
JOIN Airports a
ON a.AirportID = f.DestinationAirportID
JOIN Customers c
ON c.CustomerID = t.CustomerID
WHERE t.Price < 5000 AND t.Class = 'First'
ORDER BY TicketID

-- Section 3: Querying - 06. Customers From Home
SELECT c.CustomerID, 
	c.FirstName + ' ' + c.LastName AS FulName, 
	tn.TownName AS HomeTown
FROM Customers c
JOIN Tickets t
ON t.CustomerID = c.CustomerID
JOIN Flights f
ON f.FlightID = t.FlightID
JOIN Airports a
ON a.AirportID = f.OriginAirportID
JOIN Towns tn
ON tn.TownID = a.TownID
WHERE a.TownID = c.HomeTownID
AND f.Status = 'Departing'

-- Section 3: Querying - 07. Customers who will fly
SELECT DISTINCT c.CustomerID, 
	c.FirstName + ' ' + c.LastName AS FulName,
	2016 - YEAR(c.DateOfBirth) AS Age
FROM Customers c
JOIN Tickets t
ON t.CustomerID = c.CustomerID
JOIN Flights f
ON t.FlightID = f.FlightID
WHERE f.Status = 'Departing'
ORDER BY Age, c.CustomerID

-- Section 3: Querying - 08. Top 3 Customers Delayed
SELECT TOP 3 c.CustomerID, 
	c.FirstName + ' ' + c.LastName AS FulName,
	t.Price, a.AirportName AS Destination
FROM Customers c
JOIN Tickets t
ON t.CustomerID = c.CustomerID
JOIN Flights f
ON f.FlightID = t.FlightID
JOIN Airports a
ON a.AirportID = f.DestinationAirportID
WHERE f.Status = 'Delayed'
ORDER BY t.Price DESC, c.CustomerID

-- Section 3: Querying - 09. Last 5 Departing Flights
SELECT fl.FlightID, fl.DepartureTime, fl.ArrivalTime,
	ao.AirportName AS Origin, ad.AirportName AS Destination
FROM (SELECT TOP 5 * FROM Flights
				WHERE Status = 'Departing'
				ORDER BY DepartureTime DESC) AS fl
JOIN Airports ao
ON ao.AirportID = fl.OriginAirportID
JOIN Airports ad
ON ad.AirportID = fl.DestinationAirportID
ORDER BY fl.DepartureTime, FlightID

-- Section 3: Querying - 10. Customers Below 21
SELECT DISTINCT c.CustomerID,
	c.FirstName + ' ' + c.LastName AS FullName,
	2016 - YEAR(c.DateOfBirth) AS Age
FROM Customers c
JOIN Tickets t
ON c.CustomerID = t.CustomerID
JOIN Flights f
ON f.FlightID = t.FlightID
WHERE f.Status = 'Arrived'
AND 2016 - YEAR(c.DateOfBirth) < 21
ORDER BY Age DESC, c.CustomerID

-- Section 3: Querying - 11. AIrports and Passengers
SELECT a.AirportID, a.AirportName, 
	COUNT(t.CustomerID) AS Passengers
FROM Airports a
JOIN Flights f
ON f.OriginAirportID= a.AirportID
JOIN Tickets t
ON f.FlightID = t.FlightID
WHERE f.Status = 'Departing'
GROUP BY a.AirportID, a.AirportName

-- Section 4: Programmibility - 01. Submit Review
CREATE PROCEDURE usp_SubmitReview(@CustomerID INT, @ReviewContent VARCHAR(255),
	@ReviewGrade INT, @AirlineName VARCHAR(30))
AS
BEGIN
	BEGIN TRAN

	DECLARE @Index INT 
		IF((SELECT COUNT(*) FROM CustomerReviews) = 0)
			SET @Index = 1
		ELSE 
		SET @Index = (SELECT MAX(ReviewID) FROM CustomerReviews) + 1
		
		DECLARE @AirlineId INT  = (SELECT AirlineID FROM Airlines WHERE AirlineName = @AirlineName)
		
		INSERT INTO CustomerReviews
					(ReviewID, ReviewContent, ReviewGrade, 
						 CustomerID, AirlineID)
				VALUES (@Index, @ReviewContent, @ReviewGrade,
						@CustomerID, @AirlineID)

		IF NOT EXISTS(SELECT AirlineName FROM Airlines
					WHERE AirlineName = @AirlineName)
			BEGIN
				RAISERROR('Airline does not exist.', 16, 1)
				ROLLBACK
			END
		ELSE
			BEGIN 
				COMMIT
			END
END 

EXEC usp_SubmitReview 'nqkakvo review 1',1, 20, 'Royal Airline'

-- Section 4: Programmibility - 02. Ticket Purchase




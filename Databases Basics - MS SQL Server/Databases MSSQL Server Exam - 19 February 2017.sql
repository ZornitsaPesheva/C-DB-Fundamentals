CREATE DATABASE Bakery
USE Bakery

-- 01. Database design
CREATE TABLE Products
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(25) UNIQUE,
	Description NVARCHAR(250),
	Recipe NVARCHAR(MAX),
	Price MONEY CHECK (Price >= 0)
)

CREATE TABLE Countries
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(50) UNIQUE
)

CREATE TABLE Distributors
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(25) UNIQUE,
	AddressText NVARCHAR(30),
	Summary NVARCHAR(200),
	CountryId INT,
	CONSTRAINT FK_Distributor_Countries
		FOREIGN KEY (CountryId) 
		REFERENCES Countries(Id)
)

CREATE TABLE Ingredients
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(30),
	Description NVARCHAR(200),
	OriginCountryId INT,
	DistributorId INT,
	CONSTRAINT FK_Ingredients_Countries
		FOREIGN KEY (OriginCountryId)
		REFERENCES Countries(Id),
	CONSTRAINT FK_Ingredients_Distributors
		FOREIGN KEY (DistributorId)
		REFERENCES Distributors(Id)
)

CREATE TABLE Customers
(
	Id INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(25),
	LastName NVARCHAR(25),
	Gender CHAR(1) CHECK (Gender = 'M' OR Gender = 'F') NOT NULL,
	Age INT,
	PhoneNumber CHAR(10),
	CountryId INT,
	CONSTRAINT FK_Customers_Countries
		FOREIGN KEY (CountryId)
		REFERENCES Countries(Id)
)

CREATE TABLE Feedbacks
(
	Id INT IDENTITY PRIMARY KEY,
	Description NVARCHAR(255),
	Rate DECIMAL(4,2) CHECK (Rate >=0 AND RATE <= 10),
	ProductId INT,
	CustomerId INT,
	CONSTRAINT FK_Feedbacks_Products
		FOREIGN KEY (ProductId)
		REFERENCES Products(Id),
	CONSTRAINT FK_Feedbacks_Customers
		FOREIGN KEY (CustomerId)
		REFERENCES Customers(Id)
)

CREATE TABLE ProductsIngredients
(
	ProductId INT,
	IngredientId INT
	CONSTRAINT PK_ProductsIngredients 
		PRIMARY KEY(ProductId, IngredientId),
	CONSTRAINT FK_ProductsIngredients_Products
		FOREIGN KEY (ProductId)
		REFERENCES Products(Id),
	CONSTRAINT FK_ProductsIngredients_Ingredients
		FOREIGN KEY (IngredientId)
		REFERENCES Ingredients(Id)
)

-- 02. Insert

INSERT INTO Distributors (Name, CountryId, AddressText, Summary)	
	VALUES
		('Deloitte & Touche', 2, '6 Arch St #9757', 'Customizable neutral traveling'),
		('Congress Title', 13, '58 Hancock St', 'Customer loyalty'),
		('Kitchen People', 1, '3 E 31st St #77', 'Triple-buffered stable delivery'),
		('General Color Co Inc', 21, '6185 Bohn St #72', 'Focus group'),
		('Beck Corporation', 23, '21 E 64th Ave', 'Quality-focused 4th generation hardware')

INSERT INTO Customers (FirstName, LastName, Age, Gender, PhoneNumber, CountryId)
	VALUES
		('Francoise', 'Rautenstrauch', 15, 'M', '0195698399', 5),
		('Kendra', 'Loud', 22, 'F', '0063631526', 11),
		('Lourdes', 'Bauswell', 50, 'M', '0139037043', 8),
		('Hannah', 'Edmison', 18, 'F', '0043343686', 1),
		('Tom', 'Loeza', 31, 'M', '0144876096', 23),
		('Queenie', 'Kramarczyk', 30, 'F', '0064215793', 29),
		('Hiu', 'Portaro', 25, 'M', '0068277755', 16),
		('Josefa', 'Opitz', 43, 'F', '0197887645', 17)

-- 03. Update
UPDATE Ingredients
SET DistributorId = 35
WHERE Name IN ('Bay Leaf', 'Paprika', 'Poppy')

UPDATE Ingredients
SET OriginCountryId = 14
WHERE OriginCountryId = 8

-- 04. Delete
DELETE FROM Feedbacks
WHERE CustomerId = 14 OR ProductId = 5

-- 05. Product by Price
SELECT Name, Price, Description FROM Products
ORDER BY Price DESC, Name

-- 06. Ingredients
SELECT Name, Description, OriginCountryId 
FROM Ingredients
WHERE OriginCountryId IN (1, 10, 20)
ORDER BY Id

-- 07. Ingredients from Bulgaria and Greece
SELECT TOP 15 i.Name, i.Description, c.Name
FROM Ingredients i
JOIN Countries c
ON i.OriginCountryId = c.Id
WHERE c.Name = 'Bulgaria' OR c.Name = 'Greece'
ORDER BY i.Name, c.Name

-- 08. Best Rated Products
SELECT TOP 10 p.Name, p.Description,
		f.AvgRate, f.FeedBacksAmount
FROM Products p
JOIN (SELECT ProductId, AVG(Rate) AS AvgRate, 
			COUNT(*) AS FeedBacksAmount 
		FROM Feedbacks
		GROUP BY ProductId) AS f
ON p.Id = f.ProductId
ORDER BY f.AvgRate DESC, f.FeedBacksAmount DESC

-- 09. Negative Feedback
SELECT f.ProductId, f.Rate, f.Description, 
	f.CustomerId, c.Age, c.Gender
FROM Feedbacks f
JOIN Customers c
ON f.CustomerId = c.Id
WHERE f.Rate < 5.0
ORDER BY f.ProductId DESC, f.Rate

-- 10. Customers without Feedback ?????
SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName,
	c.PhoneNumber, c.Gender
FROM Customers c
LEFT JOIN Feedbacks f
ON c.Id = f.CustomerId
WHERE f.CustomerId IS NULL
ORDER BY c.Id

SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName,
	c.PhoneNumber, c.Gender
FROM Customers c
WHERE c.Id NOT IN (SELECT CustomerId FROM Feedbacks)
ORDER BY c.Id

-- 11. Honorable Mentions
SELECT f.ProductId, 
	CONCAT(FirstName, ' ', LastName) AS CustomerName,
	f.Description
FROM Feedbacks f
JOIN Customers c
ON f.CustomerId = c.Id
WHERE f.CustomerId IN (SELECT CustomerId
						FROM Feedbacks
						GROUP BY CustomerId
						HAVING COUNT(Id) >= 3)
ORDER BY f.ProductId, CustomerName, f.Id

-- 12. Customers by Criteria
SELECT FirstName, Age, PhoneNumber
FROM Customers
WHERE (Age >= 21 AND FirstName LIKE '%an%') 
	OR (PhoneNumber LIKE '%38' AND CountryId != 17)
ORDER BY FirstName, Age DESC

-- 13. Middle Range Distributors
SELECT d.Name AS DistributorName,
	i.Name AS IngredientName,
	p.Name AS ProductName,
	ar.AvgRate
FROM Distributors d
JOIN Ingredients i
ON d.Id = i.DistributorId
JOIN ProductsIngredients pin
ON i.Id = pin.IngredientId
JOIN Products p
ON pin.ProductId = p.Id
JOIN (SELECT ProductId, AVG(Rate) AS AvgRate
		FROM Feedbacks
		GROUP BY ProductId
		HAVING AVG(Rate) BETWEEN 5 AND 8
		) AS ar
ON p.Id = ar.ProductId
ORDER BY DistributorName, IngredientName, ProductName

-- 14. The Most Positive Country
SELECT TOP 1 WITH TIES ctr.Name AS CountryName,
	 AVG(Rate) AS FeedbackRate
FROM Feedbacks f
JOIN Customers cst
ON cst.Id = f.CustomerId
JOIN Countries ctr
ON  ctr.Id = cst.CountryId
GROUP BY ctr.Name
ORDER BY FeedbackRate DESC

-- 15. Country Representative
SELECT c.Name AS CountryName,
	d.Name AS DistributorName
	FROM Countries c
JOIN Distributors d
ON d.CountryId = c.Id
LEFT JOIN Ingredients i
ON i.DistributorId = d.Id
GROUP BY c.Name, d.Name
HAVING COUNT(i.Name) = (SELECT TOP 1 COUNT(ii.Name)
						FROM Distributors dd
						JOIN Countries cc
						ON cc.Id = dd.CountryId
						LEFT JOIN Ingredients ii
						ON ii.DistributorId = dd.Id
						WHERE cc.Name = c.Name
						GROUP BY dd.Name
						ORDER BY COUNT(ii.Name) DESC)
ORDER BY CountryName

-- 16. Customers With Countries
CREATE VIEW v_UserWithCountries AS
SELECT CONCAT(cu.FirstName, ' ', cu.LastName) AS CustomerName,
	cu.Age, cu.Gender, co.Name
FROM Customers cu
JOIN Countries co
ON cu.CountryId = co.Id

-- 17. Feedback by Product Name 
CREATE FUNCTION udf_GetRating (@productName NVARCHAR(25))
RETURNS NVARCHAR(25)
AS
BEGIN
	DECLARE @rate DECIMAL(4,2) = 0
	SET @rate = (SELECT AVG(Rate)
				FROM Feedbacks 
				WHERE ProductId = (SELECT Id
									FROM Products
									WHERE Name = @productName)
			
				)
	RETURN
		CASE 
			WHEN @rate < 5 THEN 'Bad'
			WHEN @rate BETWEEN 5 AND 8 THEN 'Average'
			WHEN @rate > 8 THEN 'Good'
			WHEN @rate IS NULL THEN 'No rating'
		END
END

-- 18. Send Feedback
CREATE PROCEDURE usp_SendFeedback (@customerId INT, @productId INT, 
				@rate DECIMAL(4,2), @deascription NVARCHAR(255))
AS
BEGIN
	BEGIN TRAN
		INSERT INTO Feedbacks (Description, Rate, ProductId, CustomerId)
		VALUES (@deascription, @rate, @productId, @customerId)
		IF (SELECT COUNT(Id)
			FROM Feedbacks
			WHERE CustomerId = @customerId) > 3
			BEGIN
				ROLLBACK
				RAISERROR('You are limited to only 3 feedbacks per product!', 16, 1)
			END
		ELSE 
			COMMIT
END

-- 19. Delete Products 




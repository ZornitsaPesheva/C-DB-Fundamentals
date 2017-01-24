--1
SELECT FirstName, LastName FROM Employees
WHERE LEFT(FirstName, 2) = 'SA'

--2
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'

--3
SELECT FirstName FROM Employees
WHERE DepartmentID IN (3, 10)  AND YEAR([HireDate]) BETWEEN 1995 AND 2005

--4
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--5
SELECT Name FROM Towns
WHERE LEN(Name) IN (5, 6)
ORDER BY Name 

--6
SELECT * FROM Towns
WHERE LEFT(Name, 1) IN ('M', 'K', 'B', 'E')
ORDER BY Name

--7
SELECT * FROM Towns
WHERE LEFT(Name, 1) NOT IN ('R', 'B', 'D')
ORDER BY Name

--8
CREATE VIEW V_EmployeesHiredAfter2000 AS
  SELECT FirstName, LastName FROM Employees
  WHERE YEAR(HireDate) > 2000

--8+
SELECT * FROM V_EmployeesHiredAfter2000

--9
SELECT FirstName, LastName FROM Employees
WHERE len(LastName) = 5

--10
SELECT CountryName, IsoCode FROM Countries
WHERE CountryName LIKE ('%a%a%a%')
ORDER BY IsoCode

--11
SELECT p.PeakName, r.RiverName, lower(p.PeakName + SUBSTRING(r.RiverName, 2, len(r.RiverName)-1)) AS Mix
FROM Peaks p
JOIN Rivers r
ON RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY Mix

--12 тук задължително char(10) и годините в кавички
SELECT TOP 50 Name, CONVERT(char(10), Start, 126) FROM Games
WHERE YEAR(Start) = '2011' OR YEAR(Start) = '2012'
ORDER BY Start, Name

--13



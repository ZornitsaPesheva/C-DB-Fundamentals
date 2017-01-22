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


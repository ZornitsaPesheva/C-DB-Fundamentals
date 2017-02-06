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
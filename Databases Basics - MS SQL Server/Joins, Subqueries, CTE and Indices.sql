-- 01. Employee Address
SELECT TOP 5 
	e.EmployeeId, e.JobTitle, e.AddressId, a.AddressText
FROM Employees e
JOIN Addresses a
ON e.AddressID = a.AddressID
ORDER BY e.AddressID

-- 02. Addresses with Towns
SELECT TOP 50 
	e.FirstName, e.LastName, t.Name, a.AddressText
FROM Employees e
JOIN Addresses a
ON e.AddressID = a.AddressID
JOIN Towns t
ON a.TownID = t.TownID
ORDER BY FirstName, LastName

-- 03. Sales Employees
SELECT 
	e.EmployeeID, e.FirstName, e.LastName, d.Name
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'SALES'
ORDER BY e.EmployeeID

-- 04. Employee Departments
SELECT TOP 5
	e.EmployeeID, e.FirstName, e.Salary, d.Name
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE Salary > 15000
ORDER BY d.DepartmentID

-- 05. Employees Without Projects
SELECT TOP 3
	e.EmployeeID, e.FirstName FROM Employees e
WHERE e.EmployeeID NOT IN 
	(SELECT EmployeeID FROM EmployeesProjects)
ORDER BY e.EmployeeID

-- 06. Employees Hired After
SELECT
	e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1999-01-01'
	AND d.Name IN ('Sales', 'Finance')

-- 07. Employees With Project
SELECT TOP 5
	e.EmployeeID, e.FirstName, p.Name
FROM Employees e
JOIN EmployeesProjects ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects p
ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13'
	AND p.EndDate IS NULL 
ORDER BY e.EmployeeID

-- 08. Employee 24
SELECT e.EmployeeID, e.FirstName, 
	CASE 
		WHEN p.StartDate > '2005-01-01' THEN NULL
		ELSE p.Name
	END AS Name
FROM Employees e
JOIN EmployeesProjects ep
ON e.EmployeeID = ep.EmployeeID
JOIN Projects p
ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

-- 09. Employee Manager
SELECT 
	e1.EmployeeID, e1.FirstName, e1.ManagerID, e2.FirstName AS ManagerName
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID
WHERE e1.ManagerID IN (3, 7)
ORDER BY e1.EmployeeID

-- 10. Employees Summary
 
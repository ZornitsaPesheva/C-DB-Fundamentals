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
SELECT TOP 50 
	e1.EmployeeID, e1.FirstName + ' ' + e1.LastName AS EmployeeName,
	e2.FirstName + ' ' + e2.LastName AS ManagerName,
	d.Name AS DepartmentName
FROM Employees e1
JOIN Employees e2
ON e1.ManagerID = e2.EmployeeID
JOIN Departments d
ON e1.DepartmentID = d.DepartmentID
ORDER BY e1.EmployeeID

-- 11. Min Average Salary
SELECT MIN(a.Salary) AS MinAverageSalary FROM 
	(SELECT e.DepartmentID, AVG(e.Salary) AS Salary
	FROM Employees e
	GROUP BY e.DepartmentID) a

-- 12. Highest Peaks in Bulgaria
SELECT mc.CountryCode, m.MountainRange, 
	p.PeakName, p.Elevation
FROM MountainsCountries mc
JOIN Mountains m
ON mc.MountainId = m.Id
RIGHT JOIN Peaks p
ON p.MountainId = m.Id
WHERE mc.CountryCode = 'BG'
	AND p.Elevation > 2835
ORDER BY p.Elevation DESC

-- 13. Count Mountain Ranges
SELECT mc.CountryCode, 
	COUNT(m.MountainRange) AS MountainRanges 
FROM MountainsCountries mc
JOIN Mountains m
ON mc.MountainId = m.Id
GROUP BY mc.CountryCode
HAVING mc.CountryCode IN ('US', 'RU', 'BG')

-- 14. Countries With or Without Rivers
SELECT TOP 5 c.CountryName, r.RiverName
FROM Countries c
LEFT JOIN CountriesRivers cr
ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers r
ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

-- 15. Continents and Currencies
SELECT -- още не мога да го измисля
	(SELECT ccc.ContinentCode, MAX(ccc.cnt) AS CurrencyUsage FROM
		(SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS cnt
		FROM Countries 
	GROUP BY ContinentCode, CurrencyCode) ccc
	GROUP BY ccc.ContinentCode
	ORDER BY ccc.ContinentCode) AS c1





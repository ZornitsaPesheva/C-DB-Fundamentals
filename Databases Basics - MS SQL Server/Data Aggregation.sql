--1.Records’ Count
SELECT COUNT(*) AS Count FROM WizzardDeposits

--2.Longest Magic Wand
SELECT MAX([MagicWandSize]) AS LongestMagicWand FROM WizzardDeposits

--3. Longest Magic Wand per Deposit Groups
SELECT [DepositGroup], MAX([MagicWandSize]) AS LongestMagicWand FROM WizzardDeposits
GROUP BY [DepositGroup]

--4. * Smallest Deposit Group per Magic Wand Size
SELECT DepositGroup 
FROM WizzardDeposits
GROUP BY DepositGroup
HAVING AVG (MagicWandSize) = (
        SELECT MIN (WandSizeTable.AverageSizes) AS MinimalSize
        FROM 
		(
			SELECT AVG (MagicWandSize) AS AverageSizes
            FROM WizzardDeposits
            GROUP BY DepositGroup
        ) AS WandSizeTable
)

--5. Deposits Sum
SELECT [DepositGroup], SUM([DepositAmount]) AS TotalSum FROM WizzardDeposits
GROUP BY [DepositGroup]

--6. Deposits Sum for Ollivander Family
SELECT [DepositGroup], SUM([DepositAmount]) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY [DepositGroup]

--7. Deposits Filter
SELECT [DepositGroup], SUM([DepositAmount]) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY [DepositGroup]
HAVING SUM([DepositAmount]) < 150000
ORDER BY TotalSum DESC

--8. Deposit Charge
SELECT [DepositGroup], [MagicWandCreator], MIN(DepositCharge) FROM WizzardDeposits
GROUP BY [DepositGroup], [MagicWandCreator]
ORDER BY [MagicWandCreator], [DepositGroup]

--9. Age Groups
SELECT AG.AgeGroup, COUNT(AG.Age)
FROM
	(SELECT
		CASE
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			ELSE '[61+]'
		END AgeGroup, Age
	FROM [WizzardDeposits]
	) AG
GROUP BY AG.AgeGroup

--10. First Letter
SELECT LEFT(FirstName, 1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)
ORDER BY FirstLetter

--11. Average Interest
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--12. * Rich Wizard, Poor Wizard
SELECT SUM(SumDiff.SumDifference)
FROM
	(SELECT h.DepositAmount -
		(SELECT DepositAmount 
		FROM WizzardDeposits
		WHERE Id = h.Id + 1
		) AS SumDifference
	 FROM WizzardDeposits h) AS SumDiff

--13. Departments Total Salaries
SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14. Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) AS MinimumSalary FROM Employees
WHERE DepartmentID IN (2, 5, 7)
AND HireDate > '2000-01-01'
GROUP BY DepartmentID

--14. Employees Minimum Salaries
SELECT * INTO NewTable FROM Employees 
WHERE Salary > 30000

DELETE FROM NewTable
WHERE ManagerID = 42

UPDATE NewTable
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM NewTable
GROUP BY DepartmentID

--16. Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17. Employees Count Salaries
SELECT COUNT(S.Salary)
	FROM
		(SELECT Salary FROM Employees
		WHERE ManagerID IS NULL) AS S

--18. *3rd Highest Salary
SELECT DepartmentID, 
	(SELECT DISTINCT Salary FROM Employees 
	 WHERE DepartmentID = e.DepartmentID 
	 ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) AS ThirdHighestSalary
FROM Employees e
WHERE (SELECT DISTINCT Salary FROM Employees 
	 WHERE DepartmentID = e.DepartmentID 
	 ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) IS NOT NULL
GROUP BY DepartmentID

--19. **Salary Challenge
SELECT TOP 10 e.FirstName, e.LastName, e.DepartmentId FROM Employees e
WHERE e.Salary  > (SELECT AVG(s.Salary)
					FROM (SELECT Salary, DepartmentID FROM Employees) AS s
					WHERE DepartmentID = e.DepartmentID)

	 

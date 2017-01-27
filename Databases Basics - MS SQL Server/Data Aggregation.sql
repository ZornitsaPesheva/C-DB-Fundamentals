--1
SELECT COUNT(*) AS Count FROM WizzardDeposits

--2
SELECT MAX([MagicWandSize]) AS LongestMagicWand FROM WizzardDeposits

--3
SELECT [DepositGroup], MAX([MagicWandSize]) AS LongestMagicWand FROM WizzardDeposits
GROUP BY [DepositGroup]

--4
SELECT DepositGroup --, AVG (MagicWandSize)
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

--5
SELECT [DepositGroup], SUM([DepositAmount]) AS TotalSum FROM WizzardDeposits
GROUP BY [DepositGroup]

--6
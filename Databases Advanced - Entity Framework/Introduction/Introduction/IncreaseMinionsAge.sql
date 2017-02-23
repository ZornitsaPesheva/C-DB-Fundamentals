USE MinionsDB

DECLARE @idsParamList NVARCHAR(50)
SET @idsParamList = ','+ @idsParam +','

UPDATE Minions
SET Age = Age+1
WHERE charindex(',' + CAST(Minions.Id as nvarchar(20)) + ',', @idsParamList) > 0

UPDATE Minions
SET Name = UPPER(LEFT(Name, 1)) + SUBSTRING(Name, 2, LEN(Name)-1) 
WHERE charindex(',' + CAST(Minions.Id as nvarchar(20)) + ',', @idsParamList) > 0

SELECT Name, Age FROM Minions
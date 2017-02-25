USE MinionsDB
-- DECLARE @mid INT = 1
EXEC usp_GetOlder @mid

SELECT Name, Age
FROM Minions
WHERE Id = @mid
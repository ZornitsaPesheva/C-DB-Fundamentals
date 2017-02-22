USE MinionsDB

SELECT v.Name, COUNT(mv.MinionId) AS MinionsCount
FROM Villains AS v
JOIN MinionsVillains AS mv
ON v.Id = mv.VillainId
GROUP BY v.Name
HAVING COUNT(mv.MinionId) > 3
ORDER BY MinionsCount DESC
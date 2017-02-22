USE MinionsDB

DECLARE @townId INT = ISNULL((SELECT Id FROM Towns
						WHERE Name = @town), 0)
IF (@townId = 0)
INSERT INTO Towns (Name, CountryId)
VALUES (@town, 1)


DECLARE @minTownId INT = (SELECT Id FROM Towns
							WHERE Name = @town)

DECLARE @villainId INT = ISNULL((SELECT Id FROM Villains
							WHERE Name = @villain), 0)

IF (@villainId = 0)
INSERT INTO Villains (Name, Evilness)
VALUES (@villain, 'evil')

DECLARE @minVillainId INT = (SELECT Id FROM Villains
								WHERE Name = @villain)

INSERT INTO Minions (Name, Age, TownId)
VALUES (@name, @age, @minTownId)

DECLARE @minionId INT = (SELECT Id FROM Minions
							WHERE Name = @name)

INSERT INTO MinionsVillains (MinionId, VillainId)
VALUES (@minionId, @minVillainId)


USE MinionsDB

DECLARE @townId INT = ISNULL((SELECT Id FROM Towns
						WHERE Name = @town), 0)

DECLARE @countryId INT = ISNULL((SELECT Id FROM Countries
						WHERE Name = @country), 0)

IF (@townId = 0)
INSERT INTO Towns (Name, CountryId)
VALUES (@town, @countryId)

DECLARE @villainId INT = (SELECT Id FROM Villains
							WHERE Name = @villain)

DECLARE @minTownId INT = (SELECT Id FROM Towns
							WHERE Name = @town)

INSERT INTO Minions (Name, Age, TownId)
VALUES (@name, @age, @minTownId)

DECLARE @minionId INT = (SELECT Id FROM Minions
							WHERE Name = @name)

INSERT INTO MinionsVillains (MinionId, VillainId)
VALUES (@minionId, @villainId)


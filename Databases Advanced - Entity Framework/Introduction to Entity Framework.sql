CREATE TABLE Countries(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(30) NOT NULL
)

CREATE TABLE Towns(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(30) NOT NULL,
CountryId INT NOT NULL,
CONSTRAINT FK_Towns_Counties FOREIGN KEY (CountryId)
	REFERENCES Countries (Id)
)

CREATE TABLE Minions(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(30) NOT NULL,
Age INT,
TownId INT NOT NULL,
CONSTRAINT FK_Minions_Towns FOREIGN KEY (TownId)
	REFERENCES Towns (Id)
)

CREATE TABLE Villains(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(30) NOT NULL,
Evilness NVARCHAR 
	CHECK (Evilness IN ('good', 'bad', 'evil', 'super evil'))
)

CREATE TABLE MinionsVillains(
MinionId INT,
VillainsId INT,
CONSTRAINT PK_MinionsVillains 
	PRIMARY KEY (MinionId, VillainsId),
CONSTRAINT FK_MinionsVillains_Minions FOREIGN KEY (MinionId)
	REFERENCES Minions(Id),
CONSTRAINT FK_MinionsVillains_Villains FOREIGN KEY (VillainsId)
	REFERENCES Villains(Id)
)






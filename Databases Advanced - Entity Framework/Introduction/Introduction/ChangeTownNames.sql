USE MinionsDB

DECLARE @countryId INT = (SELECT Id FROM Countries
							WHERE Name = @countryName)

UPDATE Towns
SET Name = UPPER(Name)
WHERE CountryId = @countryId
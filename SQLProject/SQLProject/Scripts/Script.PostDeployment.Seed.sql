/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

PRINT 'Starting post-deployment script...'

INSERT INTO Persons (FirstName, LastName)
SELECT 'Bohdan', 'Zhylavskyi'
WHERE NOT EXISTS (
    SELECT 1
    FROM Persons
    WHERE FirstName = 'Bohdan' AND LastName = 'Zhylavskyi'
);

INSERT INTO Addresses (Street, City, State, ZipCode)
SELECT v.Street, v.City, v.State, v.ZipCode
FROM (VALUES
    ('123 Maple St', 'Springfield', 'IL', '62704'),
    ('456 Oak Ave', 'Madison',     'WI', '53703'),
    ('789 Pine Rd', 'Boulder',     'CO', '80301')
) AS v (Street, City, State, ZipCode)
WHERE NOT EXISTS (
    SELECT 1 FROM Addresses a WHERE a.ZipCode = v.ZipCode
);

INSERT INTO Employees (AddressId, PersonId, CompanyName, Position, EmployeeName)
SELECT (SELECT TOP 1 Id FROM Addresses WHERE ZipCode = '62704'),
(SELECT TOP 1 Id FROM Persons WHERE FirstName = 'Bohdan' AND LastName = 'Zhylavskyi'),
'EPAM',
'Software Engineer',
'Bohdan Zhylavskyi'
WHERE NOT EXISTS (
    SELECT 1
    FROM Employees
    WHERE PersonId = (SELECT TOP 1 Id FROM Persons WHERE FirstName = 'Bohdan' AND LastName = 'Zhylavskyi')
)

INSERT INTO Companies (Name, AddressId)
SELECT 'EPAM',
(SELECT TOP 1 Id FROM Addresses WHERE ZipCode = '53703')
WHERE NOT EXISTS (
    SELECT 1
    FROM Companies
    WHERE Name = 'EPAM'
);

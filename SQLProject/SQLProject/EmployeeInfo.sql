CREATE VIEW [EmployeeInfo] AS
SELECT e.Id EmployeeId,
ISNULL(e.EmployeeName, CONCAT(p.FirstName, ' ', p.LastName)) EmployeeFullName,
CONCAT(a.ZipCode, '_', a.State, ', ', a.City, '-', a.Street) EmployeeFullAddress,
CONCAT(e.CompanyName, ' (', e.Position, ')') EmployeeCompanyInfo
FROM Employees e
INNER JOIN Persons p ON e.PersonId = p.Id
INNER JOIN Addresses a ON e.AddressId = a.Id
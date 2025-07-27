CREATE TRIGGER InsertEmployeeTrigger
ON Employees
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Companies (Name, AddressId)
    SELECT 
        i.CompanyName,
        i.AddressId
    FROM inserted i;
END
CREATE PROCEDURE [AddEmployeeInfo]
	@EmployeeName nvarchar(100) = NULL,
	@FirstName nvarchar(50) = NULL,
	@LastName nvarchar(50) = NULL,
	@CompanyName nvarchar(20),
	@Position nvarchar(30) = NULL,
	@Street nvarchar(50),
	@City nvarchar(20) = NULL,
	@State nvarchar(50) = NULL,
	@ZipCode nvarchar(50) = NULL
AS
BEGIN
	DECLARE @CreatedAddressIds TABLE (Id INT);
	DECLARE @CreatedPersonIds TABLE (Id INT);

	SET NOCOUNT ON;

	IF (@EmployeeName IS NULL OR LTRIM(RTRIM(@EmployeeName)) = '')
	AND ((@FirstName IS NULL OR LTRIM(RTRIM(@FirstName)) = '') OR (@LastName IS NULL OR LTRIM(RTRIM(@LastName)) = ''))
	BEGIN
		;THROW 50000, 'Either EmployeeName or FirstName/LastName should be not null, non empty and should not contain only space symbols', 1;
	END

	BEGIN TRY
		BEGIN TRANSACTION;

		INSERT INTO Addresses (Street, City, State, ZipCode)
			OUTPUT INSERTED.Id INTO @CreatedAddressIds
			VALUES (@Street, @City, @State, @ZipCode);

		INSERT INTO Persons (FirstName, LastName)
			OUTPUT INSERTED.Id INTO @CreatedPersonIds
			VALUES (ISNULL(@FirstName, @EmployeeName), ISNULL(@LastName, @EmployeeName))

		INSERT INTO Employees (AddressId, PersonId, CompanyName, Position, EmployeeName)
		SELECT
			a.Id,
			p.Id,
			@CompanyName,
			@Position,
			@EmployeeName
		FROM @CreatedAddressIds a
        CROSS JOIN @CreatedPersonIds p;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
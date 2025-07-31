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

IF NOT EXISTS (
    SELECT 1 FROM Employees
    WHERE EmployeeName = 'Bohdan Zhylavskyi'
)
BEGIN
    EXEC AddEmployeeInfo
		@EmployeeName = 'Bohdan Zhylavskyi',
		@FirstName = 'Bohdan',
		@LastName = 'Zhylavskyi',
		@CompanyName = 'EPAM',
		@Position = 'Software Engineer',
		@Street = '123 Maple St',
		@City = 'Springfield',
		@State = 'IL',
		@ZipCode = '62704'
END

IF NOT EXISTS (
    SELECT 1 FROM Employees
    WHERE EmployeeName = 'Dan Smith'
)
BEGIN
    EXEC AddEmployeeInfo
		@EmployeeName = 'Dan Smith',
		@FirstName = 'Dan',
		@LastName = 'Smith',
		@CompanyName = 'Google',
		@Position = 'QA Engineer',
		@Street = '123456 Oak Ave',
		@City = 'Madison',
		@State = 'WI',
		@ZipCode = '53703'
END

IF NOT EXISTS (
    SELECT 1 FROM Employees
    WHERE EmployeeName = 'Alan Jackson'
)
BEGIN
    EXEC AddEmployeeInfo
		@EmployeeName = 'Alan Jackson',
		@FirstName = 'Alan',
		@LastName = 'Jackson',
		@CompanyName = 'Amazon',
		@Position = 'Project Manager',
		@Street = '789 Pine Rd',
		@City = 'Boulder',
		@State = 'CO',
		@ZipCode = '80301'
END
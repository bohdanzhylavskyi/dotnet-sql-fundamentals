CREATE TABLE [dbo].[Companies]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Name] NVARCHAR(20) NOT NULL, 
    [AddressId] INT NOT NULL, 
    CONSTRAINT [FK_Companies_Addresses] FOREIGN KEY ([AddressId]) REFERENCES [Addresses]([Id])
)

CREATE TABLE [dbo].[ReportDataType]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [DataType] NVARCHAR(255) NULL, 
    [DataTypeId] INT NULL, 
    [Order] INT NULL, 
    [ReportFileTypeId] INT NULL
)

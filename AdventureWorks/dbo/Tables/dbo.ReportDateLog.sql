CREATE TABLE [dbo].[ReportDateLog]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[ReportFileTypeId] INT NOT NULL, 
    [LastGeneratedTimestamp] DATETIME NULL, 
    [Status] INT NULL DEFAULT 0, 
    [TimeRange] INT NULL
)

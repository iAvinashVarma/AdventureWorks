IF EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.ReportDateLog') AND Type = N'U')
BEGIN
	DROP TABLE [dbo].[ReportDateLog]
END
GO

BEGIN
	CREATE TABLE [dbo].[ReportDateLog]
	(
		[Id] INT NOT NULL PRIMARY KEY IDENTITY,
		[ReportFileTypeId] INT NOT NULL, 
		[LastGeneratedTimestamp] DATETIME NULL, 
		[TimeRange] SMALLINT NULL
	)
END
GO

IF NOT EXISTS(SELECT 1 FROM [dbo].[ReportDateLog])
BEGIN
	INSERT INTO [ReportDateLog]
	SELECT * FROM (VALUES
	(1,GETDATE(),1),
	(2,GETDATE(),1),
	(3,GETDATE(),1),
	(4,GETDATE(),1),
	(5,GETDATE(),1))
	AS [ReportDateLog]([ReportFileTypeId],[LastGeneratedTimestamp],[TimeRange]);
END
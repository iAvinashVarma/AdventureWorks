IF EXISTS (SELECT 1 FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[usp_GetReportHeader]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[usp_GetReportHeader]
END
GO

/*
	EXEC [dbo].[usp_GetReportHeader]
		 @ReportFileTypeId = 1,
		 @IsDebug = 0
*/

CREATE PROCEDURE [dbo].[usp_GetReportHeader]
	@ReportFileTypeId int = 0,
	@IsDebug bit = 0
AS
BEGIN
	SELECT	[DataType],
			[DataTypeId],
			[Order],
			[ReportFileTypeId]
	FROM [dbo].[ReportFileType]
	WHERE [ReportFileTypeId] = @ReportFileTypeId
END
GO
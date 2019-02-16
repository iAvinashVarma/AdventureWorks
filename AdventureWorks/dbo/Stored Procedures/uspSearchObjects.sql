
/*
EXEC [dbo].[uspSearchObjects] @Search='a'
*/

CREATE PROCEDURE [dbo].[uspSearchObjects]
(
    @Search NVARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

	SELECT	QUOTENAME(SCHEMA_NAME([O].[schema_id])) + '.' + QUOTENAME([O].[name]) AS [ObjectName],
			[O].[modify_date] AS [ModifyDate],
			REPLACE([O].[type_desc], '_', ' ') AS [TypeDescription],
			[M].[definition] AS [Definition]
	FROM sys.sql_modules AS [M]
	INNER JOIN sys.objects AS [O]
	ON [M].[object_id] = [O].[object_id]
	WHERE [M].[definition] LIKE '%' + @Search + '%'
	ORDER BY	[O].[type_desc] ASC,
				[O].[modify_date] DESC
END;

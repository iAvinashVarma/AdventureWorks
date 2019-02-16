
/*======================================================================================
** File			:	[dbo].[uspCheckIndexFragmentation]    
** Execution	:
					EXEC [dbo].[uspCheckIndexFragmentation]
** ------------------------------------------------------------------------------------
** Change History
** ------------------------------------------------------------------------------------
** Date			Author		Description 
** ----------	----------	-----------------------------------------------------------
** 11/11/2018   Avi			Check index fragementation and see the advise.
======================================================================================*/

CREATE PROCEDURE [dbo].[uspCheckIndexFragmentation]
AS
BEGIN
    SET NOCOUNT ON;

	;WITH [IndexFragmentation]
	AS
	(
		SELECT	QUOTENAME(SCHEMA_NAME([O].[schema_id])) + '.' + QUOTENAME(OBJECT_NAME([S].[OBJECT_ID])) AS [ObjectName],
				[I].[name] AS [IndexName],
				[S].[index_type_desc] AS [IndexTypeDescription],
				[S].[avg_fragmentation_in_percent] AS [AverageFragmentationPercent]
		FROM [sys].[dm_db_index_physical_stats]
		(
			DB_ID(),
			NULL,
			NULL,
			NULL,
			NULL
		) AS [S]
		JOIN [sys].[indexes] AS [I]
		ON [S].[index_id] = [I].[index_id] AND [S].[object_id] = [I].[object_id]
		JOIN [sys].[objects] AS [O]
		ON [S].[object_id] = [O].[object_id]
	)
	SELECT	[F].[ObjectName],
			[F].[IndexName],
			[F].[IndexTypeDescription],
			[F].[AverageFragmentationPercent],
			(CASE
				WHEN [F].[AverageFragmentationPercent] BETWEEN 5 AND 30 THEN 'ALTER INDEX ' + [F].[IndexName] + ' ON ' + [F].[ObjectName] + ' REORGANIZE'
				WHEN [F].[AverageFragmentationPercent] > 30 THEN 'ALTER INDEX ' + [F].[IndexName] + ' ON ' + [F].[ObjectName] + ' REBUILD'
				ELSE NULL
			END) AS [AlterQuery],
			(CASE
				WHEN [F].[AverageFragmentationPercent] BETWEEN 5 AND 30 THEN 'ALTER INDEX ALL ON ' + [F].[ObjectName] + ' REORGANIZE'
				WHEN [F].[AverageFragmentationPercent] > 30 THEN 'ALTER INDEX ALL ON ' + [F].[ObjectName] + ' REBUILD'
				ELSE NULL
			END) AS [AlterAllQuery]
	FROM [IndexFragmentation] AS [F]
END

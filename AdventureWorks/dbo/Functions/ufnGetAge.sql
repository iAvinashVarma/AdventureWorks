

CREATE FUNCTION [dbo].[ufnGetAge]
(
	@DOB [SMALLDATETIME]
)
RETURNS @Age TABLE 
(
    [AgeYearsDecimal]	[DECIMAL] NOT NULL, 
    [AgeYearsIntRound]	[INT] NOT NULL, 
    [AgeYearsIntTrunc]	[INT] NOT NULL,
	[BirthDate]			[NVARCHAR](55) NOT NULL,
	[CurrentDate]		[NVARCHAR](55) NOT NULL
)
AS 
BEGIN
	IF @DOB IS NOT NULL 
	BEGIN
		INSERT INTO @Age
		SELECT	DATEDIFF(hour,@DOB,GETDATE())/8766.0 AS [AgeYearsDecimal],
				CONVERT(int,ROUND(DATEDIFF(HOUR,@DOB,GETDATE())/8766.0,0)) AS [AgeYearsIntRound],
				DATEDIFF(hour,@DOB,GETDATE())/8766 AS [AgeYearsIntTrunc],
				FORMAT(@DOB, 'dd, MMMM yyyy') AS [BirthDate],
				FORMAT(GETDATE(), 'dd, MMMM yyyy') [CurrentDate]
	END

	RETURN;
END;

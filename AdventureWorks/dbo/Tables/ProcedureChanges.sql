CREATE TABLE [dbo].[ProcedureChanges] (
    [EventDate]    DATETIME       DEFAULT (getdate()) NOT NULL,
    [EventType]    NVARCHAR (100) NULL,
    [EventDDL]     NVARCHAR (MAX) NULL,
    [DatabaseName] NVARCHAR (255) NULL,
    [SchemaName]   NVARCHAR (255) NULL,
    [ObjectName]   NVARCHAR (255) NULL,
    [HostName]     NVARCHAR (255) NULL,
    [IPAddress]    VARCHAR (32)   NULL,
    [ProgramName]  NVARCHAR (255) NULL,
    [LoginName]    NVARCHAR (255) NULL
);


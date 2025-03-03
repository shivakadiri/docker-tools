-- UnComment setvar to test script locally
-- Comment setvar to run from sqlcmd from docker bash
--:setvar DB_NAME "testDB"
--:setvar DB_USER "testUser"
--:servar DB_PWD "testPwd"

USE [master]
GO

IF NOT EXISTS (SELECT [name] FROM [master].[sys].[databases] WHERE [name] = N'$(DB_NAME)')
    CREATE DATABASE $(DB_NAME);

GO

PRINT '*** Creating Login';
GO

CREATE LOGIN $(DB_USER_NAME) WITH PASSWORD=N'$(DB_USER_PWD)'
GO

USE [$(DB_NAME)];
GO

PRINT '*** Creating User';
GO

CREATE USER $(DB_USER_NAME) FOR LOGIN $(DB_USER_NAME)
GO

PRINT '*** Creating Role for $(DB_USER_NAME)';
GO

EXEC sp_addrolemember db_datareader, $(DB_USER_NAME)
GO

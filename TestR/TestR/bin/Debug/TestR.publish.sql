﻿/*
Deployment script for PhoneBook

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "PhoneBook"
:setvar DefaultFilePrefix "PhoneBook"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating Assembly [TestLibrary]...';


GO
CREATE ASSEMBLY [TestLibrary]
    AUTHORIZATION [dbo]
    FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C010300097917D60000000000000000E00022200B013000000A000000060000000000001E280000002000000040000000000010002000000002000004000000000000000600000000000000008000000002000000000000030060850000100000100000000010000010000000000000100000000000000000000000CC2700004F000000004000008803000000000000000000000000000000000000006000000C00000034270000380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E746578740000002408000000200000000A000000020000000000000000000000000000200000602E72737263000000880300000040000000040000000C0000000000000000000000000000400000402E72656C6F6300000C00000000600000000200000010000000000000000000000000000040000042000000000000000000000000000000000028000000000000480000000200050084200000B0060000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013300200160000000100001100281000000A6F1100000A026F1200000A0A2B00062A2202281300000A002A2202281300000A002A42534A4201000100000000000C00000076342E302E33303331390000000005006C00000024020000237E000090020000E402000023537472696E67730000000074050000040000002355530078050000100000002347554944000000880500002801000023426C6F620000000000000002000001471502000900000000FA0133001600000100000013000000030000000300000001000000130000000F0000000100000001000000020000000000E6010100000000000600410190020600AE019002060060005E020F00B00200000600880012020600240112020600F000120206009501120206006101120206007A01120206009F0012020600740071020600520071020600D30012020600BA00CC010600BF02F6010A000F013D0206002402FD0106003402FD01000000000800000000000100010001001000C6020000410001000100010010000100D602410001000300502000000000960045003600010072200000000086185802060002007B2000000000861858020600020000000100D102090058020100110058020600190058020A00290058021000310058021000390058021000410058021000490058021000510058021000590058021000610058021500690058021000710058021000790058021000890058020600910026001E0091003002230099003900280081005802060020007B0020012E000B003B002E00130044002E001B0063002E0023006C002E002B007D002E0033007D002E003B007D002E0043006C002E004B0083002E0053007D002E005B007D002E0063009B002E006B00C5002E007300D2001A00048000000100000000000000000000000000D60200000400000000000000000000002D001D00000000000400000000000000000000002D00110000000000000000436C61737331003C4D6F64756C653E0053797374656D2E44617461006D73636F726C6962006765745F43757272656E7443756C7475726500546F5469746C654361736500546F546F4C6973744361736500477569644174747269627574650044656275676761626C6541747472696275746500436F6D56697369626C6541747472696275746500417373656D626C795469746C6541747472696275746500417373656D626C7954726164656D61726B417474726962757465005461726765744672616D65776F726B41747472696275746500417373656D626C7946696C6556657273696F6E41747472696275746500417373656D626C79436F6E66696775726174696F6E4174747269627574650053716C46756E6374696F6E41747472696275746500417373656D626C794465736372697074696F6E41747472696275746500436F6D70696C6174696F6E52656C61786174696F6E7341747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F7079726967687441747472696275746500417373656D626C79436F6D70616E794174747269627574650052756E74696D65436F6D7061746962696C6974794174747269627574650053797374656D2E52756E74696D652E56657273696F6E696E6700546573744C6962726172792E646C6C0053797374656D0053797374656D2E476C6F62616C697A6174696F6E0053797374656D2E5265666C656374696F6E0043756C74757265496E666F006765745F54657874496E666F004D6963726F736F66742E53716C5365727665722E536572766572002E63746F720053797374656D2E446961676E6F73746963730053797374656D2E52756E74696D652E496E7465726F7053657276696365730053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300446562756767696E674D6F646573004F626A65637400506572736F6E54657374007465787400546573744C69627261727900000000000000E5C31CE277D70542BBAE29FF0DCC805600042001010803200001052001011111042001010E04200101020307010E0400001249042000124D0420010E0E08B77A5C561934E0890400010E0E0801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F7773010801000701000000001001000B546573744C696272617279000005010000000017010012436F7079726967687420C2A920203230323300002901002432343636386430372D323331352D346536662D623331622D31636263373337373832646100000C010007312E302E302E3000004D01001C2E4E45544672616D65776F726B2C56657273696F6E3D76342E372E320100540E144672616D65776F726B446973706C61794E616D65142E4E4554204672616D65776F726B20342E372E320401000000000000000000001327D2B40000000002000000600000006C2700006C09000000000000000000000000000010000000000000000000000000000000525344535510763EB79BEF4CACFBB59CDB04972501000000433A5C55736572735C6D6168616D6D6164766D5C4465736B746F705C54657374525C546573744C6962726172795C6F626A5C44656275675C546573744C6962726172792E70646200F427000000000000000000000E28000000200000000000000000000000000000000000000000000000280000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF25002000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000018000080000000000000000000000000000001000100000030000080000000000000000000000000000001000000000048000000584000002C03000000000000000000002C0334000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000001000000000000000100000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B0048C020000010053007400720069006E006700460069006C00650049006E0066006F0000006802000001003000300030003000300034006200300000001A000100010043006F006D006D0065006E007400730000000000000022000100010043006F006D00700061006E0079004E0061006D006500000000000000000040000C000100460069006C0065004400650073006300720069007000740069006F006E000000000054006500730074004C006900620072006100720079000000300008000100460069006C006500560065007200730069006F006E000000000031002E0030002E0030002E003000000040001000010049006E007400650072006E0061006C004E0061006D006500000054006500730074004C006900620072006100720079002E0064006C006C0000004800120001004C006500670061006C0043006F007000790072006900670068007400000043006F0070007900720069006700680074002000A90020002000320030003200330000002A00010001004C006500670061006C00540072006100640065006D00610072006B00730000000000000000004800100001004F0072006900670069006E0061006C00460069006C0065006E0061006D006500000054006500730074004C006900620072006100720079002E0064006C006C00000038000C000100500072006F0064007500630074004E0061006D0065000000000054006500730074004C006900620072006100720079000000340008000100500072006F006400750063007400560065007200730069006F006E00000031002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000031002E0030002E0030002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000203800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;


GO
PRINT N'Creating Function [dbo].[ToToListCase]...';


GO
CREATE FUNCTION [dbo].[ToToListCase]
(@text NVARCHAR (MAX) NULL)
RETURNS NVARCHAR (MAX)
AS
 EXTERNAL NAME [TestLibrary].[PersonTest].[ToToListCase]


GO
PRINT N'Update complete.';


GO

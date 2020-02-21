IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [dbo].[EnterpriseTypes] (
    [Id] int NOT NULL IDENTITY,
    [Active] bit NOT NULL,
    [CreatedDate] datetime2 NOT NULL DEFAULT (GETUTCDATE()),
    [ModifiedDate] datetime2 NOT NULL DEFAULT (GETUTCDATE()),
    [Name] varchar(50) NOT NULL,
    CONSTRAINT [PK_EnterpriseTypes] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [dbo].[Enterprises] (
    [Id] bigint NOT NULL IDENTITY,
    [Active] bit NOT NULL,
    [CreatedDate] datetime2 NOT NULL DEFAULT (GETUTCDATE()),
    [ModifiedDate] datetime2 NOT NULL DEFAULT (GETUTCDATE()),
    [Name] varchar(50) NOT NULL,
    [Description] nvarchar(max) NULL,
    [Value] decimal(8,2) NOT NULL DEFAULT 0.0,
    [Country] varchar(70) NULL,
    [City] varchar(50) NULL,
    [Linkedin] varchar(200) NULL,
    [Twitter] varchar(100) NULL,
    [Facebook] varchar(200) NULL,
    [Phone] varchar(14) NULL,
    [Email] varchar(100) NULL,
    [Photo] nvarchar(max) NULL,
    [Shares] decimal(8,2) NOT NULL DEFAULT 0.0,
    [SharePrice] decimal(8,2) NOT NULL DEFAULT 0.0,
    [OwnShares] bigint NOT NULL DEFAULT CAST(0 AS bigint),
    [OwnEnterprise] bit NOT NULL DEFAULT 0,
    [EnterpriseTypeId] int NOT NULL,
    CONSTRAINT [PK_Enterprises] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Enterprises_EnterpriseTypes_EnterpriseTypeId] FOREIGN KEY ([EnterpriseTypeId]) REFERENCES [dbo].[EnterpriseTypes] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [dbo].[Investors] (
    [Id] bigint NOT NULL IDENTITY,
    [Active] bit NOT NULL,
    [CreatedDate] datetime2 NOT NULL DEFAULT (GETUTCDATE()),
    [ModifiedDate] datetime2 NOT NULL DEFAULT (GETUTCDATE()),
    [Name] varchar(50) NOT NULL,
    [Email] varchar(100) NOT NULL,
    [City] varchar(50) NULL,
    [Country] varchar(70) NULL,
    [Photo] nvarchar(max) NULL,
    [Balance] decimal(8,2) NOT NULL DEFAULT 0.0,
    [FirstAccess] bit NOT NULL DEFAULT 1,
    [SuperAngel] bit NOT NULL DEFAULT 0,
    [PortfolioValue] decimal(8,2) NOT NULL DEFAULT 0.0,
    [EnterpriseId] bigint NULL,
    CONSTRAINT [PK_Investors] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Investors_Enterprises_EnterpriseId] FOREIGN KEY ([EnterpriseId]) REFERENCES [dbo].[Enterprises] ([Id]) ON DELETE NO ACTION
);

GO

CREATE TABLE [dbo].[InvestorEnterprise] (
    [InvestorId] bigint NOT NULL,
    [EnterpriseId] bigint NOT NULL,
    CONSTRAINT [PK_InvestorEnterprise] PRIMARY KEY ([InvestorId], [EnterpriseId]),
    CONSTRAINT [FK_InvestorEnterprise_Enterprises_EnterpriseId] FOREIGN KEY ([EnterpriseId]) REFERENCES [dbo].[Enterprises] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_InvestorEnterprise_Investors_InvestorId] FOREIGN KEY ([InvestorId]) REFERENCES [dbo].[Investors] ([Id]) ON DELETE NO ACTION
);

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (53, 1, '2020-02-18T04:53:14.3686076Z', 'Technology');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (57, 1, '2020-02-18T04:53:14.3727092Z', 'Telecommunications - utilities');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (48, 1, '2020-02-18T04:53:14.3727314Z', 'Services');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (3, 1, '2020-02-18T04:53:14.3728202Z', 'Agtech');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (36, 1, '2020-02-18T04:53:14.3728373Z', 'Marketing services');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (35, 1, '2020-02-18T04:53:14.3728610Z', 'Logistics aviation');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (38, 1, '2020-02-18T04:53:14.3728982Z', 'Media');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (6, 1, '2020-02-18T04:53:14.3729214Z', 'Apps');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (42, 1, '2020-02-18T04:53:14.3726914Z', 'Operational Technology');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (41, 1, '2020-02-18T04:53:14.3729361Z', 'Nanotechnology');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (12, 1, '2020-02-18T04:53:14.3730563Z', 'Construction Management Software');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (31, 1, '2020-02-18T04:53:14.3730930Z', 'IT/Mobility');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (22, 1, '2020-02-18T04:53:14.3731078Z', 'Healthcare');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (10, 1, '2020-02-18T04:53:14.3731272Z', 'Cloud/SAAS');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (39, 1, '2020-02-18T04:53:14.3731480Z', 'Medical 3d printing');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (29, 1, '2020-02-18T04:53:14.3731638Z', 'IT and Software');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (52, 1, '2020-02-18T04:53:14.3731860Z', 'Tech');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (44, 1, '2020-02-18T04:53:14.3729949Z', 'Road Freight Marketplace');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (56, 1, '2020-02-18T04:53:14.3732008Z', 'Telecommunications  ');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (7, 1, '2020-02-18T04:53:14.3726472Z', 'Artificial Intelligence');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (34, 1, '2020-02-18T04:53:14.3726126Z', 'Logistics  ');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (1, 1, '2020-02-18T04:53:14.3703535Z', 'Accounting / AI / Fintech');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (5, 1, '2020-02-18T04:53:14.3703771Z', 'App-Recycling');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (55, 1, '2020-02-18T04:53:14.3704119Z', 'Technology TI');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (17, 1, '2020-02-18T04:53:14.3704284Z', 'Fintech');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (33, 1, '2020-02-18T04:53:14.3704642Z', 'Life sciences');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (59, 1, '2020-02-18T04:53:14.3705009Z', 'Tourism');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (13, 1, '2020-02-18T04:53:14.3713991Z', 'E-commerce');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (14, 1, '2020-02-18T04:53:14.3726279Z', 'E-commerce, Marketplace B2B');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (8, 1, '2020-02-18T04:53:14.3714206Z', 'Big Data / Open Date');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (27, 1, '2020-02-18T04:53:14.3714651Z', 'IOT Cyber Security ');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (28, 1, '2020-02-18T04:53:14.3714855Z', 'IT');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (54, 1, '2020-02-18T04:53:14.3715200Z', 'Technology / Telecommunications / Marketing');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (58, 1, '2020-02-18T04:53:14.3715401Z', 'TIC');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (21, 1, '2020-02-18T04:53:14.3725237Z', 'Health');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (43, 1, '2020-02-18T04:53:14.3725506Z', 'Real estate');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (26, 1, '2020-02-18T04:53:14.3725685Z', 'IOT');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (30, 1, '2020-02-18T04:53:14.3714362Z', 'IT Industry / Energy');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] ON;
INSERT INTO [dbo].[EnterpriseTypes] ([Id], [Active], [CreatedDate], [Name])
VALUES (4, 1, '2020-02-18T04:53:14.3732375Z', 'AI / IOT');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'CreatedDate', N'Name') AND [object_id] = OBJECT_ID(N'[dbo].[EnterpriseTypes]'))
    SET IDENTITY_INSERT [dbo].[EnterpriseTypes] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(1 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3012089Z', N'AGROPRO started with 4 cofounders and the vision to develop technologies to transform agriculture worldwide. Headquartered in the Sonoran desert region in Mexico, the second largest and hottest desert in the world, and also a very important area for agricultural production that produces and exports thousands of tons of food.  We decided to face the biggest challenge of agriculture, that is to achieve 80% growth to meet the growing demand of the world population for food and products derived from this activity, as the UN states we can expect a growth of the world population to surpass the 9 billion inhabitants in 2050. It becomes necessary then to rethink the way to exploit agricultural fields, so that an efficient use of resources can be made and production levels increased. While agriculture provides food for millions of people, it is only through innovation that traditional practices can be improved, providing social and economic benefits, and even turning desert areas into important suppliers of food and income.
Our solution consists of using drones and special cameras to obtain aerial images of the crops, data then is processed to provide reports in an interactive online platform about the current state of crops. Doing this we can measure accurately and timely how the crops are doing and also save time and resources to farmers by having the right information to take actions if necessary.
With our online platform, the results of the aerial crop analyzes we do are visualized, containing relevant information for their decision making, and thus to optimize production by making more efficient use of inputs in areas specific, such as appropriate applications of agrochemicals, water and seeds.
We are transforming agriculture in benefit of consumers and producers around the world, though improving the optimization of inputs in specific areas, such as appropriate applications of water, agrochemicals and seeds.
Our value proposition is to provide the key information about the crops to the decision makers and support them to increase production by at least 5% and reduce costs from the use of agrochemicals, which account for the highest cost of up to 50% of the cost of production, by at least 10%.
We currently operate from Mexico in 10 countries in Latin America, the United States and Europe, with clients being producers, insurance companies, agrochemical manufacturers and financial institutions. And we look forward to keep growing and continue offering our services of crop analyses through our online platform, as well as to keep developing specific reports by type of crop as we keep learning the needs for different markets.', NULL, 53, ' https://www.facebook.com/3GOVideo

', 'https://www.linkedin.com/company/3go-video/', '3GOVIDEO', NULL, NULL, 5000.0, '3GOVideo ');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(20 AS bigint), 1, 'Barnsley', 'UK', '2020-02-18T04:53:14.3725518Z', N'2015-Developed PEMEX VR, training for the energy industry. 2016-Ministry of Economy, Innovation Fund, selected. 2018-Shark Tank Mexico episode, already aired (as Picoso Games). ', NULL, 26, ' https://www.facebook.com/greenywave/

', 'https://www.linkedin.com/in/jorgehsalazar/?originalSubdomain=co', 'GreenyWave Ltd', NULL, NULL, 5000.0, 'Greenywave');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(22 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3725985Z', N'Ironbit was founded in 2005 by four young and communication engineers of Mexico City. We are continuously innovating to create new ways to improve our society, for example we developed an electronic bracelet to control devices and record the body movement. Currently we are a leader in developing mobile apps in Mexico. This year, we are lauching Autorfy that helps creative authors to protect their original works and generate income selling products or intellectual property based in the blockchain and augmented reality (AR) technologies.', NULL, 34, 'Grupo OET', 'Grupooet', 'Grupo OET SAS', NULL, NULL, 5000.0, 'grupooet');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(23 AS bigint), 1, 'Manizales', 'Colombia', '2020-02-18T04:53:14.3726135Z', N'We help decision makers make sense of public opinion in a ''post-truth'' world with real-time technology and platforms based on social data and artificial intelligence, in order to interact and empathize with their audiences, clients or users. Data analysis is essential to improve the research, innovation, operation and decision making of any business model, companies spend too much on specialized resources and expensive tools to obtain data that take a long time to interpret. Our business intelligence and social interaction platforms, based on artificial intelligence algorithms and natural language processing specialized in Spanish, which automate the analysis of social conversations and generate responses in real time at an affordable price. We are looking to expand to other countries like the US where there is a highly concentration of Spanish speakers.
', NULL, 14, NULL, NULL, 'HanelBay', NULL, NULL, 5000.0, 'https://www.linkedin.com/company/handelbay');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(24 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3726323Z', N'Nacimos en 2015 con el objetivo de preservar la tradición gastronómica de México, a travez del maíz. Esto nos llevó a tomar la receta familiar del pan de elote y dar inicio a su comercialización formal, ya qur hasta la fecha, la mayoría de la venta de hace de manera informal, en puntos turísticos y de muy baja calidad.

Al ser pioneros en esta idea de desarrollo nos ha ido abriendo puertas en grandes cadenas de restauranteras como (Las Alitas, Applebee''s, Wings Army, Café Punta del Cielo, Palenque Grill; así como de cadenas de autoservicio como Alsuper)

Ahora buscamos potencializar las exportaciones, para lo cual se requieren certificaciones, equipamiento, personal, proveedores y capital.', NULL, 7, 'ibang', 'NA', 'Ibang', NULL, NULL, 5000.0, 'NA');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(25 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3726483Z', N'Experience the power of Automated Logistics. 
  
Leanflow is the first logistics platform for Manufacturers, 3PLs and Carriers that give them the reliability that only an Automated Supply Chain can provide. We are currently training LUX – our Artificial Intelligence engine that can automate, optimize and prevent anomalies in the supply chain. We feed LUX with data from our own IoT devices to get precise and continuous information that it’s crucial for making a more accurate AI engine. 

Our comprehensive platform includes all the operational (scheduling, tracking, reporting, notification and alerts), commercial (smart contracts, RFQ and communication and collaboration tools) and financial (billing, collection, aging reports, P&L reports) activities related to the logistics operations of a company.

Market size
According a study made by Transparency Market Research (TMR), logistics global market currently worth is US $8.1 tn and it is expected to grow to $15.5 tn by 2024. The report also said that the investment in technological innovation is one of the major drivers in the market due to the high level of competition in a highly fragmented market. 

Technical Roadmap
We’ve been developing the platform for the past two years. It’s currently in Beta version with plans to release the final version in 2019.  Our platform is constantly expanding: the roadmap is to add platform functionality for Distribution Centres, Warehouses and Customs Agents by 2020. 

Commercial Expansion
Leanflow is technically ready to be commercialized globally and currently supports 4 languages English, French, Spanish and Portuguese. We commercialize in Mexico only, but we have expansion plans for next year to: US, Canada and Brazil using online commercialization along with partnerships with local distributors.
', NULL, 42, NULL, 'linkedin.com/in/10N4TH4N 
https://www.linkedin.com/company/ibisa/
', 'Ibisa iDXP', NULL, NULL, 5000.0, 'Jonathan_Ibisa / ibisa_');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(26 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3726926Z', N'LiCore is a technical startup in Queretaro, Mexico. Our highly motivated team of 12 engineers and other professionals focus on applied research for the development of technical solutions in the sectors energy efficiency, renewable energy and smart grids. Founded as non-profit organization in 2011, our team with members of different gender and nationalities continuously is working on realizing our vision of contributing to the sustainable development of Mexico by developing internationally recognized technological solutions. 
Since 2014, we have been developing intelligent power conversion devices that help integrating renewable energy sources in the electricity grid. Initially working on an intelligent solid state transformers, we shifted our focus on the development on an advanced residential solar inverter in 2017. A large part of the technology and knowledge development of the former project is implemented in this inverter, which will be our first commercial product. Currently, we have reached a prototype with TRL6, which we plan to scale to TRL7 in 2019 and implement the first beta products in a pilot plant. The implementation in pilot installations in 2019 will help us to gather real world experience and refine the product. In 2020, we will certify the inverter, before launching it to the market and entering into mass production. To resume, we are currently transforming from a technical investigation laboratory into an innovative tech startup, with the objective of introducing an innovative product to the local and international market in 2020. 
', NULL, 57, NULL, 'https://www.linkedin.com/company/inorks/', 'Inorks', NULL, NULL, 5000.0, 'NA');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(27 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3727101Z', N'Description of Your Project: LINKO is a solution that brings together all mobility options in a single app. Working with artificial intelligence in real time and determining the best option for each journey combining the necessary options to reach the cheapest or fastest route. Even both.
Specifications and Advantages: 
Using LINKO, people will have the following advantages:
They can use all mobility solutions with a single registration in a single app that internally connects with existing solutions (Uber, Lyft, Cabify, Ford Go Bikes, Lime, Bart, etc.).
They can take the route that suits them best in time, money or both for each route, contemplating variables such as weather, traffic and special situations on the road. This optimal route will perform a validation combining the mobility options that exist and a person is willing to use. The app will make the combinations to make the perfect route for every user.
With LINKO, emerging mobility companies will have the opportunity to make themselves known through the platform.
With LINKO, restaurants, coffee shops and other commercial establishments can benefit to take advantage with our information, that contains itineraries, concurrency, favorite routes. All segmented and validated to campaign and more effective promotions.
With LINKO the cities will be able to have knowledge of the mobility behavior of their population, with valuable information for decision making in road restructuring, transformation of means of transport and solutions towards Smart City.
Vision for The Next Five Years: 
First Year: Go to market in London
Second Year: Expansion to some cities in Europe
Third Year: Expansion to other cities Mexico, and Latinoamerica
Alliance or partnership with a big company with converging solutions (Google, Apple, Uber, etc.).
Fourth Year: Expansion to US
Fifth Year: Global Expansion.', NULL, 48, ' https://www.facebook.com/normanramirez1975

', 'LinkedIn
 https://www.linkedin.com/in/normanramirez

', 'iteam', NULL, NULL, 5000.0, 'ramsan_');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(29 AS bigint), 1, 'Pereira', 'Colombia', '2020-02-18T04:53:14.3727466Z', N'The beginning The founding partners of the Mexican company MPcognitivos, Marco Antonio Suárez Quintana and Manuel Roberto Encinas Cota, have a close relationship for years with Jorge Guzman Estrada, founding partner of Emovere, S.A. of C.V. Both partners have more than 25 years of experience in the ICT area. Jorge Guzman entrusted us with the need for Emovere to bring to the market a new product based on its highly disruptive technology, which he named the Human Type Cognitive Process (HTCP: Human Type Cognitive Process). We offered to be that medium and put on the table the "Virtual Assistant for Smartphone" since it meets low costs of development, production and marketing; At the same time, it attacks a growing need for support for daily activities and covers a global market. Emovere liked it because he will be able to make known two things that HTCP achieves and that Artificial Intelligence has not been able (and will not) be able to do: that machines make decisions based on common sense and the natural language process, everything like Human does it. Given this, we obtained an "Exclusivity Contract" for the use of HTCP for our product and all the support that Emovere can offer us, such as flexibility in investments and payments, opportunities that will only be present for this occasion. Actual status MPcognitivos is already registered as a company before the public registry of the property and before the property with registration MPC170322J78. It has an "Exclusivity Contract" with Emovere signed before the notary Gabriel Alfaro and has a first investor who puts us in the position of developing the "commercial" prototype of the product. We have previously registered before the IMPI the logos of "MPcognitivos" and "Phibot". The website www.mpcognitivos.com has already been developed and there are two companies besides Emovere supporting the development of the commercial product. It was launched worldwide at CES2018 (located in the 25600 area of the AI area) of Las Vegas on January 9-12.', NULL, 3, 'celotor', 'jhfrlo', 'Logsent SAS', NULL, NULL, 5000.0, 'celotor');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(30 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3728217Z', N'
Medisys International is a 100% Peruvian company, capital peruano. We provide a technological platform with processes used by pharmaceutical companies or product marketing companies. This platform covers the processes of promotion and sales such as: Medical Visit, Visit Pharmacies, Promotion of products, CRM for products, CRM to retain patients and doctors, Direct sales or through distributors. BI and KPYs tailored to customers, Events, among others. The marketing of our solutions is under monthly use license. We have experience and knowledge of the business, also we are not a canned, because we personalize the solutions. We serve clients in 12 countries in Latin America and Central America. We are a small organization so technology and innovation is vital for the support of MEDISYS over time.', NULL, 36, 'LookApp', NULL, 'Lookapp', NULL, NULL, 5000.0, 'https://twitter.com/LookApp_co?lang=es');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(31 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3728383Z', N'MexPago is a company created to build an ecosystem to connect merchants with financially empowered subscribers. Our business started to process digital payment transactions using credit and debit cards. Our clients are individuals or legal entities (businesses) that want to sell their products or services to customers whose payment method is a credit or debit card. Our payment solutions cover the multi-channel approach which includes our mobile POS (mPOS)terminal for our associated merchants to sell in their phisical store using our mobile application available in Android and iOS under the name “MexPago” or using our flexible APIs connected to their online stores, our associated merchants often use both. In addition to our means of payment, we offer to our associated merchants our branded "MexPago Card" (a credit card that operates as a debit and therefore as a savings account) as an instrument to use the money received in their MexPago virtual account where their sales are deposited.

Additionally, we have a mobile application ("MexPago Pay") that is designed for underbanked or unbanked consumers. When these consumers sign up in our platform, a digital virtual bank-like account (e-wallet) is created for them at no cost. Very often these Consumers are born in our system with our branded MexPago Card where they receive funds for part-time jobs to then use these funds to purchase products and services from our associated merchants in addition to bill payments and top ups. Most recently we added the largest MNO in Mexico as our strategic partner and their services as bundles are offered in our mobile application MexPago Pay. MexPago also offers for the e-wallet to be topped up on traditional channels such as cash or wire transfer deposits through traditional channels which we are working every day to increase. Our revenues come from transactional fees from our Acquirer business as well as that from our branded MexPago Card.
', NULL, 35, NULL, NULL, 'MekaGroup SAS', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(19 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3725260Z', N'Harvest Communication was launched during the Hult Prize 2018 edition. It''s management team is composed of 4 engineering students from Tecnológico de Monterrey allied with an expert with more than 20 years in the telecommunications industry. Our company started while participating in the Hult Prize competition. In this competition we were the winners of Mexico''s National Finals with an investment of 50,000 USD and the opportunity to participate in a six-week accelerator in the UK during the summer.

Our startup is focused on providing satellite internet access to people in rural communities that have no coverage by current telecommunication companies. This is due to the fact that these regions don''t represent an attractive market for them as bringing ground-based infrastructure is not cost-effective. By securing a strategic partnership with a satellite internet provider, we are able to offer accessible and affordable solution that aims to impact in the lives of millions.', NULL, 43, 'https://www.facebook.com/geoestateint/', 'https://www.linkedin.com/company/geoestate/', 'GeoEstate.co', NULL, NULL, 5000.0, 'GeoEstateint');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(33 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3728826Z', N'Startup initially focused on selling customized software to clients, pivoted then to the current problematic of the Attention Deficit Hyperactivity disorder (ADHD) given my personal experience with the disorder. It started as an idea an with the support of the Mexican Government of 25K dollars and later on with the support of the accelerator Balero with collaboration with GSVLabs we build a prototype and validate it, reaching to the current point where we are going to release in Mexico a first commercial MVP of our virtual reality support treatment for ADHD for kids and teenagers. We target schools and specialists (B2B), which we used as a distribution channel to reach families (B2C). People pay for a monthly subscription for a software license with user seats, which means that a license gives the right to a person to register multiple patients to the treatment, each patient is a seat.', NULL, 38, 'https://www.facebook.com/Letsmowies/', 'https://www.linkedin.com/company/mowies/� ', 'Mowies Inc', NULL, NULL, 5000.0, ' https://twitter.com/LetsMowies

');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(35 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3729225Z', N'We started a 8 months ago after noticing a specific sector of the LatAm legal didn''t have any SaaS apps.

We have since then built an application that services this sector and we plan to open up our app to be able to service other sectors of the LatAm legal industry and also other parts of the world.', NULL, 41, 'Yudira Zapata', NULL, 'Nanotecol', NULL, NULL, 5000.0, 'nanotecol / yudirazapata');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(38 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3729819Z', N'Video uploaded above from our Y-Combinator Pitch Last Summer.', NULL, 44, 'Packen Colombia', ' https://www.linkedin.com/company/packen/', 'Packen', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(41 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3730358Z', N'Born in one of the states with the lowest educational level in the country, by detecting the need for a better technological culture and an educational improvement, a methodology is implemented that includes both for the development of competencies in children and their preparation for a world that is becoming more digital.', NULL, 12, NULL, 'https://www.linkedin.com/company/27147992/admin/updates/', 'Plexos Software SAS', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(43 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3730735Z', N'Gerry and Alfonso met at a hackathon in Mexico in 2013. Gerry traveled through Africa, and Alfonso to Chile, Turkey and Myanmar, meeting entrepreneurs and freelancing to sustain themselves throughout 2014. They started working together on a consulting project for the secretary of innovation in Panama in 2015, and met Martin later that year through a friend in common. Right before this, Martin had self-taught himself how to code, taken an exchange semester in Germany, studied mobile development in Sweden, and launched his own craft beer in Argentina. Together, they launched a creative agency in 2016 and took several innovation projects in 10 different countries helping companies grow faster. So after almost a couple of years working together, moving constantly across countries and around cities, and working remotely from coffee shops, airbnbs and co-working spaces naturally led them to ponder about the future of work and start The Everywhere Office in early 2018 for companies, teams and individuals to work effectively beyond their office, customizing their own work through smarter mobility and flexibility for increased productivity, satisfaction, and work-life balance.', NULL, 31, 'https://www.facebook.com/queocolombia/', 'https://www.linkedin.com/company/queo.com.co/', 'QUEO', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(44 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3730941Z', N'We started five years ago with the idea of having a medical / dental coworking system. We have been working for 35 years as a dental clinic but we wanted to expand our services. For this new bussiness, we equip 40 offices (dental and medical) and design an app for administration matters. The app allows the doctors to rent the time, the place and the office they prefer. Nowadays, we have no more spaces available in our primary building. We franchise the bussiness and sold our first franchise one year ago. Right now, we have another franchise and we are planning to spread our concept in other places, either in Mexico or outside the country.', NULL, 22, NULL, NULL, 'Sinnatte', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(45 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3731088Z', N'ContratosApp, SAPI de CV was incorporated on October - 2014 by Ignacio Bermeo Juárez (entrepreneur, corporate lawyer & iOS Programmer) as well as the company’s first angel investors. 

The idea & company graduated from the Founder Institute (http://fi.co), program that prepared the founder with the necessary tools to elaborate the PITCH, product development, market analysis, customer reach, etc.  Originally created as a mobile app that eases the process to create contracts for freelancers, it then transformed to an integral solution (SaaS) for companies that desired a seamless legal process to deliver & execute their contracts. 

Before graduation, TRATO received and investment of US$220,000 DLLS to create the product. After visiting several potential customers, the company released a version on January 2017. From then, it was accepted on Batch 7 of 500 Startups LATAM and received another investment from AVALANCHA VENTURES. The product has been received with great enthusiasm from legal & compliance departments of banks and big companies (BBVA Bancomer, Rotoplas, LIPU, SMX Financial, INVEX, Cabify, among others). 

With only 9 collaborators, mainly devs, tech-lawyers, sales, customer success & marketing, the company has managed to avoid further investment and has been growing on-boarding at least 2 new clients per month. On February 2018, the company was selected to a program that helps you learn about expansion globally in New York and changes where made to translate the software to English and adapt contracts to their jurisdiction. We found great areas of opportunity to expand to  a global market and several relevant investors expressed their interest  to invest for this purpose. However the company decided to spend 2018 on consolidating in the Latin American Market but we are prepared to grow globally starting 2019.  US or UK?  That is the question. ', NULL, 10, 'https://www.facebook.com/startopco/', 'https://www.linkedin.com/company/startop-co', 'StartOp', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(46 AS bigint), 1, 'Cali', 'Colombia', '2020-02-18T04:53:14.3731282Z', N'Vtronix means security to protect people from crime, our software predicts future actions based on human behavior to prevent robbery and eventually terrorism', NULL, 39, 'undos3d', 'undos3d', 'UNDOS3d', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(47 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3731492Z', N'Wolk LAB It is a visionary company and committed to the development of organizations and their collaborators, always looking for gender equality and a balance between personal and work life.

We have focused our energy on building an offer that solves real needs, through first class service and consulting.

We started in 2016 in Guadalajara Jalisco, now we have customers in 16 states in Mexico and we want to go international soon. 

Our team started with only 2 persons and now we are 7,  soon we will be tens of persons.', NULL, 29, 'https://www.facebook.com/VAL0PES/', ' https://www.linkedin.com/company/valopes/

', 'Valope', NULL, NULL, 5000.0, ' @val0pes');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(48 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3731647Z', N'Yeltic started as an idea at the University of Cambridge when Pedro Salinas and Bruno Caballero decided to create a company in 2008. In 2009, Yeltic was incorporated in Mexico with the legal name of Cantab Tecnología S. de R.L. de C.V.

Yeltic is the market leader in the development of custom-made virtual reality trainings and experiences that are used for hi/tech, retail, educational and manufacturing industries among others. We are currently working with major players in those industries such as Facebook, the Mexican Army and Navy, Grupo Bimbo, Audi developing virtual reality trainings or medical procedures. We have excellent skills in the development of VR, Artificial Intelligence and Cloud Computing to align organizations to the vision of Industry 4.0.

We are currently working with Audi AG developing VR trainings. In several benchmarks that we have performed, our methods and processes are based in hard data and scientific evidence and the quality of out developments is of global class. We have been doing research in collaboration with major universities that proves that our VR experiences are effective. We have also intellectual property on some of the technology we have created.

Our main goal is to keep our Mexican operations but to establish Yeltic as a global brand and operate overseas. We have had great resonance and interest from European manufacturing companies that adopt our services, so we believe that a European Headquarter would be an efficient way to achieve this goal and serve an expanding market.', NULL, 52, ' https://www.facebook.com/marco.rojas.9480

', ' https://www.linkedin.com/in/marco-rojas-8746b196/

', 'Viewy', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(50 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3732017Z', NULL, NULL, 52, 'https://www.facebook.com/whaleandjaguar/

', 'https://www.linkedin.com/company/whaleandjaguar/

', 'Whale and Jaguar Consultants', NULL, NULL, 5000.0, 'https://twitter.com/whaleandjaguar_?lang=en

');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(34 AS bigint), 1, 'Manizales', 'Colombia', '2020-02-18T04:53:14.3728994Z', N'We started this endeavor three years ago, motivated for the restrictions placed by financial institutions, for credits and other financial services. Personally, I lived this situation, first my father used to lend money to friends and neighbors, because they didn’t have the chance to get a credit from the bank. And second as an expat, living in different countries and without a financial history in each country, was very difficult for me to rent an apartment, request a credit card or even to have a cellular plan or get a cable TV service.

The lack of evaluations and scoring tools, forbid the access to financial services for two large market segments:
1.	people who doesn’t have a financial history at all, also called “NO-HITS”
2.	people who are already banked, but with not enough financial information are rejected, because banks doesn’t know how to measure them. Also called “THIN-FILES”

moyoAI is a solution that measure “the intention to repay”, through three elements:
a psychometric test + machine learning + artificial intelligence.

We are based in Mexico City. My partner and co-founder is from India. We decided to validate the solution and the business model in India first, because of: (1) large and diverse population, (2) country’s experience in microcredit (3) contacts with banks and non-bank financial institutions.

In the last two years, we evaluated +300,000 credit transactions, and we helped to authorized +240,000 loans.

We officially launch the company last year, under the name of moyoAI, and we started the expansion to Latin America. We plan to expand to UK, Europe and Africa in the near future.
', NULL, 6, NULL, NULL, 'Mr.Quick', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(49 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3731871Z', N'The idea of Zigo came from a group of investors concerned in creating disruptive technologies that adapted to the ever-changing financial market. In Mexico, credit-access and good financial services are limited to a few and Zigo’s goal is to reach those over-looked sections of the population. Since its birth, Zigo has been supported by Grupo Empresarial Vector and has had the objective to offer simple processes with low interest rates for small business and competitive returns for investors.', NULL, 56, 'https://www.facebook.com/VozyCo/', 'https://www.linkedin.com/company/vozy/', 'Vozy', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(40 AS bigint), 1, 'Chia', 'Colombia', '2020-02-18T04:53:14.3730208Z', N'Synthia was created with the idea of develop Artificial Intelligence in Mexico. We have developed several systems that can be used for different problems. We focus on Natural Language Processing and Image Recognition. We have systems that can measure mood and emotions of people, recognize in which moment a person has taken a decision and automate complaints and ticket solution. Our business model is to help different companies to save money and outperform the competition by automation of processes usually done by intelligent people. That would help those people to do more intelligent and non automatic work.', NULL, 21, 'pediahome', 'ivanfranciscoperezherrera', 'Pediahome SAS', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(37 AS bigint), 1, 'Cali', 'Colombia', '2020-02-18T04:53:14.3729520Z', N'Hi, my name is Victor Salinas, and I’m the founder of SmartConcil --- the most reliable and smarter platform to control cashflow and financial projections for SMB´s

SmartConcil is a spin-off from AIONTECH, fintech company with more than 9 years’ experience working in the financial industry
 
SmartConcil is a web-based solution with the most flexible matching rules engine to empower any company to track and match their daily transactions against bank statements; providing an easy way to control cash flow and financial projections for the company, helping Board of directors make effective decisions on financial strategies
 
Future implementation will include Artificial Intelligence for financial behavior

Our main difference from our competitors is that we don’t consider ourselves as an accounting solution, we are a fintech digital platform that manages financial information even from our competitors

We´re planning to have an organic growth in the next 3 years, Starting in Mexico and Canada, but expanding our operations through US, south America & Europe

Our business models go from licenses for big corporations to a subscription model as a SAAS service, for small and medium business
', NULL, 58, 'https://www.facebook.com/NinusDyT/', ' https://www.linkedin.com/company/ninusdyt/', 'Ninus Design & Technology', NULL, NULL, 5000.0, ' https://twitter.com/Ninus_deyt

');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(6 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3704297Z', N'Please make sure you include information about your business model and future expansions plans.

Blacktrust Group is a Mexican company who started operations in 2014 focused on solving business problems through the use of data and technology. We provide human factor assessment to mitigate the risk of hiring that may include, without limitation, the application of toxicological, psychometric tests and forensic interview, criminal/legal/social background checks. We have done more than 3.5 million risk assessments.

BlackTrust is one of the only companies of its kind, offering ethics and integrity screening processes as well as testing the candidates profile against the job requisites. BlackTrust´s differentiator is that it minimizes the risk of hiring an unethical employee while also matching the prospective employee´s skills. 

We are a group of more than 40 employees and we have worked in different countries in Latin America such as Brazil, Peru,Chile and Dominican Republic. We are really prepared to expand globally.', NULL, 53, NULL, NULL, 'Bicycle Capital', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(21 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3725696Z', N'A platform that provides producers the resources and support necessary to create the best events with the help of the Inder Space community.

A single mission

Help create Sold Out.


OUR HISTORY

Mexico is one of the countries that most attends concerts in Latin America. We personally attended many concerts, we realized the great culture that exists in Mexico, that made us enter to investigate the market, we discovered that a concert on average generates 300% of gain (there are events such as festivals live Latino, lollapalluza, tomorroland that generate more than 10X), we started to study countries with concert culture in other countries and then we discovered the opportunity.

When developing our business model, we discovered that more industries require investment to generate quality events, that''s when we started to develop the current model.

We launched our market test with a very simple landing page (you can still see it at www.inderspace.com) and we started selling, we discovered that many people are excited to invest in Inder Space projects. Then we decided to develop the complete platform and how we wanted it.

By the time you fill out this form you can see the progress in www.inderspace.com.mx is already 95%. once finished it will be launched at inderspace.com


BUSINESS MODEL

Inder space solves 3 main problems of the concerts and mass events industry.

1. Investment to produce massive events (concerts, festivals, theater, expos, live shows, experiences).

2. Production of events. We join the best producers to create the best events.

3. Sale of digital tickets for events.


How do we earn money?

1. From the collective investment, we associate with each producer we generate earnings per created event.

2. We produce our own events, focused on music. Concerts and Festivals The main sources of income are by 3 means. Sale of tickets, Sponsors and Merchandaising.

3. We offer producers of events from different industries (concerts, festivals, theater, expos, live shows, experiences) our digital ticket office tickets to $ 1 USD flat rate.
', NULL, 53, NULL, NULL, 'Grupo Bernier', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(28 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3727325Z', N'We are an engineering firm that offers mechanical design, structural analysis,  certifications and additive manufacture of Aerospace Components made of composites, metals & thermoplastics to large, mid-sizes and small companies.', NULL, 53, NULL, NULL, 'LAP Technologies', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(39 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3729959Z', N'2015: 
The company is founded
The company was accepted at Telefonica’s startup incubator: Wayra. We received USD 100K of funding from them.
Development of the first commercial MVP.

2016:
First clients, including our first international client: AB - InBev Colombia.
The company was accepted at Coca - Cola’s innovation program: ‘The Bridge’. After this program Coca - Cola became one of our biggest clients.
The company was selected for the ‘Bluebox Ventures’ accelerator program. We received 50K of funding from them.
We closed the year with 150K in sales.

2017:
We received 430K from American and Asian angel investors, and also from a Mexican VC fund.
We started working with our first US client: Intuit Turbotax.
We were accepted at the Infinity Hong - Kong accelerator program. We were the only LATAM startup selected.
We closed the year with 290K in sales.

2018:
We were selected as the best startup in the Advertising week LATAM contest. 
We increased our capacity 3X via automatization and tech improvements.
We closed two global contracts with financial and technology companies.

2019:
Opening of commercial offices in NYC.

Synapbox mission is to create and develop tools to understand human behavior. We help companies to better understand how their consumers are interacting with their digital contents, in order to get insights on how to improve those contents. We are a consumer intelligence company that helps other companies to make better - data-driven - decisions. We enable our clients the ability to reach and collect data, organize, visualize information and analyze and make decisions.
We expect to be the industry leader by 2025, using our technology to create a major disruption in the traditional market of focus groups and usability testing.', NULL, 53, NULL, NULL, 'ParqueaMe', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(42 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3730574Z', N'We are an OEM and engineering company that has an area devoted to energy. Our team has experience in bio-fuels already 16 years, started with cane sugar bagasse, then biogas from anaerobic fermentation of sludges, generating electricity since 11 years ago and up today more than 10 MWe generation, with trigeneration processes included. Combustion techniques has been developed for non-hazardous-residue but even carbon sequestration for all kind of biomass as a fuel in a fluid bed boiler, first stage has been tested in 2007 and 2008 generating continuously 450 T/h of super-heated steam and reducing particle emission in 80%. Since 2009 we have established vinculating agreements with universities and poly-techniques to improve and optimize our processes, and generate human resources for operation and maintenance requirements. Co-generation (CHP) and trigeneration projects natural gas based are being designed and built since 2007.', NULL, 53, 'https://www.facebook.com/ProcessOnlineCo', ' https://www.linkedin.com/company/process-online-s-a-s/

', 'Process Online', NULL, NULL, 5000.0, 'https://twitter.com/ProcessOnLineCo');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(2 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3702759Z', N'Currently the prevalence of patients with hearing impairment is 360 million people in the world, of which 10 million are concentrated in Mexico, however, only 1 in 20 people who need a hearing aid to solve their disability has the economic possibility to face the expense, because if we take into account the total cost of a hearing aid, medical consultations, diagnostic studies (audiometries), molds, batteries, accessories, equipment maintenance, etc., these go up to more than $ 120,000MX. Auubdire offers a smarter solution and at a price up to 9 times more accessible.

AuubDire develops the most intelligent Hearing Aid on the market, which simplifies the process of selecting and adapting it, through a single solution, adaptable and scalable to the needs of any patient, reducing up to 90 % the total cost compared to the current solutions in the market.
Our main innovation is that, unlike traditional hearing aids, the processing of audio signals is divided between the hearing aid and a mobile application in an intelligent device, since nowadays even a mid-range cell phone can perform 10 thousand times more operations per second than the most modern hearing aid in the market, with which we can make a finer adjustment of the audio signals, in addition to adding a series of unique benefits and all, at a lower price.
In November 2017 we participated in INC Monterrey and obtained the first place in the Paypal Tec award, in which we were awarded a scholarship for one year of incubation at the Monterrey Campus Tec Incubator in the January-December 2018 period. In addition to the second place in the Health Innovation Award contest, obtaining $ 50,000 MXN of capital, in addition to being creditors of a one-month acceleration program, in the Launch Pad Digital Health accelerator in San Francisco, California, with a value of $ 5, 000 USD and currently we have a private investment offer of $ 240,000 MXN.
In addition to this, we have the support of experts from different areas of medicine, engineering and business, in which we support each of the decisions we make:
José Manuel Aguirre Guillen specialist in technology commercialization, technological entrepreneurship and development strategies based on knowledge. Currently director of the Network of Entrepreneurship and Innovation Parks and Strategic Alliances in Entrepreneurship, at the Eugenio Garza Lagüera Entrepreneurship Institute of the Tecnológico de Monterrey. Mentor in the business model area.
Ramón Martín Rodríguez Dagnino Dr and Master of Science with specialization in Electrical Engineering and Communications (CINVESTAV-IPN). Mentor in technological development.
Silvia Patricia Mora Castro Director of the Network of Technology Transfer Offices of the Monterrey Institute of Technology and Higher Education and President of the OTT Mexico Network. Mentor in the area of intellectual property.', NULL, 1, ' https://www.facebook.com/akountgo

', ' https://www.linkedin.com/company/akountgo/', 'AkountGo', NULL, NULL, 5000.0, 'https://twitter.com/AkountG ');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(3 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3703564Z', N'In Bancompara we help our users to compare in real time mortgage offers adjusted to their particular needs. Not only we compare, but also we can pre-approve the credit in 3 minutes and perform all the mortgage process until the customer has purchased her / his new home. ', NULL, 5, ' https://www.facebook.com/amazoniko', 'None', 'Amazoniko', NULL, NULL, 5000.0, 'None');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(4 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3703784Z', N'We have almost 5 years solving challenges with technology. Baud was founded in Mexico City by Pedro Porras, a young mechatronics engineer and philosopher, maker, robotics teacher, university professor and FIRST mentor. Two years later Enrique Preza joined as a partner, he is an engineer too and founder of another entrepreneurship that he grew from zero for almost 6 years before partnering with Pedro and joining Baud´s team. His company develops monitoring systems for Data Centers. For example, their system generates the electricity bill for Sky at their Mexico City´s site. 

Our vision of empowering people with emergent technology began with projects of PCB design, IoT and firmware development and soon we began projects of communication experiences for brands, museums and businesses. During this time we made AR/VR apps, robotics, multimedia installations, web systems and other technologies to create experiences that brought a message to the user. In this process we learned a lot about developing technology products and experiences. 

On 2016 we partnered with Claudia Castellanos and Francisco Padilla to focus our company into the EdTech sector, pivoting into learning experiences with and about emergent technologies, using the know-how we have made with the other previous projects. Claudia describes herself as a “Disruptive pedagogist”, she is one of the pioneers in Mexico on the MakerEd movement and true advocate for STEAM (+H for Humanities). Francisco is also a pioneer on the robotics competitions in Mexico, he is director of two companies: one manufactures school furniture and builds learning spaces; the other distributes educational robots. That year was also the year in which we moved out from Pedro´s garage into a small office and hired our first full-time employees formally.

Our learning experiences model consists of an emergent technology at its core, with 4 elements surrounding it: educational content, gamification and storytelling, digital components (XR, Chatbots, apps, etc) and a physical side (kits and physical, hands-on  interfaces). Currently we are focused on Robotics and IoT for children but our expansion model aims to switch to, for example, AI for employees, Nanotechnology for University students, drones for teenagers, etc.

Since there was no hardware suitable for the learning experience we wanted to create with robotics and IoT, we developed Bucky, a low-cost educational robot with internet connectivity and visual programming (we developed our own programming language too, Flowde) that can be implemented on the reality of the education in Mexico (low budgets, non English speakers, non expert teachers, no infrastructure, etc), actually, you can build cardboard robots with it. Bucky was founded with a Government grant from CONACyT, our profits of the ad-hoc projects and with a crowdfunding campaign that we successfully made on Kickstarter. We are currently starting the first deliveries of the kickstarter orders and already signed a distribution contract with one of the most important distributors in LA for STEM competitions. 

More recently, Fernando Valenzuela, the 5th partner joined us to bring his experience of decades into the EdTech business to help us grow and find funding. He is a former McGraw Hill and HP director, board member of more than 8 education companies and endeavor mentor. This month we signed our first private investment through a convertible note and received a notification from INADEM (the entrepreneurship side of the Economy Secretariat) granting us another funding deal. Nevertheless, we are still seeking to gather the total amount that we need as investment to complete the educational ecosystem of Bucky to bring a very competitive product to the market.
', NULL, 55, NULL, NULL, 'Arkdia', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(5 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3704133Z', N'
Biomexanik is a company specialised in improving performance in physical activity with experience in the application of motion sciences. Founded by Adrian Elias and Rodolfo Vilchis in 2015 Biomexanik was created to improve the quality of life of people. As part of their work, Biomexanik provides customised services for the optimization of the human body through the improvement of motion with technological devices. Furthermore, Biomexanik designs and builds equipment focused on complementing the continuous improvement of the user. Biomexanik is a company integrated by a multidisciplinary team of engineers, sport scientists, researchers, clinicians, designers, and sales managers, all dedicated to assessment, help people to understand their body motion and provide guidelines to improve motion patterns.
', NULL, 17, NULL, NULL, 'Beriblock', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(8 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3704652Z', N'BrandMe operates a Sponsorship marketplace that connects Brands with more than 80,000 Content Creators such ass Celebrities, YouTubers, Bloggers and Influencers that monetize his own social media via our platform. Also we create a agorythm and we can extract information about any social account and give the brands information such ass fake followers, principal countries, principal states, content more popular, and engagement rate to help media agencies and brands take  better decitions. Our vision is expand our technology as a white label services, now we have clients in Mexico, Colombia and Spain and big Fortune 500 brands like Google, Amazon and Unilever', NULL, 17, 'cashmoneysolutions', NULL, 'Cash Money Solutions SAS', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(18 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3715416Z', N'The Project "Habitat University" includes
water, food, health, shelter, 
education, meditation,  and exercise.
In order to achieve human evolution in accordance with 
Carl Sagan and Jacques Derrida''s teory frameworks,
and having as method: 
imitation, equalization, innovation,  & invention.
That is why I invited every single professional 
who like to share their knowledge.
because If we do not evolutionate 
we will exterminate each other with our tecnology.
The objetives are simple: 
1 to built a scientific generation, I mean
educaton for all in all disciplines.
2 to shape other system that excludes:
war economy, patrialcal ideology and controling the way of thinking.
3 to achieve a horizontal way of living.
4 the starting point will be our habitat.
5 to avoid the destruction of our space ship 
called earth planet.', NULL, 21, 'https://www.facebook.com/gehnios', 'https://www.linkedin.com/company/gehnios/', 'GEHNIOS SOLUCIONES DIGITALES DE SALUD SAS', NULL, NULL, 5000.0, 'https://twitter.com/gehnios?lang=es');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(15 AS bigint), 1, 'Chia', 'Colombia', '2020-02-18T04:53:14.3714908Z', N'We were born as an electronic invoice company an we evolve in a SaaS that is focused in empower the Small and medium businesses with machine learning and blockchain.', NULL, 17, NULL, 'https://www.linkedin.com/company/financial-systems-company/
 
https://www.linkedin.com/in/graham-parry-b774561/
', 'Financial Systems Company SAS', NULL, NULL, 5000.0, 'https://twitter.com/FSCiUCollect

');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(36 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3729372Z', N'We create Sign Language Digital Translation, using a virtual character that translates voice and text into Mexican and American Sign Language. Our business model consists in a free mobile app that has the purpose to train our Ai algorithm that feeds the enterprise version of the platform to make webpages accessible for the Deaf. We are currently working on launching both services (free and enterprise) and planning to create real-time translation in mixed reality, which means users will interact with our character to attend classes or any activity with a personal virtual interpreter available 24/7.', NULL, 17, 'https://www.facebook.com/netmproject/', 'https://www.linkedin.com/company/netm-s-a-s ', 'NetM', NULL, NULL, 5000.0, ' https://twitter.com/netmproject');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(7 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3704502Z', N'We are a group of Biomedical Engineers and a Business Engineer that met at our alma mater Tecnológico de Monterrey. Since the beginning we had great interest in health technology and were very involved with competitions, hackathons and Entrepreneurship. We graduated and then decided to turn one project into a Startup because of its great potential to bring health equity and innovation to Mexico.', NULL, 33, 'https://www.facebook.com/germanschafer', 'https://www.linkedin.com/in/german-schäfer-4497206/ ', 'Bioprocol', NULL, NULL, 5000.0, 'Bioprocol @bioprocol');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(9 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3704860Z', N'ButterPay was inspired by projects such as MPESA in Kenia, where mobile payments are used instead of cash. Also it is inspired by the fast QR-based payments used in China. We aim to create a payments ecosystem for both peer-to-peer and merchant-to-peer payments. So far we support SMS and QR based payments, and we are developing an API to support e-commerce transactions. We provide our users with an iOS and Android app and also a webapp. With all this our customers can make payments using cheap phones, smartphones, desktops and laptops. 
We want to make the use of our service so easy and convenient that even people who sell in the street make use of it.
With this features we aim to create a strong network in Mexico, then export our platform to other countries in Latin America.', NULL, 59, 'https://www.facebook.com/CityScanCO/', 'https://www.linkedin.com/company/cityscanco/', 'CityScan by Info Projects', NULL, NULL, 5000.0, 'cityscanCO');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(10 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3705020Z', N'To set the scene:
In LATAM price differences on drugs and fast moving consumer goods are a lot higher than in the United States or Europe (25% on average with tops up to 70%) and might even vary by store.


The intransparency in the retail industry from a consumer and retail perspective. Thus consumers can buy for the cheapest prices, while retailers receive valuable information in order to optimize their pricing strategies. 

B2C: 
“Trivago for FMCGs”: It is a platform which unites all pharmacies and supermarkets with online presence, for users to compare prices and delivery time and buy with only one register. Like this we created the biggest real time database with over +500.000 SKUs in Mexico. This will lead to an estimated savings accumulating up to a month minimum wage of a chronically ill person.


B2B: 
Big Data directed towards Retailers, Pharmacies, Laboratories:
We are monetizing the data we collect. By this we can give real time price suggestions based on market movements. Furthermore it is a tool to monitor competitors. We have a commercial collaboration with revenue share with the two biggest information companies worldwide. 
', NULL, 13, ' http://facebook.com/comidaenlau', ' https://www.linkedin.com/company/comida-en-la-u/

', 'Comida en la U', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(11 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3714014Z', N'Piedra Líquida es una tecnología que nació a partir de un requerimiento de la Cámara de la Industria de la Construcción Sección Guanajuato para darle uso al residuo de madera y al plástico. Se planteó la fabricación de fachaletas plásticas, las cuales compiten con la piedra natural, con las ventajas ecológicas, baja densidad (mucho menor peso), costo competitivo, y personalizables en diseño y color. Se tiene ya el plan de negocio y el modelo de negocio desarrollados a partir de participar en el programa de Nodos Binacionales de CONACYT de Materiales Avanzados y Procesos Industriales. El proyecto requiere de ángeles inversionistas para arrancar operaciones como spin-off de CIATEC ya con un mercado definido y cuantificado a partir de un estudio subcontradado.', NULL, 8, ' https://www.facebook.com/CVN.CentroVirtualDeNegocios/', ' https://www.linkedin.com/company/cvn-centro-virtual-de-negocios/', 'CVN', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(12 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3714218Z', N'We are a digital freight forwarder that simplifies international shipping and secures the supply chain for all actors involved. We are building a podcast to expand our customer base and we believe that Mexican products stand out in foreign markets because of their quality. We charge a commision on each invoice that we send and our plans is to dominate the European (and U.K) market by the end of 2020.', NULL, 30, 'https://www.facebook.com/cyclesystems/', 'https://www.linkedin.com/company/cycle-system/', 'Cycle', NULL, NULL, 5000.0, 'leon_castano');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(13 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3714373Z', N'CREID is a technology-based startup that seeks to scale through the use of technology and technological innovations. For 3 years it has focused on the technological development of the solar dryer; of which there are several versions that lead to technological innovations and 2 patent applications. The objective is to strengthen CREID and its brands in the national and international market as a profitable company with products that denote quality, sustainability, commitment and social responsibility, maintaining a constant innovation that allows achieving recognition and positioning in the market, positively impacting the productive sector of the country and promoting the commercialization of Mexican products.', NULL, 27, NULL, 'Efiwall', 'Efiwall', NULL, NULL, 5000.0, 'Efiwall');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(14 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3714664Z', N'Jean-Matthieu (CEO) developed the base of the real-time ad recognition algorithms in 2015 just to check if the work done by Nielsen manually could be automatized. Cyprien (COO) immediately saw the potential of this technology and left his job in Paris to come to Mexico in 2016 to work full time on Decidata with him. We launched the first products (inSights and TV Sync) in March 2016. In May 2016, we got our first sale with one of the biggest media agency in Mexico City, and in October, we were profitable. In October 2017, we raised a 1.085M USD seed round with investors from Mexico, Peru, Argentina and Canada to develop our Programmatic TV platform. 
We are already operating in 11 countries: Mexico, Colombia, Ecuador, Chile, Argentina, Peru, Brazil, etc. We plan to consolidate our presence and our sales in these countries in the coming months. We are also currently in talks with operators in Spain and Mexico to implement our Programmatic TV solution with them. At the OTT (Over The Top) level, we are in the process of signing a contract with a content broker that wants to develop its own OTT app to provide Video On Demand at the international level, with a focus on Latam and Asia (Japan, Malaysia, China, etc.). We will help them monetize their content through the use of our programmatic ad buying platform.
We went from 2 to 35 people in less than 2 years, with a 259% annual revenue growth. We launched more than 700 campaigns for the biggest brands with most of the largest media agencies in Latam.
Most of our current revenues come from advertisers, as we manage directly their marketing campaign and charge a fee to do so.
With the projects under way with big operators and broadcasters in Latam and Spain, we plan to experience another 300% growth in revenue in 2018.', NULL, 28, NULL, 'www.linkedin.com/in/andres-isaza ', 'Essecorp', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(16 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3715067Z', N'We are a B2B tools that helps to improve the autoparts acquisition process, through a connection with sellers to get the best price, brand and delivery time. Right now we are operating Mexico but this model applies to LATAM. Colombia is our next step where a pilot has been run with AutoLab', NULL, 54, '  https://www.facebook.com/fiwiapp/

', NULL, 'Fiwi', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(17 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3715210Z', N'We started as an idea in 2012 to expose corruption and promote transparency in the local governments from Mexico. In 2015 it evolved into a digital governance app for social empowerment and communities management to  transform the way neighbours connect  to co-design and implement their own  local and economic development initiatives and proyects to achieve the best scenarios for each communitiy. Güinect is all about creating a new system where people can get involved in every policy making process and implementation with the goal to promote more autonomous and self sustainable communities out of pure social colaboration. From now own the Destiny of our communities is in our hands. We are not trying to substitute governments, on the contrary, our goal is to help local governments to maximize the resources and become the leaders society need to make meaningfull impact in their lifes. 
', NULL, 58, 'https://www.facebook.com/friendsofmedellin/', NULL, 'Friends of Medellin / VICO', NULL, NULL, 5000.0, NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(32 AS bigint), 1, 'Medellin', 'Colombia', '2020-02-18T04:53:14.3728621Z', N'An Artificial intelligence platforms learning users behavior to give the best e commerce experience ever.

Mobile or Web, our platform bring to users the chance to buy anything available on internet through the same place with just 3 clicks.

Users and Züggig will search for products, share them with friends, compare online prices and buy them all in the same place.

¡One stop buying experience!

Search, Share, Compare & Buy', NULL, 17, ' https://www.facebook.com/moonblockapp/

', 'https://www.linkedin.com/company/moonblock/', 'Moonblock', NULL, NULL, 5000.0, ' https://twitter.com/Moonblock_ai');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] ON;
INSERT INTO [dbo].[Enterprises] ([Id], [Active], [City], [Country], [CreatedDate], [Description], [Email], [EnterpriseTypeId], [Facebook], [Linkedin], [Name], [Phone], [Photo], [SharePrice], [Twitter])
VALUES (CAST(51 AS bigint), 1, 'Bogota', 'Colombia', '2020-02-18T04:53:14.3732159Z', NULL, NULL, 4, NULL, ' https://www.linkedin.com/in/maria-angelica-lizarazo-tarazona-a15918158/', 'Wux', NULL, NULL, 5000.0, 'https://twitter.com/MarIAngelLT');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Active', N'City', N'Country', N'CreatedDate', N'Description', N'Email', N'EnterpriseTypeId', N'Facebook', N'Linkedin', N'Name', N'Phone', N'Photo', N'SharePrice', N'Twitter') AND [object_id] = OBJECT_ID(N'[dbo].[Enterprises]'))
    SET IDENTITY_INSERT [dbo].[Enterprises] OFF;

GO

CREATE INDEX [IX_Enterprises_EnterpriseTypeId] ON [dbo].[Enterprises] ([EnterpriseTypeId]);

GO

CREATE INDEX [IX_InvestorEnterprise_EnterpriseId] ON [dbo].[InvestorEnterprise] ([EnterpriseId]);

GO

CREATE UNIQUE INDEX [IX_Investors_EnterpriseId] ON [dbo].[Investors] ([EnterpriseId]) WHERE [EnterpriseId] IS NOT NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20200218045314_V2_Simplified_Models_DecimalMoneyValues_AuditFields', N'2.2.6-servicing-10079');

GO


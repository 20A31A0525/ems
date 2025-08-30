CREATE TABLE [Users] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [UserName] varchar(100) UNIQUE NOT NULL,
  [Email] varchar(200) UNIQUE NOT NULL,
  [PasswordHash] varchar(500) NOT NULL,
  [RoleId] int,
  [CreatedAt] datetime,
  [UpdatedAt] datetime
)
GO

CREATE TABLE [Roles] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [Name] varchar(100) UNIQUE NOT NULL,
  [Description] varchar(200)
)
GO

CREATE TABLE [Departments] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [Name] varchar(100) UNIQUE NOT NULL,
  [CreatedAt] datetime,
  [UpdatedAt] datetime
)
GO

CREATE TABLE [Employees] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [FirstName] varchar(100) NOT NULL,
  [LastName] varchar(100) NOT NULL,
  [Email] varchar(200) UNIQUE NOT NULL,
  [Phone] varchar(50),
  [HireDate] date,
  [DepartmentId] int,
  [UserId] int,
  [PhotoUrl] varchar(500),
  [ResumeUrl] varchar(500),
  [IsActive] bit,
  [CreatedAt] datetime,
  [UpdatedAt] datetime
)
GO

CREATE TABLE [Projects] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [Name] varchar(150) NOT NULL,
  [Description] text,
  [StartDate] date,
  [EndDate] date,
  [CreatedAt] datetime,
  [UpdatedAt] datetime
)
GO

CREATE TABLE [Assignments] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [EmployeeId] int,
  [ProjectId] int,
  [AssignedAt] datetime
)
GO

CREATE TABLE [Attendance] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [EmployeeId] int,
  [Date] date,
  [CheckIn] datetime,
  [CheckOut] datetime,
  [Status] varchar(50)
)
GO

CREATE TABLE [LeaveRequests] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [EmployeeId] int,
  [StartDate] date,
  [EndDate] date,
  [Reason] text,
  [Status] varchar(50),
  [ApprovedBy] int,
  [CreatedAt] datetime
)
GO

CREATE TABLE [Payroll] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [EmployeeId] int,
  [Month] varchar(20),
  [Year] int,
  [BaseSalary] decimal(18,2),
  [Bonus] decimal(18,2),
  [Deductions] decimal(18,2),
  [NetPay] decimal(18,2),
  [GeneratedAt] datetime
)
GO

CREATE TABLE [AuditLogs] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [UserId] int,
  [Action] varchar(200),
  [Entity] varchar(100),
  [EntityId] int,
  [Timestamp] datetime
)
GO

CREATE TABLE [Files] (
  [Id] int PRIMARY KEY IDENTITY(1, 1),
  [FileName] varchar(200),
  [FilePath] varchar(500),
  [UploadedBy] int,
  [UploadedAt] datetime
)
GO

ALTER TABLE [Users] ADD FOREIGN KEY ([RoleId]) REFERENCES [Roles] ([Id])
GO

ALTER TABLE [Employees] ADD FOREIGN KEY ([DepartmentId]) REFERENCES [Departments] ([Id])
GO

ALTER TABLE [Employees] ADD FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id])
GO

ALTER TABLE [Assignments] ADD FOREIGN KEY ([EmployeeId]) REFERENCES [Employees] ([Id])
GO

ALTER TABLE [Assignments] ADD FOREIGN KEY ([ProjectId]) REFERENCES [Projects] ([Id])
GO

ALTER TABLE [Attendance] ADD FOREIGN KEY ([EmployeeId]) REFERENCES [Employees] ([Id])
GO

ALTER TABLE [LeaveRequests] ADD FOREIGN KEY ([EmployeeId]) REFERENCES [Employees] ([Id])
GO

ALTER TABLE [LeaveRequests] ADD FOREIGN KEY ([ApprovedBy]) REFERENCES [Employees] ([Id])
GO

ALTER TABLE [Payroll] ADD FOREIGN KEY ([EmployeeId]) REFERENCES [Employees] ([Id])
GO

ALTER TABLE [AuditLogs] ADD FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id])
GO

ALTER TABLE [Files] ADD FOREIGN KEY ([UploadedBy]) REFERENCES [Users] ([Id])
GO

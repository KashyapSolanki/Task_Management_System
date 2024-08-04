USE [master]
GO
/****** Object:  Database [TaskManagementDB]    Script Date: 8/4/2024 4:46:38 PM ******/
CREATE DATABASE [TaskManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TaskManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TaskManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TaskManagementDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskManagementDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TaskManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskManagementDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [TaskManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskManagementDB] SET RECOVERY FULL 
GO
ALTER DATABASE [TaskManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [TaskManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TaskManagementDB', N'ON'
GO
ALTER DATABASE [TaskManagementDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [TaskManagementDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TaskManagementDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 8/4/2024 4:46:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 8/4/2024 4:46:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[EmpoyeeType] [int] NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 8/4/2024 4:46:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[DueDate] [datetime2](7) NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[TeamLeaderId] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240802082329_InitialCreate', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240802082822_UpdateEmployeeTable', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240802083455_UpdateTaskTable', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240802084454_UpdateEmployeePassword', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240802093002_UpdateTaskDueDate', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240802094238_RemoveDocument', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240804100528_UpdateNotesInTask', N'7.0.5')
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20240804100820_UpdateNotesInTask', N'7.0.5')
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (1, N'Calliope', N'Castaneda', N'calliope123@gmail.com', N'calliope@7812', 1, 1, 0)
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (2, N'Connor', N'Lee', N'connor01@gmail.com', N'connor@4152', 1, 1, 0)
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (3, N'Rayna', N'Bauer', N'rayna56@gmail.com', N'rayna@1234', 1, 1, 0)
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (4, N'Axton', N'Wallace', N'axton34@gmail.com', N'axton@9876', 1, 1, 0)
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (5, N'Joey', N'Avila', N'joey789@gmail.com', N'joey@1289', 2, 1, 0)
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (6, N'Davion', N'Crane', N'davion35@gmail.com', N'davion@0456', 2, 1, 0)
GO
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [Email], [Password], [EmpoyeeType], [IsActive], [IsDeleted]) VALUES (7, N'Thomas', N'Shelby', N'thomas007@gmail.com', N'thomas@5100', 3, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Tasks] ON 
GO
INSERT [dbo].[Tasks] ([Id], [Title], [Description], [DueDate], [IsCompleted], [EmployeeId], [TeamLeaderId], [Notes]) VALUES (1, N'task 1', N'task description', CAST(N'2024-08-02T00:00:00.0000000' AS DateTime2), 1, 1, 5, N'This is testing note')
GO
INSERT [dbo].[Tasks] ([Id], [Title], [Description], [DueDate], [IsCompleted], [EmployeeId], [TeamLeaderId], [Notes]) VALUES (2, N'task 2', N'task description 2', CAST(N'2024-08-10T00:00:00.0000000' AS DateTime2), 0, 1, 5, NULL)
GO
INSERT [dbo].[Tasks] ([Id], [Title], [Description], [DueDate], [IsCompleted], [EmployeeId], [TeamLeaderId], [Notes]) VALUES (3, N'task 3', N'task description 3', CAST(N'2024-08-15T00:00:00.0000000' AS DateTime2), 0, 2, 5, NULL)
GO
INSERT [dbo].[Tasks] ([Id], [Title], [Description], [DueDate], [IsCompleted], [EmployeeId], [TeamLeaderId], [Notes]) VALUES (4, N'task 4', N'task description 4', CAST(N'2024-08-12T00:00:00.0000000' AS DateTime2), 0, 2, 5, NULL)
GO
INSERT [dbo].[Tasks] ([Id], [Title], [Description], [DueDate], [IsCompleted], [EmployeeId], [TeamLeaderId], [Notes]) VALUES (5, N'task 5', N'task description 5', CAST(N'2024-08-19T00:00:00.0000000' AS DateTime2), 0, 3, 6, NULL)
GO
INSERT [dbo].[Tasks] ([Id], [Title], [Description], [DueDate], [IsCompleted], [EmployeeId], [TeamLeaderId], [Notes]) VALUES (7, N'task 6', N'task description 6', CAST(N'2024-08-23T00:00:00.0000000' AS DateTime2), 0, 3, 6, NULL)
GO
SET IDENTITY_INSERT [dbo].[Tasks] OFF
GO
/****** Object:  Index [IX_Tasks_EmployeeId]    Script Date: 8/4/2024 4:46:38 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tasks_EmployeeId] ON [dbo].[Tasks]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees] ADD  CONSTRAINT [DF__Employees__Passw__00200768]  DEFAULT (N'') FOR [Password]
GO
ALTER TABLE [dbo].[Tasks] ADD  CONSTRAINT [DF__Tasks__TeamLeade__7F2BE32F]  DEFAULT ((0)) FOR [TeamLeaderId]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_Tasks_Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_Tasks_Employees_EmployeeId]
GO
USE [master]
GO
ALTER DATABASE [TaskManagementDB] SET  READ_WRITE 
GO

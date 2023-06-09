USE [master]
GO
/****** Object:  Database [Young-Artists]    Script Date: 2023/4/7 12:35:15 ******/
CREATE DATABASE [Young-Artists]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Young-Artists', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Young-Artists.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Young-Artists_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Young-Artists_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Young-Artists] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Young-Artists].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Young-Artists] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Young-Artists] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Young-Artists] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Young-Artists] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Young-Artists] SET ARITHABORT OFF 
GO
ALTER DATABASE [Young-Artists] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Young-Artists] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Young-Artists] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Young-Artists] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Young-Artists] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Young-Artists] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Young-Artists] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Young-Artists] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Young-Artists] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Young-Artists] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Young-Artists] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Young-Artists] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Young-Artists] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Young-Artists] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Young-Artists] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Young-Artists] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Young-Artists] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Young-Artists] SET RECOVERY FULL 
GO
ALTER DATABASE [Young-Artists] SET  MULTI_USER 
GO
ALTER DATABASE [Young-Artists] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Young-Artists] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Young-Artists] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Young-Artists] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Young-Artists] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Young-Artists] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Young-Artists', N'ON'
GO
ALTER DATABASE [Young-Artists] SET QUERY_STORE = OFF
GO
USE [Young-Artists]
GO
/****** Object:  Table [dbo].[administrators]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[administrators](
	[administrator_id] [int] IDENTITY(1,1) NOT NULL,
	[administrator_account] [nvarchar](50) NULL,
	[administrator_password] [nvarchar](50) NULL,
	[administrator_creat_timestamp] [nvarchar](50) NULL,
	[administrator_update_timestamp] [nvarchar](50) NULL,
 CONSTRAINT [PK_管理員] PRIMARY KEY CLUSTERED 
(
	[administrator_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[advertisement]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[advertisement](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[advertisement_id] [int] NULL,
	[advertisement_name] [nvarchar](50) NULL,
	[advertisement_src] [nchar](100) NULL,
	[advertisement_alt] [nchar](100) NULL,
	[advertisement_href] [nchar](100) NULL,
	[advertisement_startdate] [nvarchar](50) NULL,
	[advertisement_enddate] [nvarchar](50) NULL,
	[company_id] [int] NULL,
	[event_id] [int] NULL,
	[advertisement_online] [bit] NULL,
 CONSTRAINT [PK_Advertisement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[announcement]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[announcement](
	[aid] [int] NOT NULL,
	[announcement_type] [nvarchar](20) NULL,
	[content_title] [nvarchar](50) NULL,
	[content_time] [nvarchar](50) NULL,
	[content] [nvarchar](500) NULL,
	[details_id] [char](1) NULL,
 CONSTRAINT [PK_announcement] PRIMARY KEY CLUSTERED 
(
	[aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[commodity]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[commodity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[commodity_name] [nvarchar](50) NULL,
	[commodity_narrative] [nvarchar](500) NULL,
	[commodity_num] [int] NULL,
	[commodity_price] [money] NULL,
	[commodity_image] [nvarchar](50) NULL,
	[commodity_start] [nvarchar](50) NULL,
	[commodity_sort] [int] NULL,
	[commodity_sale] [int] NULL,
	[commodity_Classification] [nvarchar](50) NULL,
	[commodity_state] [bit] NULL,
 CONSTRAINT [PK_commodity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[company]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[company](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[company_id] [int] NULL,
	[company_name] [nchar](50) NULL,
	[company_phone] [nchar](50) NULL,
	[company_address] [nchar](50) NULL,
	[company_email] [nchar](50) NULL,
	[company_online] [bit] NULL,
 CONSTRAINT [PK_Corporation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contactPerson]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contactPerson](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contactperson_name] [nchar](50) NULL,
	[contactperson_title] [nchar](50) NULL,
	[contactperson_phone] [nchar](50) NULL,
	[contactperson_email] [nchar](50) NULL,
	[company_id] [int] NULL,
	[contactperson_online] [bit] NULL,
 CONSTRAINT [PK_ContactPerson] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_name] [nvarchar](50) NULL,
	[customer_email] [nvarchar](50) NULL,
	[customer_password] [nvarchar](50) NULL,
	[customer_phone] [nvarchar](50) NULL,
	[customer_region] [nvarchar](30) NULL,
	[customer_address] [nvarchar](100) NULL,
	[customer_birth_date] [nvarchar](30) NULL,
	[customer_gender] [nvarchar](10) NULL,
	[customer_creat_timestamp] [nvarchar](50) NULL,
	[customer_update_timestamp] [nvarchar](50) NULL,
 CONSTRAINT [PK_會員] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[details]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[details](
	[details_id] [int] NOT NULL,
	[eventtime] [nvarchar](50) NULL,
	[event_id] [int] NULL,
	[state] [nvarchar](20) NULL,
	[reason] [nvarchar](1000) NULL,
 CONSTRAINT [PK_detail] PRIMARY KEY CLUSTERED 
(
	[details_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evaluation_form]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evaluation_form](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[commodity_id] [int] NULL,
	[number_id] [int] NULL,
	[rate] [int] NULL,
	[evaluation_time] [nvarchar](50) NULL,
	[isstate] [bit] NULL,
 CONSTRAINT [PK_evaluation_form] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[event_image] [nvarchar](50) NULL,
	[event_name] [nvarchar](50) NULL,
	[event_info] [nvarchar](max) NULL,
	[company_id] [int] NULL,
	[event_sell_start_timestamp] [nvarchar](50) NULL,
	[event_sell_end_timestamp] [nvarchar](50) NULL,
	[event_start_timestamp] [nvarchar](50) NULL,
	[event_end_timestamp] [nvarchar](50) NULL,
	[event_type_id] [int] NULL,
	[event_location_id] [int] NULL,
	[event_isstate] [bit] NULL,
 CONSTRAINT [PK_活動表] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_collect]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_collect](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NULL,
	[customer_id] [int] NULL,
 CONSTRAINT [PK_加入收藏] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_location]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_location](
	[event_location_id] [int] IDENTITY(1,1) NOT NULL,
	[event_location_name] [nvarchar](50) NULL,
	[event_location_image] [nvarchar](50) NULL,
	[event_location_info] [nvarchar](max) NULL,
	[event_location_address] [nvarchar](50) NULL,
	[event_location_isstate] [bit] NULL,
 CONSTRAINT [PK_活動地點] PRIMARY KEY CLUSTERED 
(
	[event_location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[event_type]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[event_type](
	[event_type_id] [int] IDENTITY(1,1) NOT NULL,
	[event_type_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_活動分類] PRIMARY KEY CLUSTERED 
(
	[event_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_form]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_form](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[number_id] [int] NULL,
	[commodity_id] [int] NULL,
	[order_time] [nvarchar](50) NULL,
	[quantity_order] [int] NULL,
	[isState] [bit] NULL,
	[isCart] [bit] NULL,
 CONSTRAINT [PK_order_form] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_main]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_main](
	[id] [int] NOT NULL,
	[shopping_id] [int] NULL,
	[order_form] [int] NULL,
	[member_id] [int] NULL,
 CONSTRAINT [PK_訂單主表] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[seat]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[seat](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NULL,
	[area] [nvarchar](50) NULL,
	[seat_id] [int] NULL,
	[price] [money] NULL,
	[is_available] [bit] NULL,
 CONSTRAINT [PK_seat] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[seat_price]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[seat_price](
	[seat_type_id] [int] IDENTITY(1,1) NOT NULL,
	[seat_price] [int] NULL,
 CONSTRAINT [PK_座位價格] PRIMARY KEY CLUSTERED 
(
	[seat_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[seat_stock]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[seat_stock](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NOT NULL,
	[area] [nvarchar](50) NULL,
	[quantity] [int] NULL,
	[stock] [int] NULL,
	[sold] [int] NULL,
	[price] [money] NULL,
	[is_available] [bit] NULL,
 CONSTRAINT [PK_seat_count] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket_order]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket_order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[order_total_price] [money] NULL,
	[order_create_timestamp] [nvarchar](100) NULL,
	[order_update_timestamp] [nvarchar](100) NULL,
	[order_update_id] [int] NULL,
	[order_state] [int] NULL,
	[customer_id] [int] NULL,
 CONSTRAINT [PK_ticket_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ticket_order_detail]    Script Date: 2023/4/7 12:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ticket_order_detail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[event_id] [int] NULL,
	[area] [nvarchar](50) NULL,
	[seat_id] [int] NULL,
	[customer_id] [int] NULL,
 CONSTRAINT [PK_ticket_order_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[administrators] ON 

INSERT [dbo].[administrators] ([administrator_id], [administrator_account], [administrator_password], [administrator_creat_timestamp], [administrator_update_timestamp]) VALUES (1, N'aaa', N'222', N'2023-02-03 上午 09:33:25', N'2023-02-03 上午 09:33:25')
INSERT [dbo].[administrators] ([administrator_id], [administrator_account], [administrator_password], [administrator_creat_timestamp], [administrator_update_timestamp]) VALUES (2, N'admin', N'111', N'2023-02-03 上午 09:33:25', N'2023-02-03 上午 09:33:25')
INSERT [dbo].[administrators] ([administrator_id], [administrator_account], [administrator_password], [administrator_creat_timestamp], [administrator_update_timestamp]) VALUES (3, N'abc', N'123', N'2023-02-03 上午 09:33:25', N'2023-02-03 上午 09:33:25')
SET IDENTITY_INSERT [dbo].[administrators] OFF
GO
SET IDENTITY_INSERT [dbo].[advertisement] ON 

INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1, 1, N'詩意之夜', N'29a38753-bab9-40b9-b219-daa6acbbe309.jpg                                                            ', N'1                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 1, 12, 1)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1001, 2, N'藝術交流會', N'7e4a18ba-2183-4b4b-abe5-0d040ba6db44.jpg                                                            ', N'2                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 2, 30, 1)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1002, 3, N'現代詩歌朗讀會', N'bf151f11-c52d-42a4-bb93-ab6a47a426f1.jpg                                                            ', N'3                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 3, 10, 1)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1003, 4, N'靈感筆記本分享會', N'e4ba3e77-1ef4-4ddf-b541-78c80dc84536.jpg                                                            ', N'4                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 4, 24, 0)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1004, 5, N'藝術家工作坊', N'9d286da0-c209-495c-900a-be47fec4d720.jpg                                                            ', N'5                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 5, 29, 1)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1005, 6, N'散文詩分享會', N'fac8901b-6f05-4acb-93be-26af19b535ea.jpg                                                            ', N'6                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 6, 6, 0)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1006, 7, N'詩人作品展覽', N'ee83a5a0-5ddb-438d-aecc-f955537bda86.jpg                                                            ', N'7                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 7, 7, 0)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1007, 8, N'人文講座系列', N'5732414c-d626-4f4a-8c61-4a2f5f1ccdfc.jpg                                                            ', N'8                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 8, 7, 1)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1008, 9, N'創作工作坊', N'13672e07-1658-496b-b6b6-b767b1c83d86.jpg                                                            ', N'9                                                                                                   ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 9, 9, 0)
INSERT [dbo].[advertisement] ([id], [advertisement_id], [advertisement_name], [advertisement_src], [advertisement_alt], [advertisement_href], [advertisement_startdate], [advertisement_enddate], [company_id], [event_id], [advertisement_online]) VALUES (1009, 10, N'電影觀摩與座談會', N'1d775d1c-7480-4523-a391-1c8b701ee272.jpg                                                            ', N'10                                                                                                  ', N'http://1@1.com                                                                                      ', N'2023-03-10', N'2023-06-20', 10, 12, 1)
SET IDENTITY_INSERT [dbo].[advertisement] OFF
GO
INSERT [dbo].[announcement] ([aid], [announcement_type], [content_title], [content_time], [content], [details_id]) VALUES (1, N'系統公告', N'系統維護公告', N'2023-03-20', N'因系統進行升級維護，聞意青年網站購票、全家購票及取票將於 2023/3/26 (日)、3/28 (二) 06:00 ~ 07:00 暫停服務，若提早維護完畢將直接開啟所有服務功能，造成不便敬請見諒
', NULL)
INSERT [dbo].[announcement] ([aid], [announcement_type], [content_title], [content_time], [content], [details_id]) VALUES (2, N'系統公告', N'預防詐騙提醒', N'2022-02-03', N'聞意售票系統預防詐騙提醒 ＊ 近日詐騙集團猖獗, 假借各大購物網站(通常是大陸口音)名義, 並竄改來電顯示偽裝成該公司或銀行的電話號碼, 
以慣用伎倆佯稱訂單轉帳,授權,分期,送貨簽收,結賬,等錯誤問題, 恐嚇會被連續扣款, 若不從, 歹徒就再恐嚇, 這表示自動放棄權益, 並有錄音存證等語,
 然後再假藉銀行人員或警察再打來(同樣竄改來電顯示), 要求到ATM提款機取消連續扣款設定..等語, 實際卻是可惡的轉帳詐騙手法, 請大家小心提防
', NULL)
INSERT [dbo].[announcement] ([aid], [announcement_type], [content_title], [content_time], [content], [details_id]) VALUES (3, N'系統公告', N'營業時間公告', N'2023-03-28', N'112年兒童節與民族掃墓節(清明節)假期自04月01日(六)至04月05日(三)，共計五日，電話客服及線上客服亦暫停。如需辦理相關業務，請於04月06日(四)上班時間再行前往。造成您的不便，敬請見諒，謝謝您！
', NULL)
GO
SET IDENTITY_INSERT [dbo].[commodity] ON 

INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (1, N'光之影海洋展-經典背袋(深藍)', N'◎魔術大空間，裝下你的一天所需用品\\n◎精緻印刷，安心使用不掉色\\n◎高強度耐磨帆布，堅固耐操功能十足\\n◎材質：高強度耐磨帆布\\n◎尺寸：35X39 cm', 500, 590.0000, N'f64e1626-8f57-47c2-86f6-9ee2a331b071.png', N'2022/1/19 上午 09:59:05', 999, 10, N'禮物', 0)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (2, N'藝術自動折傘-光之影海洋展', N'◎尺寸｜23吋大傘面；收納時全長28公分//n◎傘架｜實心支架、防風抗斷//n◎傘骨｜8K玻璃纖維傘骨，更強韌、更有彈性，抗風加倍//n◎傘布｜雙層黑膠傘布、多塗層工藝布色牢、高效防潑、甩即瞬乾、不透光可抗紫外線、降溫8度可達防曬率99.9%', 99, 790.0000, N'2cf3876f-a1b5-4fd8-9db0-7223ceffa73b.png', N'2019/10/23 上午 09:59:05', 500, 5, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (3, N'光之影海洋展-經典背袋(白)', N'◎魔術大空間，裝下你的一天所需用品\\n◎精緻印刷，安心使用不掉色\\n◎高強度耐磨帆布，堅固耐操功能十足\\n◎材質：高強度耐磨帆布\\n◎尺寸：35X39 cm', 15, 590.0000, N'fe91ddb4-7645-4c3f-92be-f2afc920cdfc.png', N'2017/12/3 上午 09:59:05', 800, 9, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (4, N'米開朗基羅創世紀馬克杯', N'◎精緻馬克杯 加９元送同款杯墊\\n◎大容量420cc 台灣製造品質保證\\n◎任選兩款 還能湊免運喔！\\n◎此商品屬易碎品，出貨時會用氣泡紙包裝，請留意', 30, 399.0000, N'ba26f42c-7444-4e15-8916-b4302f1e2d10.png', N'2023/1/3 上午 09:59:05', 200, 7, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (5, N'藝術陶瓷鍋墊-米開朗基羅(創世紀)', N'◎材質｜陶瓷、軟木//n◎尺寸｜20*20cm', 999, 390.0000, N'8293237b-eaa4-43dc-b25d-2dac968ab6e4.png', N'2023/2/3 上午 09:59:05', 100, 6, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (8, N'文藝復興經典背袋-米開朗基羅(德爾菲女先知)', N'文藝復興《女先知》托特背袋，名畫在帆布面料突顯下，逼真如畫布質感，風格獨特，輕鬆穿搭！\\n◎材質：高強度耐磨帆布\\n◎尺寸：35X39 cm\\n◎多道加工手續紡織、染色、上漿，色牢度佳\\n◎環保，手感溫潤，厚實耐磨耐用\\n◎可肩背、手提，貼心內袋設計、方便使用\\n◎大容量，可放入A4尺寸以上物品', 30, 590.0000, N'24154d73-d24a-43d2-813e-1b380b77505f.png', N'2023/2/10 下午 01:06:29', 800, 7, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (9, N'文藝復興藝術圍裙-米開朗基羅(德爾菲女先知)', N'文藝復興《女先知》托特背袋，名畫在帆布面料突顯下，逼真如畫布質感，風格獨特，輕鬆穿搭！\\n◎材質：高強度耐磨帆布\\n◎尺寸：35X39 cm\\n◎多道加工手續紡織、染色、上漿，色牢度佳\\n◎環保，手感溫潤，厚實耐磨耐用\\n◎可肩背、手提，貼心內袋設計、方便使用\\n◎大容量，可放入A4尺寸以上物品', 30, 590.0000, N'21e4ef0e-b367-40eb-aba5-1563074f0a3a.png', N'2023/2/10 下午 01:06:29', 800, 25, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (10, N'文藝復興滑鼠墊-波提且利(年輕女子)', N'◎尺寸｜約60x30cm \\n◎厚度｜約0.4cm\\n◎材質｜超細纖維白布面x天然橡膠底\\n◎用途｜滑鼠墊、餐墊', 30, 399.0000, N'cde074b0-c2ee-47f5-b6b5-ddfe10b07c8e.png', N'2023/2/10 下午 01:06:29', 800, 31, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (11, N'文藝復興大絲巾-拉斐爾(雅典學院)', N'◎文藝復興名畫絲巾《雅典學院》\\n◎此款文藝復興名畫絲巾以拉斐爾代表作《雅典學院》為設計\\n◎典雅獨特，質感佳、實用百搭，何不讓它為自己的日常造型增添一抹亮點！\\n◎畫作故事：拉斐爾的《雅典學院》以彩繪拱門為框架，描繪了古典時代最重要的哲學家、藝術家和科學家。在一座虛構的古典建築內，藉由完美的透視相互對話，象徵著文藝復興全盛期的精神，表現出篤信人類智慧的和諧，並讚美西方文明的結晶。畫作最右側戴著黑色帽子的是拉斐爾自畫像。\\n◎尺寸｜約90x90cm \\n◎材質｜100% 純蠶絲', 30, 2980.0000, N'4158a6bb-37b0-4584-92d8-3fb2202ab37e.png', N'2023/2/10 下午 01:06:29', 800, 55, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (12, N'文藝復興大絲巾-拉斐爾(雅典學院)', N'◎文藝復興名畫絲巾《雅典學院》\\n◎此款文藝復興名畫絲巾以拉斐爾代表作《雅典學院》為設計\\n◎典雅獨特，質感佳、實用百搭，何不讓它為自己的日常造型增添一抹亮點！\\n◎畫作故事：拉斐爾的《雅典學院》以彩繪拱門為框架，描繪了古典時代最重要的哲學家、藝術家和科學家。在一座虛構的古典建築內，藉由完美的透視相互對話，象徵著文藝復興全盛期的精神，表現出篤信人類智慧的和諧，並讚美西方文明的結晶。畫作最右側戴著黑色帽子的是拉斐爾自畫像。\\n◎尺寸｜約90x90cm \\n◎材質｜100% 純蠶絲', 30, 2980.0000, N'9e43dd29-4d3e-4a8b-9da3-7a347aee72f7.png', N'2023/2/10 下午 01:06:29', 800, 15, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (13, N'文藝復興點心杯盤組-波提且利(維納斯的誕生)', N'◎文藝復興藝術板夾系列，精選大師畫作，◎以梅杜莎的大膽、蒙娜麗莎的神祕、◎拉斐爾的甜美天使、維納斯的誕生神話、\\n◎聖經的創造亞當，低調又優雅的融入日常，\\n◎板夾固定住的不僅是文件，\\n◎是定格了您對美的感受瞬間，然後等待釋放的那時刻。\\n◎板夾好固定，不易掉落，沒有桌子時也能平穩書寫，便利又實用。', 30, 280.0000, N'73e343fc-354c-4654-b794-60f5c1e61aa5.png', N'2023/2/10 下午 01:06:29', 800, 10, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (14, N'藝術磁扣托特包(百花大教堂)', N'◎材質：１００％聚脂纖維\\n◎尺寸：37X37x9 cm\\n◎多道加工手續紡織、染色、上漿，色牢度佳\\n◎環保，手感溫潤，厚實耐磨耐用\\n◎可肩背、手提，貼心內袋設計、方便使用\\n◎大容量，可放入A4尺寸以上物品', 30, 790.0000, N'576e3180-16d0-4f21-91c6-7b724c666282.png', N'2023/2/10 下午 01:06:29', 800, 5, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (17, N'莫內-日本橋＋梵谷-星夜(保溫瓶)', N'藝術名畫結合保溫杯，拿著名畫杯子欣賞精緻名畫，舉放之間，享受在生活中欣賞藝術的幸福感\\n◎長x寬x高：6.0x6.4x22.6 cm(約)\\n◎重量：230g(約)\\n◎500ML 超大容量：手搖飲、咖啡都輕鬆外帶\\n◎３０４不鏽鋼：不沾色．不卡味，各式飲品都能裝\\n◎可拆式配件：清洗便利、延長使用壽命\\n◎保溫8小時↑ 隨時享受溫熱風味', 50, 990.0000, N'50c15c6d-e396-4405-aa42-2cef20dbcd75.png', N'2023/2/10 下午 01:06:29', 50, 9, N'禮物', 1)
INSERT [dbo].[commodity] ([id], [commodity_name], [commodity_narrative], [commodity_num], [commodity_price], [commodity_image], [commodity_start], [commodity_sort], [commodity_sale], [commodity_Classification], [commodity_state]) VALUES (18, N'莫內-睡蓮和柳樹＋日本橋', N'◎材質：高強度耐磨帆布//n◎尺寸：37X37x9 cm//n◎多道加工手續紡織、染色、上漿，色牢度佳//n◎環保，手感溫潤，厚實耐磨耐用//n◎可肩背、手提，貼心內袋設計、方便使用//n◎大容量，可放入A4尺寸以上物品', 25, 790.0000, N'90bf6468-f141-4fd9-9e54-3cffcf57e53d.png', N'2023/2/10 下午 01:06:29', 145, 47, N'禮物', 1)
SET IDENTITY_INSERT [dbo].[commodity] OFF
GO
SET IDENTITY_INSERT [dbo].[company] ON 

INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1, 1, N'星光影業                                              ', N'02-35853109                                       ', N'台北市                                               ', N'bigcompany@gmail.com                              ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1001, 2, N'藍海媒體                                              ', N'02-80172217                                       ', N'台北市大同區延平北路二段16巷29號                                ', N'bsw93300@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1002, 3, N'無盡製作                                              ', N'07-9725181                                        ', N'高雄市鼓山區西藏街112巷23號                                  ', N'eti14078@nezid.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1003, 4, N'紅毯工作室                                             ', N'02-85273681                                       ', N'新北市新莊區建中街109號                                     ', N'ggm20880@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1004, 5, N'電力太陽媒體                                            ', N'07-9703058                                        ', N'高雄市旗津區廟前路27巷9號1樓                                  ', N'ela76166@zslsz.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1005, 6, N'燦爛娛樂
                                            ', N'03-9344366                                        ', N'宜蘭縣大同鄉泰雅路七段53巷1號                                  ', N'wjo99353@nezid.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1006, 7, N'黃金時段電影                                            ', N'02-30536523                                       ', N'新北市板橋區英士路219號                                     ', N'ofb33032@zslsz.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1007, 8, N'閃耀媒體集團                                            ', N'07-9383670                                        ', N'高雄市小港區港平路74巷15號                                   ', N'pgg21838@zslsz.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1008, 9, N'神秘河製片公司                                           ', N'02-78126158                                       ', N'台北市士林區重慶北路四段63巷19號                                ', N'xfv97778@nezid.com                                ', NULL)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1009, 10, N'白金電影                                              ', N'03-4505237                                        ', N'桃園市中壢區元化路225號                                     ', N'tdq44324@nezid.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1010, 11, N'華瑞天才經紀公司                                          ', N'08-8086058                                        ', N'屏東縣恆春鎮墾丁路176巷23號                                  ', N'knALKtkoa3@163.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1011, 12, N'快樂時光製作公司                                          ', N'02-88522213                                       ', N'新北市三峽區正義街223號                                     ', N'zao06765@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1012, 13, N'海洋媒體集團                                            ', N'02-80544572                                       ', N'台北市信義區松山路91號                                      ', N'G8oKuYysC3Jk@163.com                              ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1013, 14, N'午夜魔法工作室                                           ', N'04-96490086                                       ', N'台中市神岡區大富路193巷17號4樓                                ', N'wcf54656@zslsz.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1014, 15, N'星級娛樂公司                                            ', N'07-9530595                                        ', N'高雄市鳳山區過勇路197號                                     ', N'bsj23558@zslsz.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1015, 16, N'瑪奇媒體                                              ', N'02-68962565                                       ', N'台北市大安區敦化南路二段114號                                  ', N'qtu93375@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1016, 17, N'群星文化                                              ', N'02-51443838                                       ', N'台北市大同區庫倫街287號                                     ', N'sjr30223@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1017, 18, N'星空影視                                              ', N'03-9979953                                        ', N'宜蘭縣蘇澳鎮福德路207號                                     ', N'mej71478@zslsz.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1018, 19, N'藍天影業                                              ', N'04-8909425                                        ', N'彰化縣大村鄉大溪路7巷5號                                     ', N'jnz84280@nezid.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1019, 20, N'色彩創意                                              ', N'02-81141009                                       ', N'新北市三重區大同南路173號                                    ', N'yng06175@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1020, 21, N'娛樂大亨公司                                            ', N'02-50352499                                       ', N'新北市樹林區文化街133巷16號                                  ', N'mtg27555@omeie.com                                ', 1)
INSERT [dbo].[company] ([id], [company_id], [company_name], [company_phone], [company_address], [company_email], [company_online]) VALUES (1021, NULL, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[company] OFF
GO
SET IDENTITY_INSERT [dbo].[contactPerson] ON 

INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (1, N'蔡姝美                                               ', N'行銷專員                                              ', N'0954295680                                        ', N'hemsworth2935@outlook.com                         ', 1, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (2, N'朱泓泰                                               ', N'品牌經理                                              ', N'0930894692                                        ', N'paul1798@gmail.com                                ', 2, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (3, N'張東然                                               ', N'社群媒體專員                                            ', N'0939432982                                        ', N'rogers2970@yahoo.com                              ', 3, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (4, N'林照語                                               ', N'市場推廣經理                                            ', N'0919266246                                        ', N'paul5309@outlook.com                              ', 4, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (5, N'徐實豐                                               ', N'行銷專員                                              ', N'0917543110                                        ', N'fowles3393@hotmail.com                            ', 5, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (6, N'宋嬈怡                                               ', N'客戶關係經理                                            ', N'0939168159                                        ', N'nolan9038@icloud.com                              ', 6, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (7, N'金忠陣                                               ', N'社群媒體專員                                            ', N'0987221173                                        ', N'stefan2054@outlook.com                            ', 7, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (8, N'許水蓁                                               ', N'行銷專員                                              ', N'0916480727                                        ', N'carl1312@outlook.com                              ', 8, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (9, N'曹文祺                                               ', N'創意總監                                              ', N'0916300547                                        ', N'kudrow7865@gmail.com                              ', 9, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (10, N'白心竹                                               ', N'品牌經理                                              ', N'0986250230                                        ', N'diane2172@outlook.com                             ', 10, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (11, N'藍婷媗                                               ', N'行銷專員                                              ', N'0926957848                                        ', N'baker9732@gmail.com                               ', 11, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (12, N'巫嬌惠                                               ', N'品牌經理                                              ', N'0912672201                                        ', N'adrian9023@gmail.com                              ', 12, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (13, N'藍舒麗                                               ', N'行銷活動企劃師                                           ', N'0922311511                                        ', N'arnold4915@outlook.com                            ', 13, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (14, N'王召英                                               ', N'消費者行銷經理                                           ', N'0935082650                                        ', N'murphy216@icloud.com                              ', 14, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (15, N'王嵐漢                                               ', N'行銷策略師                                             ', N'0915700025                                        ', N'annabella5404@gmail.com                           ', 15, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (16, N'蘇琦竹                                               ', N'行銷策略師                                             ', N'0913800309                                        ', N'jocelyn6724@yahoo.com                             ', 16, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (17, N'張福禧                                               ', N'品牌經理                                              ', N'0982361170                                        ', N'paige9570@gmail.com                               ', 17, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (18, N'董倩詩                                               ', N'數位行銷經理                                            ', N'0956653157                                        ', N'albert5683@yahoo.com                              ', 18, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (19, N'李啟祥                                               ', N'行銷專員                                              ', N'0929942344                                        ', N'christensen9162@gmail.com                         ', 19, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (20, N'童春立                                               ', NULL, N'0970724367                                        ', N'daniel7746@gmail.com                              ', 20, 1)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (21, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (24, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (25, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (27, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[contactPerson] ([id], [contactperson_name], [contactperson_title], [contactperson_phone], [contactperson_email], [company_id], [contactperson_online]) VALUES (28, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[contactPerson] OFF
GO
SET IDENTITY_INSERT [dbo].[customers] ON 

INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1, N'孫怡文', N'ms0355995@gmial.com', N'58Aer#$cd', N'0912-345-678', N'台南市', N'東區林森路135巷54號', N'1992-07-15', N'F', N'2023-02-03 上午 09:23:03', N'2023-03-27 上午 11:48:04')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (2, N'王小明', N'ming@gmail.com', N'12Afe#$f', N'0988-445-117', N'桃園市', N'大園區航站南路9號', N'2008-02-20', N'M', N'2023-02-03 上午 09:23:03', N'2023-03-27 上午 11:48:04')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (3, N'林宜娟', N'yuan@yahoo.com.tw', N'58Aer#$cd', N'0911-223-334', N'台中市', N'北屯區北科路2號 ', N'1998-07-16', N'F', N'2023-02-03 下午 04:15:27', N'2023/3/13 上午 10:56:24')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (4, N'陳宜君', N'lee@hotmail.com', N'67Jlm#$dg', N'0963-222-333', N'台南市', N'南區忠孝路二段23號 ', N'1995-03-14', N'F', N'2023/3/8 下午 02:19:51', N'2023-03-27 上午 11:51:16')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (10, N'陳宜珊', N'chang@hotmail.com', N'09Nde#$bf', N'0958-444-555', N'台中市', N'南區建國南路一段89號 ', N'1991-04-12', N'F', N'2023/3/8 下午 04:06:13', N'2023-03-27 上午 11:52:15')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (12, N'林大同', N'tongtong@yahoo.com', N'23Gh$%^d', N'0925-678-432', N'新北市', N'板橋區文化路2號 ', N'1987-06-24', N'F', N'2023/3/8 下午 04:06:13', N'2023-03-27 下午 13:46:38')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (13, N'陳小美', N'meimei@gmail.com', N'78Hf&^fg', N'0981-445-669', N'台南市', N'北區公園路1號', N'2008-02-09', N'F', N'2023/3/9 下午 02:23:54', N'2023-03-27 上午 11:54:20')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (14, N'張正偉', N'zhengwei@gmail.com', N'45Uj#^%d', N'0977-123-456', N'新竹市', N'東區中華路1號', N'1979-07-12', N'M', N'2023/3/9 下午 02:28:56', N'2023-03-27 上午 11:55:28')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (15, N'蔡思婷', N'sting@yahoo.com', N'67Yt&^%g', N'0911-234-567', N'台中市', N'南區建國北路1號', N'1996-06-11', N'F', N'2023/3/9 下午 02:29:39', N'2023-03-27 上午 11:56:55')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (16, N'陳志遠', N'zhiyuan@gmail.com', N'90Kl&^%t', N'0933-333-333', N'台北市', N'中正區忠孝東路1號 ', N'1987-03-29', N'M', N'2023/3/10 下午 01:13:06', N'2023-03-27 上午 11:57:48')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1016, N'王宜欣', N'wang@yahoo.com.tw', N'56Sdf#$gh', N'0923-555-666', N'高雄市', N'左營區大中一路1號 ', N'1983-09-15', N'F', N'2023-03-27 下午 13:46:09', N'2023-03-27 下午 13:46:09')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1017, N'李佳蓉', N'jarong@hotmail.com', N'56Qw@#$e', N'0968-123-456', N'高雄市', N'前鎮區明華路17號 ', N'2004-12-24', N'F', N'2023-03-27 下午 13:49:34', N'2023-03-27 下午 13:49:34')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1018, N'李明明', N'mingming@yahoo.com', N'12Qw%$fg', N'0977-987-654', N'新北市', N'三峽區民權路1號 ', N'1988-12-07', N'M', N'2023-03-27 下午 13:50:35', N'2023-03-27 下午 13:50:35')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1019, N'葉怡萱', N'yixuan@gmail.com', N'34Zx&^%w', N'0928-456-789', N'台中市', N'北區三民路2號', N'1976-06-16', N'F', N'2023-03-27 下午 13:51:41', N'2023-03-27 下午 13:51:41')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1020, N'李小華', N'xiaohua@yahoo.com', N'23Pq$%^r', N'0988-456-789', N'台中市', N'南區建國南路1號', N'1991-10-03', N'M', N'2023-03-27 下午 13:53:38', N'2023-03-27 下午 13:53:38')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1021, N'林宜芳', N'lin@yahoo.com.tw', N'67Hjk#$lo', N'0981-777-888', N'台中市', N'北區建國北路二段31號', N'1992-05-16', N'F', N'2023-03-27 下午 13:55:15', N'2023-03-27 下午 13:55:15')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1022, N'李建宏', N'jianhong@hotmail.com', N'56Xc$%^r', N'0966-234-567', N'台南市', N'北區公園路3號', N'1986-02-15', N'M', N'2023-03-27 下午 13:56:04', N'2023-03-27 下午 13:56:04')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1023, N'陳怡婷', N'yiting@yahoo.com', N'78Jk&^%s', N'0968-876-543', N'桃園市', N'中壢區民族路1號', N'1989-07-31', N'F', N'2023-03-27 下午 13:57:23', N'2023-03-27 下午 13:57:23')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1024, N'張文彬', N'wenbin@yahoo.com', N'45Ty%$gh', N'0987-456-789', N'台北市', N'大安區羅斯福路1號', N'1985-03-03', N'M', N'2023-03-27 下午 14:00:06', N'2023-03-27 下午 14:00:06')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1025, N'張雅琪', N'yachi@yahoo.com', N'12Vb&^%f', N'0912-567-890', N'台中市', N'南區公益路3號', N'1990-08-08', N'F', N'2023-03-27 下午 14:00:54', N'2023-03-27 下午 14:00:54')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1026, N'丁俊安', N'123456789@gmail.com', N'aaaa.1234', N'0912-345-677', N'台北市', N'南區公益路3號', N'2023-03-20T16:00:00.000Z', N'M', N'2023/3/28 下午 01:54:16', N'2023/3/28 下午 01:54:16')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1027, N'程序員', N'111@111.com', N'123456@Abc', N'0900-000-000', N'宜蘭縣', N'123', N'2023-03-29', N'F', N'2023-03-29 上午 10:39:32', N'2023-03-29 上午 10:39:32')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1028, N'王大明', N'ming1@gmail.com', N'12Afe#$f', N'0911-666-999', N'新北市', N'大園區航站南路9號', N'2008-02-20', N'男', N'2023/3/29 11:29:28', N'2023/3/29 11:29:29')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1029, N'王大明', N'ming2@gmail.com', N'12Afe#$f', N'0977-333-666', N'新竹市', N'大園區航站南路9號', N'2008-02-20', N'男', N'2023/3/29 11:35:55', N'2023/3/29 11:35:55')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1030, N'王大明', N'ming4@gmail.com', N'12Afe#$f', N'0974-999-666', N'新竹市', N'大園區航站南路9號', N'2008-02-20', N'女', N'2023/3/29 11:39:10', N'2023/3/29 11:39:10')
INSERT [dbo].[customers] ([customer_id], [customer_name], [customer_email], [customer_password], [customer_phone], [customer_region], [customer_address], [customer_birth_date], [customer_gender], [customer_creat_timestamp], [customer_update_timestamp]) VALUES (1031, N'王小月', N'moon@gmail.com', N'12Afe#$f', N'0977-999-666', N'台北市', N'大園區航站南路9號', N'2008-02-20', N'女', N'2023/3/29 11:42:27', N'2023/3/29 11:42:27')
SET IDENTITY_INSERT [dbo].[customers] OFF
GO
INSERT [dbo].[details] ([details_id], [eventtime], [event_id], [state], [reason]) VALUES (1, N'2022-09-21', 3, N'延期', N'尊敬的顧客您好，

非常感謝您對我們活動的關注和支持。由於最近的疫情和天氣情況，我們不得不延期原定於本週舉行的活動，以確保所有參與者的健康和安全。

我們深感抱歉，這個決定將對您造成不便。我們非常重視您的參與，因此我們會盡力安排一個更加優質的活動，以補償您的等待和支持。

我們將盡快宣布活動的新日期，並在適當的時間內提供更多詳細信息。如果您有任何疑問或需要進一步的協助，請隨時與我們聯繫，我們的團隊將竭誠為您服務。

再次感謝您的支持和理解。希望您和您的家人和朋友保持健康和安全。')
INSERT [dbo].[details] ([details_id], [eventtime], [event_id], [state], [reason]) VALUES (2, N'2023-02-02', 1, N'延期', N'親愛的朋友們，

我們很抱歉地通知大家，原定於本週末舉行的活動將會延期。這個決定並不是我們輕易做出的，但我們認為這是必要的，因為表演者在排練中受傷了。

我們非常感謝所有人的支持和熱情參與，我們知道很多人已經期待著這次的活動。但是，在這個情況下，我們必須為表演者的健康和安全負責任。

我們正在努力安排一個新的日期，讓這次活動能夠順利舉行。我們將盡快公佈新的日期和時間，以及如何退換票的詳細信息。

我們深刻理解這個消息對於已經購票並且打算參加這次活動的朋友們所造成的不便和失望。我們希望您能夠理解，我們所做的一切都是為了確保這次活動的成功和所有參與者的安全。

感謝您的耐心和支持，我們期待在不久的將來與您再次相見。

活動籌備團隊')
INSERT [dbo].[details] ([details_id], [eventtime], [event_id], [state], [reason]) VALUES (3, N'2022-04-15', 2, N'取消', N'很抱歉地通知大家，由於未能預料到的情況，原定於本月舉行的活動已經被取消。我們對造成的不便深表歉意，並希望您能理解我們的決定。

我們將盡快與您聯繫，以安排相關的退款事宜。如果您有任何疑問或需要進一步的說明，請隨時聯繫我們的客戶服務部門。再次感謝您對我們活動的支持和理解。')
INSERT [dbo].[details] ([details_id], [eventtime], [event_id], [state], [reason]) VALUES (4, N'2202-10-26', 4, N'延期', N'尊敬的各位活動參加者：

感謝您們對本次活動的支持與參與，由於不可抗力的因素，我們很遺憾地宣布本次活動的日期將延期至另行通知。我們深感抱歉，給您帶來的任何不便，請您諒解。

在過去的幾個月中，全球發生了很多不可預見的事件，這些事件對我們的生活和工作產生了重大的影響。為了確保參加者的安全和健康，我們必須決定延期活動的舉辦日期。

我們正在積極與場地合作夥伴和其他相關方進行協商，以確定新的活動日期和相關安排。一旦我們確認了新的日期和時間，我們將立即通知您。請留意我們的官方網站和社交媒體平台上的最新消息。

我們非常感謝您對本次活動的熱情參與和支持，我們相信，在我們共同的努力下，我們將能夠再次成功舉辦這次活動，為大家帶來更多的歡樂和收穫。

如果您有任何疑問或需要進一步的協助，請隨時聯繫我們的活動組織者，我們將竭誠為您提供幫助和支持。

再次感謝您的支持和理解。')
INSERT [dbo].[details] ([details_id], [eventtime], [event_id], [state], [reason]) VALUES (5, N'2021-12-10', 5, N'取消', N'原定於本週末舉行的「夏日音樂派對」活動因故取消。我們深感遺憾，因為這場活動是我們與您們一同精心策劃的，但由於疫情的影響和其他不可預見的因素，我們不得不做出這個艱難的決定。

我們感謝您對這場活動的關注和支持，我們深深地感激您們一直以來的支持和信任。我們了解您對這場活動的期望和期待，我們也深感遺憾，無法如期舉辦這場活動。

我們將會全力儘快退還您的活動門票費用，您將在接下來的數個工作日內收到退款，如果您有任何問題或疑慮，請隨時聯繫我們的客戶服務中心，我們將竭誠為您解決問題。

再次向您致以最誠摯的歉意，我們深感抱歉，讓您們受到了不便。我們期待著下一次能夠和您一同舉辦一個更加精彩的活動，謝謝。')
GO
SET IDENTITY_INSERT [dbo].[evaluation_form] ON 

INSERT [dbo].[evaluation_form] ([id], [commodity_id], [number_id], [rate], [evaluation_time], [isstate]) VALUES (1, 1, 2, 4, NULL, 1)
INSERT [dbo].[evaluation_form] ([id], [commodity_id], [number_id], [rate], [evaluation_time], [isstate]) VALUES (2, 1, 3, 3, NULL, 1)
SET IDENTITY_INSERT [dbo].[evaluation_form] OFF
GO
SET IDENTITY_INSERT [dbo].[event] ON 

INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (1, N'9e609ffa-b73e-43eb-a886-a34ae788e587.jpg', N'The Band', N'起源於美國的南部地區。搖滾樂的特點是節奏強烈、旋律流暢、吉他獨奏和激情演唱。這種音樂風格從誕生到現在，已經發展出了各種各樣的風格和次風格，其中包括硬式搖滾、藍調搖滾、龐克搖滾、重金屬搖滾等等。 ', 1, N'2023/3/23 19:00:00', N'2023/4/28 19:00:00', N'2023/4/13 19:00:00', N'2023/4/26 19:00:00', 1, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (2, N'd4958166-b3f4-44ce-ad62-5f98a64b2e66.jpg', N'Friday', N'Friday，翻譯為中文就是「星期五」，是一個讓人感到興奮和期待的日子。對於許多人來說，星期五代表著工作或學校的一周即將結束，即將迎來一個放鬆和愉快的週末。', 2, N'2023/1/23 19:00:00', N'2023/1/28 19:00:00', N'2023/1/29 19:00:00', N'2023/1/31 19:00:00', 1, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (3, N'3795cdd6-f6bf-4952-be0c-fac92ac96f4e.jpg', N'Georgia', N'Georgia是美國第13個州，成立於1788年。這個州擁有豐富的歷史和文化，是美國南方的一個重要的州。Georgia擁有許多受歡迎的旅遊景點，包括亞特蘭大市、喬治亞海岸、喬治亞山脈、薩凡納市等等。', 3, N'2023/1/23 19:00:00', N'2023/1/23 19:00:00', N'2023/1/23 19:00:00', N'2023/1/23 22:00:00', 1, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (4, N'317cd0b5-6645-4162-9bc2-76063316114d.jpg', N'gospel concert ', N'A gospel concert is a musical event that features gospel music, a genre of Christian music that originated in African American communities in the United States', 4, N'2023/8/10 19:00:00', N'2023/8/24 19:00:00', N'2023/8/14 19:00:00', N'2023/8/24 19:00:00', 1, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (5, N'ad080c9f-cf55-4b64-b098-c586519b76be.jpg', N'rock', N'Rock is a genre of popular music that originated in the United States in the 1950s and quickly spread throughout the world. It is characterized by its use of electric guitars, bass guitar, drums, and often keyboards or other instruments, as well as its emphasis on the rhythms and energy of the music.', 5, N'2023/5/16 19:00:00', N'2023/5/31 19:00:00', N'2023/5/30 19:00:00', N'2023/5/31 19:00:00', 1, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (6, N'15be276f-c923-4077-b359-8c14da879400.jpg', N'古典樂會', N'古典音樂是指西方傳統音樂的一種流派，其歷史可以追溯到中世紀。其特點包括嚴謹的樂曲結構、精湛的演奏技巧、優美的旋律和豐富的音樂表現力。', 6, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 2, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (7, N'20305fa1-6485-40ea-a323-017cd980ced0.jpg', N'Piano', N'The piano is a musical instrument that produces sound by striking strings with hammers. It is a keyboard instrument, meaning that the performer presses keys on a keyboard to produce the sound.', 6, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 2, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (8, N'cdd6d4fe-c66e-4091-b0aa-869cce1ca8a2.jpg', N'Drama', N'戲劇是一種藝術形式，通常以演員在舞台上表演的方式呈現。它可以是娛樂性的，也可以是文化性的，有時還可以是教育性的。戲劇通常具有情節、角色和對話，它可以讓觀眾們體驗到各種不同的情感和情感體驗。', 8, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 3, 6, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (9, N'a626c1e4-9c65-481b-b4e2-00fc9e17f3a2.jpg', N'FIFA', N'運動賽事是一種刺激和令人興奮的體驗，它們可以讓運動員展示他們的技能和實力，也可以讓觀眾感受到比賽的緊張和激情。無論是足球、籃球、棒球、田徑、游泳還是其他運動，賽事都是體育精神和運動文化的體現。', 10, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 4, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (10, N'd7cc81da-3a52-4fcf-b1cc-332f66df5453.jpg', N'anime', N'本季度最期待的動畫即將來襲！這部動畫故事情節豐富，充滿懸疑與刺激，讓人捉摸不定。角色們獨具特色，形象鮮明，你一定會喜歡上他們！動畫配樂精彩絕倫，將帶你進入全新的世界，讓你的心情隨之熱血沸騰！還等什麼，趕快搶先觀看預告，為這部動畫瘋狂打Call！', 11, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 5, 5, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (11, N'83ec07a2-5965-4dbb-8ca0-a72ed634ef17.jpg', N'Curry', N'想成為一位出色的廚師？那就參加我們的料理課程吧！我們的課程將教你如何製作各種美食，包括精美的前菜、主菜和甜點。無論你是初學者還是有一定經驗的廚師，我們的課程都將為你提供實用的技巧和知識。', 3, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 6, 6, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (12, N'3ff60402-0c3e-4bde-ac7c-87de632a86fe.jpg', N'旅遊', N'旅遊是一種探索新世界的方式，它可以讓您體驗不同文化、風土人情和美麗風景。無論是在國內還是國外，旅遊都是一種令人愉悅的體驗。', 4, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 7, 4, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (13, N'1bed512c-fe72-4b25-9351-8372cdd8c034.jpg', N'Jazz', N'Jazz is a genre of music that originated in the African American communities of New Orleans, United States, in the late 19th and early 20th centuries. ', 10, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 2, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (14, N'7b82f666-07b6-4f62-b706-cbbd9a2411c4.jpg', N'Violin', N'精彩音樂盛會即將到來！我們誠摯邀請您參加一場非凡的小提琴音樂會。在這場音樂會上，您將有機會聆聽到多位優秀的小提琴家的精彩演出，他們將演奏各種風格的樂曲，包括古典樂、爵士樂、流行樂等，帶給您豐富多樣的音樂體驗。', 7, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 2, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (15, N'd874de4b-3864-470d-9fd7-f6aeae02abb0.jpg', N'Guitar', N'歡迎來到吉他的世界！吉他是一種流行樂器，具有獨特的聲音和優美的外觀。它是一種簡單易學、靈活多變的樂器，不僅適合初學者，也是許多專業音樂人的首選樂器。', 6, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 2, 7, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (16, N'5c9895a6-aed4-4a8b-a5e9-a1680ff03c79.jpg', N'卡門', N'在這部充滿熱情和戲劇性的歌劇中，您將見識到被譽為法國最偉大作曲家之一的比才的才華。由一個激情四溢的愛情故事所驅動，這部歌劇以它的音樂和舞台表演，帶給您一場豐富、感人至深的音樂體驗。', 8, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 3, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (17, N'24a5a377-500e-414d-bf59-fac7af41ccde.jpg', N'波希米亞人', N'這部由威爾第譜曲的歌劇以愛情和友情為主題，敘述了一群年輕人的故事。充滿激情的音樂，配合精彩的舞台設計和表演，將帶給您一場動人心弦的音樂體驗。', 4, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 3, 7, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (18, N'8779d2aa-9596-4658-9dfe-a70dcf2b787e.jpg', N'茶花女', N'由維爾第所譜曲的這部歌劇是一個關於愛、嫉妒和犧牲的故事。在這場充滿熱情的音樂會上，您將享受到優美的旋律和令人驚艷的表演，一定會讓您感受到歌劇的魅力。', 1, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 3, 5, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (19, N'df373d37-40fe-44ae-9c44-30e4b2ffd56b.jpg', N'唐璜', N'作為一部充滿中國特色的歌劇，它的音樂和表演充滿著東方的神秘和魅力。它的故事以唐代的詩人杜甫和李白為背景，描繪了他們的友誼和經歷。在這場歌劇中，您將聆聽到中國古典音樂的精髓，一定會讓您倍感興奮。', 6, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 3, 7, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (20, N'2d51ca58-991a-4659-ba72-9acd48ed8f42.jpg', N'魔笛', N'這部由莫扎特所譜曲的歌劇充滿了神奇和奇幻的元素。故事描述了一個年輕王子的冒險之旅，並充滿了豐富的音樂和優美的旋律。這部歌劇以其獨特的風格和魅力，成為了全球最受歡迎的歌劇之一，您絕對不能錯過。', 2, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 3, 3, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (21, N'5bf1ac42-555b-4ad8-b8d6-73936c674e22.jpg', N'籃球', N'超強對決，精彩無限！來參加我們的籃球賽事，見證最優秀的籃球運動員在球場上的表現。從快速的運球、精準的投籃到驚人的空中接力，每一個瞬間都會讓您目不轉睛。', 8, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 4, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (22, N'9eb52348-a0bd-4eff-8b8b-4e1b525bbec1.jpg', N'Kart', N'快速、激烈、充滿挑戰性！來體驗卡丁車的速度與激情，這是一個既刺激又刺激的體驗。在這裡，您可以與您的朋友或家人競爭，體驗高速行駛的感覺，並感受到您的心臟在加速跳動。', 4, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 4, 4, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (23, N'b5fc05b1-c2ed-4ad3-89e7-66ee8fc99f5d.jpg', N'Ice', N'雪上飛舞的速度與熱情！快來參加我們的冰球比賽，體驗這種充滿活力和激情的運動。從技術高超的運球、犀利的射門到精準的傳球，每一個瞬間都將讓您屏息凝神。', 7, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 4, 4, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (24, N'ac95f18b-99f4-4913-915c-7eba5ab41287.jpg', N'golf', N'精確度與技巧的完美結合！來體驗高爾夫運動，這是一種需要技巧、耐心和精確度的運動。在這裡，您可以享受到美麗的風景和放鬆的氛圍，同時挑戰您的技巧和挑戰力。', 5, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 4, 2, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (25, N'dea5ee4f-38c5-49ff-aa38-ae67c54f22c1.jpg', N'動畫展', N'您最愛的角色現在成真了！來參加我們的動畫展，探索您最喜愛的動畫世界。無論是日本動漫、美國卡通還是歐洲動畫，這裡都有您最愛的角色和場景，讓您可以感受到動畫的真實與美麗。', 9, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 5, 3, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (26, N'a1957cab-a502-4e49-a8e6-fe435fd96958.jpg', N'anime music', N'音樂和動畫的完美結合！來聆聽您最喜愛的動畫音樂，感受音樂帶來的動畫情感。無論是悲傷、浪漫、快樂還是勇敢，這些動畫音樂都可以讓您重新感受到動畫的美麗和情感。', 10, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 5, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (27, N'42d62494-2ccc-4b95-8610-459aedb61212.jpg', N' cosplay ', N'化身成您最喜愛的角色！來參加我們的Cosplay活動，展現您的熱愛和才華。這裡有各種不同風格的Cosplay，讓您可以盡情展現自己的風格和創意。', 4, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 5, 6, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (28, N'3c86bcd8-7e79-42b3-96b3-e35c46a9b974.jpg', N'bake class', N'擁抱烘焙的樂趣！在這個烘焙課程中，您將學習如何製作最美味的甜點和麵包。無論您是初學者還是經驗豐富的烘焙愛好者，這裡的課程都能讓您獲得寶貴的烘焙技能和知識。', 8, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 6, 5, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (29, N'4c256455-6912-4532-a3d3-6d6a7ce1ec18.jpg', N'化妝講座', N'讓您的美麗無限延伸！在這個美妝講座中，您將學習到如何製作最令人驚艷的妝容，從基本的化妝技巧到高級的妝容設計，這裡的課程將讓您獲得寶貴的美妝技巧和知識。', 7, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 6, 1, 1)
INSERT [dbo].[event] ([event_id], [event_image], [event_name], [event_info], [company_id], [event_sell_start_timestamp], [event_sell_end_timestamp], [event_start_timestamp], [event_end_timestamp], [event_type_id], [event_location_id], [event_isstate]) VALUES (30, N'9043bf29-7a30-49f4-9a27-ff87e7e10f85.jpg', N'園藝講座', N'在家打造美麗的花園！在這個園藝課程中，您將學習到如何種植最美麗的花卉和植物，從基本的園藝技巧到高級的植物設計，這裡的課程將讓您獲得寶貴的園藝知識和技巧。', 4, N'2023/4/15 19:00:00', N'2023/4/20 19:00:00', N'2023/3/25 19:00:00', N'2023/4/20 19:00:00', 6, 7, 1)
SET IDENTITY_INSERT [dbo].[event] OFF
GO
SET IDENTITY_INSERT [dbo].[event_collect] ON 

INSERT [dbo].[event_collect] ([id], [event_id], [customer_id]) VALUES (4, 1, 2)
SET IDENTITY_INSERT [dbo].[event_collect] OFF
GO
SET IDENTITY_INSERT [dbo].[event_location] ON 

INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (1, N'國家音樂廳', N'10aa7187-639a-4e52-8840-c8c4ed946645.jpg', N'內有兩個表演空間，分別是採「鞋盒式」設計的音樂廳 ( 2022席，含14個輪椅席）、演奏廳（354席，含4個輪椅席），皆具國際級頂尖音場設計。', N'臺北市中正區中山南路21-1號', 1)
INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (2, N'臺北小巨蛋 ', N'0a1b6a40-a264-478f-8a14-0e52a909474a.jpg', N'臺北小巨蛋是多功能體育館，坐落於南京東路及敦化北路交叉口。除了提供體育競賽場地之外，亦經常舉辦演唱會、頒獎典禮等大型文藝活動，為臺灣娛樂業界的指標場所之一。', N'臺北市松山區南京東路四段2號', 1)
INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (3, N'臺北國際會議中心TICC', N'ab31a9db-16bb-43ea-ac8e-a2bb68e569f1.jpg', N'TICC除了提供工商界租用此建築進行各類型會議與展覽以外，也有設置餐廳及大會堂，是一項多功能的展會建築。', N'台北市信義區信義路五段1號', 1)
INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (4, N'士林官邸公園', N'a2cf5000-17c3-41e6-8d9f-3eb4e26b920d.jpg', N'士林官邸是已故中華民國總統蔣中正在臺灣的官邸之一，位於臺北市士林區，可分為官邸與花園（含士林園藝所）兩部份，花園由台北市政府公燈處園藝管理所管理、官邸正館(正房)由台北市政府文化局管理。', N' 臺灣臺北市士林區福林路60號', 1)
INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (5, N'宏匯廣場', N'f923ca9d-27f6-4951-84eb-4584dc9e621b.jpg', N'擁有3.1萬坪的商場空間，引進400個品牌，影城由美麗新影城營運，並獨家引進日本娛樂品牌，設置日本索尼音樂集團旗下表演場館「Zepp New Taipei」、以及萬代南夢宮控股旗下萬代南夢宮遊藝虛擬實境體驗樂園「VR ZONE NewTaipei」', N'新北市新莊區新北大道四段3號8樓', 1)
INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (6, N'DSpace元動空間', N'c60c2c64-2293-40e5-affd-eae8ead7a29b.jpg', N'開放各類型活動場地租賃：海內外藝人展演活動、粉絲見面會、記者發佈會、歲末尾牙活動等。', N'台北市中山區敬業三路123號8樓', 1)
INSERT [dbo].[event_location] ([event_location_id], [event_location_name], [event_location_image], [event_location_info], [event_location_address], [event_location_isstate]) VALUES (7, N'高雄流行音樂中心 ', N'ae917b55-f0fe-48c3-8a7e-5a7ba9aa515e.jpg', N'主體包括海風廣場、音浪塔（室內大型表演場館）、鯨魚堤岸（6間小型展演空間）、珊瑚礁群（複合商業空間）、海豚步道、渡輪碼頭、和文創市集', N'高雄市高雄港11-15號', 1)
SET IDENTITY_INSERT [dbo].[event_location] OFF
GO
SET IDENTITY_INSERT [dbo].[event_type] ON 

INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (1, N'演唱會')
INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (2, N'音樂會')
INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (3, N'戲劇')
INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (4, N'運動')
INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (5, N'動漫')
INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (6, N'講座')
INSERT [dbo].[event_type] ([event_type_id], [event_type_name]) VALUES (7, N'旅遊')
SET IDENTITY_INSERT [dbo].[event_type] OFF
GO
SET IDENTITY_INSERT [dbo].[order_form] ON 

INSERT [dbo].[order_form] ([id], [number_id], [commodity_id], [order_time], [quantity_order], [isState], [isCart]) VALUES (40, 2, 1, N'2023/3/24 下午 02:15:07', 14, 0, 1)
INSERT [dbo].[order_form] ([id], [number_id], [commodity_id], [order_time], [quantity_order], [isState], [isCart]) VALUES (41, 2, 2, N'2023/3/24 下午 02:17:15', 4, 0, 1)
SET IDENTITY_INSERT [dbo].[order_form] OFF
GO
SET IDENTITY_INSERT [dbo].[seat] ON 

INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (1, 1, N'A', 1, 1000.0000, 0)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (2, 1, N'A', 2, 1000.0000, 0)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (3, 1, N'A', 3, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (4, 1, N'A', 4, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (5, 1, N'A', 5, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (6, 1, N'A', 6, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (7, 1, N'A', 7, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (8, 1, N'A', 8, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (9, 1, N'A', 9, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (10, 1, N'A', 10, 1000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (11, 1, N'B', 1, 1500.0000, 0)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (12, 1, N'B', 2, 1500.0000, 0)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (13, 1, N'B', 3, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (14, 1, N'B', 4, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (15, 1, N'B', 5, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (16, 1, N'B', 6, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (17, 1, N'B', 7, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (18, 1, N'B', 8, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (19, 1, N'B', 9, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (20, 1, N'B', 10, 1500.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (21, 1, N'C', 1, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (22, 1, N'C', 2, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (23, 1, N'C', 3, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (24, 1, N'C', 4, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (25, 1, N'C', 5, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (26, 1, N'C', 6, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (27, 1, N'C', 7, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (28, 1, N'C', 8, 2000.0000, 1)
INSERT [dbo].[seat] ([id], [event_id], [area], [seat_id], [price], [is_available]) VALUES (29, 1, N'C', 9, 2000.0000, 1)
SET IDENTITY_INSERT [dbo].[seat] OFF
GO
SET IDENTITY_INSERT [dbo].[seat_stock] ON 

INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (4, 1, N'搖滾區', 40, 32, 8, 3500.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (5, 1, N'一般區', 50, 42, 8, 2200.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (6, 1, N'站區', 100, 92, 8, 1500.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (7, 2, N'貴賓區', 20, 20, 0, 5500.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (8, 2, N'一般區', 30, 30, 0, 2200.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (9, 2, N'站區', 30, 30, 0, 1500.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (10, 3, N'貴賓A區', 15, 15, 0, 2300.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (11, 3, N'貴賓B區', 20, 20, 0, 2100.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (12, 3, N'貴賓C區', 10, 10, 0, 2200.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (13, 4, N'搖滾區', 40, 40, 0, 3700.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (14, 4, N'一般區', 50, 50, 0, 2600.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (15, 4, N'站區', 100, 100, 0, 1000.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (16, 5, N'搖滾區', 40, 40, 0, 3900.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (17, 5, N'一般區', 50, 50, 0, 2270.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (18, 5, N'站區', 100, 100, 0, 1500.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (19, 6, N'搖滾區', 40, 40, 0, 3339.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (20, 6, N'一般區', 50, 50, 0, 2229.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (21, 6, N'站區', 100, 100, 0, 1119.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (22, 7, N'搖滾區', 40, 40, 0, 3370.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (23, 7, N'一般區', 50, 50, 0, 2150.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (24, 7, N'站區', 100, 100, 0, 1100.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (25, 8, N'搖滾區', 40, 40, 0, 1920.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (26, 8, N'一般區', 50, 50, 0, 1110.0000, 1)
INSERT [dbo].[seat_stock] ([id], [event_id], [area], [quantity], [stock], [sold], [price], [is_available]) VALUES (27, 8, N'站區', 100, 100, 0, 550.0000, 1)
SET IDENTITY_INSERT [dbo].[seat_stock] OFF
GO
SET IDENTITY_INSERT [dbo].[ticket_order] ON 

INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (57, 2023038054, 7200.0000, N'2023/3/29 12:03:10', N'2023/3/29 12:03:10', 0, 0, 1031)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (58, 2023037399, 7200.0000, N'2023/3/29 12:03:24', N'2023/3/29 12:03:24', 0, 0, 1031)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (59, 2023037879, 7200.0000, N'2023/3/29 12:12:12', N'2023/3/29 12:12:12', 0, 2, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (60, 2023033083, 7200.0000, N'2023/3/29 12:12:30', N'2023/3/29 12:12:30', 0, 2, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (61, 2023034466, 7200.0000, N'2023/3/29 12:15:18', N'2023/3/29 12:15:18', 0, 1, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (62, 2023038440, 7200.0000, N'2023/3/29 12:19:17', N'2023/3/29 12:19:17', 0, 1, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (63, 2023038416, 7200.0000, N'2023/3/29 12:22:08', N'2023/3/29 12:22:08', 0, 0, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (64, 2023037372, 7200.0000, N'2023/3/29 12:22:20', N'2023/3/29 12:22:20', 0, 2, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (65, 2023033128, 7200.0000, N'2023/3/29 12:23:48', N'2023/3/29 12:23:48', 0, 1, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (66, 2023038281, 7200.0000, N'2023/3/29 12:28:59', N'2023/3/29 12:28:59', 0, 0, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (67, 2023032053, 7200.0000, N'2023/3/29 12:29:09', N'2023/3/29 12:29:09', 0, 2, 2)
INSERT [dbo].[ticket_order] ([id], [order_id], [order_total_price], [order_create_timestamp], [order_update_timestamp], [order_update_id], [order_state], [customer_id]) VALUES (68, 2023031995, 7200.0000, N'2023/3/29 12:31:34', N'2023/3/29 12:31:34', 0, 1, 2)
SET IDENTITY_INSERT [dbo].[ticket_order] OFF
GO
SET IDENTITY_INSERT [dbo].[ticket_order_detail] ON 

INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (114, 2023038054, 1, N'搖滾區', 1, 1031)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (115, 2023038054, 1, N'一般區', 1, 1031)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (116, 2023038054, 1, N'站區', 1, 1031)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (117, 2023037399, 1, N'搖滾區', 2, 1031)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (118, 2023037399, 1, N'一般區', 2, 1031)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (119, 2023037399, 1, N'站區', 2, 1031)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (126, 2023034466, 1, N'搖滾區', 5, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (127, 2023034466, 1, N'一般區', 5, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (128, 2023034466, 1, N'站區', 5, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (129, 2023038440, 1, N'搖滾區', 6, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (130, 2023038440, 1, N'一般區', 6, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (131, 2023038440, 1, N'站區', 6, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (132, 2023038416, 1, N'搖滾區', 7, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (133, 2023038416, 1, N'一般區', 7, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (134, 2023038416, 1, N'站區', 7, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (138, 2023033128, 1, N'搖滾區', 9, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (139, 2023033128, 1, N'一般區', 9, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (140, 2023033128, 1, N'站區', 9, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (141, 2023038281, 1, N'搖滾區', 10, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (142, 2023038281, 1, N'一般區', 10, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (143, 2023038281, 1, N'站區', 10, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (147, 2023031995, 1, N'搖滾區', 12, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (148, 2023031995, 1, N'一般區', 12, 2)
INSERT [dbo].[ticket_order_detail] ([id], [order_id], [event_id], [area], [seat_id], [customer_id]) VALUES (149, 2023031995, 1, N'站區', 12, 2)
SET IDENTITY_INSERT [dbo].[ticket_order_detail] OFF
GO
USE [master]
GO
ALTER DATABASE [Young-Artists] SET  READ_WRITE 
GO

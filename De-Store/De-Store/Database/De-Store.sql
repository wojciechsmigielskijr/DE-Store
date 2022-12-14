USE [master]
GO
/****** Object:  Database [De-Store]    Script Date: 16/08/2022 00:39:12 ******/
CREATE DATABASE [De-Store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'De-Store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.WOJCIECHSDESK\MSSQL\DATA\De-Store.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'De-Store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.WOJCIECHSDESK\MSSQL\DATA\De-Store_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [De-Store] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [De-Store].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [De-Store] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [De-Store] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [De-Store] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [De-Store] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [De-Store] SET ARITHABORT OFF 
GO
ALTER DATABASE [De-Store] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [De-Store] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [De-Store] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [De-Store] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [De-Store] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [De-Store] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [De-Store] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [De-Store] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [De-Store] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [De-Store] SET  DISABLE_BROKER 
GO
ALTER DATABASE [De-Store] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [De-Store] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [De-Store] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [De-Store] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [De-Store] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [De-Store] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [De-Store] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [De-Store] SET RECOVERY FULL 
GO
ALTER DATABASE [De-Store] SET  MULTI_USER 
GO
ALTER DATABASE [De-Store] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [De-Store] SET DB_CHAINING OFF 
GO
ALTER DATABASE [De-Store] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [De-Store] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [De-Store] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [De-Store] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'De-Store', N'ON'
GO
ALTER DATABASE [De-Store] SET QUERY_STORE = OFF
GO
USE [De-Store]
GO
/****** Object:  Table [dbo].[Config]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config](
	[ConfigSetting] [nvarchar](50) NOT NULL,
	[ConfigValue] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerLoyaltyCards]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerLoyaltyCards](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoyatyCardTypeID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Points] [int] NOT NULL,
	[Revoked] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeaderQuartersOrders]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeaderQuartersOrders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeID] [int] NOT NULL,
	[AmountOrdered] [int] NOT NULL,
	[OrderState] [nvarchar](50) NOT NULL,
	[OrderDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoyaltyCardOffers]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyaltyCardOffers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LoyatyCardID] [int] NOT NULL,
	[LoyaltyCardOfferID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoyaltyCardOfferTypes]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyaltyCardOfferTypes](
	[ID] [int] NOT NULL,
	[OfferType] [nvarchar](50) NOT NULL,
	[OfferDescription] [nvarchar](max) NOT NULL,
	[OfferLoyaltyCost] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoyaltyCards]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyaltyCards](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CardType] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Offers]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OfferType] [nvarchar](50) NOT NULL,
	[OfferDescription] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Offers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductType] [nvarchar](50) NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductCost] [decimal](18, 2) NOT NULL,
	[AvailableToBuy] [bit] NOT NULL,
	[OfferID] [int] NULL,
	[OfferExpiry] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[SaleLocationID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SaleCost] [decimal](18, 0) NULL,
	[CustomerID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 16/08/2022 00:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[Stock] [bigint] NOT NULL,
	[LocationID] [int] NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Config] ([ConfigSetting], [ConfigValue]) VALUES (N'StockWarningAmount', N'5')
GO
SET IDENTITY_INSERT [dbo].[CustomerLoyaltyCards] ON 

INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (1, 1, 2, 100, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (2, 2, 3, 617, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (3, 1, 5, 231, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (4, 3, 6, 5, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (5, 1, 9, 141, 1)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (6, 3, 12, 881, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (7, 2, 17, 51, 1)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (8, 1, 24, 893, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (9, 3, 14, 1551, 0)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (10, 1, 28, 352, 1)
INSERT [dbo].[CustomerLoyaltyCards] ([ID], [LoyatyCardTypeID], [CustomerID], [Points], [Revoked]) VALUES (11, 3, 30, 512, 0)
SET IDENTITY_INSERT [dbo].[CustomerLoyaltyCards] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (1, N'Albert Woofendell', N'76 Northwestern Pass', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (2, N'Scottie Pepin', N'21779 Karstens Avenue', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (3, N'Fayina Stag', N'39 Cody Center', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (4, N'Diarmid Di Lucia', N'4249 Blaine Road', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (5, N'Antonin Cairns', N'7136 Sugar Pass', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (6, N'Gamaliel Andreini', N'74 Lakeland Pass', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (7, N'Myrta Milthorpe', N'57135 Hermina Center', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (8, N'Danila Bulpitt', N'0166 Mosinee Pass', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (9, N'Audry Webling', N'22191 Graedel Plaza', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (10, N'Florencia Arnold', N'0296 Derek Road', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (11, N'Brewster Fossick', N'8426 Kenwood Pass', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (12, N'Glynnis Trevascus', N'040 Burning Wood Junction', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (13, N'Morlee Chaudret', N'2 Reinke Lane', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (14, N'Fan Venditto', N'57 Waubesa Point', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (15, N'Dahlia Tart', N'7425 Autumn Leaf Crossing', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (16, N'Carla O''Curran', N'497 Golden Leaf Street', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (17, N'Eugenius Butter', N'1201 Wayridge Pass', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (18, N'Bess Thurling', N'3565 Truax Center', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (19, N'Leia Conn', N'9574 Menomonie Way', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (20, N'Brigit De Gouy', N'19 Basil Junction', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (21, N'Madeline Muscat', N'1 Novick Crossing', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (22, N'Vickie Gronaver', N'478 Glacier Hill Way', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (23, N'Delmore Greeves', N'25 Maple Court', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (24, N'Magdalene Harford', N'172 Sundown Junction', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (25, N'Onfre Blazy', N'66565 Larry Center', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (26, N'Uriah Lee', N'024 Clarendon Place', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (27, N'Carolann Szymanowicz', N'75 Hoepker Plaza', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (28, N'Fraze Traher', N'0759 Charing Cross Hill', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (29, N'Titus Dadge', N'58132 Marcy Way', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (30, N'Estelle Sacks', N'6899 Sheridan Place', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (31, N'Francyne MacAnulty', N'0237 Evergreen Avenue', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (32, N'Easter Easterling', N'9755 Barnett Center', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (33, N'Von Sextone', N'524 Cascade Drive', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (34, N'Paige Suggitt', N'6402 Union Court', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (35, N'Madelina Gianasi', N'862 Nevada Street', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (36, N'Bryant Harmes', N'34 La Follette Street', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (37, N'Lizzy Haisell', N'225 Cardinal Trail', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (38, N'Drucill Suermeier', N'6 Lawn Point', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (39, N'Colin Markham', N'72 Briar Crest Lane', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (40, N'Adrianna Roostan', N'1 Kenwood Parkway', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (41, N'Ara Rosenbloom', N'34 Miller Point', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (42, N'Kelley Pidgeon', N'67044 Crowley Drive', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (43, N'Mariska Isakovitch', N'84321 Anzinger Park', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (44, N'Neill McLaughlin', N'75340 Spaight Place', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (45, N'Gussie Croizier', N'84869 Gerald Lane', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (46, N'Alvie Shinner', N'340 Tomscot Parkway', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (47, N'Bronny Faltin', N'6785 Superior Way', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (48, N'Hendrik Siley', N'56 Longview Center', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (49, N'Madalena Eberdt', N'4 4th Plaza', 1)
INSERT [dbo].[Customers] ([ID], [Name], [Address], [Active]) VALUES (50, N'Lukas Lyte', N'8 Dixon Lane', 1)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([ID], [Location]) VALUES (1, N'Edinburgh East')
INSERT [dbo].[Locations] ([ID], [Location]) VALUES (2, N'Edinburgh West')
INSERT [dbo].[Locations] ([ID], [Location]) VALUES (3, N'Glasgow')
INSERT [dbo].[Locations] ([ID], [Location]) VALUES (4, N'Stirling')
INSERT [dbo].[Locations] ([ID], [Location]) VALUES (5, N'Livingston')
SET IDENTITY_INSERT [dbo].[Locations] OFF
GO
SET IDENTITY_INSERT [dbo].[LoyaltyCardOffers] ON 

INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (1, 1, 3)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (2, 2, 3)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (3, 2, 4)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (4, 3, 3)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (5, 3, 4)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (6, 4, 2)
SET IDENTITY_INSERT [dbo].[LoyaltyCardOffers] OFF
GO
SET IDENTITY_INSERT [dbo].[LoyaltyCards] ON 

INSERT [dbo].[LoyaltyCards] ([ID], [CardType]) VALUES (1, N'Silver')
INSERT [dbo].[LoyaltyCards] ([ID], [CardType]) VALUES (2, N'Gold')
INSERT [dbo].[LoyaltyCards] ([ID], [CardType]) VALUES (3, N'Platinum')
SET IDENTITY_INSERT [dbo].[LoyaltyCards] OFF
GO
SET IDENTITY_INSERT [dbo].[Offers] ON 

INSERT [dbo].[Offers] ([ID], [OfferType], [OfferDescription]) VALUES (1, N'None', N'No Offers set')
INSERT [dbo].[Offers] ([ID], [OfferType], [OfferDescription]) VALUES (2, N'Buy 1 get 1 free', N'Buy 1 get 1 free.')
INSERT [dbo].[Offers] ([ID], [OfferType], [OfferDescription]) VALUES (3, N'Free Delivery', N'Free delivery on this product')
INSERT [dbo].[Offers] ([ID], [OfferType], [OfferDescription]) VALUES (4, N'3 for 2', N'Buy 3 for the price of two. ')
SET IDENTITY_INSERT [dbo].[Offers] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (1, N'Paint', N'Paint for your Shed', CAST(1.50 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (2, N'Small Brushes', N'Small brushes for small areas', CAST(1.25 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (3, N'Large Brushes', N'Large brushes for large areas', CAST(2.50 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (4, N'Screwdriver', N'Just a standard screwdriver', CAST(1.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (5, N'Wallpaper', N'Wall paper for your wall', CAST(3.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (6, N'Lightbulb', N'25W Lightbulb for your patio', CAST(1.10 AS Decimal(18, 2)), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (1, 1, 10, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (2, 2, 76, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (3, 3, 2951, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (4, 4, 3, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (5, 5, 1, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (6, 6, 791, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (7, 1, 5, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (8, 2, 5123, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (9, 3, 9, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (10, 4, 52, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (11, 5, 4, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (12, 6, 4, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (13, 1, 2, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (14, 2, 3, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (15, 3, 9, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (16, 4, 4, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (17, 5, 5, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (18, 6, 43, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (19, 1, 51, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (20, 2, 43, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (21, 3, 34, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (22, 4, 11, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (23, 5, 54, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (24, 6, 220, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (25, 1, 51, 5)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (26, 2, 145, 5)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (27, 3, 134, 5)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (28, 4, 451, 5)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (29, 5, 232, 5)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (30, 6, 511, 5)
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([ID])
GO
ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Customers]
GO
USE [master]
GO
ALTER DATABASE [De-Store] SET  READ_WRITE 
GO

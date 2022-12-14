USE [master]
GO
/****** Object:  Database [De-Store]    Script Date: 19/08/2022 19:12:11 ******/
CREATE DATABASE [De-Store]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'De-Store', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.WOJCIECHSDESK\MSSQL\DATA\De-Store.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'De-Store_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.WOJCIECHSDESK\MSSQL\DATA\De-Store_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  Table [dbo].[LoyaltyCards]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyaltyCards](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CardType] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerLoyaltyCards]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  View [dbo].[AllCustomsWithLoyaltyCards]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[AllCustomsWithLoyaltyCards]
AS
SELECT        dbo.Customers.ID AS CustomerID, dbo.Customers.Name, dbo.Customers.Address, dbo.Customers.Active, dbo.CustomerLoyaltyCards.LoyatyCardTypeID, dbo.CustomerLoyaltyCards.Points, 
                         dbo.CustomerLoyaltyCards.Revoked, dbo.CustomerLoyaltyCards.ID AS LoyaltyCardID, L.CardType
FROM            dbo.Customers LEFT JOIN
                         dbo.CustomerLoyaltyCards ON dbo.Customers.ID = dbo.CustomerLoyaltyCards.CustomerID
						 LEFT JOIN dbo.LoyaltyCards L ON dbo.CustomerLoyaltyCards.LoyatyCardTypeID = L.ID
GO
/****** Object:  Table [dbo].[Products]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  Table [dbo].[Sales]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[SaleLocationID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SaleCost] [decimal](18, 2) NULL,
	[CustomerID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateOfSale] [datetime] NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SalesByProduct]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SalesByProduct]
AS
SELECT        TOP (100) PERCENT P.ProductType, COUNT(*) AS ProductSales
FROM            dbo.Sales AS S INNER JOIN
                         dbo.Products AS P ON S.ProductID = P.ID
GROUP BY P.ProductType
ORDER BY P.ProductType
GO
/****** Object:  View [dbo].[SalesByMonth]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create VIEW [dbo].[SalesByMonth] AS
 
 SELECT SUM(Sales.MyCost) As MyMonthlyCost, Sales.MyMonth as MyNewMonth FROM (
 SELECT SUM(SaleCost) AS MyCost, CONCAT(DATEPART(MONTH, DateOfSale), ' ', DATEPART(YEAR, DateOfSale)) as MyMonth FROM [De-Store].[dbo].[Sales]
 GROUP BY DateOfSale
 ) Sales
 Group by Sales.MyMonth
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  View [dbo].[SalesByLocation]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SalesByLocation]
AS
SELECT        COUNT(*) AS SalesInLocation, L.Location
FROM            dbo.Sales AS S INNER JOIN
                         dbo.Locations AS L ON S.SaleLocationID = L.ID
GROUP BY L.Location
GO
/****** Object:  Table [dbo].[Config]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config](
	[ConfigSetting] [nvarchar](50) NOT NULL,
	[ConfigValue] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeaderQuartersOrders]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  Table [dbo].[LoyaltyCardOffers]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  Table [dbo].[LoyaltyCardOfferTypes]    Script Date: 19/08/2022 19:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoyaltyCardOfferTypes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OfferType] [nvarchar](50) NOT NULL,
	[OfferDescription] [nvarchar](max) NOT NULL,
	[OfferLoyaltyCost] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Offers]    Script Date: 19/08/2022 19:12:11 ******/
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
/****** Object:  Table [dbo].[Warehouse]    Script Date: 19/08/2022 19:12:11 ******/
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

INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (1, 1, 2)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (7, 2, 2)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (3, 2, 3)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (4, 3, 2)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (5, 3, 3)
INSERT [dbo].[LoyaltyCardOffers] ([ID], [LoyatyCardID], [LoyaltyCardOfferID]) VALUES (6, 3, 1)
SET IDENTITY_INSERT [dbo].[LoyaltyCardOffers] OFF
GO
SET IDENTITY_INSERT [dbo].[LoyaltyCardOfferTypes] ON 

INSERT [dbo].[LoyaltyCardOfferTypes] ([ID], [OfferType], [OfferDescription], [OfferLoyaltyCost]) VALUES (1, N'Buy 1 get 1 free', N'Buy 1 get 1 free.', 100)
INSERT [dbo].[LoyaltyCardOfferTypes] ([ID], [OfferType], [OfferDescription], [OfferLoyaltyCost]) VALUES (2, N'Free Delivery', N'Free delivery on a product', 50)
INSERT [dbo].[LoyaltyCardOfferTypes] ([ID], [OfferType], [OfferDescription], [OfferLoyaltyCost]) VALUES (3, N'3 for 2', N'Buy 3 for the price of two. ', 75)
SET IDENTITY_INSERT [dbo].[LoyaltyCardOfferTypes] OFF
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

INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (1, N'Paint', N'Paint for your Shed', CAST(2.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (2, N'Small Brushes', N'Small brushes for small areas', CAST(1.25 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (3, N'Large Brushes', N'Large brushes for large areas', CAST(2.50 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (4, N'Screwdriver', N'Just a standard screwdriver', CAST(1.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (5, N'Wallpaper', N'Wall paper for your wall', CAST(3.00 AS Decimal(18, 2)), 1, 1, NULL)
INSERT [dbo].[Products] ([ID], [ProductType], [ProductDescription], [ProductCost], [AvailableToBuy], [OfferID], [OfferExpiry]) VALUES (6, N'Lightbulb', N'25W Lightbulb for your patio', CAST(1.10 AS Decimal(18, 2)), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Sales] ON 

INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.12 AS Decimal(18, 2)), 49, 2001, CAST(N'2022-03-20T04:57:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(3.09 AS Decimal(18, 2)), 36, 2002, CAST(N'2021-11-29T04:49:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.42 AS Decimal(18, 2)), 44, 2003, CAST(N'2022-04-19T11:19:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.31 AS Decimal(18, 2)), 49, 2004, CAST(N'2022-03-19T14:43:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.09 AS Decimal(18, 2)), 8, 2005, CAST(N'2022-08-11T17:41:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(3.49 AS Decimal(18, 2)), 40, 2006, CAST(N'2022-03-28T11:40:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.56 AS Decimal(18, 2)), 17, 2007, CAST(N'2022-01-07T02:58:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.61 AS Decimal(18, 2)), 18, 2008, CAST(N'2021-06-24T04:03:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(6.68 AS Decimal(18, 2)), 31, 2009, CAST(N'2021-09-03T03:49:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(1.13 AS Decimal(18, 2)), 20, 2010, CAST(N'2021-09-15T19:51:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.71 AS Decimal(18, 2)), 35, 2011, CAST(N'2021-09-25T11:43:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(3.59 AS Decimal(18, 2)), 17, 2012, CAST(N'2022-07-16T10:37:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.31 AS Decimal(18, 2)), 36, 2013, CAST(N'2022-01-07T05:31:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(9.97 AS Decimal(18, 2)), 40, 2014, CAST(N'2021-09-24T15:22:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.45 AS Decimal(18, 2)), 48, 2015, CAST(N'2021-11-12T15:50:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(7.01 AS Decimal(18, 2)), 11, 2016, CAST(N'2022-03-15T23:01:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.70 AS Decimal(18, 2)), 18, 2017, CAST(N'2022-01-29T22:23:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.71 AS Decimal(18, 2)), 8, 2018, CAST(N'2022-03-15T08:27:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.79 AS Decimal(18, 2)), 50, 2019, CAST(N'2021-12-22T11:55:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.79 AS Decimal(18, 2)), 21, 2020, CAST(N'2021-09-05T01:08:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.10 AS Decimal(18, 2)), 23, 2021, CAST(N'2022-04-03T22:18:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(6.93 AS Decimal(18, 2)), 6, 2022, CAST(N'2021-07-23T23:24:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(4.25 AS Decimal(18, 2)), 6, 2023, CAST(N'2021-12-02T03:21:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.49 AS Decimal(18, 2)), 50, 2024, CAST(N'2021-06-06T11:21:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.36 AS Decimal(18, 2)), 45, 2025, CAST(N'2021-08-17T03:13:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(1.45 AS Decimal(18, 2)), 46, 2026, CAST(N'2021-08-19T19:56:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(4.92 AS Decimal(18, 2)), 23, 2027, CAST(N'2021-07-28T09:41:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(5.99 AS Decimal(18, 2)), 45, 2028, CAST(N'2021-09-03T23:41:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(6.11 AS Decimal(18, 2)), 30, 2029, CAST(N'2022-08-03T21:57:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.10 AS Decimal(18, 2)), 8, 2030, CAST(N'2022-08-13T17:02:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.95 AS Decimal(18, 2)), 35, 2031, CAST(N'2021-12-14T12:21:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.36 AS Decimal(18, 2)), 40, 2032, CAST(N'2021-08-11T16:14:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.07 AS Decimal(18, 2)), 32, 2033, CAST(N'2022-04-12T01:18:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.90 AS Decimal(18, 2)), 10, 2034, CAST(N'2022-01-10T00:43:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.72 AS Decimal(18, 2)), 34, 2035, CAST(N'2022-02-22T00:08:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(8.99 AS Decimal(18, 2)), 50, 2036, CAST(N'2021-08-01T16:23:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(3.97 AS Decimal(18, 2)), 21, 2037, CAST(N'2022-07-25T17:22:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.02 AS Decimal(18, 2)), 27, 2038, CAST(N'2021-09-24T17:16:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(6.65 AS Decimal(18, 2)), 20, 2039, CAST(N'2021-12-09T18:59:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(6.36 AS Decimal(18, 2)), 2, 2040, CAST(N'2021-09-20T15:19:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.17 AS Decimal(18, 2)), 12, 2041, CAST(N'2022-02-09T04:52:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.69 AS Decimal(18, 2)), 20, 2042, CAST(N'2021-12-29T06:35:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.12 AS Decimal(18, 2)), 9, 2043, CAST(N'2022-02-01T02:28:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(7.46 AS Decimal(18, 2)), 16, 2044, CAST(N'2022-02-28T07:02:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.81 AS Decimal(18, 2)), 16, 2045, CAST(N'2021-08-31T09:52:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.96 AS Decimal(18, 2)), 14, 2046, CAST(N'2022-07-29T17:26:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.86 AS Decimal(18, 2)), 26, 2047, CAST(N'2021-12-04T02:30:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.55 AS Decimal(18, 2)), 13, 2048, CAST(N'2021-11-22T18:10:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.22 AS Decimal(18, 2)), 47, 2049, CAST(N'2022-04-09T18:45:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.69 AS Decimal(18, 2)), 20, 2050, CAST(N'2021-06-12T06:34:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.19 AS Decimal(18, 2)), 9, 2051, CAST(N'2021-06-21T17:12:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(2.93 AS Decimal(18, 2)), 11, 2052, CAST(N'2022-07-15T18:34:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.70 AS Decimal(18, 2)), 1, 2053, CAST(N'2022-07-18T16:17:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.65 AS Decimal(18, 2)), 25, 2054, CAST(N'2021-07-05T03:17:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.09 AS Decimal(18, 2)), 3, 2055, CAST(N'2021-07-05T22:52:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(9.59 AS Decimal(18, 2)), 14, 2056, CAST(N'2021-07-13T06:26:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.70 AS Decimal(18, 2)), 43, 2057, CAST(N'2022-05-19T07:38:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.76 AS Decimal(18, 2)), 44, 2058, CAST(N'2022-02-20T07:12:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.92 AS Decimal(18, 2)), 23, 2059, CAST(N'2021-06-22T17:53:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.61 AS Decimal(18, 2)), 28, 2060, CAST(N'2022-02-14T07:43:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.68 AS Decimal(18, 2)), 33, 2061, CAST(N'2021-10-20T01:03:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.25 AS Decimal(18, 2)), 46, 2062, CAST(N'2021-11-15T01:35:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(9.37 AS Decimal(18, 2)), 24, 2063, CAST(N'2021-12-20T04:37:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.82 AS Decimal(18, 2)), 41, 2064, CAST(N'2021-11-18T04:31:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.08 AS Decimal(18, 2)), 50, 2065, CAST(N'2022-03-22T10:43:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(2.58 AS Decimal(18, 2)), 1, 2066, CAST(N'2021-08-13T15:20:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.81 AS Decimal(18, 2)), 6, 2067, CAST(N'2022-05-02T07:45:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(5.46 AS Decimal(18, 2)), 11, 2068, CAST(N'2022-03-25T01:31:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.50 AS Decimal(18, 2)), 18, 2069, CAST(N'2022-04-04T19:24:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.78 AS Decimal(18, 2)), 2, 2070, CAST(N'2022-06-20T07:19:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.15 AS Decimal(18, 2)), 30, 2071, CAST(N'2021-07-24T00:20:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.93 AS Decimal(18, 2)), 17, 2072, CAST(N'2021-08-08T04:53:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(2.73 AS Decimal(18, 2)), 18, 2073, CAST(N'2021-11-11T22:08:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.25 AS Decimal(18, 2)), 3, 2074, CAST(N'2021-08-25T22:36:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.60 AS Decimal(18, 2)), 44, 2075, CAST(N'2022-02-04T06:04:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.13 AS Decimal(18, 2)), 45, 2076, CAST(N'2022-05-16T15:24:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.96 AS Decimal(18, 2)), 19, 2077, CAST(N'2021-07-12T17:33:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(8.32 AS Decimal(18, 2)), 26, 2078, CAST(N'2021-10-09T12:21:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.72 AS Decimal(18, 2)), 48, 2079, CAST(N'2022-06-04T06:00:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(6.69 AS Decimal(18, 2)), 43, 2080, CAST(N'2021-07-03T17:49:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.65 AS Decimal(18, 2)), 33, 2081, CAST(N'2021-07-22T23:55:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.65 AS Decimal(18, 2)), 22, 2082, CAST(N'2022-01-29T03:23:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.94 AS Decimal(18, 2)), 34, 2083, CAST(N'2022-02-28T15:25:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.54 AS Decimal(18, 2)), 42, 2084, CAST(N'2022-08-10T19:18:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.85 AS Decimal(18, 2)), 40, 2085, CAST(N'2022-03-15T09:05:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.55 AS Decimal(18, 2)), 41, 2086, CAST(N'2021-07-19T09:05:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.11 AS Decimal(18, 2)), 6, 2087, CAST(N'2022-04-08T06:06:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.61 AS Decimal(18, 2)), 12, 2088, CAST(N'2021-07-22T05:24:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.97 AS Decimal(18, 2)), 23, 2089, CAST(N'2022-06-25T23:48:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.41 AS Decimal(18, 2)), 41, 2090, CAST(N'2021-06-20T01:51:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.78 AS Decimal(18, 2)), 12, 2091, CAST(N'2021-12-20T01:54:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.87 AS Decimal(18, 2)), 28, 2092, CAST(N'2021-12-31T06:44:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.77 AS Decimal(18, 2)), 30, 2093, CAST(N'2022-01-24T23:11:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.45 AS Decimal(18, 2)), 43, 2094, CAST(N'2021-07-11T05:56:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.66 AS Decimal(18, 2)), 48, 2095, CAST(N'2021-07-25T02:10:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(3.01 AS Decimal(18, 2)), 2, 2096, CAST(N'2022-04-25T03:00:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.89 AS Decimal(18, 2)), 5, 2097, CAST(N'2021-06-18T00:10:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.12 AS Decimal(18, 2)), 3, 2098, CAST(N'2022-05-13T04:19:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.74 AS Decimal(18, 2)), 31, 2099, CAST(N'2022-07-05T04:01:52.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.74 AS Decimal(18, 2)), 9, 2100, CAST(N'2021-07-06T19:04:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(3.77 AS Decimal(18, 2)), 11, 2101, CAST(N'2021-08-18T19:00:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.96 AS Decimal(18, 2)), 24, 2102, CAST(N'2021-06-28T08:19:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.42 AS Decimal(18, 2)), 20, 2103, CAST(N'2021-09-21T10:20:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.66 AS Decimal(18, 2)), 36, 2104, CAST(N'2021-10-06T06:58:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.11 AS Decimal(18, 2)), 44, 2105, CAST(N'2021-10-06T07:59:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(5.73 AS Decimal(18, 2)), 18, 2106, CAST(N'2021-07-05T09:25:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(6.87 AS Decimal(18, 2)), 3, 2107, CAST(N'2021-06-14T01:17:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.62 AS Decimal(18, 2)), 3, 2108, CAST(N'2022-08-01T04:20:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.89 AS Decimal(18, 2)), 17, 2109, CAST(N'2022-02-05T13:05:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.30 AS Decimal(18, 2)), 32, 2110, CAST(N'2022-01-05T17:01:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.33 AS Decimal(18, 2)), 31, 2111, CAST(N'2021-09-22T17:31:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.03 AS Decimal(18, 2)), 40, 2112, CAST(N'2021-06-05T17:26:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.70 AS Decimal(18, 2)), 29, 2113, CAST(N'2022-01-16T18:17:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(2.21 AS Decimal(18, 2)), 19, 2114, CAST(N'2021-07-08T10:48:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.74 AS Decimal(18, 2)), 8, 2115, CAST(N'2021-06-06T00:45:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.90 AS Decimal(18, 2)), 7, 2116, CAST(N'2022-07-06T16:20:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.38 AS Decimal(18, 2)), 32, 2117, CAST(N'2022-05-22T22:38:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.66 AS Decimal(18, 2)), 49, 2118, CAST(N'2022-02-24T14:00:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.86 AS Decimal(18, 2)), 24, 2119, CAST(N'2021-12-14T04:01:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(7.70 AS Decimal(18, 2)), 1, 2120, CAST(N'2021-11-03T01:21:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(1.70 AS Decimal(18, 2)), 42, 2121, CAST(N'2021-09-23T09:11:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.94 AS Decimal(18, 2)), 17, 2122, CAST(N'2021-11-03T14:22:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.74 AS Decimal(18, 2)), 36, 2123, CAST(N'2021-06-12T22:36:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.87 AS Decimal(18, 2)), 22, 2124, CAST(N'2022-05-10T23:22:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.69 AS Decimal(18, 2)), 28, 2125, CAST(N'2021-12-09T21:52:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(3.54 AS Decimal(18, 2)), 34, 2126, CAST(N'2021-12-27T15:15:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.39 AS Decimal(18, 2)), 30, 2127, CAST(N'2021-06-04T17:54:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.52 AS Decimal(18, 2)), 22, 2128, CAST(N'2022-05-24T14:46:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(3.13 AS Decimal(18, 2)), 34, 2129, CAST(N'2021-06-17T17:32:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.03 AS Decimal(18, 2)), 7, 2130, CAST(N'2021-11-03T15:36:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.24 AS Decimal(18, 2)), 14, 2131, CAST(N'2021-10-18T17:08:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.30 AS Decimal(18, 2)), 30, 2132, CAST(N'2022-07-04T23:25:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.58 AS Decimal(18, 2)), 36, 2133, CAST(N'2022-07-14T19:49:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.89 AS Decimal(18, 2)), 10, 2134, CAST(N'2021-11-15T22:03:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.90 AS Decimal(18, 2)), 4, 2135, CAST(N'2021-12-03T02:51:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.08 AS Decimal(18, 2)), 23, 2136, CAST(N'2022-02-05T14:22:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(4.52 AS Decimal(18, 2)), 21, 2137, CAST(N'2022-07-27T10:53:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.13 AS Decimal(18, 2)), 17, 2138, CAST(N'2021-12-06T11:20:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.40 AS Decimal(18, 2)), 37, 2139, CAST(N'2021-11-20T22:34:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.52 AS Decimal(18, 2)), 42, 2140, CAST(N'2022-05-03T22:56:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.01 AS Decimal(18, 2)), 35, 2141, CAST(N'2021-08-09T02:40:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.74 AS Decimal(18, 2)), 8, 2142, CAST(N'2022-05-24T19:10:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(2.91 AS Decimal(18, 2)), 44, 2143, CAST(N'2022-07-23T16:58:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.84 AS Decimal(18, 2)), 16, 2144, CAST(N'2021-11-03T02:34:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(5.72 AS Decimal(18, 2)), 18, 2145, CAST(N'2021-07-16T04:15:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.30 AS Decimal(18, 2)), 34, 2146, CAST(N'2021-11-12T22:45:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.76 AS Decimal(18, 2)), 8, 2147, CAST(N'2021-08-08T19:47:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.72 AS Decimal(18, 2)), 21, 2148, CAST(N'2021-12-28T16:30:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.43 AS Decimal(18, 2)), 18, 2149, CAST(N'2021-09-17T22:18:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.04 AS Decimal(18, 2)), 7, 2150, CAST(N'2022-03-18T19:32:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.72 AS Decimal(18, 2)), 32, 2151, CAST(N'2022-05-21T01:58:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(10.00 AS Decimal(18, 2)), 50, 2152, CAST(N'2022-05-10T01:14:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.24 AS Decimal(18, 2)), 16, 2153, CAST(N'2021-09-21T08:25:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.62 AS Decimal(18, 2)), 48, 2154, CAST(N'2022-02-10T06:32:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.31 AS Decimal(18, 2)), 5, 2155, CAST(N'2022-06-28T08:17:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.33 AS Decimal(18, 2)), 19, 2156, CAST(N'2022-01-09T13:35:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(7.82 AS Decimal(18, 2)), 7, 2157, CAST(N'2022-07-19T09:04:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.51 AS Decimal(18, 2)), 11, 2158, CAST(N'2022-01-19T17:13:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(9.37 AS Decimal(18, 2)), 15, 2159, CAST(N'2021-06-18T21:25:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.40 AS Decimal(18, 2)), 19, 2160, CAST(N'2022-03-16T04:06:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(5.93 AS Decimal(18, 2)), 21, 2161, CAST(N'2022-07-26T01:33:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.60 AS Decimal(18, 2)), 11, 2162, CAST(N'2022-05-27T16:56:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.58 AS Decimal(18, 2)), 16, 2163, CAST(N'2022-03-25T12:14:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.92 AS Decimal(18, 2)), 50, 2164, CAST(N'2022-07-04T04:55:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(4.11 AS Decimal(18, 2)), 11, 2165, CAST(N'2022-05-30T11:49:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.29 AS Decimal(18, 2)), 1, 2166, CAST(N'2021-08-01T15:48:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.22 AS Decimal(18, 2)), 24, 2167, CAST(N'2021-06-08T18:31:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.39 AS Decimal(18, 2)), 20, 2168, CAST(N'2022-05-16T15:21:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.97 AS Decimal(18, 2)), 21, 2169, CAST(N'2021-07-23T10:50:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.17 AS Decimal(18, 2)), 18, 2170, CAST(N'2022-04-16T14:24:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.21 AS Decimal(18, 2)), 2, 2171, CAST(N'2021-09-19T04:50:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.24 AS Decimal(18, 2)), 2, 2172, CAST(N'2022-03-02T19:24:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(7.63 AS Decimal(18, 2)), 7, 2173, CAST(N'2022-03-18T07:03:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.99 AS Decimal(18, 2)), 50, 2174, CAST(N'2021-12-19T13:55:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.19 AS Decimal(18, 2)), 18, 2175, CAST(N'2021-09-27T18:30:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(6.64 AS Decimal(18, 2)), 45, 2176, CAST(N'2021-10-27T07:16:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.37 AS Decimal(18, 2)), 37, 2177, CAST(N'2022-02-20T21:08:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.47 AS Decimal(18, 2)), 10, 2178, CAST(N'2022-05-02T12:45:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.35 AS Decimal(18, 2)), 49, 2179, CAST(N'2022-07-29T02:48:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.02 AS Decimal(18, 2)), 48, 2180, CAST(N'2022-06-18T05:24:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.10 AS Decimal(18, 2)), 34, 2181, CAST(N'2022-06-19T02:32:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.14 AS Decimal(18, 2)), 31, 2182, CAST(N'2022-01-21T10:31:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.86 AS Decimal(18, 2)), 36, 2183, CAST(N'2022-08-15T17:58:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.43 AS Decimal(18, 2)), 35, 2184, CAST(N'2022-04-14T09:09:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.39 AS Decimal(18, 2)), 4, 2185, CAST(N'2021-09-19T20:57:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.17 AS Decimal(18, 2)), 38, 2186, CAST(N'2021-08-08T07:46:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(2.52 AS Decimal(18, 2)), 24, 2187, CAST(N'2022-02-24T01:45:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.06 AS Decimal(18, 2)), 10, 2188, CAST(N'2022-07-04T00:16:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.99 AS Decimal(18, 2)), 35, 2189, CAST(N'2021-08-09T04:21:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.55 AS Decimal(18, 2)), 34, 2190, CAST(N'2022-08-03T15:41:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(5.00 AS Decimal(18, 2)), 15, 2191, CAST(N'2021-10-15T09:31:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.84 AS Decimal(18, 2)), 34, 2192, CAST(N'2021-11-06T20:26:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(2.72 AS Decimal(18, 2)), 50, 2193, CAST(N'2021-10-30T08:58:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.64 AS Decimal(18, 2)), 44, 2194, CAST(N'2021-09-19T13:43:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.12 AS Decimal(18, 2)), 23, 2195, CAST(N'2022-05-30T11:12:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.64 AS Decimal(18, 2)), 47, 2196, CAST(N'2021-12-13T08:01:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.22 AS Decimal(18, 2)), 19, 2197, CAST(N'2022-01-13T15:48:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.23 AS Decimal(18, 2)), 40, 2198, CAST(N'2022-07-18T09:32:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.65 AS Decimal(18, 2)), 5, 2199, CAST(N'2021-06-06T19:41:45.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.48 AS Decimal(18, 2)), 5, 2200, CAST(N'2021-08-06T20:19:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.27 AS Decimal(18, 2)), 45, 2201, CAST(N'2022-02-04T21:35:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.53 AS Decimal(18, 2)), 48, 2202, CAST(N'2022-02-13T01:24:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.44 AS Decimal(18, 2)), 50, 2203, CAST(N'2022-06-13T01:33:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.60 AS Decimal(18, 2)), 7, 2204, CAST(N'2021-07-13T03:25:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.84 AS Decimal(18, 2)), 44, 2205, CAST(N'2021-09-08T21:56:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.14 AS Decimal(18, 2)), 38, 2206, CAST(N'2021-12-14T15:43:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.20 AS Decimal(18, 2)), 31, 2207, CAST(N'2021-07-13T13:13:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.86 AS Decimal(18, 2)), 36, 2208, CAST(N'2022-01-31T06:10:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.91 AS Decimal(18, 2)), 41, 2209, CAST(N'2021-07-24T12:33:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.19 AS Decimal(18, 2)), 23, 2210, CAST(N'2022-05-27T13:41:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.76 AS Decimal(18, 2)), 7, 2211, CAST(N'2022-03-16T16:59:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.85 AS Decimal(18, 2)), 41, 2212, CAST(N'2022-01-08T19:49:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.63 AS Decimal(18, 2)), 42, 2213, CAST(N'2022-07-30T12:57:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(7.29 AS Decimal(18, 2)), 12, 2214, CAST(N'2022-05-11T19:29:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.97 AS Decimal(18, 2)), 20, 2215, CAST(N'2022-03-07T02:54:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.17 AS Decimal(18, 2)), 15, 2216, CAST(N'2021-10-29T21:49:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.62 AS Decimal(18, 2)), 24, 2217, CAST(N'2021-07-22T02:16:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.48 AS Decimal(18, 2)), 42, 2218, CAST(N'2022-07-27T05:35:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.59 AS Decimal(18, 2)), 1, 2219, CAST(N'2021-06-08T17:29:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.73 AS Decimal(18, 2)), 6, 2220, CAST(N'2021-08-02T15:13:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(3.68 AS Decimal(18, 2)), 37, 2221, CAST(N'2022-02-11T02:58:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.94 AS Decimal(18, 2)), 1, 2222, CAST(N'2022-08-08T05:38:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.47 AS Decimal(18, 2)), 16, 2223, CAST(N'2022-01-28T08:06:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.25 AS Decimal(18, 2)), 7, 2224, CAST(N'2021-07-05T17:51:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(4.07 AS Decimal(18, 2)), 4, 2225, CAST(N'2021-08-14T00:07:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(6.16 AS Decimal(18, 2)), 45, 2226, CAST(N'2021-06-12T05:53:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(7.76 AS Decimal(18, 2)), 42, 2227, CAST(N'2022-07-15T22:09:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.64 AS Decimal(18, 2)), 39, 2228, CAST(N'2022-06-11T10:32:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.56 AS Decimal(18, 2)), 41, 2229, CAST(N'2021-06-11T06:51:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.77 AS Decimal(18, 2)), 35, 2230, CAST(N'2022-03-03T20:03:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.59 AS Decimal(18, 2)), 20, 2231, CAST(N'2022-04-13T21:04:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.49 AS Decimal(18, 2)), 41, 2232, CAST(N'2022-02-06T07:43:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.92 AS Decimal(18, 2)), 46, 2233, CAST(N'2021-12-26T01:34:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.83 AS Decimal(18, 2)), 36, 2234, CAST(N'2022-04-07T21:23:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.27 AS Decimal(18, 2)), 22, 2235, CAST(N'2022-01-16T11:25:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.45 AS Decimal(18, 2)), 44, 2236, CAST(N'2022-03-30T13:57:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(5.03 AS Decimal(18, 2)), 26, 2237, CAST(N'2022-06-14T12:26:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.78 AS Decimal(18, 2)), 34, 2238, CAST(N'2021-08-21T12:24:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.80 AS Decimal(18, 2)), 37, 2239, CAST(N'2021-09-27T07:34:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.68 AS Decimal(18, 2)), 24, 2240, CAST(N'2021-09-16T06:07:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.44 AS Decimal(18, 2)), 2, 2241, CAST(N'2021-06-23T16:59:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.85 AS Decimal(18, 2)), 35, 2242, CAST(N'2022-06-15T00:30:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.79 AS Decimal(18, 2)), 43, 2243, CAST(N'2021-11-16T23:50:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.47 AS Decimal(18, 2)), 17, 2244, CAST(N'2022-05-09T02:42:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(8.52 AS Decimal(18, 2)), 35, 2245, CAST(N'2022-03-29T14:16:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(3.15 AS Decimal(18, 2)), 24, 2246, CAST(N'2021-11-11T17:56:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.10 AS Decimal(18, 2)), 21, 2247, CAST(N'2022-07-16T13:54:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.43 AS Decimal(18, 2)), 21, 2248, CAST(N'2022-05-27T13:55:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.63 AS Decimal(18, 2)), 13, 2249, CAST(N'2022-08-09T03:19:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.78 AS Decimal(18, 2)), 50, 2250, CAST(N'2022-01-22T20:36:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.45 AS Decimal(18, 2)), 13, 2251, CAST(N'2022-05-23T08:43:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.03 AS Decimal(18, 2)), 2, 2252, CAST(N'2021-06-12T09:25:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.18 AS Decimal(18, 2)), 10, 2253, CAST(N'2021-07-08T05:39:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.60 AS Decimal(18, 2)), 26, 2254, CAST(N'2022-01-07T02:22:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.19 AS Decimal(18, 2)), 45, 2255, CAST(N'2021-08-23T09:04:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.64 AS Decimal(18, 2)), 24, 2256, CAST(N'2022-05-22T05:57:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(9.01 AS Decimal(18, 2)), 2, 2257, CAST(N'2021-12-31T05:17:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.93 AS Decimal(18, 2)), 44, 2258, CAST(N'2022-02-10T23:27:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(4.52 AS Decimal(18, 2)), 9, 2259, CAST(N'2021-07-03T04:50:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(6.90 AS Decimal(18, 2)), 33, 2260, CAST(N'2021-06-27T00:43:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.75 AS Decimal(18, 2)), 27, 2261, CAST(N'2022-01-12T11:52:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.41 AS Decimal(18, 2)), 11, 2262, CAST(N'2021-08-03T03:07:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.94 AS Decimal(18, 2)), 26, 2263, CAST(N'2021-06-17T20:57:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.83 AS Decimal(18, 2)), 18, 2264, CAST(N'2021-06-16T11:12:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.49 AS Decimal(18, 2)), 8, 2265, CAST(N'2022-03-22T12:58:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.71 AS Decimal(18, 2)), 7, 2266, CAST(N'2022-02-01T22:15:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.77 AS Decimal(18, 2)), 10, 2267, CAST(N'2022-07-04T19:21:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.53 AS Decimal(18, 2)), 22, 2268, CAST(N'2021-12-12T16:27:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.55 AS Decimal(18, 2)), 49, 2269, CAST(N'2021-06-18T08:34:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.42 AS Decimal(18, 2)), 44, 2270, CAST(N'2022-07-06T05:27:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.41 AS Decimal(18, 2)), 34, 2271, CAST(N'2022-06-26T04:00:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.87 AS Decimal(18, 2)), 3, 2272, CAST(N'2022-01-04T15:44:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.07 AS Decimal(18, 2)), 2, 2273, CAST(N'2021-12-06T14:02:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.07 AS Decimal(18, 2)), 24, 2274, CAST(N'2022-03-08T18:26:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.03 AS Decimal(18, 2)), 25, 2275, CAST(N'2022-05-11T09:10:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.72 AS Decimal(18, 2)), 29, 2276, CAST(N'2022-01-07T00:12:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(5.36 AS Decimal(18, 2)), 24, 2277, CAST(N'2022-03-23T09:34:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(4.00 AS Decimal(18, 2)), 46, 2278, CAST(N'2022-01-06T03:41:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(7.35 AS Decimal(18, 2)), 30, 2279, CAST(N'2021-09-17T07:31:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.22 AS Decimal(18, 2)), 49, 2280, CAST(N'2021-06-14T15:37:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.57 AS Decimal(18, 2)), 45, 2281, CAST(N'2022-03-24T05:22:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(3.39 AS Decimal(18, 2)), 44, 2282, CAST(N'2021-09-25T08:10:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(9.34 AS Decimal(18, 2)), 42, 2283, CAST(N'2021-07-12T04:07:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(8.16 AS Decimal(18, 2)), 17, 2284, CAST(N'2021-09-22T04:13:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(8.37 AS Decimal(18, 2)), 28, 2285, CAST(N'2022-05-13T20:36:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(9.49 AS Decimal(18, 2)), 42, 2286, CAST(N'2021-12-10T13:35:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.56 AS Decimal(18, 2)), 31, 2287, CAST(N'2022-06-15T01:33:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.45 AS Decimal(18, 2)), 45, 2288, CAST(N'2022-04-05T02:35:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.01 AS Decimal(18, 2)), 36, 2289, CAST(N'2022-08-02T01:58:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(8.63 AS Decimal(18, 2)), 33, 2290, CAST(N'2022-04-02T00:31:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.30 AS Decimal(18, 2)), 37, 2291, CAST(N'2022-05-21T20:10:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.93 AS Decimal(18, 2)), 30, 2292, CAST(N'2022-05-03T18:56:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.98 AS Decimal(18, 2)), 44, 2293, CAST(N'2021-09-22T03:59:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(2.22 AS Decimal(18, 2)), 25, 2294, CAST(N'2021-08-25T20:11:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.41 AS Decimal(18, 2)), 43, 2295, CAST(N'2022-02-19T14:39:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(1.44 AS Decimal(18, 2)), 39, 2296, CAST(N'2021-09-18T19:56:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.11 AS Decimal(18, 2)), 49, 2297, CAST(N'2022-03-04T18:38:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.59 AS Decimal(18, 2)), 5, 2298, CAST(N'2022-02-24T04:59:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.56 AS Decimal(18, 2)), 8, 2299, CAST(N'2021-06-24T17:29:22.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.62 AS Decimal(18, 2)), 32, 2300, CAST(N'2022-02-02T01:30:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(7.89 AS Decimal(18, 2)), 22, 2301, CAST(N'2022-02-11T20:20:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(4.29 AS Decimal(18, 2)), 44, 2302, CAST(N'2022-01-06T23:49:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.89 AS Decimal(18, 2)), 25, 2303, CAST(N'2021-12-09T22:19:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(4.30 AS Decimal(18, 2)), 27, 2304, CAST(N'2022-05-31T21:02:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.37 AS Decimal(18, 2)), 9, 2305, CAST(N'2021-11-18T20:44:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.91 AS Decimal(18, 2)), 47, 2306, CAST(N'2021-09-23T06:04:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.23 AS Decimal(18, 2)), 17, 2307, CAST(N'2022-06-26T04:11:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.94 AS Decimal(18, 2)), 8, 2308, CAST(N'2021-12-20T22:57:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.08 AS Decimal(18, 2)), 12, 2309, CAST(N'2021-07-03T03:15:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.95 AS Decimal(18, 2)), 25, 2310, CAST(N'2022-07-13T05:37:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.06 AS Decimal(18, 2)), 18, 2311, CAST(N'2022-07-09T20:14:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.20 AS Decimal(18, 2)), 28, 2312, CAST(N'2022-07-31T03:49:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.12 AS Decimal(18, 2)), 18, 2313, CAST(N'2022-06-21T21:06:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.97 AS Decimal(18, 2)), 29, 2314, CAST(N'2022-05-27T16:29:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.39 AS Decimal(18, 2)), 2, 2315, CAST(N'2022-08-09T20:51:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.10 AS Decimal(18, 2)), 50, 2316, CAST(N'2021-10-07T04:19:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(6.12 AS Decimal(18, 2)), 20, 2317, CAST(N'2021-10-04T07:37:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(1.35 AS Decimal(18, 2)), 45, 2318, CAST(N'2022-08-12T14:47:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.58 AS Decimal(18, 2)), 5, 2319, CAST(N'2022-01-12T06:11:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.45 AS Decimal(18, 2)), 44, 2320, CAST(N'2022-06-16T01:41:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.28 AS Decimal(18, 2)), 18, 2321, CAST(N'2022-07-28T17:18:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(2.45 AS Decimal(18, 2)), 4, 2322, CAST(N'2021-12-13T10:35:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.74 AS Decimal(18, 2)), 31, 2323, CAST(N'2021-09-24T05:13:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.62 AS Decimal(18, 2)), 9, 2324, CAST(N'2021-08-31T03:46:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.31 AS Decimal(18, 2)), 44, 2325, CAST(N'2022-08-08T07:56:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.17 AS Decimal(18, 2)), 31, 2326, CAST(N'2021-10-05T13:09:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.06 AS Decimal(18, 2)), 40, 2327, CAST(N'2021-08-07T22:37:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.04 AS Decimal(18, 2)), 15, 2328, CAST(N'2021-07-20T15:11:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(6.35 AS Decimal(18, 2)), 12, 2329, CAST(N'2022-02-04T18:09:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.70 AS Decimal(18, 2)), 6, 2330, CAST(N'2022-07-17T07:08:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.40 AS Decimal(18, 2)), 47, 2331, CAST(N'2021-09-28T20:25:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(2.70 AS Decimal(18, 2)), 45, 2332, CAST(N'2022-04-30T21:24:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.99 AS Decimal(18, 2)), 30, 2333, CAST(N'2021-08-02T11:00:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.19 AS Decimal(18, 2)), 50, 2334, CAST(N'2021-09-07T19:53:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.58 AS Decimal(18, 2)), 3, 2335, CAST(N'2022-04-24T02:21:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(5.53 AS Decimal(18, 2)), 10, 2336, CAST(N'2022-06-11T16:54:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.84 AS Decimal(18, 2)), 47, 2337, CAST(N'2022-01-05T09:59:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.36 AS Decimal(18, 2)), 19, 2338, CAST(N'2022-04-04T11:18:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.47 AS Decimal(18, 2)), 37, 2339, CAST(N'2022-07-16T22:08:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.95 AS Decimal(18, 2)), 25, 2340, CAST(N'2021-09-22T05:54:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(6.30 AS Decimal(18, 2)), 3, 2341, CAST(N'2022-03-29T05:38:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.11 AS Decimal(18, 2)), 49, 2342, CAST(N'2022-04-15T10:00:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(5.17 AS Decimal(18, 2)), 34, 2343, CAST(N'2021-11-01T22:33:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.01 AS Decimal(18, 2)), 28, 2344, CAST(N'2022-07-15T03:54:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.89 AS Decimal(18, 2)), 50, 2345, CAST(N'2021-12-04T16:39:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(6.73 AS Decimal(18, 2)), 39, 2346, CAST(N'2022-05-04T15:20:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.79 AS Decimal(18, 2)), 26, 2347, CAST(N'2021-08-06T02:21:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(2.30 AS Decimal(18, 2)), 42, 2348, CAST(N'2021-12-22T06:04:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.31 AS Decimal(18, 2)), 37, 2349, CAST(N'2021-08-13T18:38:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(3.60 AS Decimal(18, 2)), 24, 2350, CAST(N'2021-06-09T02:58:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.47 AS Decimal(18, 2)), 40, 2351, CAST(N'2021-08-27T10:58:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.03 AS Decimal(18, 2)), 5, 2352, CAST(N'2022-07-02T06:50:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.80 AS Decimal(18, 2)), 16, 2353, CAST(N'2021-09-14T06:52:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.11 AS Decimal(18, 2)), 46, 2354, CAST(N'2022-06-19T18:50:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.78 AS Decimal(18, 2)), 17, 2355, CAST(N'2021-10-09T11:20:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.24 AS Decimal(18, 2)), 30, 2356, CAST(N'2021-08-11T07:21:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(3.30 AS Decimal(18, 2)), 12, 2357, CAST(N'2022-02-14T04:31:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(6.75 AS Decimal(18, 2)), 43, 2358, CAST(N'2021-08-25T02:45:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.92 AS Decimal(18, 2)), 22, 2359, CAST(N'2021-07-02T08:35:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.67 AS Decimal(18, 2)), 8, 2360, CAST(N'2022-03-08T17:29:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.47 AS Decimal(18, 2)), 21, 2361, CAST(N'2021-07-27T07:36:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(3.93 AS Decimal(18, 2)), 9, 2362, CAST(N'2022-02-28T08:17:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.95 AS Decimal(18, 2)), 3, 2363, CAST(N'2022-02-26T14:56:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.09 AS Decimal(18, 2)), 28, 2364, CAST(N'2022-07-01T08:48:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.36 AS Decimal(18, 2)), 40, 2365, CAST(N'2022-01-24T16:12:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(6.82 AS Decimal(18, 2)), 20, 2366, CAST(N'2022-04-17T07:05:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.78 AS Decimal(18, 2)), 27, 2367, CAST(N'2021-12-30T11:35:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.41 AS Decimal(18, 2)), 38, 2368, CAST(N'2022-05-01T16:12:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.11 AS Decimal(18, 2)), 30, 2369, CAST(N'2021-06-25T06:38:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(8.04 AS Decimal(18, 2)), 20, 2370, CAST(N'2022-04-04T20:08:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.66 AS Decimal(18, 2)), 28, 2371, CAST(N'2021-10-02T12:05:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.62 AS Decimal(18, 2)), 44, 2372, CAST(N'2021-08-06T08:47:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(6.33 AS Decimal(18, 2)), 29, 2373, CAST(N'2022-03-17T10:56:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.24 AS Decimal(18, 2)), 1, 2374, CAST(N'2022-03-17T20:33:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.52 AS Decimal(18, 2)), 25, 2375, CAST(N'2022-01-03T08:44:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.03 AS Decimal(18, 2)), 13, 2376, CAST(N'2021-12-13T18:22:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.64 AS Decimal(18, 2)), 49, 2377, CAST(N'2022-02-07T03:50:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(6.54 AS Decimal(18, 2)), 29, 2378, CAST(N'2022-07-24T18:17:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(2.20 AS Decimal(18, 2)), 13, 2379, CAST(N'2022-06-30T05:25:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.05 AS Decimal(18, 2)), 2, 2380, CAST(N'2021-08-02T11:30:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.31 AS Decimal(18, 2)), 26, 2381, CAST(N'2021-11-26T07:37:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.64 AS Decimal(18, 2)), 24, 2382, CAST(N'2021-06-08T18:46:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.46 AS Decimal(18, 2)), 47, 2383, CAST(N'2022-04-09T15:52:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(3.48 AS Decimal(18, 2)), 15, 2384, CAST(N'2021-10-11T09:07:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.60 AS Decimal(18, 2)), 11, 2385, CAST(N'2022-05-14T21:57:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(7.26 AS Decimal(18, 2)), 16, 2386, CAST(N'2021-10-21T02:55:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.87 AS Decimal(18, 2)), 16, 2387, CAST(N'2022-06-16T02:04:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.88 AS Decimal(18, 2)), 16, 2388, CAST(N'2022-07-29T02:39:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.74 AS Decimal(18, 2)), 31, 2389, CAST(N'2021-06-18T23:37:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.59 AS Decimal(18, 2)), 27, 2390, CAST(N'2021-11-18T04:37:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(2.80 AS Decimal(18, 2)), 15, 2391, CAST(N'2022-05-12T05:02:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.54 AS Decimal(18, 2)), 18, 2392, CAST(N'2021-08-29T03:39:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(6.75 AS Decimal(18, 2)), 34, 2393, CAST(N'2021-07-21T04:25:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(5.37 AS Decimal(18, 2)), 14, 2394, CAST(N'2021-08-22T08:45:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.23 AS Decimal(18, 2)), 3, 2395, CAST(N'2022-04-05T03:52:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.02 AS Decimal(18, 2)), 3, 2396, CAST(N'2022-02-06T23:26:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.37 AS Decimal(18, 2)), 25, 2397, CAST(N'2021-08-09T03:25:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(4.54 AS Decimal(18, 2)), 31, 2398, CAST(N'2021-09-07T10:31:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.71 AS Decimal(18, 2)), 40, 2399, CAST(N'2022-07-26T23:18:07.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.19 AS Decimal(18, 2)), 26, 2400, CAST(N'2022-07-30T05:33:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.13 AS Decimal(18, 2)), 30, 2401, CAST(N'2021-09-03T05:08:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(8.24 AS Decimal(18, 2)), 38, 2402, CAST(N'2021-09-04T14:25:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.62 AS Decimal(18, 2)), 7, 2403, CAST(N'2021-08-17T01:37:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(2.47 AS Decimal(18, 2)), 4, 2404, CAST(N'2022-06-01T19:02:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.90 AS Decimal(18, 2)), 14, 2405, CAST(N'2021-07-01T14:03:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.22 AS Decimal(18, 2)), 12, 2406, CAST(N'2022-07-31T12:54:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.24 AS Decimal(18, 2)), 7, 2407, CAST(N'2022-05-09T16:43:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.69 AS Decimal(18, 2)), 39, 2408, CAST(N'2021-11-28T01:06:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.69 AS Decimal(18, 2)), 23, 2409, CAST(N'2022-04-27T22:49:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.05 AS Decimal(18, 2)), 27, 2410, CAST(N'2022-07-19T03:03:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.24 AS Decimal(18, 2)), 48, 2411, CAST(N'2022-04-17T03:19:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.40 AS Decimal(18, 2)), 2, 2412, CAST(N'2022-05-06T17:43:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(4.15 AS Decimal(18, 2)), 8, 2413, CAST(N'2021-10-11T14:16:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.72 AS Decimal(18, 2)), 8, 2414, CAST(N'2022-05-24T06:25:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(3.91 AS Decimal(18, 2)), 48, 2415, CAST(N'2021-08-11T17:16:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.79 AS Decimal(18, 2)), 49, 2416, CAST(N'2022-01-29T06:24:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.92 AS Decimal(18, 2)), 24, 2417, CAST(N'2021-08-18T18:28:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.24 AS Decimal(18, 2)), 49, 2418, CAST(N'2022-02-10T17:01:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(2.07 AS Decimal(18, 2)), 1, 2419, CAST(N'2022-03-22T21:04:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.22 AS Decimal(18, 2)), 13, 2420, CAST(N'2022-03-21T13:34:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.71 AS Decimal(18, 2)), 6, 2421, CAST(N'2021-07-24T20:56:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(6.77 AS Decimal(18, 2)), 41, 2422, CAST(N'2021-08-08T04:46:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(9.11 AS Decimal(18, 2)), 17, 2423, CAST(N'2021-06-08T01:51:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.17 AS Decimal(18, 2)), 47, 2424, CAST(N'2021-10-20T11:29:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(4.10 AS Decimal(18, 2)), 5, 2425, CAST(N'2022-07-14T20:13:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(2.78 AS Decimal(18, 2)), 46, 2426, CAST(N'2022-04-17T03:40:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.72 AS Decimal(18, 2)), 13, 2427, CAST(N'2021-07-21T00:03:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.21 AS Decimal(18, 2)), 1, 2428, CAST(N'2021-12-08T03:17:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.47 AS Decimal(18, 2)), 36, 2429, CAST(N'2021-11-21T11:23:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.98 AS Decimal(18, 2)), 18, 2430, CAST(N'2021-07-04T22:19:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.74 AS Decimal(18, 2)), 38, 2431, CAST(N'2022-07-04T10:36:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(6.57 AS Decimal(18, 2)), 50, 2432, CAST(N'2022-05-11T00:28:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.76 AS Decimal(18, 2)), 42, 2433, CAST(N'2022-06-05T18:59:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.65 AS Decimal(18, 2)), 31, 2434, CAST(N'2022-05-30T04:44:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.73 AS Decimal(18, 2)), 37, 2435, CAST(N'2021-06-05T16:46:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.71 AS Decimal(18, 2)), 5, 2436, CAST(N'2021-11-07T06:08:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.44 AS Decimal(18, 2)), 7, 2437, CAST(N'2022-01-18T13:40:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.50 AS Decimal(18, 2)), 30, 2438, CAST(N'2022-06-08T20:49:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(7.70 AS Decimal(18, 2)), 16, 2439, CAST(N'2022-06-21T03:06:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.18 AS Decimal(18, 2)), 31, 2440, CAST(N'2021-12-01T06:58:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.04 AS Decimal(18, 2)), 25, 2441, CAST(N'2021-08-19T03:32:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.94 AS Decimal(18, 2)), 27, 2442, CAST(N'2022-06-16T07:13:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.53 AS Decimal(18, 2)), 5, 2443, CAST(N'2022-02-15T06:46:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.49 AS Decimal(18, 2)), 31, 2444, CAST(N'2022-05-02T17:01:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.40 AS Decimal(18, 2)), 3, 2445, CAST(N'2022-07-14T17:38:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.80 AS Decimal(18, 2)), 19, 2446, CAST(N'2022-04-06T22:42:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.50 AS Decimal(18, 2)), 48, 2447, CAST(N'2022-07-05T06:18:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(6.49 AS Decimal(18, 2)), 19, 2448, CAST(N'2021-12-11T11:30:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(6.40 AS Decimal(18, 2)), 32, 2449, CAST(N'2022-06-09T15:23:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.75 AS Decimal(18, 2)), 9, 2450, CAST(N'2022-01-23T01:22:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.19 AS Decimal(18, 2)), 40, 2451, CAST(N'2021-06-22T19:08:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(7.64 AS Decimal(18, 2)), 45, 2452, CAST(N'2022-07-20T17:07:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.25 AS Decimal(18, 2)), 42, 2453, CAST(N'2022-04-29T01:38:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.43 AS Decimal(18, 2)), 13, 2454, CAST(N'2022-02-05T01:46:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.05 AS Decimal(18, 2)), 24, 2455, CAST(N'2021-08-24T03:44:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.20 AS Decimal(18, 2)), 47, 2456, CAST(N'2021-12-07T16:49:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.17 AS Decimal(18, 2)), 46, 2457, CAST(N'2021-11-10T09:47:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.73 AS Decimal(18, 2)), 13, 2458, CAST(N'2022-07-11T20:39:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.53 AS Decimal(18, 2)), 44, 2459, CAST(N'2021-09-04T04:02:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.07 AS Decimal(18, 2)), 2, 2460, CAST(N'2021-11-19T00:27:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.83 AS Decimal(18, 2)), 15, 2461, CAST(N'2022-07-25T11:25:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(4.67 AS Decimal(18, 2)), 3, 2462, CAST(N'2022-06-04T00:09:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.48 AS Decimal(18, 2)), 10, 2463, CAST(N'2022-02-07T05:58:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.11 AS Decimal(18, 2)), 14, 2464, CAST(N'2022-06-08T01:52:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.29 AS Decimal(18, 2)), 50, 2465, CAST(N'2022-04-02T04:51:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.62 AS Decimal(18, 2)), 31, 2466, CAST(N'2022-04-18T12:20:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(9.22 AS Decimal(18, 2)), 3, 2467, CAST(N'2022-08-14T20:58:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.03 AS Decimal(18, 2)), 38, 2468, CAST(N'2022-06-11T07:15:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.82 AS Decimal(18, 2)), 3, 2469, CAST(N'2022-07-25T03:47:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.76 AS Decimal(18, 2)), 11, 2470, CAST(N'2021-11-14T01:46:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(2.44 AS Decimal(18, 2)), 10, 2471, CAST(N'2022-03-23T08:52:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.73 AS Decimal(18, 2)), 43, 2472, CAST(N'2022-05-05T16:00:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.10 AS Decimal(18, 2)), 2, 2473, CAST(N'2022-07-01T10:27:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.51 AS Decimal(18, 2)), 26, 2474, CAST(N'2021-08-01T13:05:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.96 AS Decimal(18, 2)), 28, 2475, CAST(N'2022-06-06T16:11:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.10 AS Decimal(18, 2)), 2, 2476, CAST(N'2021-09-01T18:29:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(5.17 AS Decimal(18, 2)), 32, 2477, CAST(N'2022-07-20T01:50:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.55 AS Decimal(18, 2)), 41, 2478, CAST(N'2021-11-26T08:19:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.71 AS Decimal(18, 2)), 35, 2479, CAST(N'2022-06-24T03:53:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.84 AS Decimal(18, 2)), 17, 2480, CAST(N'2022-01-11T18:55:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.55 AS Decimal(18, 2)), 7, 2481, CAST(N'2021-12-22T09:46:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.31 AS Decimal(18, 2)), 40, 2482, CAST(N'2021-08-07T00:39:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.95 AS Decimal(18, 2)), 46, 2483, CAST(N'2021-11-18T15:19:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(3.63 AS Decimal(18, 2)), 49, 2484, CAST(N'2021-09-27T11:12:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.57 AS Decimal(18, 2)), 48, 2485, CAST(N'2022-08-03T03:11:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(2.35 AS Decimal(18, 2)), 35, 2486, CAST(N'2021-07-30T15:06:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(4.50 AS Decimal(18, 2)), 34, 2487, CAST(N'2022-02-16T17:59:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.59 AS Decimal(18, 2)), 44, 2488, CAST(N'2021-06-23T03:35:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.34 AS Decimal(18, 2)), 26, 2489, CAST(N'2022-06-17T00:32:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(7.67 AS Decimal(18, 2)), 27, 2490, CAST(N'2022-01-24T22:03:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.47 AS Decimal(18, 2)), 40, 2491, CAST(N'2021-06-12T10:16:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.18 AS Decimal(18, 2)), 36, 2492, CAST(N'2022-05-11T21:21:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.73 AS Decimal(18, 2)), 30, 2493, CAST(N'2021-06-25T16:53:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.56 AS Decimal(18, 2)), 18, 2494, CAST(N'2022-08-07T14:27:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.55 AS Decimal(18, 2)), 12, 2495, CAST(N'2021-06-25T15:08:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(4.16 AS Decimal(18, 2)), 14, 2496, CAST(N'2021-10-04T12:58:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.62 AS Decimal(18, 2)), 15, 2497, CAST(N'2022-01-08T04:42:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.27 AS Decimal(18, 2)), 39, 2498, CAST(N'2022-08-08T13:23:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.21 AS Decimal(18, 2)), 50, 2499, CAST(N'2022-03-03T17:12:27.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.13 AS Decimal(18, 2)), 39, 2500, CAST(N'2022-06-15T15:15:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.47 AS Decimal(18, 2)), 45, 2501, CAST(N'2022-01-16T21:45:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.80 AS Decimal(18, 2)), 12, 2502, CAST(N'2021-07-20T04:55:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(7.00 AS Decimal(18, 2)), 19, 2503, CAST(N'2022-04-03T18:49:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(5.47 AS Decimal(18, 2)), 5, 2504, CAST(N'2022-04-13T08:08:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(8.13 AS Decimal(18, 2)), 6, 2505, CAST(N'2021-09-01T04:58:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.17 AS Decimal(18, 2)), 1, 2506, CAST(N'2021-09-24T05:40:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.10 AS Decimal(18, 2)), 35, 2507, CAST(N'2022-07-12T09:29:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.88 AS Decimal(18, 2)), 45, 2508, CAST(N'2022-07-06T13:01:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(2.13 AS Decimal(18, 2)), 41, 2509, CAST(N'2021-06-08T10:55:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(2.47 AS Decimal(18, 2)), 32, 2510, CAST(N'2022-07-19T05:40:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(6.52 AS Decimal(18, 2)), 46, 2511, CAST(N'2021-12-07T03:42:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.39 AS Decimal(18, 2)), 46, 2512, CAST(N'2021-07-02T05:34:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.38 AS Decimal(18, 2)), 29, 2513, CAST(N'2021-11-07T02:33:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.03 AS Decimal(18, 2)), 17, 2514, CAST(N'2021-12-22T02:12:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.68 AS Decimal(18, 2)), 36, 2515, CAST(N'2022-04-25T00:26:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.88 AS Decimal(18, 2)), 30, 2516, CAST(N'2021-12-30T15:39:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.44 AS Decimal(18, 2)), 37, 2517, CAST(N'2021-12-14T10:39:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.45 AS Decimal(18, 2)), 20, 2518, CAST(N'2021-07-03T04:14:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(4.90 AS Decimal(18, 2)), 15, 2519, CAST(N'2022-01-05T01:16:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.55 AS Decimal(18, 2)), 6, 2520, CAST(N'2021-09-24T19:19:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.42 AS Decimal(18, 2)), 50, 2521, CAST(N'2021-08-29T13:31:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.42 AS Decimal(18, 2)), 28, 2522, CAST(N'2021-06-15T10:29:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.66 AS Decimal(18, 2)), 43, 2523, CAST(N'2022-08-05T10:46:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.05 AS Decimal(18, 2)), 35, 2524, CAST(N'2022-04-07T03:16:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(3.88 AS Decimal(18, 2)), 48, 2525, CAST(N'2021-10-12T08:07:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.62 AS Decimal(18, 2)), 9, 2526, CAST(N'2022-08-15T01:36:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.50 AS Decimal(18, 2)), 9, 2527, CAST(N'2021-09-25T16:20:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.74 AS Decimal(18, 2)), 17, 2528, CAST(N'2022-01-06T11:18:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.18 AS Decimal(18, 2)), 5, 2529, CAST(N'2022-02-26T02:09:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.25 AS Decimal(18, 2)), 43, 2530, CAST(N'2021-09-29T10:09:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.25 AS Decimal(18, 2)), 37, 2531, CAST(N'2021-10-15T23:02:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.55 AS Decimal(18, 2)), 39, 2532, CAST(N'2021-07-20T23:30:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(1.29 AS Decimal(18, 2)), 15, 2533, CAST(N'2021-07-04T11:05:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.13 AS Decimal(18, 2)), 9, 2534, CAST(N'2022-07-26T03:02:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.17 AS Decimal(18, 2)), 14, 2535, CAST(N'2022-02-03T09:11:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.01 AS Decimal(18, 2)), 23, 2536, CAST(N'2022-06-08T21:28:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.62 AS Decimal(18, 2)), 48, 2537, CAST(N'2021-09-08T00:38:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(2.68 AS Decimal(18, 2)), 33, 2538, CAST(N'2021-08-25T05:23:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.58 AS Decimal(18, 2)), 48, 2539, CAST(N'2022-05-02T23:05:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.60 AS Decimal(18, 2)), 45, 2540, CAST(N'2022-01-24T07:05:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.32 AS Decimal(18, 2)), 41, 2541, CAST(N'2022-07-14T17:14:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.94 AS Decimal(18, 2)), 16, 2542, CAST(N'2021-10-31T15:36:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(9.34 AS Decimal(18, 2)), 29, 2543, CAST(N'2022-05-20T15:42:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(2.93 AS Decimal(18, 2)), 8, 2544, CAST(N'2022-02-05T10:17:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.31 AS Decimal(18, 2)), 24, 2545, CAST(N'2021-07-27T03:39:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(4.58 AS Decimal(18, 2)), 39, 2546, CAST(N'2022-08-13T12:30:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.97 AS Decimal(18, 2)), 35, 2547, CAST(N'2021-12-21T03:46:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.52 AS Decimal(18, 2)), 6, 2548, CAST(N'2021-11-17T23:55:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.31 AS Decimal(18, 2)), 19, 2549, CAST(N'2021-06-23T00:03:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.03 AS Decimal(18, 2)), 5, 2550, CAST(N'2022-01-27T05:38:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.59 AS Decimal(18, 2)), 31, 2551, CAST(N'2021-11-12T21:11:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(4.59 AS Decimal(18, 2)), 29, 2552, CAST(N'2022-05-15T00:51:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.47 AS Decimal(18, 2)), 14, 2553, CAST(N'2021-06-29T07:10:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.62 AS Decimal(18, 2)), 34, 2554, CAST(N'2021-09-30T14:44:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(2.60 AS Decimal(18, 2)), 1, 2555, CAST(N'2021-10-06T22:35:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(9.17 AS Decimal(18, 2)), 10, 2556, CAST(N'2022-05-22T09:10:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.93 AS Decimal(18, 2)), 3, 2557, CAST(N'2021-09-10T20:23:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.89 AS Decimal(18, 2)), 18, 2558, CAST(N'2021-06-21T14:20:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.34 AS Decimal(18, 2)), 43, 2559, CAST(N'2022-03-26T23:26:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(6.80 AS Decimal(18, 2)), 2, 2560, CAST(N'2022-04-06T08:00:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.78 AS Decimal(18, 2)), 41, 2561, CAST(N'2022-01-06T09:02:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.17 AS Decimal(18, 2)), 2, 2562, CAST(N'2021-06-12T17:22:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(5.40 AS Decimal(18, 2)), 45, 2563, CAST(N'2022-03-01T03:06:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(9.61 AS Decimal(18, 2)), 35, 2564, CAST(N'2022-06-29T08:54:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.43 AS Decimal(18, 2)), 11, 2565, CAST(N'2022-07-08T09:37:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.32 AS Decimal(18, 2)), 20, 2566, CAST(N'2021-11-17T10:12:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.09 AS Decimal(18, 2)), 3, 2567, CAST(N'2021-11-27T14:04:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.24 AS Decimal(18, 2)), 37, 2568, CAST(N'2022-07-05T12:49:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.11 AS Decimal(18, 2)), 19, 2569, CAST(N'2021-12-29T18:30:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(4.13 AS Decimal(18, 2)), 32, 2570, CAST(N'2021-10-13T11:20:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.67 AS Decimal(18, 2)), 38, 2571, CAST(N'2022-06-03T17:49:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.86 AS Decimal(18, 2)), 45, 2572, CAST(N'2021-10-05T01:49:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.62 AS Decimal(18, 2)), 3, 2573, CAST(N'2021-10-25T00:42:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.55 AS Decimal(18, 2)), 22, 2574, CAST(N'2022-03-07T13:38:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.57 AS Decimal(18, 2)), 39, 2575, CAST(N'2022-07-18T17:22:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.79 AS Decimal(18, 2)), 15, 2576, CAST(N'2021-10-29T08:42:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(2.93 AS Decimal(18, 2)), 28, 2577, CAST(N'2021-09-14T17:56:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.65 AS Decimal(18, 2)), 42, 2578, CAST(N'2022-06-08T03:28:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.66 AS Decimal(18, 2)), 44, 2579, CAST(N'2022-04-20T02:06:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.26 AS Decimal(18, 2)), 39, 2580, CAST(N'2021-09-04T10:52:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(4.81 AS Decimal(18, 2)), 9, 2581, CAST(N'2021-12-11T18:11:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(2.06 AS Decimal(18, 2)), 2, 2582, CAST(N'2021-06-28T09:10:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(3.27 AS Decimal(18, 2)), 5, 2583, CAST(N'2022-07-25T13:29:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.40 AS Decimal(18, 2)), 47, 2584, CAST(N'2021-06-01T02:49:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(5.79 AS Decimal(18, 2)), 47, 2585, CAST(N'2022-03-29T05:23:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.70 AS Decimal(18, 2)), 2, 2586, CAST(N'2021-11-09T21:09:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.63 AS Decimal(18, 2)), 10, 2587, CAST(N'2022-01-14T05:39:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.82 AS Decimal(18, 2)), 6, 2588, CAST(N'2022-08-05T07:59:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.52 AS Decimal(18, 2)), 14, 2589, CAST(N'2022-03-11T14:29:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.49 AS Decimal(18, 2)), 16, 2590, CAST(N'2021-10-16T10:51:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(3.46 AS Decimal(18, 2)), 27, 2591, CAST(N'2021-12-16T22:37:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(8.41 AS Decimal(18, 2)), 15, 2592, CAST(N'2022-06-28T04:43:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(5.19 AS Decimal(18, 2)), 17, 2593, CAST(N'2021-06-14T15:57:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.86 AS Decimal(18, 2)), 22, 2594, CAST(N'2022-06-24T21:41:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(5.87 AS Decimal(18, 2)), 35, 2595, CAST(N'2022-01-01T12:33:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.01 AS Decimal(18, 2)), 21, 2596, CAST(N'2021-06-13T09:19:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.74 AS Decimal(18, 2)), 24, 2597, CAST(N'2021-11-01T03:10:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(9.99 AS Decimal(18, 2)), 35, 2598, CAST(N'2021-07-20T18:07:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.84 AS Decimal(18, 2)), 3, 2599, CAST(N'2022-05-24T04:16:20.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(6.07 AS Decimal(18, 2)), 1, 2600, CAST(N'2021-06-17T08:55:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.42 AS Decimal(18, 2)), 35, 2601, CAST(N'2022-01-18T01:16:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(6.60 AS Decimal(18, 2)), 50, 2602, CAST(N'2022-01-08T14:44:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.09 AS Decimal(18, 2)), 38, 2603, CAST(N'2022-02-10T03:57:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.30 AS Decimal(18, 2)), 42, 2604, CAST(N'2021-10-27T10:42:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.23 AS Decimal(18, 2)), 47, 2605, CAST(N'2022-03-02T07:53:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(4.48 AS Decimal(18, 2)), 3, 2606, CAST(N'2021-06-08T03:19:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.75 AS Decimal(18, 2)), 26, 2607, CAST(N'2022-07-05T16:43:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(9.86 AS Decimal(18, 2)), 8, 2608, CAST(N'2022-03-03T14:42:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.84 AS Decimal(18, 2)), 37, 2609, CAST(N'2021-07-21T03:26:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.96 AS Decimal(18, 2)), 27, 2610, CAST(N'2021-08-15T05:14:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.57 AS Decimal(18, 2)), 2, 2611, CAST(N'2022-03-06T03:20:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(8.47 AS Decimal(18, 2)), 17, 2612, CAST(N'2021-07-13T23:42:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.64 AS Decimal(18, 2)), 13, 2613, CAST(N'2021-12-05T07:16:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(9.17 AS Decimal(18, 2)), 39, 2614, CAST(N'2021-10-18T08:22:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.38 AS Decimal(18, 2)), 4, 2615, CAST(N'2021-07-30T13:08:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.05 AS Decimal(18, 2)), 31, 2616, CAST(N'2021-07-01T18:45:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.89 AS Decimal(18, 2)), 39, 2617, CAST(N'2022-05-29T09:49:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(8.66 AS Decimal(18, 2)), 37, 2618, CAST(N'2021-07-22T22:48:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(6.70 AS Decimal(18, 2)), 11, 2619, CAST(N'2022-06-23T10:16:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.51 AS Decimal(18, 2)), 14, 2620, CAST(N'2022-01-27T02:28:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.29 AS Decimal(18, 2)), 11, 2621, CAST(N'2022-05-22T01:56:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.93 AS Decimal(18, 2)), 3, 2622, CAST(N'2022-01-07T04:33:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(5.62 AS Decimal(18, 2)), 1, 2623, CAST(N'2022-06-28T22:50:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(1.23 AS Decimal(18, 2)), 20, 2624, CAST(N'2021-06-06T04:54:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.57 AS Decimal(18, 2)), 39, 2625, CAST(N'2022-03-09T12:44:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.55 AS Decimal(18, 2)), 44, 2626, CAST(N'2021-12-14T08:18:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.38 AS Decimal(18, 2)), 17, 2627, CAST(N'2022-07-13T22:20:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.65 AS Decimal(18, 2)), 28, 2628, CAST(N'2021-10-10T12:01:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.87 AS Decimal(18, 2)), 30, 2629, CAST(N'2022-01-08T15:03:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.73 AS Decimal(18, 2)), 47, 2630, CAST(N'2022-05-11T21:36:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.31 AS Decimal(18, 2)), 11, 2631, CAST(N'2021-10-31T19:01:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.79 AS Decimal(18, 2)), 5, 2632, CAST(N'2022-03-17T09:35:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(2.08 AS Decimal(18, 2)), 23, 2633, CAST(N'2022-01-30T08:13:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.50 AS Decimal(18, 2)), 10, 2634, CAST(N'2021-12-27T06:37:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.76 AS Decimal(18, 2)), 11, 2635, CAST(N'2021-07-25T02:27:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.58 AS Decimal(18, 2)), 4, 2636, CAST(N'2022-01-30T03:49:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.08 AS Decimal(18, 2)), 26, 2637, CAST(N'2021-12-24T07:36:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.28 AS Decimal(18, 2)), 21, 2638, CAST(N'2021-12-25T06:33:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.13 AS Decimal(18, 2)), 42, 2639, CAST(N'2021-08-15T23:01:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(2.08 AS Decimal(18, 2)), 36, 2640, CAST(N'2021-06-24T23:51:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.35 AS Decimal(18, 2)), 20, 2641, CAST(N'2021-12-14T23:29:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.36 AS Decimal(18, 2)), 38, 2642, CAST(N'2021-08-17T05:49:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(1.36 AS Decimal(18, 2)), 29, 2643, CAST(N'2021-06-27T14:06:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(3.43 AS Decimal(18, 2)), 20, 2644, CAST(N'2022-05-26T02:32:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.04 AS Decimal(18, 2)), 46, 2645, CAST(N'2022-03-01T21:53:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(2.43 AS Decimal(18, 2)), 27, 2646, CAST(N'2021-06-15T05:19:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.81 AS Decimal(18, 2)), 33, 2647, CAST(N'2021-07-17T21:31:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.08 AS Decimal(18, 2)), 19, 2648, CAST(N'2022-04-12T19:21:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.82 AS Decimal(18, 2)), 4, 2649, CAST(N'2021-09-28T00:02:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.37 AS Decimal(18, 2)), 50, 2650, CAST(N'2021-06-18T00:53:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.21 AS Decimal(18, 2)), 42, 2651, CAST(N'2022-07-25T05:10:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.37 AS Decimal(18, 2)), 30, 2652, CAST(N'2021-12-07T12:28:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.36 AS Decimal(18, 2)), 40, 2653, CAST(N'2021-07-05T13:06:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.49 AS Decimal(18, 2)), 28, 2654, CAST(N'2021-07-30T14:19:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.39 AS Decimal(18, 2)), 12, 2655, CAST(N'2022-06-03T15:21:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.63 AS Decimal(18, 2)), 45, 2656, CAST(N'2022-04-20T07:43:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(9.44 AS Decimal(18, 2)), 44, 2657, CAST(N'2021-12-30T03:58:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.81 AS Decimal(18, 2)), 46, 2658, CAST(N'2022-06-06T23:11:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.44 AS Decimal(18, 2)), 40, 2659, CAST(N'2021-12-06T17:56:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.34 AS Decimal(18, 2)), 22, 2660, CAST(N'2022-01-23T16:32:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.20 AS Decimal(18, 2)), 9, 2661, CAST(N'2021-12-21T22:29:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.74 AS Decimal(18, 2)), 3, 2662, CAST(N'2021-10-09T00:00:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.95 AS Decimal(18, 2)), 35, 2663, CAST(N'2022-01-14T10:02:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.47 AS Decimal(18, 2)), 5, 2664, CAST(N'2022-07-19T16:01:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(1.03 AS Decimal(18, 2)), 43, 2665, CAST(N'2021-06-18T03:01:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.91 AS Decimal(18, 2)), 33, 2666, CAST(N'2021-08-29T05:24:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.28 AS Decimal(18, 2)), 11, 2667, CAST(N'2021-12-29T14:27:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.94 AS Decimal(18, 2)), 35, 2668, CAST(N'2022-06-01T12:02:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.75 AS Decimal(18, 2)), 26, 2669, CAST(N'2022-07-26T05:15:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.66 AS Decimal(18, 2)), 46, 2670, CAST(N'2022-08-10T01:43:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.88 AS Decimal(18, 2)), 25, 2671, CAST(N'2022-01-21T05:26:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.45 AS Decimal(18, 2)), 23, 2672, CAST(N'2022-06-04T07:30:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.23 AS Decimal(18, 2)), 42, 2673, CAST(N'2021-08-10T10:21:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.80 AS Decimal(18, 2)), 15, 2674, CAST(N'2022-05-23T17:33:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.71 AS Decimal(18, 2)), 45, 2675, CAST(N'2022-03-10T17:32:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.14 AS Decimal(18, 2)), 45, 2676, CAST(N'2022-01-13T04:21:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.31 AS Decimal(18, 2)), 3, 2677, CAST(N'2022-04-29T06:18:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.22 AS Decimal(18, 2)), 21, 2678, CAST(N'2022-03-13T21:33:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.28 AS Decimal(18, 2)), 25, 2679, CAST(N'2021-09-14T12:17:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(6.61 AS Decimal(18, 2)), 45, 2680, CAST(N'2021-07-29T09:42:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.26 AS Decimal(18, 2)), 8, 2681, CAST(N'2022-07-15T08:12:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.27 AS Decimal(18, 2)), 7, 2682, CAST(N'2022-02-20T17:00:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(4.36 AS Decimal(18, 2)), 29, 2683, CAST(N'2021-11-04T02:22:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.57 AS Decimal(18, 2)), 14, 2684, CAST(N'2022-05-13T05:54:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.69 AS Decimal(18, 2)), 19, 2685, CAST(N'2022-04-04T11:16:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.24 AS Decimal(18, 2)), 3, 2686, CAST(N'2021-10-26T08:12:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(2.14 AS Decimal(18, 2)), 40, 2687, CAST(N'2021-09-09T17:19:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.17 AS Decimal(18, 2)), 27, 2688, CAST(N'2022-07-26T02:21:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.35 AS Decimal(18, 2)), 33, 2689, CAST(N'2022-06-13T00:42:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.34 AS Decimal(18, 2)), 35, 2690, CAST(N'2021-09-23T22:24:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.57 AS Decimal(18, 2)), 37, 2691, CAST(N'2021-10-12T11:37:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(8.19 AS Decimal(18, 2)), 46, 2692, CAST(N'2021-09-17T01:27:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(5.51 AS Decimal(18, 2)), 41, 2693, CAST(N'2021-09-12T02:03:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.36 AS Decimal(18, 2)), 37, 2694, CAST(N'2021-07-01T12:29:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(1.47 AS Decimal(18, 2)), 5, 2695, CAST(N'2021-12-07T04:14:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.85 AS Decimal(18, 2)), 42, 2696, CAST(N'2022-05-08T03:51:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(5.90 AS Decimal(18, 2)), 27, 2697, CAST(N'2021-07-14T01:09:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.80 AS Decimal(18, 2)), 16, 2698, CAST(N'2022-02-08T19:01:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(9.50 AS Decimal(18, 2)), 42, 2699, CAST(N'2022-06-02T21:12:06.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(6.52 AS Decimal(18, 2)), 41, 2700, CAST(N'2021-09-16T02:40:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.58 AS Decimal(18, 2)), 43, 2701, CAST(N'2021-12-07T02:02:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(7.39 AS Decimal(18, 2)), 12, 2702, CAST(N'2022-06-05T02:20:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.52 AS Decimal(18, 2)), 13, 2703, CAST(N'2021-07-30T16:29:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.34 AS Decimal(18, 2)), 20, 2704, CAST(N'2022-01-05T16:52:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.05 AS Decimal(18, 2)), 50, 2705, CAST(N'2022-07-25T04:47:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.79 AS Decimal(18, 2)), 41, 2706, CAST(N'2021-12-13T16:14:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.69 AS Decimal(18, 2)), 33, 2707, CAST(N'2021-06-18T16:42:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.60 AS Decimal(18, 2)), 21, 2708, CAST(N'2021-10-08T03:48:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.11 AS Decimal(18, 2)), 7, 2709, CAST(N'2022-07-07T06:50:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(7.32 AS Decimal(18, 2)), 26, 2710, CAST(N'2021-11-20T00:41:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.89 AS Decimal(18, 2)), 23, 2711, CAST(N'2021-08-30T00:14:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.10 AS Decimal(18, 2)), 44, 2712, CAST(N'2022-04-28T10:48:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(5.88 AS Decimal(18, 2)), 26, 2713, CAST(N'2022-07-26T10:25:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.67 AS Decimal(18, 2)), 46, 2714, CAST(N'2022-07-19T22:09:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(3.75 AS Decimal(18, 2)), 13, 2715, CAST(N'2021-12-23T17:13:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.85 AS Decimal(18, 2)), 26, 2716, CAST(N'2022-02-13T00:16:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.67 AS Decimal(18, 2)), 17, 2717, CAST(N'2021-08-16T15:58:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(6.20 AS Decimal(18, 2)), 22, 2718, CAST(N'2021-09-19T10:04:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(1.94 AS Decimal(18, 2)), 7, 2719, CAST(N'2021-06-29T22:31:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.72 AS Decimal(18, 2)), 35, 2720, CAST(N'2022-04-06T19:54:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.77 AS Decimal(18, 2)), 48, 2721, CAST(N'2022-07-23T07:22:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.67 AS Decimal(18, 2)), 43, 2722, CAST(N'2022-08-13T10:32:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.92 AS Decimal(18, 2)), 26, 2723, CAST(N'2022-02-28T10:58:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.56 AS Decimal(18, 2)), 20, 2724, CAST(N'2022-04-05T08:58:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(8.64 AS Decimal(18, 2)), 31, 2725, CAST(N'2022-05-21T00:36:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.29 AS Decimal(18, 2)), 14, 2726, CAST(N'2022-02-07T15:18:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.38 AS Decimal(18, 2)), 38, 2727, CAST(N'2021-12-07T00:56:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(7.06 AS Decimal(18, 2)), 5, 2728, CAST(N'2021-11-16T13:41:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.10 AS Decimal(18, 2)), 28, 2729, CAST(N'2022-01-01T00:41:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.64 AS Decimal(18, 2)), 47, 2730, CAST(N'2022-02-18T19:41:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.92 AS Decimal(18, 2)), 32, 2731, CAST(N'2021-08-30T02:45:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(6.89 AS Decimal(18, 2)), 7, 2732, CAST(N'2021-06-22T15:55:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.46 AS Decimal(18, 2)), 12, 2733, CAST(N'2022-02-18T18:31:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.41 AS Decimal(18, 2)), 25, 2734, CAST(N'2022-01-14T07:34:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.54 AS Decimal(18, 2)), 16, 2735, CAST(N'2021-12-08T04:49:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.23 AS Decimal(18, 2)), 46, 2736, CAST(N'2021-06-11T17:59:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.04 AS Decimal(18, 2)), 32, 2737, CAST(N'2022-03-14T22:42:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(7.55 AS Decimal(18, 2)), 34, 2738, CAST(N'2021-06-10T15:11:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(5.71 AS Decimal(18, 2)), 35, 2739, CAST(N'2022-02-05T06:10:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.99 AS Decimal(18, 2)), 9, 2740, CAST(N'2021-08-22T10:18:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.20 AS Decimal(18, 2)), 17, 2741, CAST(N'2022-08-05T04:05:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(7.04 AS Decimal(18, 2)), 18, 2742, CAST(N'2022-04-30T11:22:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(5.64 AS Decimal(18, 2)), 37, 2743, CAST(N'2021-09-26T20:53:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.22 AS Decimal(18, 2)), 7, 2744, CAST(N'2022-02-05T05:36:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.08 AS Decimal(18, 2)), 11, 2745, CAST(N'2022-06-04T13:23:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.71 AS Decimal(18, 2)), 40, 2746, CAST(N'2021-11-14T21:35:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(2.97 AS Decimal(18, 2)), 34, 2747, CAST(N'2021-09-06T06:11:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(7.98 AS Decimal(18, 2)), 42, 2748, CAST(N'2022-06-08T08:18:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.74 AS Decimal(18, 2)), 14, 2749, CAST(N'2022-07-09T18:27:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.17 AS Decimal(18, 2)), 44, 2750, CAST(N'2022-05-06T19:28:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.59 AS Decimal(18, 2)), 40, 2751, CAST(N'2022-04-22T19:39:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.47 AS Decimal(18, 2)), 17, 2752, CAST(N'2022-03-26T17:37:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.91 AS Decimal(18, 2)), 27, 2753, CAST(N'2022-03-01T16:28:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(1.22 AS Decimal(18, 2)), 43, 2754, CAST(N'2022-01-14T07:46:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.25 AS Decimal(18, 2)), 42, 2755, CAST(N'2021-12-05T11:48:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.43 AS Decimal(18, 2)), 48, 2756, CAST(N'2022-05-05T19:06:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.81 AS Decimal(18, 2)), 28, 2757, CAST(N'2021-09-26T15:10:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(4.82 AS Decimal(18, 2)), 4, 2758, CAST(N'2022-05-13T19:41:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.59 AS Decimal(18, 2)), 3, 2759, CAST(N'2022-02-03T00:59:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.73 AS Decimal(18, 2)), 45, 2760, CAST(N'2022-04-18T06:48:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.17 AS Decimal(18, 2)), 50, 2761, CAST(N'2021-09-28T01:25:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.94 AS Decimal(18, 2)), 39, 2762, CAST(N'2021-06-22T02:35:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(4.42 AS Decimal(18, 2)), 42, 2763, CAST(N'2022-07-21T17:29:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.07 AS Decimal(18, 2)), 21, 2764, CAST(N'2022-05-17T17:01:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(2.41 AS Decimal(18, 2)), 29, 2765, CAST(N'2021-10-21T18:34:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.21 AS Decimal(18, 2)), 29, 2766, CAST(N'2022-01-23T09:30:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.75 AS Decimal(18, 2)), 33, 2767, CAST(N'2022-04-19T06:03:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.57 AS Decimal(18, 2)), 32, 2768, CAST(N'2021-10-01T11:13:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(1.51 AS Decimal(18, 2)), 12, 2769, CAST(N'2021-12-29T16:08:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(2.66 AS Decimal(18, 2)), 31, 2770, CAST(N'2021-09-05T04:54:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.73 AS Decimal(18, 2)), 42, 2771, CAST(N'2021-12-20T00:22:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.08 AS Decimal(18, 2)), 9, 2772, CAST(N'2022-06-22T19:11:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.84 AS Decimal(18, 2)), 6, 2773, CAST(N'2022-05-28T08:20:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.82 AS Decimal(18, 2)), 23, 2774, CAST(N'2021-10-28T06:14:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.99 AS Decimal(18, 2)), 22, 2775, CAST(N'2022-03-01T12:54:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.56 AS Decimal(18, 2)), 9, 2776, CAST(N'2022-05-24T02:23:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(8.08 AS Decimal(18, 2)), 43, 2777, CAST(N'2022-04-12T05:10:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.83 AS Decimal(18, 2)), 19, 2778, CAST(N'2021-12-27T17:47:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.80 AS Decimal(18, 2)), 38, 2779, CAST(N'2021-10-04T20:54:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.37 AS Decimal(18, 2)), 6, 2780, CAST(N'2022-03-06T15:47:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.34 AS Decimal(18, 2)), 36, 2781, CAST(N'2021-07-07T17:57:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.67 AS Decimal(18, 2)), 45, 2782, CAST(N'2022-07-25T10:58:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.79 AS Decimal(18, 2)), 43, 2783, CAST(N'2021-08-02T06:52:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.55 AS Decimal(18, 2)), 21, 2784, CAST(N'2022-05-17T15:46:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(6.80 AS Decimal(18, 2)), 22, 2785, CAST(N'2022-06-12T21:17:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(3.86 AS Decimal(18, 2)), 15, 2786, CAST(N'2022-05-30T17:46:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.33 AS Decimal(18, 2)), 4, 2787, CAST(N'2022-03-29T04:49:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.12 AS Decimal(18, 2)), 26, 2788, CAST(N'2022-05-17T06:53:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(4.11 AS Decimal(18, 2)), 7, 2789, CAST(N'2022-07-13T03:23:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.74 AS Decimal(18, 2)), 3, 2790, CAST(N'2021-10-20T19:10:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.71 AS Decimal(18, 2)), 23, 2791, CAST(N'2021-08-19T03:47:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.87 AS Decimal(18, 2)), 21, 2792, CAST(N'2022-06-23T21:20:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.02 AS Decimal(18, 2)), 42, 2793, CAST(N'2022-05-01T03:36:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.06 AS Decimal(18, 2)), 12, 2794, CAST(N'2022-01-14T08:17:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.24 AS Decimal(18, 2)), 12, 2795, CAST(N'2021-10-28T23:44:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.88 AS Decimal(18, 2)), 32, 2796, CAST(N'2021-08-06T12:24:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(9.42 AS Decimal(18, 2)), 38, 2797, CAST(N'2021-07-29T22:04:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.80 AS Decimal(18, 2)), 33, 2798, CAST(N'2021-10-23T20:54:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.83 AS Decimal(18, 2)), 43, 2799, CAST(N'2021-11-05T18:49:54.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.04 AS Decimal(18, 2)), 26, 2800, CAST(N'2022-06-21T02:51:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.19 AS Decimal(18, 2)), 4, 2801, CAST(N'2022-05-04T15:36:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.30 AS Decimal(18, 2)), 19, 2802, CAST(N'2022-05-03T20:41:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.30 AS Decimal(18, 2)), 8, 2803, CAST(N'2022-01-27T21:25:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.99 AS Decimal(18, 2)), 39, 2804, CAST(N'2021-07-20T05:03:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.99 AS Decimal(18, 2)), 43, 2805, CAST(N'2021-07-23T18:16:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.26 AS Decimal(18, 2)), 19, 2806, CAST(N'2021-12-06T15:14:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(2.20 AS Decimal(18, 2)), 15, 2807, CAST(N'2021-08-15T04:39:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.60 AS Decimal(18, 2)), 36, 2808, CAST(N'2022-04-10T23:26:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.68 AS Decimal(18, 2)), 25, 2809, CAST(N'2021-06-25T18:09:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.19 AS Decimal(18, 2)), 46, 2810, CAST(N'2022-02-24T11:30:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.00 AS Decimal(18, 2)), 19, 2811, CAST(N'2022-08-03T02:51:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.25 AS Decimal(18, 2)), 9, 2812, CAST(N'2022-03-25T05:04:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.73 AS Decimal(18, 2)), 19, 2813, CAST(N'2021-10-09T15:31:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.56 AS Decimal(18, 2)), 45, 2814, CAST(N'2022-06-16T05:39:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.15 AS Decimal(18, 2)), 6, 2815, CAST(N'2021-08-28T06:57:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.50 AS Decimal(18, 2)), 35, 2816, CAST(N'2022-06-17T23:40:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(2.73 AS Decimal(18, 2)), 29, 2817, CAST(N'2021-08-13T13:35:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(4.68 AS Decimal(18, 2)), 15, 2818, CAST(N'2021-11-01T21:38:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.87 AS Decimal(18, 2)), 35, 2819, CAST(N'2022-07-18T06:20:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(8.83 AS Decimal(18, 2)), 1, 2820, CAST(N'2022-01-07T09:25:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.08 AS Decimal(18, 2)), 37, 2821, CAST(N'2022-05-03T11:24:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.76 AS Decimal(18, 2)), 44, 2822, CAST(N'2021-12-10T06:11:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.48 AS Decimal(18, 2)), 17, 2823, CAST(N'2021-11-21T04:59:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.24 AS Decimal(18, 2)), 37, 2824, CAST(N'2022-02-27T07:12:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.49 AS Decimal(18, 2)), 46, 2825, CAST(N'2021-09-01T09:15:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.92 AS Decimal(18, 2)), 15, 2826, CAST(N'2022-08-11T22:38:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(1.26 AS Decimal(18, 2)), 41, 2827, CAST(N'2021-11-30T08:43:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(2.77 AS Decimal(18, 2)), 13, 2828, CAST(N'2022-03-20T23:38:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.16 AS Decimal(18, 2)), 30, 2829, CAST(N'2022-08-05T03:08:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.46 AS Decimal(18, 2)), 6, 2830, CAST(N'2022-04-25T02:23:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.69 AS Decimal(18, 2)), 35, 2831, CAST(N'2022-07-03T08:18:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.73 AS Decimal(18, 2)), 19, 2832, CAST(N'2021-12-06T02:25:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.44 AS Decimal(18, 2)), 49, 2833, CAST(N'2021-06-08T06:55:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(4.46 AS Decimal(18, 2)), 31, 2834, CAST(N'2022-01-07T07:55:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.06 AS Decimal(18, 2)), 28, 2835, CAST(N'2022-03-23T02:52:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.17 AS Decimal(18, 2)), 19, 2836, CAST(N'2022-08-13T06:35:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.33 AS Decimal(18, 2)), 6, 2837, CAST(N'2021-12-20T13:51:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.25 AS Decimal(18, 2)), 4, 2838, CAST(N'2022-08-08T16:00:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.77 AS Decimal(18, 2)), 38, 2839, CAST(N'2021-06-09T02:53:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.93 AS Decimal(18, 2)), 26, 2840, CAST(N'2021-10-17T17:55:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.02 AS Decimal(18, 2)), 26, 2841, CAST(N'2021-07-19T09:32:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.79 AS Decimal(18, 2)), 21, 2842, CAST(N'2021-12-07T17:44:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(4.91 AS Decimal(18, 2)), 45, 2843, CAST(N'2021-09-26T06:37:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.44 AS Decimal(18, 2)), 29, 2844, CAST(N'2021-11-24T18:06:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(2.84 AS Decimal(18, 2)), 44, 2845, CAST(N'2021-11-14T19:22:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.42 AS Decimal(18, 2)), 17, 2846, CAST(N'2022-06-03T10:52:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(2.33 AS Decimal(18, 2)), 50, 2847, CAST(N'2022-01-11T02:03:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(9.11 AS Decimal(18, 2)), 17, 2848, CAST(N'2022-06-12T14:16:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.95 AS Decimal(18, 2)), 19, 2849, CAST(N'2021-06-07T00:48:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.21 AS Decimal(18, 2)), 28, 2850, CAST(N'2021-11-10T06:18:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.86 AS Decimal(18, 2)), 34, 2851, CAST(N'2022-06-30T10:40:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(1.08 AS Decimal(18, 2)), 21, 2852, CAST(N'2022-03-16T22:28:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.33 AS Decimal(18, 2)), 10, 2853, CAST(N'2021-06-13T12:26:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.41 AS Decimal(18, 2)), 19, 2854, CAST(N'2022-03-01T21:39:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.18 AS Decimal(18, 2)), 30, 2855, CAST(N'2022-03-14T03:35:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(4.56 AS Decimal(18, 2)), 40, 2856, CAST(N'2021-11-24T22:21:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(7.96 AS Decimal(18, 2)), 37, 2857, CAST(N'2021-12-17T21:19:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(7.81 AS Decimal(18, 2)), 31, 2858, CAST(N'2021-11-30T04:59:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.55 AS Decimal(18, 2)), 46, 2859, CAST(N'2021-06-24T09:52:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.63 AS Decimal(18, 2)), 12, 2860, CAST(N'2021-09-18T02:36:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.37 AS Decimal(18, 2)), 23, 2861, CAST(N'2021-09-29T02:35:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.56 AS Decimal(18, 2)), 14, 2862, CAST(N'2022-06-22T07:50:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(3.24 AS Decimal(18, 2)), 4, 2863, CAST(N'2022-01-19T11:38:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(9.53 AS Decimal(18, 2)), 39, 2864, CAST(N'2021-12-03T01:53:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.34 AS Decimal(18, 2)), 4, 2865, CAST(N'2021-12-04T00:33:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.93 AS Decimal(18, 2)), 41, 2866, CAST(N'2021-10-04T11:51:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(8.34 AS Decimal(18, 2)), 34, 2867, CAST(N'2021-12-30T09:54:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.75 AS Decimal(18, 2)), 24, 2868, CAST(N'2022-06-14T06:41:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.32 AS Decimal(18, 2)), 26, 2869, CAST(N'2021-06-01T02:04:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(7.55 AS Decimal(18, 2)), 36, 2870, CAST(N'2021-08-20T01:17:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.80 AS Decimal(18, 2)), 17, 2871, CAST(N'2021-07-18T13:04:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.05 AS Decimal(18, 2)), 39, 2872, CAST(N'2022-07-26T12:58:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.29 AS Decimal(18, 2)), 16, 2873, CAST(N'2021-12-24T06:04:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.63 AS Decimal(18, 2)), 37, 2874, CAST(N'2021-09-24T10:14:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.56 AS Decimal(18, 2)), 23, 2875, CAST(N'2021-08-24T21:39:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.21 AS Decimal(18, 2)), 34, 2876, CAST(N'2021-12-21T19:39:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.37 AS Decimal(18, 2)), 23, 2877, CAST(N'2022-01-20T08:43:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.24 AS Decimal(18, 2)), 45, 2878, CAST(N'2021-06-14T14:19:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.34 AS Decimal(18, 2)), 11, 2879, CAST(N'2021-09-17T08:55:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.42 AS Decimal(18, 2)), 20, 2880, CAST(N'2021-06-08T11:11:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(4.07 AS Decimal(18, 2)), 27, 2881, CAST(N'2022-02-09T23:18:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(5.73 AS Decimal(18, 2)), 9, 2882, CAST(N'2021-12-17T06:51:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.47 AS Decimal(18, 2)), 31, 2883, CAST(N'2021-08-18T07:24:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.06 AS Decimal(18, 2)), 12, 2884, CAST(N'2022-08-01T11:23:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.22 AS Decimal(18, 2)), 17, 2885, CAST(N'2021-12-31T08:31:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.72 AS Decimal(18, 2)), 28, 2886, CAST(N'2021-11-05T04:04:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.92 AS Decimal(18, 2)), 20, 2887, CAST(N'2021-11-02T19:01:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.14 AS Decimal(18, 2)), 26, 2888, CAST(N'2022-03-10T18:18:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.14 AS Decimal(18, 2)), 46, 2889, CAST(N'2021-11-22T09:11:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(2.36 AS Decimal(18, 2)), 34, 2890, CAST(N'2022-04-03T06:56:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.93 AS Decimal(18, 2)), 28, 2891, CAST(N'2022-01-25T18:21:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(4.02 AS Decimal(18, 2)), 23, 2892, CAST(N'2022-04-30T10:33:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(9.26 AS Decimal(18, 2)), 4, 2893, CAST(N'2021-08-06T04:46:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(6.35 AS Decimal(18, 2)), 24, 2894, CAST(N'2021-10-18T23:42:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.63 AS Decimal(18, 2)), 20, 2895, CAST(N'2022-08-01T15:17:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.02 AS Decimal(18, 2)), 1, 2896, CAST(N'2022-03-11T14:28:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.86 AS Decimal(18, 2)), 10, 2897, CAST(N'2022-02-03T04:24:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.55 AS Decimal(18, 2)), 21, 2898, CAST(N'2021-06-12T23:30:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(3.75 AS Decimal(18, 2)), 18, 2899, CAST(N'2022-07-22T18:11:03.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.17 AS Decimal(18, 2)), 12, 2900, CAST(N'2021-06-28T14:10:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.85 AS Decimal(18, 2)), 40, 2901, CAST(N'2022-02-21T23:08:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.59 AS Decimal(18, 2)), 12, 2902, CAST(N'2022-07-31T23:53:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.12 AS Decimal(18, 2)), 50, 2903, CAST(N'2021-06-04T20:26:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.81 AS Decimal(18, 2)), 8, 2904, CAST(N'2021-12-30T08:47:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.58 AS Decimal(18, 2)), 23, 2905, CAST(N'2022-03-01T22:55:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(3.57 AS Decimal(18, 2)), 11, 2906, CAST(N'2022-02-19T19:48:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.28 AS Decimal(18, 2)), 12, 2907, CAST(N'2021-06-14T13:48:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.05 AS Decimal(18, 2)), 39, 2908, CAST(N'2022-02-21T15:14:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.03 AS Decimal(18, 2)), 3, 2909, CAST(N'2021-12-24T12:17:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.22 AS Decimal(18, 2)), 46, 2910, CAST(N'2022-03-19T03:49:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.12 AS Decimal(18, 2)), 20, 2911, CAST(N'2022-07-23T14:46:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.94 AS Decimal(18, 2)), 44, 2912, CAST(N'2022-03-31T23:35:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.63 AS Decimal(18, 2)), 27, 2913, CAST(N'2022-06-15T02:47:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.63 AS Decimal(18, 2)), 50, 2914, CAST(N'2022-04-22T05:00:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.57 AS Decimal(18, 2)), 43, 2915, CAST(N'2022-02-15T18:41:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.81 AS Decimal(18, 2)), 18, 2916, CAST(N'2021-07-10T05:53:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(5.38 AS Decimal(18, 2)), 18, 2917, CAST(N'2022-03-15T05:02:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.60 AS Decimal(18, 2)), 8, 2918, CAST(N'2022-04-21T22:41:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.54 AS Decimal(18, 2)), 46, 2919, CAST(N'2021-08-05T00:28:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.22 AS Decimal(18, 2)), 44, 2920, CAST(N'2022-05-02T23:26:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.06 AS Decimal(18, 2)), 40, 2921, CAST(N'2021-11-23T09:11:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.41 AS Decimal(18, 2)), 8, 2922, CAST(N'2021-06-27T18:19:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.62 AS Decimal(18, 2)), 38, 2923, CAST(N'2021-08-19T16:57:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.30 AS Decimal(18, 2)), 8, 2924, CAST(N'2021-08-20T09:38:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.18 AS Decimal(18, 2)), 46, 2925, CAST(N'2021-10-21T06:03:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.23 AS Decimal(18, 2)), 6, 2926, CAST(N'2022-04-05T12:57:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(4.44 AS Decimal(18, 2)), 46, 2927, CAST(N'2022-06-07T21:33:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(5.50 AS Decimal(18, 2)), 15, 2928, CAST(N'2021-10-11T15:37:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(6.28 AS Decimal(18, 2)), 47, 2929, CAST(N'2021-09-27T23:14:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.36 AS Decimal(18, 2)), 26, 2930, CAST(N'2022-01-19T07:50:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(7.47 AS Decimal(18, 2)), 18, 2931, CAST(N'2022-02-01T19:20:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.49 AS Decimal(18, 2)), 4, 2932, CAST(N'2022-04-15T23:30:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.31 AS Decimal(18, 2)), 6, 2933, CAST(N'2021-12-20T16:23:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.52 AS Decimal(18, 2)), 4, 2934, CAST(N'2021-12-26T15:55:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.26 AS Decimal(18, 2)), 18, 2935, CAST(N'2021-06-28T21:55:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.52 AS Decimal(18, 2)), 1, 2936, CAST(N'2021-12-30T21:14:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.16 AS Decimal(18, 2)), 19, 2937, CAST(N'2022-02-15T13:36:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(1.92 AS Decimal(18, 2)), 14, 2938, CAST(N'2022-04-05T21:43:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.07 AS Decimal(18, 2)), 9, 2939, CAST(N'2022-06-28T05:36:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(2.62 AS Decimal(18, 2)), 12, 2940, CAST(N'2022-05-19T12:41:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.24 AS Decimal(18, 2)), 42, 2941, CAST(N'2021-07-22T12:15:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.01 AS Decimal(18, 2)), 41, 2942, CAST(N'2021-08-11T22:33:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(8.33 AS Decimal(18, 2)), 7, 2943, CAST(N'2022-01-06T07:39:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.24 AS Decimal(18, 2)), 43, 2944, CAST(N'2021-07-25T17:58:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(3.57 AS Decimal(18, 2)), 6, 2945, CAST(N'2022-03-25T08:31:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.74 AS Decimal(18, 2)), 24, 2946, CAST(N'2022-05-27T18:42:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.10 AS Decimal(18, 2)), 28, 2947, CAST(N'2022-06-25T11:30:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(3.91 AS Decimal(18, 2)), 39, 2948, CAST(N'2021-12-27T01:10:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.17 AS Decimal(18, 2)), 12, 2949, CAST(N'2021-07-17T04:03:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(8.62 AS Decimal(18, 2)), 3, 2950, CAST(N'2022-04-21T13:33:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.63 AS Decimal(18, 2)), 49, 2951, CAST(N'2022-03-25T09:06:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.07 AS Decimal(18, 2)), 17, 2952, CAST(N'2021-08-22T09:59:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(9.57 AS Decimal(18, 2)), 18, 2953, CAST(N'2021-12-04T11:37:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.44 AS Decimal(18, 2)), 19, 2954, CAST(N'2021-09-20T01:25:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.87 AS Decimal(18, 2)), 7, 2955, CAST(N'2021-09-15T12:33:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(2.65 AS Decimal(18, 2)), 32, 2956, CAST(N'2021-10-12T09:29:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(9.56 AS Decimal(18, 2)), 10, 2957, CAST(N'2021-10-12T15:31:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.24 AS Decimal(18, 2)), 39, 2958, CAST(N'2022-04-10T01:46:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.71 AS Decimal(18, 2)), 20, 2959, CAST(N'2022-07-23T11:43:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(4.21 AS Decimal(18, 2)), 27, 2960, CAST(N'2021-11-19T12:34:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.66 AS Decimal(18, 2)), 15, 2961, CAST(N'2021-11-09T22:39:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.75 AS Decimal(18, 2)), 22, 2962, CAST(N'2021-08-08T20:18:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(9.93 AS Decimal(18, 2)), 36, 2963, CAST(N'2022-03-28T12:14:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.17 AS Decimal(18, 2)), 36, 2964, CAST(N'2021-12-06T21:23:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.08 AS Decimal(18, 2)), 28, 2965, CAST(N'2021-10-24T21:14:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.95 AS Decimal(18, 2)), 9, 2966, CAST(N'2021-11-26T01:29:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(3.82 AS Decimal(18, 2)), 23, 2967, CAST(N'2021-08-23T11:19:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.75 AS Decimal(18, 2)), 11, 2968, CAST(N'2021-11-04T21:49:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.13 AS Decimal(18, 2)), 30, 2969, CAST(N'2021-08-29T05:47:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.60 AS Decimal(18, 2)), 29, 2970, CAST(N'2021-08-02T06:14:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.74 AS Decimal(18, 2)), 23, 2971, CAST(N'2021-12-15T17:07:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(5.14 AS Decimal(18, 2)), 8, 2972, CAST(N'2022-07-05T11:06:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.53 AS Decimal(18, 2)), 4, 2973, CAST(N'2022-06-04T07:12:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(6.99 AS Decimal(18, 2)), 2, 2974, CAST(N'2022-03-28T16:46:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.68 AS Decimal(18, 2)), 38, 2975, CAST(N'2021-10-02T13:31:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.75 AS Decimal(18, 2)), 35, 2976, CAST(N'2021-08-21T14:24:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.38 AS Decimal(18, 2)), 23, 2977, CAST(N'2021-10-25T14:41:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.54 AS Decimal(18, 2)), 4, 2978, CAST(N'2021-09-09T05:43:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(8.40 AS Decimal(18, 2)), 32, 2979, CAST(N'2022-04-18T05:52:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.34 AS Decimal(18, 2)), 45, 2980, CAST(N'2022-05-27T18:35:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.73 AS Decimal(18, 2)), 19, 2981, CAST(N'2021-11-18T14:57:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.20 AS Decimal(18, 2)), 5, 2982, CAST(N'2022-04-07T18:54:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.46 AS Decimal(18, 2)), 9, 2983, CAST(N'2021-07-21T11:29:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.87 AS Decimal(18, 2)), 21, 2984, CAST(N'2022-03-12T02:36:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(5.67 AS Decimal(18, 2)), 16, 2985, CAST(N'2021-06-24T04:50:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.67 AS Decimal(18, 2)), 20, 2986, CAST(N'2022-06-23T06:27:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.63 AS Decimal(18, 2)), 4, 2987, CAST(N'2022-05-24T10:40:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.60 AS Decimal(18, 2)), 48, 2988, CAST(N'2022-06-03T00:44:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.74 AS Decimal(18, 2)), 39, 2989, CAST(N'2022-02-01T17:30:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.21 AS Decimal(18, 2)), 28, 2990, CAST(N'2022-01-01T14:14:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.20 AS Decimal(18, 2)), 19, 2991, CAST(N'2022-03-14T15:54:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.85 AS Decimal(18, 2)), 6, 2992, CAST(N'2021-12-17T06:40:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.03 AS Decimal(18, 2)), 36, 2993, CAST(N'2021-12-17T02:46:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.62 AS Decimal(18, 2)), 38, 2994, CAST(N'2021-06-25T17:16:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.45 AS Decimal(18, 2)), 40, 2995, CAST(N'2021-09-22T05:37:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.59 AS Decimal(18, 2)), 22, 2996, CAST(N'2021-09-10T00:40:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.05 AS Decimal(18, 2)), 6, 2997, CAST(N'2022-08-06T10:46:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.23 AS Decimal(18, 2)), 32, 2998, CAST(N'2021-08-03T10:09:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.15 AS Decimal(18, 2)), 5, 2999, CAST(N'2022-04-19T16:00:25.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.17 AS Decimal(18, 2)), 9, 3000, CAST(N'2022-07-22T18:57:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.09 AS Decimal(18, 2)), 50, 3001, CAST(N'2022-08-06T16:03:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(6.93 AS Decimal(18, 2)), 40, 3002, CAST(N'2021-10-10T05:42:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.79 AS Decimal(18, 2)), 1, 3003, CAST(N'2022-03-13T17:36:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.14 AS Decimal(18, 2)), 4, 3004, CAST(N'2021-07-02T11:12:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.26 AS Decimal(18, 2)), 27, 3005, CAST(N'2021-09-28T15:30:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(3.37 AS Decimal(18, 2)), 22, 3006, CAST(N'2022-07-08T16:03:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(10.00 AS Decimal(18, 2)), 7, 3007, CAST(N'2022-03-19T02:08:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.71 AS Decimal(18, 2)), 4, 3008, CAST(N'2022-07-16T17:20:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.92 AS Decimal(18, 2)), 11, 3009, CAST(N'2021-08-09T15:34:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.41 AS Decimal(18, 2)), 1, 3010, CAST(N'2022-07-31T17:28:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.35 AS Decimal(18, 2)), 1, 3011, CAST(N'2022-05-04T00:42:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.07 AS Decimal(18, 2)), 16, 3012, CAST(N'2021-11-03T00:13:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.03 AS Decimal(18, 2)), 42, 3013, CAST(N'2022-03-08T21:01:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.18 AS Decimal(18, 2)), 10, 3014, CAST(N'2022-06-29T00:29:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.72 AS Decimal(18, 2)), 29, 3015, CAST(N'2021-12-13T17:36:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.95 AS Decimal(18, 2)), 24, 3016, CAST(N'2022-07-19T00:23:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.99 AS Decimal(18, 2)), 39, 3017, CAST(N'2022-08-07T18:59:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(5.21 AS Decimal(18, 2)), 24, 3018, CAST(N'2022-02-03T06:24:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(6.92 AS Decimal(18, 2)), 43, 3019, CAST(N'2022-02-11T14:17:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.10 AS Decimal(18, 2)), 48, 3020, CAST(N'2021-09-16T18:16:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(7.72 AS Decimal(18, 2)), 10, 3021, CAST(N'2022-03-04T14:24:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.26 AS Decimal(18, 2)), 6, 3022, CAST(N'2022-02-12T03:01:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.79 AS Decimal(18, 2)), 23, 3023, CAST(N'2022-03-01T18:39:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.53 AS Decimal(18, 2)), 44, 3024, CAST(N'2022-04-16T23:15:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.81 AS Decimal(18, 2)), 36, 3025, CAST(N'2021-08-26T09:47:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.92 AS Decimal(18, 2)), 21, 3026, CAST(N'2021-08-27T20:55:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(4.96 AS Decimal(18, 2)), 45, 3027, CAST(N'2021-10-07T21:11:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.71 AS Decimal(18, 2)), 18, 3028, CAST(N'2022-06-07T10:23:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.81 AS Decimal(18, 2)), 15, 3029, CAST(N'2021-11-22T16:33:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(1.50 AS Decimal(18, 2)), 8, 3030, CAST(N'2021-07-28T00:24:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.76 AS Decimal(18, 2)), 13, 3031, CAST(N'2021-06-03T21:56:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(8.72 AS Decimal(18, 2)), 48, 3032, CAST(N'2022-02-18T18:04:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(6.71 AS Decimal(18, 2)), 11, 3033, CAST(N'2021-08-10T19:44:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.87 AS Decimal(18, 2)), 3, 3034, CAST(N'2022-04-06T05:55:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(7.87 AS Decimal(18, 2)), 15, 3035, CAST(N'2021-06-15T16:30:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.68 AS Decimal(18, 2)), 22, 3036, CAST(N'2021-11-28T09:48:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.14 AS Decimal(18, 2)), 10, 3037, CAST(N'2022-03-19T15:35:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.00 AS Decimal(18, 2)), 28, 3038, CAST(N'2021-11-07T13:33:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(3.99 AS Decimal(18, 2)), 38, 3039, CAST(N'2021-07-02T14:10:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.62 AS Decimal(18, 2)), 4, 3040, CAST(N'2021-06-25T02:41:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(6.59 AS Decimal(18, 2)), 7, 3041, CAST(N'2021-09-15T00:01:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(4.46 AS Decimal(18, 2)), 1, 3042, CAST(N'2022-06-01T23:59:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.72 AS Decimal(18, 2)), 18, 3043, CAST(N'2021-07-07T23:42:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.30 AS Decimal(18, 2)), 26, 3044, CAST(N'2022-04-30T14:45:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.80 AS Decimal(18, 2)), 34, 3045, CAST(N'2021-08-01T09:53:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(6.04 AS Decimal(18, 2)), 29, 3046, CAST(N'2022-01-22T05:25:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(3.41 AS Decimal(18, 2)), 4, 3047, CAST(N'2022-05-06T16:53:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(6.62 AS Decimal(18, 2)), 24, 3048, CAST(N'2021-10-24T13:02:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.15 AS Decimal(18, 2)), 3, 3049, CAST(N'2021-11-07T13:49:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.08 AS Decimal(18, 2)), 17, 3050, CAST(N'2021-10-17T16:10:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.66 AS Decimal(18, 2)), 49, 3051, CAST(N'2021-07-12T09:32:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(2.62 AS Decimal(18, 2)), 44, 3052, CAST(N'2021-09-03T13:06:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.97 AS Decimal(18, 2)), 30, 3053, CAST(N'2021-07-29T18:47:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(1.07 AS Decimal(18, 2)), 34, 3054, CAST(N'2021-11-14T20:57:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.03 AS Decimal(18, 2)), 16, 3055, CAST(N'2022-06-19T06:06:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.95 AS Decimal(18, 2)), 47, 3056, CAST(N'2022-04-15T10:10:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.10 AS Decimal(18, 2)), 4, 3057, CAST(N'2021-10-16T05:29:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.38 AS Decimal(18, 2)), 33, 3058, CAST(N'2021-07-30T07:37:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.65 AS Decimal(18, 2)), 4, 3059, CAST(N'2021-06-10T08:19:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(8.68 AS Decimal(18, 2)), 20, 3060, CAST(N'2021-12-09T19:50:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.51 AS Decimal(18, 2)), 48, 3061, CAST(N'2021-07-21T16:23:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.47 AS Decimal(18, 2)), 9, 3062, CAST(N'2021-06-16T14:53:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.67 AS Decimal(18, 2)), 48, 3063, CAST(N'2022-05-04T19:45:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(1.17 AS Decimal(18, 2)), 8, 3064, CAST(N'2022-01-03T23:22:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.70 AS Decimal(18, 2)), 17, 3065, CAST(N'2022-04-07T03:01:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.60 AS Decimal(18, 2)), 4, 3066, CAST(N'2021-11-25T23:43:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.40 AS Decimal(18, 2)), 40, 3067, CAST(N'2022-06-06T23:40:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(4.19 AS Decimal(18, 2)), 6, 3068, CAST(N'2022-02-04T15:03:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(1.11 AS Decimal(18, 2)), 9, 3069, CAST(N'2022-08-11T14:07:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.11 AS Decimal(18, 2)), 6, 3070, CAST(N'2022-06-15T02:19:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.91 AS Decimal(18, 2)), 39, 3071, CAST(N'2022-08-10T03:59:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(7.06 AS Decimal(18, 2)), 8, 3072, CAST(N'2022-05-20T06:49:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.31 AS Decimal(18, 2)), 36, 3073, CAST(N'2022-07-20T16:06:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.31 AS Decimal(18, 2)), 41, 3074, CAST(N'2022-05-13T09:02:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.98 AS Decimal(18, 2)), 43, 3075, CAST(N'2022-05-04T08:27:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.25 AS Decimal(18, 2)), 4, 3076, CAST(N'2021-10-02T10:58:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.12 AS Decimal(18, 2)), 10, 3077, CAST(N'2021-12-04T17:04:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.91 AS Decimal(18, 2)), 10, 3078, CAST(N'2022-01-31T03:22:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.72 AS Decimal(18, 2)), 17, 3079, CAST(N'2021-11-08T17:54:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.52 AS Decimal(18, 2)), 26, 3080, CAST(N'2022-04-06T15:44:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(1.30 AS Decimal(18, 2)), 32, 3081, CAST(N'2021-11-26T08:58:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.80 AS Decimal(18, 2)), 30, 3082, CAST(N'2022-07-20T20:21:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.31 AS Decimal(18, 2)), 2, 3083, CAST(N'2022-04-19T08:38:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.55 AS Decimal(18, 2)), 20, 3084, CAST(N'2022-07-10T01:37:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.30 AS Decimal(18, 2)), 48, 3085, CAST(N'2022-07-05T13:04:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(4.92 AS Decimal(18, 2)), 23, 3086, CAST(N'2021-10-05T03:57:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(7.69 AS Decimal(18, 2)), 23, 3087, CAST(N'2022-08-09T06:41:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.57 AS Decimal(18, 2)), 12, 3088, CAST(N'2022-08-14T20:25:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.58 AS Decimal(18, 2)), 18, 3089, CAST(N'2021-08-02T20:46:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.05 AS Decimal(18, 2)), 30, 3090, CAST(N'2022-03-06T00:09:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(4.02 AS Decimal(18, 2)), 48, 3091, CAST(N'2022-05-02T19:04:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.55 AS Decimal(18, 2)), 31, 3092, CAST(N'2022-07-23T13:28:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(6.65 AS Decimal(18, 2)), 20, 3093, CAST(N'2021-09-07T23:27:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(4.27 AS Decimal(18, 2)), 30, 3094, CAST(N'2021-07-31T09:55:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.69 AS Decimal(18, 2)), 18, 3095, CAST(N'2022-07-23T19:36:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(3.38 AS Decimal(18, 2)), 18, 3096, CAST(N'2022-02-13T09:21:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.04 AS Decimal(18, 2)), 6, 3097, CAST(N'2022-08-15T15:05:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.65 AS Decimal(18, 2)), 19, 3098, CAST(N'2021-08-28T16:24:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.98 AS Decimal(18, 2)), 1, 3099, CAST(N'2022-05-13T06:06:26.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.85 AS Decimal(18, 2)), 36, 3100, CAST(N'2022-02-19T19:03:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.72 AS Decimal(18, 2)), 32, 3101, CAST(N'2022-02-01T07:23:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.21 AS Decimal(18, 2)), 14, 3102, CAST(N'2021-11-28T07:56:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.13 AS Decimal(18, 2)), 13, 3103, CAST(N'2022-02-19T19:50:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(2.47 AS Decimal(18, 2)), 29, 3104, CAST(N'2022-02-15T08:29:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.16 AS Decimal(18, 2)), 29, 3105, CAST(N'2022-06-24T07:45:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.41 AS Decimal(18, 2)), 44, 3106, CAST(N'2021-11-26T22:50:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.76 AS Decimal(18, 2)), 33, 3107, CAST(N'2022-01-10T13:53:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.57 AS Decimal(18, 2)), 46, 3108, CAST(N'2021-07-03T08:37:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(2.94 AS Decimal(18, 2)), 49, 3109, CAST(N'2021-12-05T12:41:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(3.24 AS Decimal(18, 2)), 1, 3110, CAST(N'2022-08-05T04:13:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.05 AS Decimal(18, 2)), 43, 3111, CAST(N'2021-12-01T14:56:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.94 AS Decimal(18, 2)), 43, 3112, CAST(N'2022-04-28T13:32:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.68 AS Decimal(18, 2)), 21, 3113, CAST(N'2022-06-01T06:47:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.95 AS Decimal(18, 2)), 25, 3114, CAST(N'2021-11-26T02:02:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.55 AS Decimal(18, 2)), 9, 3115, CAST(N'2021-07-18T00:51:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.77 AS Decimal(18, 2)), 41, 3116, CAST(N'2022-06-16T15:25:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(6.98 AS Decimal(18, 2)), 40, 3117, CAST(N'2021-11-20T13:55:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.61 AS Decimal(18, 2)), 24, 3118, CAST(N'2022-07-07T00:16:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(3.71 AS Decimal(18, 2)), 1, 3119, CAST(N'2022-06-18T22:10:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.54 AS Decimal(18, 2)), 11, 3120, CAST(N'2022-07-04T11:59:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.39 AS Decimal(18, 2)), 31, 3121, CAST(N'2022-01-03T20:57:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(1.10 AS Decimal(18, 2)), 16, 3122, CAST(N'2021-12-05T12:09:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(2.41 AS Decimal(18, 2)), 16, 3123, CAST(N'2021-09-28T19:18:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.37 AS Decimal(18, 2)), 40, 3124, CAST(N'2021-08-28T15:00:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.61 AS Decimal(18, 2)), 12, 3125, CAST(N'2021-10-20T22:47:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.21 AS Decimal(18, 2)), 34, 3126, CAST(N'2022-06-22T08:26:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(2.96 AS Decimal(18, 2)), 46, 3127, CAST(N'2022-05-09T02:57:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(4.44 AS Decimal(18, 2)), 37, 3128, CAST(N'2021-08-01T14:39:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.94 AS Decimal(18, 2)), 49, 3129, CAST(N'2021-10-05T17:49:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.24 AS Decimal(18, 2)), 34, 3130, CAST(N'2021-10-31T01:34:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.54 AS Decimal(18, 2)), 36, 3131, CAST(N'2022-06-11T18:50:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.76 AS Decimal(18, 2)), 21, 3132, CAST(N'2021-07-16T13:20:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(4.14 AS Decimal(18, 2)), 19, 3133, CAST(N'2022-03-23T15:17:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(5.01 AS Decimal(18, 2)), 28, 3134, CAST(N'2022-03-12T03:20:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(1.82 AS Decimal(18, 2)), 19, 3135, CAST(N'2021-09-11T01:16:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(3.37 AS Decimal(18, 2)), 13, 3136, CAST(N'2021-07-17T16:10:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.70 AS Decimal(18, 2)), 19, 3137, CAST(N'2021-08-21T10:56:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(8.10 AS Decimal(18, 2)), 5, 3138, CAST(N'2021-12-02T04:25:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.48 AS Decimal(18, 2)), 19, 3139, CAST(N'2021-11-27T15:18:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.44 AS Decimal(18, 2)), 20, 3140, CAST(N'2022-02-04T00:57:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(3.31 AS Decimal(18, 2)), 14, 3141, CAST(N'2021-12-28T23:26:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(3.69 AS Decimal(18, 2)), 16, 3142, CAST(N'2021-08-02T23:18:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(4.31 AS Decimal(18, 2)), 45, 3143, CAST(N'2022-01-03T06:50:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.85 AS Decimal(18, 2)), 2, 3144, CAST(N'2022-03-16T08:08:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.20 AS Decimal(18, 2)), 34, 3145, CAST(N'2022-04-14T21:47:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(2.13 AS Decimal(18, 2)), 28, 3146, CAST(N'2021-10-01T01:03:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(5.28 AS Decimal(18, 2)), 6, 3147, CAST(N'2022-03-18T14:25:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.46 AS Decimal(18, 2)), 44, 3148, CAST(N'2021-06-23T03:04:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(5.45 AS Decimal(18, 2)), 31, 3149, CAST(N'2022-02-20T03:30:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.71 AS Decimal(18, 2)), 46, 3150, CAST(N'2021-10-25T07:18:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(9.82 AS Decimal(18, 2)), 23, 3151, CAST(N'2022-06-06T01:46:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.79 AS Decimal(18, 2)), 16, 3152, CAST(N'2022-07-30T01:18:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.82 AS Decimal(18, 2)), 34, 3153, CAST(N'2021-09-22T03:38:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.72 AS Decimal(18, 2)), 43, 3154, CAST(N'2021-09-16T10:40:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.58 AS Decimal(18, 2)), 48, 3155, CAST(N'2022-05-31T01:16:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(3.07 AS Decimal(18, 2)), 36, 3156, CAST(N'2021-09-08T14:27:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.63 AS Decimal(18, 2)), 38, 3157, CAST(N'2022-06-20T01:00:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.88 AS Decimal(18, 2)), 43, 3158, CAST(N'2021-06-03T12:36:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.46 AS Decimal(18, 2)), 38, 3159, CAST(N'2021-09-14T03:18:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.00 AS Decimal(18, 2)), 50, 3160, CAST(N'2021-10-16T13:47:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(2.51 AS Decimal(18, 2)), 47, 3161, CAST(N'2022-03-02T10:15:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.73 AS Decimal(18, 2)), 30, 3162, CAST(N'2021-06-14T09:25:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.58 AS Decimal(18, 2)), 23, 3163, CAST(N'2021-07-27T00:09:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.65 AS Decimal(18, 2)), 36, 3164, CAST(N'2022-07-16T18:13:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(1.71 AS Decimal(18, 2)), 47, 3165, CAST(N'2022-04-12T15:29:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.79 AS Decimal(18, 2)), 22, 3166, CAST(N'2021-12-19T12:00:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.51 AS Decimal(18, 2)), 21, 3167, CAST(N'2022-07-24T13:18:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.70 AS Decimal(18, 2)), 15, 3168, CAST(N'2022-08-04T09:49:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.35 AS Decimal(18, 2)), 2, 3169, CAST(N'2021-09-03T04:03:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.21 AS Decimal(18, 2)), 13, 3170, CAST(N'2022-06-04T08:00:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(4.64 AS Decimal(18, 2)), 22, 3171, CAST(N'2021-10-19T19:06:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.20 AS Decimal(18, 2)), 26, 3172, CAST(N'2022-01-23T11:01:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.00 AS Decimal(18, 2)), 25, 3173, CAST(N'2022-07-31T09:05:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.03 AS Decimal(18, 2)), 47, 3174, CAST(N'2021-09-07T00:29:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.27 AS Decimal(18, 2)), 38, 3175, CAST(N'2021-08-27T21:42:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(8.14 AS Decimal(18, 2)), 38, 3176, CAST(N'2021-07-10T10:35:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.72 AS Decimal(18, 2)), 21, 3177, CAST(N'2022-01-30T06:34:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(4.02 AS Decimal(18, 2)), 41, 3178, CAST(N'2021-11-17T13:25:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.18 AS Decimal(18, 2)), 43, 3179, CAST(N'2021-12-04T11:40:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(8.54 AS Decimal(18, 2)), 38, 3180, CAST(N'2021-09-29T16:16:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.10 AS Decimal(18, 2)), 25, 3181, CAST(N'2021-10-06T04:35:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.86 AS Decimal(18, 2)), 15, 3182, CAST(N'2021-11-12T01:31:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(2.18 AS Decimal(18, 2)), 44, 3183, CAST(N'2021-06-17T08:50:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(2.80 AS Decimal(18, 2)), 34, 3184, CAST(N'2022-08-09T21:24:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(1.13 AS Decimal(18, 2)), 12, 3185, CAST(N'2021-08-06T18:20:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.09 AS Decimal(18, 2)), 9, 3186, CAST(N'2022-04-12T05:38:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.17 AS Decimal(18, 2)), 37, 3187, CAST(N'2021-07-22T01:01:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.75 AS Decimal(18, 2)), 46, 3188, CAST(N'2022-07-03T16:06:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.44 AS Decimal(18, 2)), 22, 3189, CAST(N'2021-07-22T05:34:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.72 AS Decimal(18, 2)), 43, 3190, CAST(N'2021-12-09T02:33:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.35 AS Decimal(18, 2)), 2, 3191, CAST(N'2022-08-10T18:24:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(2.92 AS Decimal(18, 2)), 26, 3192, CAST(N'2021-12-23T02:32:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.52 AS Decimal(18, 2)), 2, 3193, CAST(N'2022-08-02T03:15:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(8.67 AS Decimal(18, 2)), 33, 3194, CAST(N'2022-04-20T22:44:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.28 AS Decimal(18, 2)), 40, 3195, CAST(N'2021-09-11T20:31:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.75 AS Decimal(18, 2)), 43, 3196, CAST(N'2021-09-04T04:27:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(7.36 AS Decimal(18, 2)), 25, 3197, CAST(N'2021-11-03T11:06:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.26 AS Decimal(18, 2)), 31, 3198, CAST(N'2022-05-24T11:00:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(2.54 AS Decimal(18, 2)), 8, 3199, CAST(N'2022-03-25T23:17:13.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(6.95 AS Decimal(18, 2)), 48, 3200, CAST(N'2021-12-27T03:45:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.02 AS Decimal(18, 2)), 46, 3201, CAST(N'2021-12-31T10:05:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(4.75 AS Decimal(18, 2)), 25, 3202, CAST(N'2022-07-02T06:30:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.92 AS Decimal(18, 2)), 18, 3203, CAST(N'2021-12-24T04:05:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.17 AS Decimal(18, 2)), 40, 3204, CAST(N'2021-12-18T10:41:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.70 AS Decimal(18, 2)), 3, 3205, CAST(N'2021-09-19T06:31:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(2.37 AS Decimal(18, 2)), 14, 3206, CAST(N'2021-06-04T01:08:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.54 AS Decimal(18, 2)), 39, 3207, CAST(N'2022-05-29T12:56:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(3.84 AS Decimal(18, 2)), 46, 3208, CAST(N'2021-10-06T19:19:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(7.20 AS Decimal(18, 2)), 24, 3209, CAST(N'2021-06-09T09:18:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.24 AS Decimal(18, 2)), 47, 3210, CAST(N'2021-07-09T03:48:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.30 AS Decimal(18, 2)), 43, 3211, CAST(N'2022-08-10T05:09:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.35 AS Decimal(18, 2)), 19, 3212, CAST(N'2021-09-07T23:11:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(6.52 AS Decimal(18, 2)), 33, 3213, CAST(N'2021-12-16T15:43:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.03 AS Decimal(18, 2)), 3, 3214, CAST(N'2021-12-17T07:35:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.83 AS Decimal(18, 2)), 17, 3215, CAST(N'2022-06-10T06:53:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.47 AS Decimal(18, 2)), 32, 3216, CAST(N'2021-12-06T22:08:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.34 AS Decimal(18, 2)), 47, 3217, CAST(N'2021-12-17T08:45:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.42 AS Decimal(18, 2)), 24, 3218, CAST(N'2021-12-09T20:27:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(4.91 AS Decimal(18, 2)), 33, 3219, CAST(N'2021-11-11T11:18:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.26 AS Decimal(18, 2)), 38, 3220, CAST(N'2022-07-09T11:44:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(2.18 AS Decimal(18, 2)), 28, 3221, CAST(N'2022-01-22T09:26:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.04 AS Decimal(18, 2)), 37, 3222, CAST(N'2022-02-01T01:46:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.89 AS Decimal(18, 2)), 7, 3223, CAST(N'2022-05-21T04:38:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.46 AS Decimal(18, 2)), 9, 3224, CAST(N'2022-07-29T09:46:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.96 AS Decimal(18, 2)), 48, 3225, CAST(N'2022-02-20T18:52:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.28 AS Decimal(18, 2)), 33, 3226, CAST(N'2022-03-11T14:04:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.54 AS Decimal(18, 2)), 23, 3227, CAST(N'2021-09-01T22:52:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(8.04 AS Decimal(18, 2)), 21, 3228, CAST(N'2022-06-12T14:38:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(8.96 AS Decimal(18, 2)), 38, 3229, CAST(N'2021-10-29T12:59:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.17 AS Decimal(18, 2)), 31, 3230, CAST(N'2022-02-13T15:08:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.37 AS Decimal(18, 2)), 4, 3231, CAST(N'2022-07-30T00:44:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.53 AS Decimal(18, 2)), 49, 3232, CAST(N'2022-07-15T03:57:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(5.61 AS Decimal(18, 2)), 23, 3233, CAST(N'2022-01-18T18:19:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.35 AS Decimal(18, 2)), 33, 3234, CAST(N'2021-11-01T06:43:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.04 AS Decimal(18, 2)), 6, 3235, CAST(N'2021-12-26T20:41:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.48 AS Decimal(18, 2)), 1, 3236, CAST(N'2022-06-02T12:45:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.24 AS Decimal(18, 2)), 1, 3237, CAST(N'2022-05-21T07:04:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.94 AS Decimal(18, 2)), 42, 3238, CAST(N'2022-06-21T14:52:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.89 AS Decimal(18, 2)), 45, 3239, CAST(N'2022-04-13T03:55:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.36 AS Decimal(18, 2)), 30, 3240, CAST(N'2021-11-04T14:45:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.43 AS Decimal(18, 2)), 21, 3241, CAST(N'2021-07-10T21:16:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.85 AS Decimal(18, 2)), 31, 3242, CAST(N'2022-01-08T16:17:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.72 AS Decimal(18, 2)), 29, 3243, CAST(N'2022-03-02T11:37:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.71 AS Decimal(18, 2)), 40, 3244, CAST(N'2022-05-30T13:45:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.94 AS Decimal(18, 2)), 9, 3245, CAST(N'2022-03-20T13:00:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.93 AS Decimal(18, 2)), 19, 3246, CAST(N'2022-04-04T19:50:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.21 AS Decimal(18, 2)), 14, 3247, CAST(N'2021-06-06T01:28:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.63 AS Decimal(18, 2)), 36, 3248, CAST(N'2021-09-26T09:17:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(5.32 AS Decimal(18, 2)), 41, 3249, CAST(N'2022-07-28T21:24:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.66 AS Decimal(18, 2)), 19, 3250, CAST(N'2021-12-17T01:58:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.82 AS Decimal(18, 2)), 40, 3251, CAST(N'2021-10-14T00:17:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.82 AS Decimal(18, 2)), 38, 3252, CAST(N'2022-07-26T01:14:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(9.55 AS Decimal(18, 2)), 16, 3253, CAST(N'2021-07-24T18:21:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.28 AS Decimal(18, 2)), 8, 3254, CAST(N'2021-09-18T17:08:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.47 AS Decimal(18, 2)), 10, 3255, CAST(N'2021-10-13T18:15:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(8.78 AS Decimal(18, 2)), 37, 3256, CAST(N'2022-05-25T07:03:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.61 AS Decimal(18, 2)), 28, 3257, CAST(N'2021-06-09T01:19:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(6.84 AS Decimal(18, 2)), 18, 3258, CAST(N'2022-04-13T04:05:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(6.36 AS Decimal(18, 2)), 44, 3259, CAST(N'2021-07-04T19:06:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.16 AS Decimal(18, 2)), 12, 3260, CAST(N'2022-06-09T10:23:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.60 AS Decimal(18, 2)), 28, 3261, CAST(N'2022-05-07T04:34:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.54 AS Decimal(18, 2)), 33, 3262, CAST(N'2021-12-06T07:04:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(5.86 AS Decimal(18, 2)), 10, 3263, CAST(N'2022-04-19T05:58:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.10 AS Decimal(18, 2)), 22, 3264, CAST(N'2021-12-14T23:36:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(5.79 AS Decimal(18, 2)), 35, 3265, CAST(N'2021-08-06T14:58:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.42 AS Decimal(18, 2)), 50, 3266, CAST(N'2022-01-03T12:53:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.27 AS Decimal(18, 2)), 43, 3267, CAST(N'2022-01-06T01:33:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(6.27 AS Decimal(18, 2)), 36, 3268, CAST(N'2022-03-23T09:04:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.92 AS Decimal(18, 2)), 49, 3269, CAST(N'2021-09-19T06:41:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.89 AS Decimal(18, 2)), 26, 3270, CAST(N'2021-11-21T18:06:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(7.13 AS Decimal(18, 2)), 39, 3271, CAST(N'2021-09-25T18:38:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.21 AS Decimal(18, 2)), 15, 3272, CAST(N'2022-03-06T18:35:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.62 AS Decimal(18, 2)), 22, 3273, CAST(N'2022-02-16T09:45:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.03 AS Decimal(18, 2)), 49, 3274, CAST(N'2021-06-24T04:12:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.36 AS Decimal(18, 2)), 15, 3275, CAST(N'2022-05-24T00:45:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.21 AS Decimal(18, 2)), 15, 3276, CAST(N'2021-10-19T14:23:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.13 AS Decimal(18, 2)), 42, 3277, CAST(N'2021-12-15T17:59:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(3.18 AS Decimal(18, 2)), 34, 3278, CAST(N'2021-09-28T11:32:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.30 AS Decimal(18, 2)), 40, 3279, CAST(N'2022-05-12T03:41:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(1.16 AS Decimal(18, 2)), 49, 3280, CAST(N'2021-12-07T01:39:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(7.92 AS Decimal(18, 2)), 25, 3281, CAST(N'2022-03-16T12:48:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.32 AS Decimal(18, 2)), 1, 3282, CAST(N'2022-08-04T08:00:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(7.25 AS Decimal(18, 2)), 35, 3283, CAST(N'2022-02-10T14:35:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(8.41 AS Decimal(18, 2)), 47, 3284, CAST(N'2022-06-12T15:21:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.93 AS Decimal(18, 2)), 42, 3285, CAST(N'2022-02-24T08:51:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(3.51 AS Decimal(18, 2)), 27, 3286, CAST(N'2022-04-29T04:49:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(1.89 AS Decimal(18, 2)), 23, 3287, CAST(N'2021-09-27T14:34:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.08 AS Decimal(18, 2)), 18, 3288, CAST(N'2022-01-21T13:04:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.60 AS Decimal(18, 2)), 41, 3289, CAST(N'2021-11-25T11:09:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.92 AS Decimal(18, 2)), 24, 3290, CAST(N'2021-08-13T22:19:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(5.68 AS Decimal(18, 2)), 42, 3291, CAST(N'2022-02-26T11:49:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.38 AS Decimal(18, 2)), 27, 3292, CAST(N'2022-03-02T05:08:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.37 AS Decimal(18, 2)), 27, 3293, CAST(N'2022-07-11T18:34:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.59 AS Decimal(18, 2)), 1, 3294, CAST(N'2021-09-30T06:21:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.73 AS Decimal(18, 2)), 25, 3295, CAST(N'2021-11-04T12:26:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.78 AS Decimal(18, 2)), 10, 3296, CAST(N'2021-10-24T11:28:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.83 AS Decimal(18, 2)), 40, 3297, CAST(N'2021-07-16T09:50:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.17 AS Decimal(18, 2)), 50, 3298, CAST(N'2021-07-22T01:58:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.76 AS Decimal(18, 2)), 31, 3299, CAST(N'2021-08-29T11:31:17.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.43 AS Decimal(18, 2)), 24, 3300, CAST(N'2021-07-17T03:44:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.01 AS Decimal(18, 2)), 15, 3301, CAST(N'2022-02-07T09:59:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.38 AS Decimal(18, 2)), 34, 3302, CAST(N'2021-12-22T09:27:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.01 AS Decimal(18, 2)), 37, 3303, CAST(N'2022-04-01T22:38:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.39 AS Decimal(18, 2)), 38, 3304, CAST(N'2021-08-12T23:30:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.25 AS Decimal(18, 2)), 43, 3305, CAST(N'2021-06-11T00:15:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(1.01 AS Decimal(18, 2)), 34, 3306, CAST(N'2021-12-12T04:52:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(3.02 AS Decimal(18, 2)), 37, 3307, CAST(N'2021-07-06T04:44:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.25 AS Decimal(18, 2)), 49, 3308, CAST(N'2022-06-24T17:32:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.97 AS Decimal(18, 2)), 38, 3309, CAST(N'2021-09-09T04:21:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.41 AS Decimal(18, 2)), 41, 3310, CAST(N'2022-07-30T14:49:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.57 AS Decimal(18, 2)), 17, 3311, CAST(N'2022-04-25T19:21:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.69 AS Decimal(18, 2)), 37, 3312, CAST(N'2022-07-14T08:17:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.91 AS Decimal(18, 2)), 29, 3313, CAST(N'2021-12-04T05:27:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(7.40 AS Decimal(18, 2)), 5, 3314, CAST(N'2021-08-26T07:45:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.16 AS Decimal(18, 2)), 16, 3315, CAST(N'2022-01-04T16:24:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.90 AS Decimal(18, 2)), 12, 3316, CAST(N'2021-08-21T08:39:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(6.84 AS Decimal(18, 2)), 13, 3317, CAST(N'2021-06-21T09:24:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.55 AS Decimal(18, 2)), 48, 3318, CAST(N'2022-02-15T22:34:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(5.87 AS Decimal(18, 2)), 45, 3319, CAST(N'2022-01-01T06:32:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.19 AS Decimal(18, 2)), 4, 3320, CAST(N'2022-03-12T19:59:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.77 AS Decimal(18, 2)), 32, 3321, CAST(N'2021-08-19T16:30:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.10 AS Decimal(18, 2)), 40, 3322, CAST(N'2022-07-25T10:27:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(6.57 AS Decimal(18, 2)), 49, 3323, CAST(N'2021-11-19T12:08:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.64 AS Decimal(18, 2)), 50, 3324, CAST(N'2022-08-10T20:04:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.26 AS Decimal(18, 2)), 20, 3325, CAST(N'2022-04-12T12:24:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.31 AS Decimal(18, 2)), 43, 3326, CAST(N'2022-07-17T12:34:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(4.72 AS Decimal(18, 2)), 42, 3327, CAST(N'2022-02-09T21:01:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(2.22 AS Decimal(18, 2)), 26, 3328, CAST(N'2022-06-19T23:21:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.99 AS Decimal(18, 2)), 25, 3329, CAST(N'2021-09-14T16:38:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.69 AS Decimal(18, 2)), 11, 3330, CAST(N'2022-02-18T07:16:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.74 AS Decimal(18, 2)), 1, 3331, CAST(N'2021-10-17T13:22:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(8.85 AS Decimal(18, 2)), 44, 3332, CAST(N'2022-06-26T11:03:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.81 AS Decimal(18, 2)), 9, 3333, CAST(N'2021-11-09T03:29:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.43 AS Decimal(18, 2)), 38, 3334, CAST(N'2022-05-31T07:53:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.75 AS Decimal(18, 2)), 30, 3335, CAST(N'2022-05-20T10:46:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.35 AS Decimal(18, 2)), 45, 3336, CAST(N'2022-03-18T05:57:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.01 AS Decimal(18, 2)), 33, 3337, CAST(N'2022-05-30T18:51:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(5.69 AS Decimal(18, 2)), 19, 3338, CAST(N'2021-09-25T12:23:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.96 AS Decimal(18, 2)), 17, 3339, CAST(N'2021-09-08T02:18:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.90 AS Decimal(18, 2)), 27, 3340, CAST(N'2021-07-10T07:10:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.19 AS Decimal(18, 2)), 28, 3341, CAST(N'2021-10-01T04:59:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(6.77 AS Decimal(18, 2)), 47, 3342, CAST(N'2021-11-21T08:40:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.96 AS Decimal(18, 2)), 31, 3343, CAST(N'2022-06-29T19:04:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.38 AS Decimal(18, 2)), 45, 3344, CAST(N'2021-10-25T07:07:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.58 AS Decimal(18, 2)), 29, 3345, CAST(N'2021-10-01T07:45:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(7.56 AS Decimal(18, 2)), 22, 3346, CAST(N'2022-03-06T07:25:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.28 AS Decimal(18, 2)), 47, 3347, CAST(N'2022-07-13T06:21:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.47 AS Decimal(18, 2)), 14, 3348, CAST(N'2021-06-18T12:20:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.49 AS Decimal(18, 2)), 30, 3349, CAST(N'2022-01-11T18:50:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.18 AS Decimal(18, 2)), 2, 3350, CAST(N'2021-11-21T07:42:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.50 AS Decimal(18, 2)), 22, 3351, CAST(N'2021-12-30T10:42:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.47 AS Decimal(18, 2)), 16, 3352, CAST(N'2021-08-10T12:34:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(8.09 AS Decimal(18, 2)), 41, 3353, CAST(N'2022-07-24T04:46:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.25 AS Decimal(18, 2)), 7, 3354, CAST(N'2021-11-18T04:24:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.02 AS Decimal(18, 2)), 25, 3355, CAST(N'2022-01-25T07:06:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.61 AS Decimal(18, 2)), 33, 3356, CAST(N'2021-11-26T22:42:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.61 AS Decimal(18, 2)), 3, 3357, CAST(N'2021-08-25T03:55:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(3.55 AS Decimal(18, 2)), 44, 3358, CAST(N'2021-08-18T12:15:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(8.85 AS Decimal(18, 2)), 40, 3359, CAST(N'2022-08-05T13:24:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.71 AS Decimal(18, 2)), 10, 3360, CAST(N'2021-07-03T04:22:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.97 AS Decimal(18, 2)), 44, 3361, CAST(N'2022-06-06T23:11:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.40 AS Decimal(18, 2)), 10, 3362, CAST(N'2022-05-10T21:13:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.93 AS Decimal(18, 2)), 22, 3363, CAST(N'2021-10-06T13:14:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.55 AS Decimal(18, 2)), 26, 3364, CAST(N'2022-03-08T13:04:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.21 AS Decimal(18, 2)), 31, 3365, CAST(N'2021-11-11T20:41:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.78 AS Decimal(18, 2)), 7, 3366, CAST(N'2022-01-13T22:25:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.70 AS Decimal(18, 2)), 8, 3367, CAST(N'2021-08-18T18:51:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.87 AS Decimal(18, 2)), 19, 3368, CAST(N'2022-04-24T09:51:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(3.83 AS Decimal(18, 2)), 23, 3369, CAST(N'2021-08-05T22:06:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.33 AS Decimal(18, 2)), 33, 3370, CAST(N'2022-06-03T12:20:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(6.13 AS Decimal(18, 2)), 39, 3371, CAST(N'2021-10-08T05:26:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.00 AS Decimal(18, 2)), 48, 3372, CAST(N'2022-03-11T00:53:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.01 AS Decimal(18, 2)), 11, 3373, CAST(N'2022-06-18T22:11:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.74 AS Decimal(18, 2)), 45, 3374, CAST(N'2022-08-15T19:21:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.61 AS Decimal(18, 2)), 16, 3375, CAST(N'2021-12-04T12:25:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(5.64 AS Decimal(18, 2)), 19, 3376, CAST(N'2022-03-27T17:09:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.89 AS Decimal(18, 2)), 25, 3377, CAST(N'2021-07-07T13:57:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.49 AS Decimal(18, 2)), 2, 3378, CAST(N'2022-05-15T18:21:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.51 AS Decimal(18, 2)), 6, 3379, CAST(N'2021-07-07T07:22:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.92 AS Decimal(18, 2)), 50, 3380, CAST(N'2021-11-02T14:36:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.79 AS Decimal(18, 2)), 37, 3381, CAST(N'2022-02-17T20:51:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.50 AS Decimal(18, 2)), 47, 3382, CAST(N'2022-05-04T00:30:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.59 AS Decimal(18, 2)), 18, 3383, CAST(N'2022-06-04T03:20:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.04 AS Decimal(18, 2)), 40, 3384, CAST(N'2022-07-17T04:35:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.39 AS Decimal(18, 2)), 38, 3385, CAST(N'2021-07-03T01:22:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(4.26 AS Decimal(18, 2)), 21, 3386, CAST(N'2022-03-23T02:03:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.68 AS Decimal(18, 2)), 6, 3387, CAST(N'2021-10-23T13:10:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.32 AS Decimal(18, 2)), 6, 3388, CAST(N'2022-06-04T10:08:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.64 AS Decimal(18, 2)), 48, 3389, CAST(N'2021-11-19T16:59:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.07 AS Decimal(18, 2)), 26, 3390, CAST(N'2022-02-12T01:58:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.39 AS Decimal(18, 2)), 49, 3391, CAST(N'2021-09-15T07:53:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.87 AS Decimal(18, 2)), 8, 3392, CAST(N'2021-07-12T17:11:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.77 AS Decimal(18, 2)), 39, 3393, CAST(N'2021-07-21T06:57:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.44 AS Decimal(18, 2)), 35, 3394, CAST(N'2021-08-10T13:27:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.07 AS Decimal(18, 2)), 5, 3395, CAST(N'2022-01-14T00:05:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.40 AS Decimal(18, 2)), 19, 3396, CAST(N'2021-11-24T23:42:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.64 AS Decimal(18, 2)), 34, 3397, CAST(N'2022-06-21T04:17:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(5.41 AS Decimal(18, 2)), 35, 3398, CAST(N'2021-11-29T10:44:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.16 AS Decimal(18, 2)), 44, 3399, CAST(N'2022-06-24T14:06:49.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(7.82 AS Decimal(18, 2)), 1, 3400, CAST(N'2022-02-06T21:10:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.32 AS Decimal(18, 2)), 43, 3401, CAST(N'2021-08-04T05:07:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.42 AS Decimal(18, 2)), 46, 3402, CAST(N'2022-04-12T18:26:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.21 AS Decimal(18, 2)), 40, 3403, CAST(N'2022-06-14T01:28:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.84 AS Decimal(18, 2)), 35, 3404, CAST(N'2022-01-25T14:58:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.95 AS Decimal(18, 2)), 30, 3405, CAST(N'2021-09-26T11:24:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.65 AS Decimal(18, 2)), 27, 3406, CAST(N'2022-02-07T14:13:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.07 AS Decimal(18, 2)), 5, 3407, CAST(N'2021-09-26T00:17:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.47 AS Decimal(18, 2)), 21, 3408, CAST(N'2022-08-05T13:38:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.57 AS Decimal(18, 2)), 31, 3409, CAST(N'2022-07-29T02:06:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.27 AS Decimal(18, 2)), 6, 3410, CAST(N'2021-12-19T21:45:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.46 AS Decimal(18, 2)), 19, 3411, CAST(N'2021-09-19T05:25:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.57 AS Decimal(18, 2)), 33, 3412, CAST(N'2022-04-09T00:40:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.07 AS Decimal(18, 2)), 19, 3413, CAST(N'2021-08-01T19:45:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.27 AS Decimal(18, 2)), 26, 3414, CAST(N'2021-06-26T10:41:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.12 AS Decimal(18, 2)), 17, 3415, CAST(N'2022-07-01T03:33:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(7.69 AS Decimal(18, 2)), 39, 3416, CAST(N'2022-05-04T09:05:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.34 AS Decimal(18, 2)), 25, 3417, CAST(N'2022-06-06T19:21:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.39 AS Decimal(18, 2)), 13, 3418, CAST(N'2021-11-20T04:04:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.60 AS Decimal(18, 2)), 44, 3419, CAST(N'2021-09-03T22:12:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(3.76 AS Decimal(18, 2)), 22, 3420, CAST(N'2022-01-14T17:40:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.81 AS Decimal(18, 2)), 40, 3421, CAST(N'2022-02-05T20:10:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.03 AS Decimal(18, 2)), 27, 3422, CAST(N'2022-02-12T16:56:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.48 AS Decimal(18, 2)), 28, 3423, CAST(N'2022-03-06T03:25:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.34 AS Decimal(18, 2)), 47, 3424, CAST(N'2021-11-04T09:26:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(2.28 AS Decimal(18, 2)), 40, 3425, CAST(N'2021-11-24T18:16:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.61 AS Decimal(18, 2)), 40, 3426, CAST(N'2022-04-08T07:25:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.86 AS Decimal(18, 2)), 5, 3427, CAST(N'2021-11-24T20:50:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.13 AS Decimal(18, 2)), 22, 3428, CAST(N'2022-02-18T21:45:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.42 AS Decimal(18, 2)), 42, 3429, CAST(N'2021-11-21T11:50:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(3.56 AS Decimal(18, 2)), 12, 3430, CAST(N'2021-06-28T21:19:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(6.50 AS Decimal(18, 2)), 22, 3431, CAST(N'2021-09-27T16:31:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.21 AS Decimal(18, 2)), 38, 3432, CAST(N'2022-03-21T21:45:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.64 AS Decimal(18, 2)), 2, 3433, CAST(N'2021-07-09T02:29:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.37 AS Decimal(18, 2)), 8, 3434, CAST(N'2022-05-27T22:16:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.36 AS Decimal(18, 2)), 6, 3435, CAST(N'2022-07-18T05:58:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.98 AS Decimal(18, 2)), 9, 3436, CAST(N'2022-01-30T08:29:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.39 AS Decimal(18, 2)), 45, 3437, CAST(N'2021-11-28T12:58:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.85 AS Decimal(18, 2)), 39, 3438, CAST(N'2022-04-20T15:32:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(3.78 AS Decimal(18, 2)), 35, 3439, CAST(N'2022-06-27T20:06:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.38 AS Decimal(18, 2)), 33, 3440, CAST(N'2022-01-06T22:32:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.23 AS Decimal(18, 2)), 13, 3441, CAST(N'2022-06-09T18:44:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.06 AS Decimal(18, 2)), 36, 3442, CAST(N'2022-01-20T02:04:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(2.59 AS Decimal(18, 2)), 18, 3443, CAST(N'2021-12-07T09:06:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.58 AS Decimal(18, 2)), 13, 3444, CAST(N'2022-02-09T18:53:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(3.55 AS Decimal(18, 2)), 4, 3445, CAST(N'2022-03-08T09:23:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.94 AS Decimal(18, 2)), 30, 3446, CAST(N'2021-11-24T09:13:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.55 AS Decimal(18, 2)), 23, 3447, CAST(N'2021-12-22T22:57:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(3.35 AS Decimal(18, 2)), 6, 3448, CAST(N'2021-08-12T16:17:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.34 AS Decimal(18, 2)), 41, 3449, CAST(N'2022-04-26T12:09:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.55 AS Decimal(18, 2)), 18, 3450, CAST(N'2022-04-24T08:19:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.22 AS Decimal(18, 2)), 24, 3451, CAST(N'2022-05-06T20:53:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(9.36 AS Decimal(18, 2)), 9, 3452, CAST(N'2021-08-02T01:50:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.69 AS Decimal(18, 2)), 33, 3453, CAST(N'2022-07-06T14:32:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(1.54 AS Decimal(18, 2)), 25, 3454, CAST(N'2021-09-17T12:48:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.70 AS Decimal(18, 2)), 40, 3455, CAST(N'2022-03-18T15:00:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(7.19 AS Decimal(18, 2)), 49, 3456, CAST(N'2021-12-20T08:51:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.65 AS Decimal(18, 2)), 50, 3457, CAST(N'2022-01-11T15:20:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.59 AS Decimal(18, 2)), 25, 3458, CAST(N'2022-02-25T10:22:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.17 AS Decimal(18, 2)), 50, 3459, CAST(N'2021-07-05T03:35:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(3.45 AS Decimal(18, 2)), 15, 3460, CAST(N'2021-11-08T18:11:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.33 AS Decimal(18, 2)), 5, 3461, CAST(N'2022-06-05T23:19:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.51 AS Decimal(18, 2)), 9, 3462, CAST(N'2022-05-20T17:04:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.64 AS Decimal(18, 2)), 37, 3463, CAST(N'2022-05-09T21:50:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(1.96 AS Decimal(18, 2)), 33, 3464, CAST(N'2021-09-27T14:35:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.68 AS Decimal(18, 2)), 34, 3465, CAST(N'2022-03-12T21:56:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.40 AS Decimal(18, 2)), 47, 3466, CAST(N'2021-10-30T23:31:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(2.38 AS Decimal(18, 2)), 7, 3467, CAST(N'2021-09-20T01:33:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.95 AS Decimal(18, 2)), 48, 3468, CAST(N'2021-06-27T20:12:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(4.11 AS Decimal(18, 2)), 34, 3469, CAST(N'2022-03-29T10:12:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.21 AS Decimal(18, 2)), 42, 3470, CAST(N'2022-02-17T13:47:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.53 AS Decimal(18, 2)), 33, 3471, CAST(N'2021-10-24T22:42:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.57 AS Decimal(18, 2)), 23, 3472, CAST(N'2022-07-26T16:36:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.52 AS Decimal(18, 2)), 31, 3473, CAST(N'2022-04-26T03:51:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(1.04 AS Decimal(18, 2)), 42, 3474, CAST(N'2022-01-28T13:56:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(4.62 AS Decimal(18, 2)), 13, 3475, CAST(N'2022-05-30T09:21:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.08 AS Decimal(18, 2)), 7, 3476, CAST(N'2022-03-17T18:21:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(7.41 AS Decimal(18, 2)), 37, 3477, CAST(N'2022-02-23T05:27:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(7.05 AS Decimal(18, 2)), 41, 3478, CAST(N'2022-02-15T18:11:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.49 AS Decimal(18, 2)), 1, 3479, CAST(N'2022-03-21T18:57:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.91 AS Decimal(18, 2)), 34, 3480, CAST(N'2021-08-04T13:08:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.96 AS Decimal(18, 2)), 27, 3481, CAST(N'2022-02-13T04:00:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.32 AS Decimal(18, 2)), 20, 3482, CAST(N'2022-03-22T14:28:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(4.25 AS Decimal(18, 2)), 31, 3483, CAST(N'2022-07-23T17:13:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.06 AS Decimal(18, 2)), 17, 3484, CAST(N'2022-01-01T16:07:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.32 AS Decimal(18, 2)), 21, 3485, CAST(N'2022-05-13T21:34:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.21 AS Decimal(18, 2)), 50, 3486, CAST(N'2021-09-27T11:34:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.14 AS Decimal(18, 2)), 40, 3487, CAST(N'2022-07-29T21:35:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(4.79 AS Decimal(18, 2)), 9, 3488, CAST(N'2022-02-26T13:53:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.36 AS Decimal(18, 2)), 40, 3489, CAST(N'2022-04-18T16:44:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.59 AS Decimal(18, 2)), 32, 3490, CAST(N'2021-09-29T14:33:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.79 AS Decimal(18, 2)), 7, 3491, CAST(N'2022-06-11T04:01:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.56 AS Decimal(18, 2)), 43, 3492, CAST(N'2021-09-05T09:20:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(4.15 AS Decimal(18, 2)), 39, 3493, CAST(N'2022-03-19T05:17:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.01 AS Decimal(18, 2)), 12, 3494, CAST(N'2021-12-11T22:20:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(5.98 AS Decimal(18, 2)), 21, 3495, CAST(N'2021-11-02T10:04:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.90 AS Decimal(18, 2)), 41, 3496, CAST(N'2021-12-28T02:00:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.18 AS Decimal(18, 2)), 21, 3497, CAST(N'2022-03-11T23:31:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(4.08 AS Decimal(18, 2)), 42, 3498, CAST(N'2022-04-12T06:43:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.06 AS Decimal(18, 2)), 24, 3499, CAST(N'2022-03-08T00:12:01.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.94 AS Decimal(18, 2)), 49, 3500, CAST(N'2021-12-21T10:33:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(1.23 AS Decimal(18, 2)), 28, 3501, CAST(N'2022-06-10T19:49:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.20 AS Decimal(18, 2)), 32, 3502, CAST(N'2021-06-16T03:18:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.24 AS Decimal(18, 2)), 22, 3503, CAST(N'2021-06-20T20:23:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.04 AS Decimal(18, 2)), 46, 3504, CAST(N'2022-04-21T12:18:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.31 AS Decimal(18, 2)), 28, 3505, CAST(N'2021-12-05T16:36:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.86 AS Decimal(18, 2)), 20, 3506, CAST(N'2022-03-13T20:12:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(4.46 AS Decimal(18, 2)), 22, 3507, CAST(N'2021-10-01T10:46:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.43 AS Decimal(18, 2)), 11, 3508, CAST(N'2021-09-25T05:53:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.96 AS Decimal(18, 2)), 18, 3509, CAST(N'2022-01-21T11:34:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.20 AS Decimal(18, 2)), 40, 3510, CAST(N'2022-03-22T05:04:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(9.09 AS Decimal(18, 2)), 23, 3511, CAST(N'2022-07-27T18:03:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.40 AS Decimal(18, 2)), 5, 3512, CAST(N'2022-03-27T10:47:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(1.88 AS Decimal(18, 2)), 25, 3513, CAST(N'2022-05-07T04:02:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.38 AS Decimal(18, 2)), 12, 3514, CAST(N'2021-08-17T18:24:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(8.20 AS Decimal(18, 2)), 18, 3515, CAST(N'2021-11-02T04:14:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.78 AS Decimal(18, 2)), 39, 3516, CAST(N'2022-04-11T18:45:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(3.72 AS Decimal(18, 2)), 10, 3517, CAST(N'2022-01-20T12:26:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.24 AS Decimal(18, 2)), 28, 3518, CAST(N'2021-06-21T14:00:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.83 AS Decimal(18, 2)), 28, 3519, CAST(N'2022-04-02T01:58:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(2.15 AS Decimal(18, 2)), 44, 3520, CAST(N'2022-06-28T00:20:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.01 AS Decimal(18, 2)), 6, 3521, CAST(N'2021-08-25T00:00:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(8.98 AS Decimal(18, 2)), 23, 3522, CAST(N'2021-07-15T05:46:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.84 AS Decimal(18, 2)), 9, 3523, CAST(N'2022-05-16T11:14:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.93 AS Decimal(18, 2)), 42, 3524, CAST(N'2021-08-15T14:19:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(4.60 AS Decimal(18, 2)), 10, 3525, CAST(N'2021-09-05T07:42:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(5.69 AS Decimal(18, 2)), 18, 3526, CAST(N'2022-01-13T18:41:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.62 AS Decimal(18, 2)), 18, 3527, CAST(N'2022-06-18T15:25:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(7.62 AS Decimal(18, 2)), 34, 3528, CAST(N'2021-08-22T23:14:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.68 AS Decimal(18, 2)), 33, 3529, CAST(N'2022-01-28T10:42:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(3.51 AS Decimal(18, 2)), 50, 3530, CAST(N'2022-01-07T03:52:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.06 AS Decimal(18, 2)), 5, 3531, CAST(N'2022-08-03T03:32:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(7.40 AS Decimal(18, 2)), 24, 3532, CAST(N'2022-05-13T12:41:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(9.90 AS Decimal(18, 2)), 9, 3533, CAST(N'2021-06-08T21:55:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(7.58 AS Decimal(18, 2)), 34, 3534, CAST(N'2021-12-22T15:36:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(6.63 AS Decimal(18, 2)), 12, 3535, CAST(N'2022-02-06T08:36:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.82 AS Decimal(18, 2)), 39, 3536, CAST(N'2021-08-26T13:43:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.83 AS Decimal(18, 2)), 22, 3537, CAST(N'2022-03-18T07:11:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.59 AS Decimal(18, 2)), 10, 3538, CAST(N'2021-11-18T17:20:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.43 AS Decimal(18, 2)), 47, 3539, CAST(N'2021-10-12T05:08:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.52 AS Decimal(18, 2)), 8, 3540, CAST(N'2021-09-27T17:54:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.34 AS Decimal(18, 2)), 43, 3541, CAST(N'2021-08-06T12:13:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.27 AS Decimal(18, 2)), 48, 3542, CAST(N'2022-02-28T13:05:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.73 AS Decimal(18, 2)), 3, 3543, CAST(N'2021-10-25T11:34:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.57 AS Decimal(18, 2)), 11, 3544, CAST(N'2022-05-03T01:15:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.88 AS Decimal(18, 2)), 50, 3545, CAST(N'2022-03-13T12:36:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(4.04 AS Decimal(18, 2)), 8, 3546, CAST(N'2021-12-22T13:33:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(3.08 AS Decimal(18, 2)), 11, 3547, CAST(N'2021-11-11T07:51:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.27 AS Decimal(18, 2)), 25, 3548, CAST(N'2022-07-20T02:10:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.35 AS Decimal(18, 2)), 50, 3549, CAST(N'2021-07-22T04:05:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.19 AS Decimal(18, 2)), 8, 3550, CAST(N'2021-08-13T16:16:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.18 AS Decimal(18, 2)), 48, 3551, CAST(N'2021-09-21T20:02:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.09 AS Decimal(18, 2)), 7, 3552, CAST(N'2022-03-22T08:09:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.19 AS Decimal(18, 2)), 10, 3553, CAST(N'2022-08-08T19:13:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.27 AS Decimal(18, 2)), 33, 3554, CAST(N'2021-08-25T14:38:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.20 AS Decimal(18, 2)), 48, 3555, CAST(N'2022-01-16T09:45:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.13 AS Decimal(18, 2)), 33, 3556, CAST(N'2022-04-26T08:06:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.28 AS Decimal(18, 2)), 32, 3557, CAST(N'2022-02-16T07:42:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(7.77 AS Decimal(18, 2)), 24, 3558, CAST(N'2021-06-14T07:43:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(2.87 AS Decimal(18, 2)), 5, 3559, CAST(N'2021-09-12T20:51:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(2.59 AS Decimal(18, 2)), 32, 3560, CAST(N'2021-08-15T23:10:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.34 AS Decimal(18, 2)), 19, 3561, CAST(N'2021-06-20T07:48:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.56 AS Decimal(18, 2)), 50, 3562, CAST(N'2021-11-28T09:26:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.84 AS Decimal(18, 2)), 31, 3563, CAST(N'2021-11-07T22:22:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.67 AS Decimal(18, 2)), 49, 3564, CAST(N'2021-12-10T03:23:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.49 AS Decimal(18, 2)), 31, 3565, CAST(N'2022-06-25T03:16:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(8.81 AS Decimal(18, 2)), 35, 3566, CAST(N'2022-01-28T10:37:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.50 AS Decimal(18, 2)), 49, 3567, CAST(N'2021-07-12T04:34:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.43 AS Decimal(18, 2)), 8, 3568, CAST(N'2021-06-28T17:08:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(6.80 AS Decimal(18, 2)), 13, 3569, CAST(N'2021-09-30T20:19:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.91 AS Decimal(18, 2)), 3, 3570, CAST(N'2021-09-23T15:25:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.31 AS Decimal(18, 2)), 41, 3571, CAST(N'2021-12-08T01:04:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.91 AS Decimal(18, 2)), 9, 3572, CAST(N'2022-06-08T08:27:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.02 AS Decimal(18, 2)), 48, 3573, CAST(N'2021-06-11T11:45:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.08 AS Decimal(18, 2)), 6, 3574, CAST(N'2021-11-22T15:11:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(2.80 AS Decimal(18, 2)), 35, 3575, CAST(N'2022-02-11T02:26:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.57 AS Decimal(18, 2)), 46, 3576, CAST(N'2022-06-08T13:27:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.79 AS Decimal(18, 2)), 45, 3577, CAST(N'2022-07-21T02:49:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.86 AS Decimal(18, 2)), 18, 3578, CAST(N'2022-08-06T16:51:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.26 AS Decimal(18, 2)), 17, 3579, CAST(N'2022-04-03T19:52:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.50 AS Decimal(18, 2)), 6, 3580, CAST(N'2021-09-09T03:39:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.14 AS Decimal(18, 2)), 37, 3581, CAST(N'2022-04-08T00:16:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.54 AS Decimal(18, 2)), 39, 3582, CAST(N'2022-02-16T02:07:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(4.80 AS Decimal(18, 2)), 43, 3583, CAST(N'2022-05-16T00:46:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(4.54 AS Decimal(18, 2)), 7, 3584, CAST(N'2022-08-05T02:02:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.35 AS Decimal(18, 2)), 50, 3585, CAST(N'2021-08-27T12:37:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.37 AS Decimal(18, 2)), 16, 3586, CAST(N'2021-10-07T18:21:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(4.24 AS Decimal(18, 2)), 41, 3587, CAST(N'2021-09-28T20:45:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.82 AS Decimal(18, 2)), 41, 3588, CAST(N'2022-05-23T22:07:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.44 AS Decimal(18, 2)), 33, 3589, CAST(N'2022-03-30T08:43:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.65 AS Decimal(18, 2)), 48, 3590, CAST(N'2022-04-24T18:41:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(3.54 AS Decimal(18, 2)), 37, 3591, CAST(N'2021-12-12T04:30:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.42 AS Decimal(18, 2)), 30, 3592, CAST(N'2022-06-19T06:50:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(3.36 AS Decimal(18, 2)), 44, 3593, CAST(N'2021-08-19T11:08:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(2.12 AS Decimal(18, 2)), 40, 3594, CAST(N'2021-08-04T04:13:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(5.81 AS Decimal(18, 2)), 2, 3595, CAST(N'2021-11-01T07:43:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.11 AS Decimal(18, 2)), 14, 3596, CAST(N'2022-04-13T16:33:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.67 AS Decimal(18, 2)), 47, 3597, CAST(N'2021-06-10T16:44:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(3.04 AS Decimal(18, 2)), 43, 3598, CAST(N'2022-02-11T01:36:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(4.08 AS Decimal(18, 2)), 44, 3599, CAST(N'2021-07-01T02:25:33.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.88 AS Decimal(18, 2)), 4, 3600, CAST(N'2021-10-10T18:47:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.40 AS Decimal(18, 2)), 16, 3601, CAST(N'2022-04-04T15:05:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.84 AS Decimal(18, 2)), 47, 3602, CAST(N'2021-10-09T15:20:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(9.41 AS Decimal(18, 2)), 7, 3603, CAST(N'2021-11-07T16:24:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.60 AS Decimal(18, 2)), 48, 3604, CAST(N'2022-05-11T19:05:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(3.19 AS Decimal(18, 2)), 27, 3605, CAST(N'2022-01-04T10:34:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.57 AS Decimal(18, 2)), 29, 3606, CAST(N'2022-01-08T22:07:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.46 AS Decimal(18, 2)), 36, 3607, CAST(N'2021-06-24T05:30:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.39 AS Decimal(18, 2)), 29, 3608, CAST(N'2022-05-18T14:15:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(4.39 AS Decimal(18, 2)), 49, 3609, CAST(N'2022-06-03T07:53:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.33 AS Decimal(18, 2)), 20, 3610, CAST(N'2022-06-23T12:32:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(2.61 AS Decimal(18, 2)), 8, 3611, CAST(N'2022-04-03T09:04:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.71 AS Decimal(18, 2)), 12, 3612, CAST(N'2022-05-07T21:41:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(3.59 AS Decimal(18, 2)), 35, 3613, CAST(N'2021-07-29T10:37:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(4.97 AS Decimal(18, 2)), 49, 3614, CAST(N'2021-06-25T21:10:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(1.57 AS Decimal(18, 2)), 31, 3615, CAST(N'2021-06-02T03:28:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.81 AS Decimal(18, 2)), 5, 3616, CAST(N'2021-11-18T04:05:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(1.26 AS Decimal(18, 2)), 2, 3617, CAST(N'2022-04-26T16:14:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.44 AS Decimal(18, 2)), 46, 3618, CAST(N'2022-07-08T23:52:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(3.98 AS Decimal(18, 2)), 25, 3619, CAST(N'2022-04-13T17:51:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.09 AS Decimal(18, 2)), 46, 3620, CAST(N'2021-07-19T04:40:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.02 AS Decimal(18, 2)), 19, 3621, CAST(N'2022-08-07T16:25:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.79 AS Decimal(18, 2)), 45, 3622, CAST(N'2022-07-17T15:53:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(4.14 AS Decimal(18, 2)), 16, 3623, CAST(N'2022-07-12T14:56:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.72 AS Decimal(18, 2)), 22, 3624, CAST(N'2021-06-14T02:12:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.38 AS Decimal(18, 2)), 44, 3625, CAST(N'2021-08-13T12:29:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.81 AS Decimal(18, 2)), 24, 3626, CAST(N'2021-11-10T11:35:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(7.21 AS Decimal(18, 2)), 38, 3627, CAST(N'2022-01-06T23:43:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(1.76 AS Decimal(18, 2)), 19, 3628, CAST(N'2022-08-08T12:32:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(2.96 AS Decimal(18, 2)), 43, 3629, CAST(N'2022-01-18T20:28:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.24 AS Decimal(18, 2)), 35, 3630, CAST(N'2021-07-17T22:26:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.05 AS Decimal(18, 2)), 21, 3631, CAST(N'2022-07-25T17:22:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(5.87 AS Decimal(18, 2)), 29, 3632, CAST(N'2021-12-27T08:28:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.51 AS Decimal(18, 2)), 24, 3633, CAST(N'2021-07-15T19:31:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(1.28 AS Decimal(18, 2)), 32, 3634, CAST(N'2022-03-20T10:29:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(5.12 AS Decimal(18, 2)), 32, 3635, CAST(N'2022-07-18T19:20:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(4.82 AS Decimal(18, 2)), 42, 3636, CAST(N'2022-02-03T15:44:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(7.34 AS Decimal(18, 2)), 30, 3637, CAST(N'2021-06-13T00:12:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.43 AS Decimal(18, 2)), 1, 3638, CAST(N'2022-04-28T09:32:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(4.27 AS Decimal(18, 2)), 1, 3639, CAST(N'2022-03-12T21:27:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(3.37 AS Decimal(18, 2)), 34, 3640, CAST(N'2021-07-05T22:03:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.94 AS Decimal(18, 2)), 15, 3641, CAST(N'2022-06-03T11:15:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(2.77 AS Decimal(18, 2)), 21, 3642, CAST(N'2021-09-22T08:03:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.36 AS Decimal(18, 2)), 31, 3643, CAST(N'2022-03-20T12:24:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(9.28 AS Decimal(18, 2)), 41, 3644, CAST(N'2022-03-25T10:05:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.46 AS Decimal(18, 2)), 41, 3645, CAST(N'2021-08-14T19:41:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.65 AS Decimal(18, 2)), 7, 3646, CAST(N'2021-08-13T11:19:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.31 AS Decimal(18, 2)), 50, 3647, CAST(N'2021-12-05T10:02:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.71 AS Decimal(18, 2)), 47, 3648, CAST(N'2021-10-15T17:17:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.11 AS Decimal(18, 2)), 6, 3649, CAST(N'2021-12-18T19:13:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(6.81 AS Decimal(18, 2)), 35, 3650, CAST(N'2022-02-28T14:00:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.75 AS Decimal(18, 2)), 42, 3651, CAST(N'2021-12-12T23:47:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.86 AS Decimal(18, 2)), 30, 3652, CAST(N'2022-01-31T00:04:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(3.57 AS Decimal(18, 2)), 18, 3653, CAST(N'2022-01-22T09:27:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(9.32 AS Decimal(18, 2)), 14, 3654, CAST(N'2021-07-10T15:30:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(3.24 AS Decimal(18, 2)), 36, 3655, CAST(N'2021-08-10T00:12:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.16 AS Decimal(18, 2)), 5, 3656, CAST(N'2021-08-02T12:53:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.58 AS Decimal(18, 2)), 29, 3657, CAST(N'2022-03-13T19:05:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(7.18 AS Decimal(18, 2)), 42, 3658, CAST(N'2022-05-17T11:32:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.09 AS Decimal(18, 2)), 3, 3659, CAST(N'2021-09-20T07:48:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.34 AS Decimal(18, 2)), 2, 3660, CAST(N'2022-03-26T02:16:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(1.52 AS Decimal(18, 2)), 12, 3661, CAST(N'2022-01-31T20:14:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.27 AS Decimal(18, 2)), 4, 3662, CAST(N'2021-10-20T23:18:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.49 AS Decimal(18, 2)), 15, 3663, CAST(N'2022-05-17T06:22:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(1.97 AS Decimal(18, 2)), 31, 3664, CAST(N'2022-06-30T23:54:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.68 AS Decimal(18, 2)), 28, 3665, CAST(N'2022-04-21T15:36:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.90 AS Decimal(18, 2)), 2, 3666, CAST(N'2021-09-08T18:16:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(8.74 AS Decimal(18, 2)), 26, 3667, CAST(N'2021-09-26T15:15:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(4.50 AS Decimal(18, 2)), 43, 3668, CAST(N'2021-09-30T02:54:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.43 AS Decimal(18, 2)), 45, 3669, CAST(N'2021-08-15T15:16:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.75 AS Decimal(18, 2)), 18, 3670, CAST(N'2022-01-31T07:20:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.73 AS Decimal(18, 2)), 34, 3671, CAST(N'2022-01-01T18:04:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.96 AS Decimal(18, 2)), 47, 3672, CAST(N'2021-08-01T14:33:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(2.59 AS Decimal(18, 2)), 47, 3673, CAST(N'2022-05-24T16:20:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.28 AS Decimal(18, 2)), 11, 3674, CAST(N'2021-07-10T12:35:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.54 AS Decimal(18, 2)), 24, 3675, CAST(N'2021-06-28T19:49:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(9.66 AS Decimal(18, 2)), 4, 3676, CAST(N'2022-05-08T02:06:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.66 AS Decimal(18, 2)), 21, 3677, CAST(N'2022-03-18T09:24:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.39 AS Decimal(18, 2)), 23, 3678, CAST(N'2021-10-16T02:15:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.44 AS Decimal(18, 2)), 27, 3679, CAST(N'2021-09-11T00:31:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(1.56 AS Decimal(18, 2)), 24, 3680, CAST(N'2021-10-08T03:52:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.64 AS Decimal(18, 2)), 42, 3681, CAST(N'2022-07-15T02:51:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(9.56 AS Decimal(18, 2)), 47, 3682, CAST(N'2021-11-18T02:16:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.87 AS Decimal(18, 2)), 14, 3683, CAST(N'2021-06-08T12:09:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.34 AS Decimal(18, 2)), 40, 3684, CAST(N'2021-09-02T02:09:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.02 AS Decimal(18, 2)), 28, 3685, CAST(N'2022-06-05T16:55:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.66 AS Decimal(18, 2)), 9, 3686, CAST(N'2022-08-09T00:37:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(5.94 AS Decimal(18, 2)), 18, 3687, CAST(N'2021-07-07T07:19:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.50 AS Decimal(18, 2)), 31, 3688, CAST(N'2022-01-22T09:32:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.28 AS Decimal(18, 2)), 29, 3689, CAST(N'2022-07-22T19:38:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.33 AS Decimal(18, 2)), 7, 3690, CAST(N'2022-01-03T08:13:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.55 AS Decimal(18, 2)), 29, 3691, CAST(N'2021-12-07T04:55:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.11 AS Decimal(18, 2)), 5, 3692, CAST(N'2021-10-28T02:58:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(7.62 AS Decimal(18, 2)), 47, 3693, CAST(N'2021-12-14T07:35:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(8.90 AS Decimal(18, 2)), 16, 3694, CAST(N'2021-11-07T19:44:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.71 AS Decimal(18, 2)), 9, 3695, CAST(N'2021-11-29T13:32:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.71 AS Decimal(18, 2)), 30, 3696, CAST(N'2021-12-23T20:12:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.03 AS Decimal(18, 2)), 50, 3697, CAST(N'2021-08-24T21:32:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(6.93 AS Decimal(18, 2)), 26, 3698, CAST(N'2021-11-17T09:17:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.36 AS Decimal(18, 2)), 43, 3699, CAST(N'2022-01-31T20:03:33.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(5.80 AS Decimal(18, 2)), 15, 3700, CAST(N'2021-11-08T08:28:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(4.17 AS Decimal(18, 2)), 28, 3701, CAST(N'2022-07-03T22:54:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.01 AS Decimal(18, 2)), 28, 3702, CAST(N'2022-05-08T17:34:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.52 AS Decimal(18, 2)), 32, 3703, CAST(N'2022-05-31T05:39:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.62 AS Decimal(18, 2)), 7, 3704, CAST(N'2021-10-27T02:28:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.63 AS Decimal(18, 2)), 22, 3705, CAST(N'2021-07-30T04:38:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(6.52 AS Decimal(18, 2)), 31, 3706, CAST(N'2022-05-31T10:57:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(4.77 AS Decimal(18, 2)), 7, 3707, CAST(N'2022-07-06T12:50:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.06 AS Decimal(18, 2)), 33, 3708, CAST(N'2022-01-12T04:49:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(4.40 AS Decimal(18, 2)), 20, 3709, CAST(N'2021-08-11T11:41:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.45 AS Decimal(18, 2)), 31, 3710, CAST(N'2021-06-27T11:06:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(2.89 AS Decimal(18, 2)), 3, 3711, CAST(N'2022-01-28T20:12:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(4.14 AS Decimal(18, 2)), 38, 3712, CAST(N'2021-12-12T20:32:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(5.36 AS Decimal(18, 2)), 21, 3713, CAST(N'2022-02-02T08:08:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.38 AS Decimal(18, 2)), 50, 3714, CAST(N'2022-02-06T07:10:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.44 AS Decimal(18, 2)), 4, 3715, CAST(N'2022-07-27T05:58:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(9.40 AS Decimal(18, 2)), 50, 3716, CAST(N'2021-10-16T00:51:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(5.98 AS Decimal(18, 2)), 13, 3717, CAST(N'2022-04-02T19:37:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.96 AS Decimal(18, 2)), 20, 3718, CAST(N'2022-02-10T05:04:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.48 AS Decimal(18, 2)), 40, 3719, CAST(N'2022-03-18T14:18:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.08 AS Decimal(18, 2)), 27, 3720, CAST(N'2022-04-04T12:22:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.86 AS Decimal(18, 2)), 19, 3721, CAST(N'2021-11-23T08:46:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.74 AS Decimal(18, 2)), 33, 3722, CAST(N'2021-07-12T03:43:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.19 AS Decimal(18, 2)), 17, 3723, CAST(N'2022-06-19T10:33:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.13 AS Decimal(18, 2)), 33, 3724, CAST(N'2022-05-01T13:52:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(6.36 AS Decimal(18, 2)), 25, 3725, CAST(N'2021-06-02T19:31:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.58 AS Decimal(18, 2)), 28, 3726, CAST(N'2021-07-05T22:33:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.01 AS Decimal(18, 2)), 32, 3727, CAST(N'2021-11-07T07:30:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.52 AS Decimal(18, 2)), 13, 3728, CAST(N'2021-11-13T13:36:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(7.72 AS Decimal(18, 2)), 48, 3729, CAST(N'2022-01-14T01:57:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.91 AS Decimal(18, 2)), 10, 3730, CAST(N'2021-11-27T05:23:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.20 AS Decimal(18, 2)), 15, 3731, CAST(N'2021-12-24T01:16:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(4.58 AS Decimal(18, 2)), 17, 3732, CAST(N'2021-12-20T15:03:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(2.51 AS Decimal(18, 2)), 20, 3733, CAST(N'2021-12-23T12:36:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.33 AS Decimal(18, 2)), 4, 3734, CAST(N'2021-10-25T15:03:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.55 AS Decimal(18, 2)), 11, 3735, CAST(N'2022-07-25T22:55:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.00 AS Decimal(18, 2)), 9, 3736, CAST(N'2022-08-06T22:45:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.20 AS Decimal(18, 2)), 24, 3737, CAST(N'2022-06-24T17:02:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.63 AS Decimal(18, 2)), 28, 3738, CAST(N'2021-09-19T22:36:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(9.69 AS Decimal(18, 2)), 14, 3739, CAST(N'2021-11-15T20:10:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.99 AS Decimal(18, 2)), 42, 3740, CAST(N'2022-07-30T11:01:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.65 AS Decimal(18, 2)), 6, 3741, CAST(N'2022-03-11T01:56:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.46 AS Decimal(18, 2)), 34, 3742, CAST(N'2022-04-15T09:59:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(4.25 AS Decimal(18, 2)), 4, 3743, CAST(N'2021-07-26T01:01:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.01 AS Decimal(18, 2)), 3, 3744, CAST(N'2022-06-02T05:09:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.78 AS Decimal(18, 2)), 7, 3745, CAST(N'2022-03-21T14:37:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(5.75 AS Decimal(18, 2)), 30, 3746, CAST(N'2022-02-27T10:01:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.07 AS Decimal(18, 2)), 42, 3747, CAST(N'2022-03-08T14:17:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.04 AS Decimal(18, 2)), 21, 3748, CAST(N'2022-04-02T20:11:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.58 AS Decimal(18, 2)), 32, 3749, CAST(N'2022-04-08T23:30:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(5.54 AS Decimal(18, 2)), 11, 3750, CAST(N'2022-05-13T16:49:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.04 AS Decimal(18, 2)), 24, 3751, CAST(N'2021-10-21T01:08:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(4.85 AS Decimal(18, 2)), 23, 3752, CAST(N'2022-02-10T21:15:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(2.65 AS Decimal(18, 2)), 27, 3753, CAST(N'2021-12-21T01:49:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.80 AS Decimal(18, 2)), 21, 3754, CAST(N'2022-07-08T23:52:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.35 AS Decimal(18, 2)), 28, 3755, CAST(N'2021-11-29T13:42:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.92 AS Decimal(18, 2)), 23, 3756, CAST(N'2021-10-05T08:30:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.46 AS Decimal(18, 2)), 18, 3757, CAST(N'2022-08-15T00:46:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(1.63 AS Decimal(18, 2)), 48, 3758, CAST(N'2021-08-18T12:16:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(3.19 AS Decimal(18, 2)), 20, 3759, CAST(N'2022-01-18T13:11:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.31 AS Decimal(18, 2)), 2, 3760, CAST(N'2022-03-13T00:29:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.03 AS Decimal(18, 2)), 5, 3761, CAST(N'2021-08-19T17:19:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(2.64 AS Decimal(18, 2)), 39, 3762, CAST(N'2022-05-09T06:21:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.25 AS Decimal(18, 2)), 43, 3763, CAST(N'2022-06-14T22:32:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(3.94 AS Decimal(18, 2)), 21, 3764, CAST(N'2022-03-24T10:50:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(3.30 AS Decimal(18, 2)), 39, 3765, CAST(N'2022-01-15T04:58:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(3.00 AS Decimal(18, 2)), 39, 3766, CAST(N'2022-03-23T19:29:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.85 AS Decimal(18, 2)), 30, 3767, CAST(N'2021-07-31T22:17:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.27 AS Decimal(18, 2)), 27, 3768, CAST(N'2022-05-17T05:12:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.63 AS Decimal(18, 2)), 48, 3769, CAST(N'2021-07-07T11:50:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.24 AS Decimal(18, 2)), 26, 3770, CAST(N'2021-07-03T10:06:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.74 AS Decimal(18, 2)), 16, 3771, CAST(N'2021-09-04T23:25:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.91 AS Decimal(18, 2)), 18, 3772, CAST(N'2021-10-07T06:29:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.66 AS Decimal(18, 2)), 29, 3773, CAST(N'2021-11-30T06:07:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(2.97 AS Decimal(18, 2)), 5, 3774, CAST(N'2021-12-27T16:34:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(6.79 AS Decimal(18, 2)), 36, 3775, CAST(N'2022-01-08T17:51:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(6.06 AS Decimal(18, 2)), 14, 3776, CAST(N'2021-06-22T00:14:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.51 AS Decimal(18, 2)), 7, 3777, CAST(N'2021-09-06T06:46:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(3.57 AS Decimal(18, 2)), 39, 3778, CAST(N'2022-03-02T00:13:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(7.36 AS Decimal(18, 2)), 44, 3779, CAST(N'2021-08-12T21:33:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(9.06 AS Decimal(18, 2)), 32, 3780, CAST(N'2021-09-28T17:59:07.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.52 AS Decimal(18, 2)), 15, 3781, CAST(N'2022-05-24T19:20:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(2.74 AS Decimal(18, 2)), 42, 3782, CAST(N'2022-01-26T15:44:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.04 AS Decimal(18, 2)), 25, 3783, CAST(N'2022-05-19T12:56:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(8.39 AS Decimal(18, 2)), 22, 3784, CAST(N'2022-06-11T11:46:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(5.41 AS Decimal(18, 2)), 26, 3785, CAST(N'2022-02-13T23:03:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(3.06 AS Decimal(18, 2)), 4, 3786, CAST(N'2021-09-11T17:32:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.28 AS Decimal(18, 2)), 43, 3787, CAST(N'2022-08-04T00:04:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.97 AS Decimal(18, 2)), 36, 3788, CAST(N'2021-07-19T23:50:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(1.24 AS Decimal(18, 2)), 2, 3789, CAST(N'2021-09-16T16:44:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(6.51 AS Decimal(18, 2)), 2, 3790, CAST(N'2021-08-18T17:53:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.89 AS Decimal(18, 2)), 18, 3791, CAST(N'2021-06-26T10:26:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(8.33 AS Decimal(18, 2)), 16, 3792, CAST(N'2021-10-12T06:04:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.36 AS Decimal(18, 2)), 3, 3793, CAST(N'2022-05-29T11:07:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(4.04 AS Decimal(18, 2)), 31, 3794, CAST(N'2022-07-28T21:06:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.01 AS Decimal(18, 2)), 30, 3795, CAST(N'2021-07-27T02:45:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(2.62 AS Decimal(18, 2)), 14, 3796, CAST(N'2021-10-10T19:24:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.82 AS Decimal(18, 2)), 25, 3797, CAST(N'2021-08-09T05:52:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.43 AS Decimal(18, 2)), 30, 3798, CAST(N'2021-11-26T18:32:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.09 AS Decimal(18, 2)), 24, 3799, CAST(N'2022-01-29T01:51:13.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.96 AS Decimal(18, 2)), 24, 3800, CAST(N'2021-11-30T13:09:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.09 AS Decimal(18, 2)), 34, 3801, CAST(N'2022-02-28T07:45:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(1.38 AS Decimal(18, 2)), 37, 3802, CAST(N'2022-05-06T17:23:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.94 AS Decimal(18, 2)), 22, 3803, CAST(N'2022-07-18T19:14:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.99 AS Decimal(18, 2)), 42, 3804, CAST(N'2022-03-08T23:05:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(8.66 AS Decimal(18, 2)), 48, 3805, CAST(N'2021-07-13T22:44:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.14 AS Decimal(18, 2)), 32, 3806, CAST(N'2021-10-31T14:43:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(4.06 AS Decimal(18, 2)), 42, 3807, CAST(N'2022-04-11T22:36:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.31 AS Decimal(18, 2)), 40, 3808, CAST(N'2021-09-03T22:09:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.47 AS Decimal(18, 2)), 8, 3809, CAST(N'2022-04-19T09:44:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.60 AS Decimal(18, 2)), 49, 3810, CAST(N'2021-10-23T07:58:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(2.80 AS Decimal(18, 2)), 34, 3811, CAST(N'2022-04-07T23:54:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.22 AS Decimal(18, 2)), 13, 3812, CAST(N'2021-08-02T01:25:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(4.07 AS Decimal(18, 2)), 4, 3813, CAST(N'2022-01-19T00:28:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(2.27 AS Decimal(18, 2)), 25, 3814, CAST(N'2021-12-26T18:40:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(8.92 AS Decimal(18, 2)), 4, 3815, CAST(N'2022-05-21T18:10:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(7.07 AS Decimal(18, 2)), 8, 3816, CAST(N'2021-11-10T18:34:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(9.42 AS Decimal(18, 2)), 13, 3817, CAST(N'2022-07-02T20:23:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(3.77 AS Decimal(18, 2)), 44, 3818, CAST(N'2021-12-27T13:28:29.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.41 AS Decimal(18, 2)), 5, 3819, CAST(N'2021-11-22T06:01:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(9.93 AS Decimal(18, 2)), 8, 3820, CAST(N'2021-11-06T23:09:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(4.32 AS Decimal(18, 2)), 23, 3821, CAST(N'2022-02-24T11:41:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(7.23 AS Decimal(18, 2)), 22, 3822, CAST(N'2022-05-26T08:43:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(4.03 AS Decimal(18, 2)), 11, 3823, CAST(N'2022-08-03T18:02:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.95 AS Decimal(18, 2)), 33, 3824, CAST(N'2021-06-05T00:01:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(4.48 AS Decimal(18, 2)), 36, 3825, CAST(N'2022-04-09T21:22:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(9.15 AS Decimal(18, 2)), 5, 3826, CAST(N'2022-08-11T06:49:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.34 AS Decimal(18, 2)), 44, 3827, CAST(N'2022-04-13T22:55:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(7.85 AS Decimal(18, 2)), 12, 3828, CAST(N'2022-07-17T21:36:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(3.32 AS Decimal(18, 2)), 8, 3829, CAST(N'2021-06-10T17:22:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.00 AS Decimal(18, 2)), 46, 3830, CAST(N'2022-01-21T18:21:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(2.97 AS Decimal(18, 2)), 9, 3831, CAST(N'2022-06-19T13:17:36.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(9.57 AS Decimal(18, 2)), 36, 3832, CAST(N'2021-08-19T18:23:25.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(1.12 AS Decimal(18, 2)), 7, 3833, CAST(N'2021-09-26T02:27:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(9.01 AS Decimal(18, 2)), 23, 3834, CAST(N'2021-08-03T17:32:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(4.77 AS Decimal(18, 2)), 38, 3835, CAST(N'2021-08-13T22:38:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(5.54 AS Decimal(18, 2)), 24, 3836, CAST(N'2022-05-18T10:19:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(9.92 AS Decimal(18, 2)), 7, 3837, CAST(N'2022-06-02T10:55:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(2.14 AS Decimal(18, 2)), 9, 3838, CAST(N'2022-05-17T22:42:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(4.15 AS Decimal(18, 2)), 48, 3839, CAST(N'2022-03-26T08:43:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.65 AS Decimal(18, 2)), 42, 3840, CAST(N'2021-09-04T02:59:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.82 AS Decimal(18, 2)), 24, 3841, CAST(N'2021-09-21T15:32:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(5.94 AS Decimal(18, 2)), 18, 3842, CAST(N'2022-05-20T06:04:06.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.69 AS Decimal(18, 2)), 26, 3843, CAST(N'2022-07-25T18:10:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(2.73 AS Decimal(18, 2)), 29, 3844, CAST(N'2022-05-02T19:48:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(3.32 AS Decimal(18, 2)), 9, 3845, CAST(N'2022-07-18T08:25:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.83 AS Decimal(18, 2)), 33, 3846, CAST(N'2021-12-31T16:44:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(3.81 AS Decimal(18, 2)), 48, 3847, CAST(N'2021-11-24T10:55:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.78 AS Decimal(18, 2)), 18, 3848, CAST(N'2022-03-31T00:53:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(6.39 AS Decimal(18, 2)), 39, 3849, CAST(N'2021-10-03T13:49:21.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(4.27 AS Decimal(18, 2)), 19, 3850, CAST(N'2021-09-25T13:58:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.48 AS Decimal(18, 2)), 47, 3851, CAST(N'2022-03-29T14:58:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(1.07 AS Decimal(18, 2)), 9, 3852, CAST(N'2022-08-02T23:38:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(8.41 AS Decimal(18, 2)), 36, 3853, CAST(N'2022-01-10T13:37:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.77 AS Decimal(18, 2)), 38, 3854, CAST(N'2022-04-29T15:02:19.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.97 AS Decimal(18, 2)), 6, 3855, CAST(N'2022-03-27T01:42:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(6.87 AS Decimal(18, 2)), 20, 3856, CAST(N'2022-07-09T21:51:55.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(9.52 AS Decimal(18, 2)), 37, 3857, CAST(N'2022-06-29T19:35:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(3.23 AS Decimal(18, 2)), 49, 3858, CAST(N'2022-07-05T01:48:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.83 AS Decimal(18, 2)), 46, 3859, CAST(N'2021-10-31T00:12:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(9.37 AS Decimal(18, 2)), 31, 3860, CAST(N'2022-01-19T22:18:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(4.02 AS Decimal(18, 2)), 36, 3861, CAST(N'2021-09-06T11:55:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(8.32 AS Decimal(18, 2)), 22, 3862, CAST(N'2021-06-23T09:35:49.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(7.30 AS Decimal(18, 2)), 27, 3863, CAST(N'2021-08-12T02:04:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(3.23 AS Decimal(18, 2)), 17, 3864, CAST(N'2022-01-26T13:45:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(1.58 AS Decimal(18, 2)), 15, 3865, CAST(N'2021-07-29T07:36:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(7.98 AS Decimal(18, 2)), 1, 3866, CAST(N'2021-11-05T14:31:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(5.44 AS Decimal(18, 2)), 15, 3867, CAST(N'2021-09-19T17:43:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(6.51 AS Decimal(18, 2)), 28, 3868, CAST(N'2021-09-17T07:32:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(6.62 AS Decimal(18, 2)), 7, 3869, CAST(N'2021-06-14T10:26:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.30 AS Decimal(18, 2)), 26, 3870, CAST(N'2022-02-24T20:56:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(8.73 AS Decimal(18, 2)), 20, 3871, CAST(N'2022-04-27T17:21:33.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(9.66 AS Decimal(18, 2)), 33, 3872, CAST(N'2022-02-15T08:20:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(4.08 AS Decimal(18, 2)), 18, 3873, CAST(N'2021-09-05T22:47:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(5.06 AS Decimal(18, 2)), 28, 3874, CAST(N'2022-02-14T04:37:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(6.89 AS Decimal(18, 2)), 45, 3875, CAST(N'2022-03-10T11:17:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(8.00 AS Decimal(18, 2)), 8, 3876, CAST(N'2021-11-03T23:57:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(5.12 AS Decimal(18, 2)), 2, 3877, CAST(N'2021-06-19T19:23:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.44 AS Decimal(18, 2)), 22, 3878, CAST(N'2022-02-06T21:57:03.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(3.71 AS Decimal(18, 2)), 11, 3879, CAST(N'2021-06-20T15:11:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.37 AS Decimal(18, 2)), 33, 3880, CAST(N'2021-07-06T05:27:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.41 AS Decimal(18, 2)), 5, 3881, CAST(N'2022-05-29T16:06:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.47 AS Decimal(18, 2)), 41, 3882, CAST(N'2022-05-14T11:47:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(7.70 AS Decimal(18, 2)), 23, 3883, CAST(N'2021-10-31T20:03:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(2.66 AS Decimal(18, 2)), 34, 3884, CAST(N'2021-06-09T06:56:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(9.05 AS Decimal(18, 2)), 18, 3885, CAST(N'2022-05-26T13:13:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.05 AS Decimal(18, 2)), 12, 3886, CAST(N'2021-06-07T19:32:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(8.23 AS Decimal(18, 2)), 20, 3887, CAST(N'2022-04-21T03:21:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.20 AS Decimal(18, 2)), 20, 3888, CAST(N'2021-09-24T10:53:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(8.24 AS Decimal(18, 2)), 22, 3889, CAST(N'2021-07-10T08:27:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.94 AS Decimal(18, 2)), 33, 3890, CAST(N'2021-09-29T10:33:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(4.11 AS Decimal(18, 2)), 22, 3891, CAST(N'2021-08-01T22:37:18.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(1.06 AS Decimal(18, 2)), 2, 3892, CAST(N'2022-07-18T03:31:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(1.38 AS Decimal(18, 2)), 39, 3893, CAST(N'2021-08-15T04:40:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(9.42 AS Decimal(18, 2)), 23, 3894, CAST(N'2022-02-20T20:54:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(1.10 AS Decimal(18, 2)), 5, 3895, CAST(N'2021-11-08T21:50:59.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(7.30 AS Decimal(18, 2)), 45, 3896, CAST(N'2022-04-04T06:54:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(6.04 AS Decimal(18, 2)), 6, 3897, CAST(N'2021-09-14T14:53:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(2.83 AS Decimal(18, 2)), 39, 3898, CAST(N'2022-02-21T21:36:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(9.15 AS Decimal(18, 2)), 50, 3899, CAST(N'2022-06-06T02:04:40.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(9.16 AS Decimal(18, 2)), 25, 3900, CAST(N'2021-06-02T11:48:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(5.42 AS Decimal(18, 2)), 1, 3901, CAST(N'2021-06-10T01:05:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(7.16 AS Decimal(18, 2)), 1, 3902, CAST(N'2021-07-23T20:50:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(6.20 AS Decimal(18, 2)), 8, 3903, CAST(N'2022-05-19T23:12:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(7.99 AS Decimal(18, 2)), 6, 3904, CAST(N'2022-04-28T00:24:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.15 AS Decimal(18, 2)), 25, 3905, CAST(N'2022-01-05T18:48:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.16 AS Decimal(18, 2)), 29, 3906, CAST(N'2022-05-14T18:34:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(6.11 AS Decimal(18, 2)), 40, 3907, CAST(N'2021-12-19T02:51:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(2.64 AS Decimal(18, 2)), 11, 3908, CAST(N'2022-01-03T00:29:28.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(4.13 AS Decimal(18, 2)), 15, 3909, CAST(N'2022-07-05T05:43:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(5.07 AS Decimal(18, 2)), 46, 3910, CAST(N'2022-01-30T05:38:37.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(6.66 AS Decimal(18, 2)), 45, 3911, CAST(N'2022-04-16T04:07:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.97 AS Decimal(18, 2)), 30, 3912, CAST(N'2022-07-23T10:16:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(5.84 AS Decimal(18, 2)), 15, 3913, CAST(N'2022-06-06T01:01:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(8.03 AS Decimal(18, 2)), 23, 3914, CAST(N'2022-05-09T12:01:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.97 AS Decimal(18, 2)), 50, 3915, CAST(N'2022-01-31T01:50:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.21 AS Decimal(18, 2)), 36, 3916, CAST(N'2021-12-12T08:55:40.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(1.07 AS Decimal(18, 2)), 19, 3917, CAST(N'2022-07-15T06:42:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(8.35 AS Decimal(18, 2)), 13, 3918, CAST(N'2022-05-25T16:34:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 5, CAST(1.31 AS Decimal(18, 2)), 4, 3919, CAST(N'2022-06-02T22:42:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.46 AS Decimal(18, 2)), 12, 3920, CAST(N'2022-02-11T09:29:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.31 AS Decimal(18, 2)), 38, 3921, CAST(N'2021-11-29T20:30:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(3.75 AS Decimal(18, 2)), 19, 3922, CAST(N'2022-05-27T16:28:04.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(3.53 AS Decimal(18, 2)), 7, 3923, CAST(N'2022-07-10T13:06:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.02 AS Decimal(18, 2)), 18, 3924, CAST(N'2022-04-05T12:39:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(7.96 AS Decimal(18, 2)), 5, 3925, CAST(N'2021-11-02T22:12:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(9.28 AS Decimal(18, 2)), 39, 3926, CAST(N'2022-08-11T16:59:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(4.71 AS Decimal(18, 2)), 1, 3927, CAST(N'2022-06-29T00:18:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(3.99 AS Decimal(18, 2)), 7, 3928, CAST(N'2021-08-07T08:18:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(3.30 AS Decimal(18, 2)), 26, 3929, CAST(N'2021-12-12T17:20:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(1.50 AS Decimal(18, 2)), 10, 3930, CAST(N'2021-10-21T14:29:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.74 AS Decimal(18, 2)), 45, 3931, CAST(N'2022-02-23T17:37:54.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(7.08 AS Decimal(18, 2)), 50, 3932, CAST(N'2021-11-01T07:31:16.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(8.49 AS Decimal(18, 2)), 38, 3933, CAST(N'2022-07-31T14:07:13.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(5.77 AS Decimal(18, 2)), 46, 3934, CAST(N'2022-07-15T21:21:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(5.49 AS Decimal(18, 2)), 8, 3935, CAST(N'2022-02-02T03:50:38.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(4.75 AS Decimal(18, 2)), 23, 3936, CAST(N'2021-06-16T04:52:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(6.81 AS Decimal(18, 2)), 42, 3937, CAST(N'2022-01-30T16:12:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(4.04 AS Decimal(18, 2)), 37, 3938, CAST(N'2022-05-27T19:11:30.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 1, CAST(1.92 AS Decimal(18, 2)), 21, 3939, CAST(N'2021-09-20T06:37:02.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(9.65 AS Decimal(18, 2)), 17, 3940, CAST(N'2021-07-12T05:17:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(1.76 AS Decimal(18, 2)), 46, 3941, CAST(N'2021-12-02T03:56:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.57 AS Decimal(18, 2)), 5, 3942, CAST(N'2021-10-29T02:37:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 2, CAST(5.60 AS Decimal(18, 2)), 42, 3943, CAST(N'2021-11-29T09:37:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 3, CAST(3.32 AS Decimal(18, 2)), 29, 3944, CAST(N'2022-05-20T14:43:15.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.55 AS Decimal(18, 2)), 36, 3945, CAST(N'2022-01-16T16:06:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 2, CAST(6.06 AS Decimal(18, 2)), 33, 3946, CAST(N'2022-06-12T22:40:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(3.99 AS Decimal(18, 2)), 18, 3947, CAST(N'2021-11-22T07:59:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(9.88 AS Decimal(18, 2)), 13, 3948, CAST(N'2021-09-05T12:40:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.62 AS Decimal(18, 2)), 12, 3949, CAST(N'2021-10-29T00:30:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 1, CAST(3.36 AS Decimal(18, 2)), 30, 3950, CAST(N'2021-11-30T16:03:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(5.74 AS Decimal(18, 2)), 32, 3951, CAST(N'2021-10-08T11:43:23.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 6, CAST(2.55 AS Decimal(18, 2)), 19, 3952, CAST(N'2022-05-19T06:58:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.42 AS Decimal(18, 2)), 20, 3953, CAST(N'2022-04-08T03:34:10.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(4.77 AS Decimal(18, 2)), 15, 3954, CAST(N'2021-11-10T00:21:11.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(2.20 AS Decimal(18, 2)), 12, 3955, CAST(N'2021-11-24T15:59:34.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(1.25 AS Decimal(18, 2)), 36, 3956, CAST(N'2022-01-11T21:27:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 3, CAST(7.84 AS Decimal(18, 2)), 48, 3957, CAST(N'2021-11-17T08:22:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(8.14 AS Decimal(18, 2)), 28, 3958, CAST(N'2022-06-06T14:12:31.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(9.92 AS Decimal(18, 2)), 22, 3959, CAST(N'2021-07-28T00:40:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(7.09 AS Decimal(18, 2)), 24, 3960, CAST(N'2021-10-10T11:54:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(1.43 AS Decimal(18, 2)), 32, 3961, CAST(N'2021-06-22T02:29:58.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(2.99 AS Decimal(18, 2)), 44, 3962, CAST(N'2022-01-06T09:53:00.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.69 AS Decimal(18, 2)), 47, 3963, CAST(N'2022-06-08T10:17:45.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(7.47 AS Decimal(18, 2)), 26, 3964, CAST(N'2021-06-06T00:10:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(8.42 AS Decimal(18, 2)), 1, 3965, CAST(N'2022-03-16T02:07:35.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(4.00 AS Decimal(18, 2)), 2, 3966, CAST(N'2021-12-25T10:03:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 5, CAST(7.91 AS Decimal(18, 2)), 23, 3967, CAST(N'2021-11-14T02:11:05.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.31 AS Decimal(18, 2)), 11, 3968, CAST(N'2022-07-13T00:27:51.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(6.88 AS Decimal(18, 2)), 3, 3969, CAST(N'2022-07-11T08:38:47.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 1, CAST(2.31 AS Decimal(18, 2)), 2, 3970, CAST(N'2022-04-06T03:56:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(8.46 AS Decimal(18, 2)), 31, 3971, CAST(N'2021-11-12T08:02:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(5.79 AS Decimal(18, 2)), 6, 3972, CAST(N'2022-08-15T10:28:20.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 4, CAST(8.97 AS Decimal(18, 2)), 42, 3973, CAST(N'2021-06-14T06:05:56.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 6, CAST(2.95 AS Decimal(18, 2)), 2, 3974, CAST(N'2021-06-19T00:11:12.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(8.58 AS Decimal(18, 2)), 7, 3975, CAST(N'2022-03-29T04:42:46.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(9.27 AS Decimal(18, 2)), 5, 3976, CAST(N'2021-09-20T10:25:24.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 6, CAST(4.92 AS Decimal(18, 2)), 7, 3977, CAST(N'2021-10-10T22:35:42.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 2, CAST(1.18 AS Decimal(18, 2)), 21, 3978, CAST(N'2022-07-12T19:36:44.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(4.67 AS Decimal(18, 2)), 14, 3979, CAST(N'2021-10-28T06:28:41.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 6, CAST(9.80 AS Decimal(18, 2)), 33, 3980, CAST(N'2021-08-08T15:03:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.62 AS Decimal(18, 2)), 22, 3981, CAST(N'2021-10-10T22:13:43.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 2, CAST(7.13 AS Decimal(18, 2)), 32, 3982, CAST(N'2022-03-20T08:49:57.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(5.76 AS Decimal(18, 2)), 40, 3983, CAST(N'2022-06-16T02:00:53.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 6, CAST(2.44 AS Decimal(18, 2)), 2, 3984, CAST(N'2022-06-13T01:03:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(9.85 AS Decimal(18, 2)), 41, 3985, CAST(N'2022-04-27T12:05:27.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 2, CAST(2.90 AS Decimal(18, 2)), 37, 3986, CAST(N'2021-12-13T04:53:17.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 4, CAST(7.54 AS Decimal(18, 2)), 6, 3987, CAST(N'2022-06-19T00:57:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 4, CAST(5.16 AS Decimal(18, 2)), 8, 3988, CAST(N'2022-03-04T02:36:22.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (3, 3, CAST(1.23 AS Decimal(18, 2)), 8, 3989, CAST(N'2022-02-04T08:05:09.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 3, CAST(8.88 AS Decimal(18, 2)), 49, 3990, CAST(N'2021-09-08T18:12:26.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 4, CAST(7.71 AS Decimal(18, 2)), 48, 3991, CAST(N'2022-01-12T21:12:14.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 5, CAST(6.83 AS Decimal(18, 2)), 29, 3992, CAST(N'2021-07-05T07:56:52.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 5, CAST(8.48 AS Decimal(18, 2)), 5, 3993, CAST(N'2022-06-27T08:33:08.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 5, CAST(7.13 AS Decimal(18, 2)), 21, 3994, CAST(N'2022-01-25T15:43:48.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (5, 1, CAST(7.77 AS Decimal(18, 2)), 35, 3995, CAST(N'2022-07-25T18:42:50.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(5.11 AS Decimal(18, 2)), 35, 3996, CAST(N'2021-08-10T15:08:39.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (2, 4, CAST(1.59 AS Decimal(18, 2)), 19, 3997, CAST(N'2021-12-21T13:06:01.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (4, 3, CAST(2.98 AS Decimal(18, 2)), 35, 3998, CAST(N'2022-03-05T16:19:32.000' AS DateTime))
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(6.11 AS Decimal(18, 2)), 17, 3999, CAST(N'2022-03-13T09:16:55.000' AS DateTime))
GO
INSERT [dbo].[Sales] ([SaleLocationID], [ProductID], [SaleCost], [CustomerID], [ID], [DateOfSale]) VALUES (1, 1, CAST(8.20 AS Decimal(18, 2)), 3, 4000, CAST(N'2022-06-18T05:42:49.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Sales] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (1, 1, 10, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (2, 2, 5, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (3, 3, 2951, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (4, 4, 3, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (5, 5, 1, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (6, 6, 791, 1)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (7, 1, 5, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (8, 2, 5123, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (9, 3, 2, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (10, 4, 3, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (11, 5, 412, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (12, 6, 4, 2)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (13, 1, 2, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (14, 2, 3, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (15, 3, 9, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (16, 4, 2, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (17, 5, 3, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (18, 6, 3, 3)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (19, 1, 4, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (20, 2, 3, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (21, 3, 51, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (22, 4, 3, 4)
INSERT [dbo].[Warehouse] ([ID], [ProductID], [Stock], [LocationID]) VALUES (23, 5, 5, 4)
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[28] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customers_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerLoyaltyCards"
            Begin Extent = 
               Top = 0
               Left = 246
               Bottom = 189
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3450
         Alias = 2145
         Table = 3435
         Output = 2670
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllCustomsWithLoyaltyCards'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllCustomsWithLoyaltyCards'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "S"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 102
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SalesByLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SalesByLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "S"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 136
               Right = 469
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SalesByProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SalesByProduct'
GO
USE [master]
GO
ALTER DATABASE [De-Store] SET  READ_WRITE 
GO

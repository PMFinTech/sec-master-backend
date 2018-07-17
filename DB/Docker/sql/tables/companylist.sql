USE [SecMaster]
GO

/****** Object:  Table [dbo].[companylist]    Script Date: 7/11/2018 10:01:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[companylist](
	[Symbol] [varchar](10) NULL,
	[Name] [varchar](1024) NULL,
	[LastSale] [varchar](20) NULL,
	[MarketCap] [varchar](50) NULL,
	[IPOyear] [varchar](255) NULL,
	[Sector] [varchar](50) NULL,
	[Industry] [varchar](255) NULL,
	[Summary Quote] [varchar](2048) NULL
) ON [PRIMARY]
GO



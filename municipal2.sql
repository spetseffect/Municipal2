USE [Municipal2]
GO
/****** Object:  UserDefinedFunction [dbo].[LastCounterValue]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LastCounterValue](
	@serviceId INT,
	@AddressId INT
) RETURNS NUMERIC(8,3) AS BEGIN
	DECLARE @val NUMERIC(8,3);
	DECLARE @tableName NVARCHAR(120) = (
		SELECT TableName
			FROM [Services]
			WHERE ServiceId=@serviceId);
	EXEC sp_GetLastCounterValue @tableName, @AddressId, @val OUTPUT;
	RETURN @val;
END;
GO
/****** Object:  Table [dbo].[AddressActiveServices]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressActiveServices](
	[AddressActiveServiceId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[AddressId] [int] NOT NULL,
	[Active] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressActiveServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Street] [nvarchar](50) NOT NULL,
	[House] [nvarchar](10) NOT NULL,
	[Flat] [nvarchar](10) NULL,
	[Active] [int] NOT NULL,
 CONSTRAINT [PK__Addresse__091C2AFB4D8B7061] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrentConfig]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrentConfig](
	[Attribute] [nvarchar](120) NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_CurrentConfig] PRIMARY KEY CLUSTERED 
(
	[Attribute] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Electric]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Electric](
	[ElectricId] [int] IDENTITY(1,1) NOT NULL,
	[ValueDate] [date] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[PaidMonth] [int] NOT NULL,
	[PaidYear] [int] NOT NULL,
	[AddressId] [int] NOT NULL,
	[Rate1] [int] NULL,
	[Rate2] [int] NULL,
	[ThresholdValue] [numeric](8, 3) NULL,
	[Value] [numeric](8, 3) NULL,
	[Difference] [numeric](8, 3) NULL,
	[Sum] [money] NOT NULL,
	[SubscriberFee] [money] NOT NULL,
	[Comment] [nvarchar](200) NULL,
 CONSTRAINT [PK__Electric__791DAFD8EF74CF47] PRIMARY KEY CLUSTERED 
(
	[ElectricId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gas]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gas](
	[GasId] [int] IDENTITY(1,1) NOT NULL,
	[ValueDate] [date] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[PaidMonth] [int] NOT NULL,
	[PaidYear] [int] NOT NULL,
	[AddressId] [int] NOT NULL,
	[Rate1] [int] NULL,
	[Rate2] [int] NULL,
	[ThresholdValue] [numeric](8, 3) NULL,
	[Value] [numeric](8, 3) NULL,
	[Difference] [numeric](8, 3) NULL,
	[Sum] [money] NOT NULL,
	[SubscriberFee] [money] NOT NULL,
	[Comment] [nvarchar](200) NULL,
 CONSTRAINT [PK__Gas__DBB4630107A6D74F] PRIMARY KEY CLUSTERED 
(
	[GasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[LanguageId] [int] IDENTITY(1,1) NOT NULL,
	[LanguageName] [nvarchar](50) NOT NULL,
	[LanguageLabel] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PayDates]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PayDates](
	[PayDatesId] [int] IDENTITY(1,1) NOT NULL,
	[PayDate] [date] NOT NULL,
	[AddressId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PayDatesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rates]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rates](
	[RateId] [int] IDENTITY(1,1) NOT NULL,
	[RateValue] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[RateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RatesCurrent]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RatesCurrent](
	[RateCurrentId] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[RateId1] [int] NULL,
	[RateId2] [int] NULL,
	[ThresholdValue] [numeric](8, 3) NULL,
	[SubscriberFeeExistance] [int] NOT NULL,
 CONSTRAINT [PK__RatesCur__7A717D5364D594D4] PRIMARY KEY CLUSTERED 
(
	[RateCurrentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](100) NOT NULL,
	[ServiceAcronym] [nvarchar](20) NULL,
	[TableName] [nvarchar](120) NOT NULL,
	[MeasureUnit] [nvarchar](20) NULL,
	[Active] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AddressActiveServices] ON 
GO
INSERT [dbo].[AddressActiveServices] ([AddressActiveServiceId], [ServiceId], [AddressId], [Active]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[AddressActiveServices] ([AddressActiveServiceId], [ServiceId], [AddressId], [Active]) VALUES (2, 2, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[AddressActiveServices] OFF
GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 
GO
INSERT [dbo].[Addresses] ([AddressId], [City], [Street], [House], [Flat], [Active]) VALUES (1, N'м. Вінниця', N'вул. Форпостна', N'17', N'5', 1)
GO
INSERT [dbo].[Addresses] ([AddressId], [City], [Street], [House], [Flat], [Active]) VALUES (2, N'м. Київ', N'вул. Луценка Дмитра', N'5Б', N'36', 1)
GO
SET IDENTITY_INSERT [dbo].[Addresses] OFF
GO
INSERT [dbo].[CurrentConfig] ([Attribute], [Value]) VALUES (N'AddressId', 1)
GO
SET IDENTITY_INSERT [dbo].[Electric] ON 
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (1, CAST(N'2014-09-20' AS Date), CAST(N'2014-09-20T00:00:00.000' AS DateTime), 8, 2014, 1, 1, NULL, NULL, CAST(2381.600 AS Numeric(8, 3)), CAST(0.000 AS Numeric(8, 3)), 0.0000, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (2, CAST(N'2014-10-20' AS Date), CAST(N'2014-10-20T19:34:05.000' AS DateTime), 9, 2014, 1, 1, NULL, NULL, CAST(2566.000 AS Numeric(8, 3)), CAST(184.400 AS Numeric(8, 3)), 56.8690, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (3, CAST(N'2014-11-20' AS Date), CAST(N'2014-11-20T19:11:33.000' AS DateTime), 10, 2014, 1, 1, NULL, NULL, CAST(2720.000 AS Numeric(8, 3)), CAST(154.000 AS Numeric(8, 3)), 47.4936, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (4, CAST(N'2014-12-20' AS Date), CAST(N'2014-12-20T19:54:37.000' AS DateTime), 11, 2014, 1, 1, NULL, NULL, CAST(2900.000 AS Numeric(8, 3)), CAST(180.000 AS Numeric(8, 3)), 55.5120, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (5, CAST(N'2015-01-20' AS Date), CAST(N'2015-01-20T19:22:12.000' AS DateTime), 12, 2014, 1, 1, NULL, NULL, CAST(3045.000 AS Numeric(8, 3)), CAST(145.000 AS Numeric(8, 3)), 44.7180, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (6, CAST(N'2015-02-20' AS Date), CAST(N'2015-02-20T19:00:56.000' AS DateTime), 1, 2015, 1, 1, NULL, NULL, CAST(3180.000 AS Numeric(8, 3)), CAST(135.000 AS Numeric(8, 3)), 41.6340, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (7, CAST(N'2015-03-20' AS Date), CAST(N'2015-03-20T19:32:04.000' AS DateTime), 1, 2015, 1, 1, NULL, NULL, CAST(3340.000 AS Numeric(8, 3)), CAST(160.000 AS Numeric(8, 3)), 49.3440, 0.0000, NULL)
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (8, CAST(N'2020-08-30' AS Date), CAST(N'2020-08-30T21:02:00.000' AS DateTime), 1, 2020, 1, 1, 4, CAST(100.000 AS Numeric(8, 3)), CAST(3450.000 AS Numeric(8, 3)), CAST(110.000 AS Numeric(8, 3)), 37.3000, 0.0000, N'@Comment')
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (9, CAST(N'2020-08-31' AS Date), CAST(N'2020-08-31T07:10:00.000' AS DateTime), 7, 2020, 1, 1, 4, CAST(100.000 AS Numeric(8, 3)), CAST(3460.000 AS Numeric(8, 3)), CAST(10.000 AS Numeric(8, 3)), 3.1000, 10.0000, N'''')
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (10, CAST(N'2020-08-31' AS Date), CAST(N'2020-08-31T07:12:00.000' AS DateTime), 7, 2020, 1, 1, 4, CAST(100.000 AS Numeric(8, 3)), CAST(3470.000 AS Numeric(8, 3)), CAST(10.000 AS Numeric(8, 3)), 3.1000, 10.0000, N'''')
GO
INSERT [dbo].[Electric] ([ElectricId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (11, CAST(N'2020-08-31' AS Date), CAST(N'2020-08-31T07:16:00.000' AS DateTime), 7, 2020, 1, 1, 4, CAST(100.000 AS Numeric(8, 3)), CAST(3480.000 AS Numeric(8, 3)), CAST(10.000 AS Numeric(8, 3)), 3.1000, 0.0000, N'''')
GO
SET IDENTITY_INSERT [dbo].[Electric] OFF
GO
SET IDENTITY_INSERT [dbo].[Gas] ON 
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (1, CAST(N'2014-09-20' AS Date), CAST(N'2014-09-20T00:00:00.000' AS DateTime), 8, 2014, 1, 6, NULL, NULL, CAST(2967.560 AS Numeric(8, 3)), CAST(0.000 AS Numeric(8, 3)), 0.0000, 0.0000, NULL)
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (2, CAST(N'2014-10-20' AS Date), CAST(N'2014-10-20T19:34:05.000' AS DateTime), 9, 2014, 1, 6, NULL, NULL, CAST(3088.000 AS Numeric(8, 3)), CAST(120.440 AS Numeric(8, 3)), 131.1592, 0.0000, NULL)
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (3, CAST(N'2014-11-20' AS Date), CAST(N'2014-11-20T19:11:33.000' AS DateTime), 10, 2014, 1, 6, NULL, NULL, CAST(3230.000 AS Numeric(8, 3)), CAST(142.000 AS Numeric(8, 3)), 154.6380, 0.0000, NULL)
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (4, CAST(N'2014-12-20' AS Date), CAST(N'2014-12-20T19:54:37.000' AS DateTime), 11, 2014, 1, 6, NULL, NULL, CAST(3400.000 AS Numeric(8, 3)), CAST(170.000 AS Numeric(8, 3)), 185.1300, 0.0000, NULL)
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (5, CAST(N'2015-01-20' AS Date), CAST(N'2015-01-20T19:22:12.000' AS DateTime), 12, 2014, 1, 6, NULL, NULL, CAST(3600.000 AS Numeric(8, 3)), CAST(200.000 AS Numeric(8, 3)), 217.8000, 0.0000, NULL)
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (6, CAST(N'2015-02-20' AS Date), CAST(N'2015-02-20T19:00:56.000' AS DateTime), 1, 2015, 1, 6, NULL, NULL, CAST(3730.000 AS Numeric(8, 3)), CAST(130.000 AS Numeric(8, 3)), 141.5700, 0.0000, NULL)
GO
INSERT [dbo].[Gas] ([GasId], [ValueDate], [EntryDate], [PaidMonth], [PaidYear], [AddressId], [Rate1], [Rate2], [ThresholdValue], [Value], [Difference], [Sum], [SubscriberFee], [Comment]) VALUES (7, CAST(N'2015-03-20' AS Date), CAST(N'2015-03-20T19:32:04.000' AS DateTime), 2, 2015, 1, 6, NULL, NULL, CAST(3860.000 AS Numeric(8, 3)), CAST(130.000 AS Numeric(8, 3)), 141.5700, 0.0000, NULL)
GO
SET IDENTITY_INSERT [dbo].[Gas] OFF
GO
SET IDENTITY_INSERT [dbo].[PayDates] ON 
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (1, CAST(N'2014-09-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (2, CAST(N'2014-10-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (3, CAST(N'2014-11-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (4, CAST(N'2014-12-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (5, CAST(N'2015-01-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (6, CAST(N'2015-02-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (7, CAST(N'2015-03-20' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (1002, CAST(N'2020-08-30' AS Date), 1)
GO
INSERT [dbo].[PayDates] ([PayDatesId], [PayDate], [AddressId]) VALUES (1003, CAST(N'2020-08-31' AS Date), 1)
GO
SET IDENTITY_INSERT [dbo].[PayDates] OFF
GO
SET IDENTITY_INSERT [dbo].[Rates] ON 
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (1, 0.3084)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (2, 0.3660)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (3, 0.4560)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (4, 0.6300)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (5, 0.7890)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (6, 1.0890)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (7, 3.6000)
GO
INSERT [dbo].[Rates] ([RateId], [RateValue]) VALUES (8, 7.1900)
GO
SET IDENTITY_INSERT [dbo].[Rates] OFF
GO
SET IDENTITY_INSERT [dbo].[RatesCurrent] ON 
GO
INSERT [dbo].[RatesCurrent] ([RateCurrentId], [AddressId], [ServiceId], [RateId1], [RateId2], [ThresholdValue], [SubscriberFeeExistance]) VALUES (1, 1, 1, 1, 4, CAST(100.000 AS Numeric(8, 3)), 1)
GO
INSERT [dbo].[RatesCurrent] ([RateCurrentId], [AddressId], [ServiceId], [RateId1], [RateId2], [ThresholdValue], [SubscriberFeeExistance]) VALUES (2, 1, 2, 6, NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[RatesCurrent] OFF
GO
SET IDENTITY_INSERT [dbo].[Services] ON 
GO
INSERT [dbo].[Services] ([ServiceId], [ServiceName], [ServiceAcronym], [TableName], [MeasureUnit], [Active]) VALUES (1, N'Електроенергія', N'Е/енергія', N'Electric', N'кВт/год', 1)
GO
INSERT [dbo].[Services] ([ServiceId], [ServiceName], [ServiceAcronym], [TableName], [MeasureUnit], [Active]) VALUES (2, N'Газ', NULL, N'Gas', N'м.куб.', 1)
GO
SET IDENTITY_INSERT [dbo].[Services] OFF
GO
ALTER TABLE [dbo].[AddressActiveServices]  WITH CHECK ADD  CONSTRAINT [FK__AddressAc__Addre__6FE99F9F] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[AddressActiveServices] CHECK CONSTRAINT [FK__AddressAc__Addre__6FE99F9F]
GO
ALTER TABLE [dbo].[AddressActiveServices]  WITH CHECK ADD FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Services] ([ServiceId])
GO
ALTER TABLE [dbo].[Electric]  WITH CHECK ADD  CONSTRAINT [FK__Electric__Addres__5EBF139D] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[Electric] CHECK CONSTRAINT [FK__Electric__Addres__5EBF139D]
GO
ALTER TABLE [dbo].[Electric]  WITH CHECK ADD  CONSTRAINT [FK__Electric__Rate1__5CD6CB2B] FOREIGN KEY([Rate1])
REFERENCES [dbo].[Rates] ([RateId])
GO
ALTER TABLE [dbo].[Electric] CHECK CONSTRAINT [FK__Electric__Rate1__5CD6CB2B]
GO
ALTER TABLE [dbo].[Electric]  WITH CHECK ADD  CONSTRAINT [FK__Electric__Rate2__5DCAEF64] FOREIGN KEY([Rate2])
REFERENCES [dbo].[Rates] ([RateId])
GO
ALTER TABLE [dbo].[Electric] CHECK CONSTRAINT [FK__Electric__Rate2__5DCAEF64]
GO
ALTER TABLE [dbo].[Gas]  WITH CHECK ADD  CONSTRAINT [FK__Gas__AddressId__619B8048] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[Gas] CHECK CONSTRAINT [FK__Gas__AddressId__619B8048]
GO
ALTER TABLE [dbo].[Gas]  WITH CHECK ADD  CONSTRAINT [FK__Gas__Rate1__628FA481] FOREIGN KEY([Rate1])
REFERENCES [dbo].[Rates] ([RateId])
GO
ALTER TABLE [dbo].[Gas] CHECK CONSTRAINT [FK__Gas__Rate1__628FA481]
GO
ALTER TABLE [dbo].[Gas]  WITH CHECK ADD  CONSTRAINT [FK__Gas__Rate2__6383C8BA] FOREIGN KEY([Rate2])
REFERENCES [dbo].[Rates] ([RateId])
GO
ALTER TABLE [dbo].[Gas] CHECK CONSTRAINT [FK__Gas__Rate2__6383C8BA]
GO
ALTER TABLE [dbo].[PayDates]  WITH CHECK ADD  CONSTRAINT [FK__PayDates__Addres__68487DD7] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[PayDates] CHECK CONSTRAINT [FK__PayDates__Addres__68487DD7]
GO
ALTER TABLE [dbo].[RatesCurrent]  WITH CHECK ADD  CONSTRAINT [FK__RatesCurr__Addre__30C33EC3] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([AddressId])
GO
ALTER TABLE [dbo].[RatesCurrent] CHECK CONSTRAINT [FK__RatesCurr__Addre__30C33EC3]
GO
ALTER TABLE [dbo].[RatesCurrent]  WITH CHECK ADD  CONSTRAINT [FK__RatesCurr__RateI__3B75D760] FOREIGN KEY([RateId1])
REFERENCES [dbo].[Rates] ([RateId])
GO
ALTER TABLE [dbo].[RatesCurrent] CHECK CONSTRAINT [FK__RatesCurr__RateI__3B75D760]
GO
ALTER TABLE [dbo].[RatesCurrent]  WITH CHECK ADD  CONSTRAINT [FK__RatesCurr__RateI__3C69FB99] FOREIGN KEY([RateId2])
REFERENCES [dbo].[Rates] ([RateId])
GO
ALTER TABLE [dbo].[RatesCurrent] CHECK CONSTRAINT [FK__RatesCurr__RateI__3C69FB99]
GO
ALTER TABLE [dbo].[RatesCurrent]  WITH CHECK ADD  CONSTRAINT [FK__RatesCurr__Servi__3D5E1FD2] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Services] ([ServiceId])
GO
ALTER TABLE [dbo].[RatesCurrent] CHECK CONSTRAINT [FK__RatesCurr__Servi__3D5E1FD2]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddNewData]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddNewData]
		@AddressId INT,
		@PaidMonth INT,
		@PaidYear INT,
		@ServiceId INT,
		@Value NUMERIC(8,3),
		@Difference NUMERIC(8,3),
		@Sum MONEY,
		@SubscribFee MONEY,
		@Comment NVARCHAR(200)
	AS BEGIN
		DECLARE @table NVARCHAR(120) = (SELECT TableName
											FROM [Services]
											WHERE ServiceId=@ServiceId);
		DECLARE @RateId1 INT,
				@RateId2 INT,
				@ThresholdValue NUMERIC(8,3);
		SELECT	 @RateId1=RateId1
				,@RateId2=RateId2
				,@ThresholdValue=ThresholdValue
			FROM RatesCurrent
			WHERE AddressId=@AddressId
				AND ServiceId=@ServiceId;
		DECLARE @query NVARCHAR(2000) = CONCAT('
			INSERT INTO ',@table,' VALUES ('''
				,CAST(GETDATE() AS DATE)
				,''',''',GETDATE()
				,''',',CAST(@PaidMonth AS NVARCHAR(2))
				,',',CAST(@PaidYear AS NVARCHAR(4))
				,',',CAST(@AddressId AS NVARCHAR(11))
				,',',CAST(@RateId1 AS NVARCHAR(11))
				,',',CAST(@RateId2 AS NVARCHAR(11))
				,',',CAST(@ThresholdValue AS NVARCHAR(8))
				,',',CAST(@Value AS NVARCHAR(8))
				,',',CAST(@Difference AS NVARCHAR(8))
				,',',CAST(@Sum AS NVARCHAR(20))
				,',',CAST(@SubscribFee AS NVARCHAR(20))
				,',''',IIF(TRIM(@Comment)='',NULL,TRIM(@Comment)),'''
			)');
		EXEC(@query);
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_AddPayDate]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddPayDate]
		@AddressId INT
	AS BEGIN
		DECLARE @date DATE = CAST(GETDATE() AS DATE);
		IF(NOT EXISTS(SELECT PayDatesId FROM PayDates WHERE PayDate=@date AND AddressId=@AddressId))
			INSERT INTO PayDates VALUES (@date,@AddressId);
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNewDataCollect]    Script Date: 12/22/2020 9:13:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetNewDataCollect]
		@AddressId INT
	AS BEGIN
		CREATE TABLE #T(RowId INT, ServiceId INT, TableName NVARCHAR(120), LastValue NUMERIC(8,3));
		INSERT INTO #T
			SELECT ROW_NUMBER() OVER(ORDER BY s.ServiceId) RowId
					,s.ServiceId,s.TableName, NULL LastValue
				FROM [Services] s
					INNER JOIN AddressActiveServices a ON a.ServiceId=s.ServiceId
				WHERE a.Active=1 AND a.AddressId=@AddressId
		DECLARE @K INT = @@ROWCOUNT;
		DECLARE @I INT = 1;
		WHILE(@I<=@K)
			BEGIN
				DECLARE @name NVARCHAR(120) = (SELECT TableName FROM #T WHERE RowId=@I);
				DECLARE @q NVARCHAR(1000) = CONCAT('
					UPDATE #T
						SET LastValue = CAST((SELECT TOP 1 [Value] 
												FROM ',@name,' 
												WHERE AddressId=',@AddressId,' 
												ORDER BY EntryDate DESC) AS NVARCHAR(8))
						WHERE RowId=',@I
					);
				EXEC(@q);
				SET @I=@I+1;
			END;
		SELECT
				ServiceId = s.ServiceId
				,ServiceName = s.ServiceName
				,Active = 'True'
				,DifferenceVisibility =	IIF(ISNULL(r1.RateValue,0)=0,'Collapsed','Visible')
				,DifferenceValue = CAST(0 AS DECIMAL(1,0))
				,Rate1 = r1.RateValue
				,Rate2 = r2.RateValue
				,SlashBetweenRates = IIF(ISNULL(r2.RateValue,0)=0,'Collapsed','Visible')
				,ThresholdValueVisibility = IIF(ISNULL(rc.ThresholdValue,0)=0,'Collapsed','Visible')
				,ThresholdValue = rc.ThresholdValue
				,DifferenceSum = CAST(0 AS DECIMAL(1,0))
				,MeasureUnit = CONCAT(' ',s.MeasureUnit)
				,PaySum = CAST(0 AS DECIMAL(1,0))
				,CounterVisibility = IIF(ISNULL(r1.RateValue,0)=0,'Collapsed','Visible')
				,CounterValuePrev = t.LastValue
				,CounterValueCurrent = ''
				,SubscriberFeeVisibility = IIF(rc.SubscriberFeeExistance=1,'Visible','Collapsed')
				,SubscriberFeeSum = CAST(0 AS DECIMAL(1,0))
				,Comment = ''
			FROM [Services] s
				INNER JOIN AddressActiveServices a ON a.ServiceId=s.ServiceId
				INNER JOIN #T t ON t.ServiceId=s.ServiceId
				LEFT JOIN RatesCurrent rc ON rc.ServiceId=s.ServiceId
				LEFT JOIN Rates r1 ON r1.RateId=rc.RateId1
				LEFT JOIN Rates r2 ON r2.RateId=rc.RateId2
			WHERE a.AddressId=@AddressId AND a.Active=1;
		DROP TABLE #T;
	END;
GO

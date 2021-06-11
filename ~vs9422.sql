/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT TOP (1000) [ServiceId]
      ,[ServiceName]
      ,[ServiceAcronym]
      ,[TableName]
      ,[MeasureUnit]
      ,[Active]
  FROM [Municipal2].[dbo].[Services]

  --set identity_insert [Services] on
  --insert into [Services]([ServiceId],[ServiceName],[ServiceAcronym],[TableName],[MeasureUnit],[Active]) values
  --(1,'Електроенергія','Е/енергія','Electric','кВт/год',1),
  --(2,'Газ',NULL,'Gas','м.куб.',1);
  --set identity_insert [Services] off
--  create table Gas(
--	GasId INT identity primary key,
--	ValueDate date not null,
--	EntryDate datetime not null,
--	AddressId int not null foreign key references Addresses(AddressId),
--	Rate1 int null
--		foreign key references Rates(RateId),
--	Rate2 int null
--		foreign key references Rates(RateId),
--	ThresholdValue numeric(8,3) null,
--	[Value] numeric(8,3) null,
--	[Difference] numeric(8,3) null,
--	[Sum] money,
--	SubscriberFee money,
--	Comment nvarchar(1000)
--)
--create table PayDates(
--	PayDatesId int identity primary key,
--	PayDate date not null
--)





create table [ServicesConfig](
	[ConfigId] int identity primary key
	,[ConfigNameId] int not null
	,[ConfigName] nvarchar(100) not null
	,[ServiceId] int not null foreign key references [Services](ServiceId)
	,[ConfigValue] nvarchar(50) not null
	,AddressId int not null foreign key references Addresses(AddressId)
)
/*

 Active = true
CounterValueCurrent
CounterValuePrev
CounterVisibility
 DifferenceValue = 0
DifferenceVisibility
 MeasureUnit
 PaySum = 0
Rates
 ServiceName
 SubscriberFeeSum = 0
SubscriberFeeVisibility


GO
CREATE PROCEDURE sp_GetLastCounterValue
		@tableName NVARCHAR(120),
		@AddressId INT,
		@result NVARCHAR(120) OUTPUT
	AS BEGIN
		EXEC('
			SELECT TOP 1 @result=[Value]
				FROM '+@tableName+'
				WHERE AddressId='+@AddressId+'
				ORDER BY EntryDate DESC
		');
	END;
GO
CREATE FUNCTION dbo.LastCounterValue(
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
*/









IF OBJECT_ID('sp_AddNewData','P') IS NOT NULL
	DROP PROCEDURE sp_AddNewData;
GO
CREATE PROCEDURE sp_AddNewData
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

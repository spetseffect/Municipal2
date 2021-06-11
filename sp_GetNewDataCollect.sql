IF OBJECT_ID('sp_GetNewDataCollect','P') IS NOT NULL
	DROP PROCEDURE sp_GetNewDataCollect;
GO
CREATE PROCEDURE sp_GetNewDataCollect
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
--exec sp_GetNewDataCollect 1
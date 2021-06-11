CREATE TABLE #months(mNumber INT, mName NVARCHAR(30));
INSERT INTO #months VALUES
	(1,'січень'),(2,'лютий'),(3,'березень'),(4,'квітень'),(5,'травень'),(6,'червень'),
	(7,'липень'),(8,'серпень'),(9,'вересень'),(10,'жовтень'),(11,'листопад'),(12,'грудень');
DECLARE @tableNames TABLE(RowId INT,TableName NVARCHAR(120));
INSERT INTO @tableNames
SELECT ROW_NUMBER() OVER(ORDER BY s.ServiceId) RowId
		,s.TableName
	FROM Services s
		JOIN AddressActiveServices a ON a.ServiceId=s.ServiceId
	WHERE s.Active=1 AND a.AddressId=1;
DECLARE @K INT = @@ROWCOUNT,
		@I INT = 1;
--select * from @tableNames;
DECLARE @s1 NVARCHAR(4000)='',
		@s2 NVARCHAR(1000)='';
WHILE(@I<=@K)
	BEGIN
		SELECT @s1 = CONCAT(@s1,',SUM(',TableName,'.[Sum]+',TableName,'.SubscriberFee) OVER(PARTITION BY ',TableName,'.ValueDate) ',TableName,'Sum
			  ,(SELECT mName FROM #months WHERE mNumber=',TableName,'.PaidMonth)+'' ''+CAST(',TableName,'.PaidYear AS NVARCHAR(4)) ',TableName,'PaidPeriod'),
				@s2 = CONCAT(@s2,' LEFT JOIN ',TableName,' ON ',TableName,'.ValueDate=pd.PayDate')
			FROM @tableNames
			WHERE RowId=@I;
		SET @I=@I+1;
	END;
DECLARE @query NVARCHAR(4000) =CONCAT('SELECT 1',@s1,' FROM PayDates pd ',@s2,' WHERE pd.AddressId=1');
EXEC(@query);
DROP TABLE #months;
--



















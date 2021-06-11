IF OBJECT_ID('sp_AddPayDate','P') IS NOT NULL
	DROP PROCEDURE sp_AddPayDate;
GO
CREATE PROCEDURE sp_AddPayDate
		@AddressId INT
	AS BEGIN
		DECLARE @date DATE = CAST(GETDATE() AS DATE);
		IF(NOT EXISTS(SELECT PayDatesId FROM PayDates WHERE PayDate=@date AND AddressId=@AddressId))
			INSERT INTO PayDates VALUES (@date,@AddressId);
	END;
GO
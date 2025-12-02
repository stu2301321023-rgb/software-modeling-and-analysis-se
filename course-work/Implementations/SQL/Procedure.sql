--Procedure
GO
CREATE PROCEDURE dbo.sp_CreateOrder
    @BuyerID         INT,
    @ShippingAddress NVARCHAR(200),
    @ShippingCity    NVARCHAR(100),
    @ShippingCountry NVARCHAR(50),
    @OrderID         INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Orders (BuyerID, OrderDate, TotalAmount, Status, ShippingAddress, ShippingCity, ShippingCountry)
    VALUES (@BuyerID, SYSDATETIME(), 0, N'Нова', @ShippingAddress, @ShippingCity, @ShippingCountry);

    SET @OrderID = SCOPE_IDENTITY();
END
GO
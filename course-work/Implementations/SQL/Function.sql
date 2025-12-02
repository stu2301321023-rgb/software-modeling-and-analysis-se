
--Function
GO
CREATE FUNCTION dbo.fn_GetUserRating (@UserID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Result FLOAT;

    SELECT @Result = AVG(CAST(Rating AS FLOAT))
    FROM Feedback
    WHERE ToUserID = @UserID;

    RETURN ISNULL(@Result, 0);
END
GO
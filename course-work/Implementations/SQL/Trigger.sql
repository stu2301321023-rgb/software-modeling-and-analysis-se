
--Trigger
GO
CREATE TRIGGER trg_UpdateUserRating
ON Feedback
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Users TABLE (UserID INT PRIMARY KEY);

    INSERT INTO @Users(UserID)
    SELECT DISTINCT ToUserID FROM inserted
    UNION
    SELECT DISTINCT ToUserID FROM deleted;

    UPDATE u
    SET Rating = dbo.fn_GetUserRating(u.UserID)
    FROM Users u
    INNER JOIN @Users x ON u.UserID = x.UserID;
END
GO
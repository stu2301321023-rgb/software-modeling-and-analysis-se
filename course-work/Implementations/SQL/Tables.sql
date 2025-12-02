CREATE DATABASE EbayProjectDB;
GO

USE EbayProjectDB;
GO


-- Users
CREATE TABLE Users (
    UserID          INT IDENTITY(1,1) PRIMARY KEY,
    Username        NVARCHAR(50)  NOT NULL,
    Email           NVARCHAR(100) NOT NULL,
    PasswordHash    NVARCHAR(200) NOT NULL,
    RegistrationDate DATE         NOT NULL,
    Country         NVARCHAR(50)  NULL,
    Rating          FLOAT         NULL,
    IsSeller        BIT           NOT NULL
);
GO

-- Categories
CREATE TABLE Categories (
    CategoryID       INT IDENTITY(1,1) PRIMARY KEY,
    Name             NVARCHAR(100) NOT NULL,
    ParentCategoryID INT NULL
);
GO

ALTER TABLE Categories
ADD CONSTRAINT FK_Categories_Parent
FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID);
GO

-- Items
CREATE TABLE Items (
    ItemID        INT IDENTITY(1,1) PRIMARY KEY,
    SellerID      INT NOT NULL,
    Title         NVARCHAR(200) NOT NULL,
    Description   NVARCHAR(MAX) NULL,
    StartPrice    DECIMAL(10,2) NOT NULL,
    BuyNowPrice   DECIMAL(10,2) NULL,
    Quantity      INT NOT NULL,
    Condition     NVARCHAR(50) NOT NULL,
    Status        NVARCHAR(50) NOT NULL,
    CreatedAt     DATETIME2 NOT NULL,
    EndAt         DATETIME2 NULL
);
GO

ALTER TABLE Items
ADD CONSTRAINT FK_Items_Users
FOREIGN KEY (SellerID) REFERENCES Users(UserID);
GO

-- ItemCategory 
CREATE TABLE ItemCategory (
    ItemID     INT NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT PK_ItemCategory PRIMARY KEY (ItemID, CategoryID),
    CONSTRAINT FK_ItemCategory_Items
        FOREIGN KEY (ItemID) REFERENCES Items(ItemID),
    CONSTRAINT FK_ItemCategory_Categories
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- Orders
CREATE TABLE Orders (
    OrderID        INT IDENTITY(1,1) PRIMARY KEY,
    BuyerID        INT NOT NULL,
    OrderDate      DATETIME2 NOT NULL,
    TotalAmount    DECIMAL(10,2) NOT NULL,
    Status         NVARCHAR(50) NOT NULL,
    ShippingAddress NVARCHAR(200) NOT NULL,
    ShippingCity   NVARCHAR(100) NOT NULL,
    ShippingCountry NVARCHAR(50) NOT NULL
);
GO

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Users
FOREIGN KEY (BuyerID) REFERENCES Users(UserID);
GO

-- OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID     INT NOT NULL,
    ItemID      INT NOT NULL,
    Quantity    INT NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL
);
GO

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Items
FOREIGN KEY (ItemID) REFERENCES Items(ItemID);
GO

-- Payments
CREATE TABLE Payments (
    PaymentID     INT IDENTITY(1,1) PRIMARY KEY,
    OrderID       INT NOT NULL,
    PaymentDate   DATETIME2 NOT NULL,
    Amount        DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    Status        NVARCHAR(50) NOT NULL,
    TransactionRef NVARCHAR(100) NULL
);
GO

ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Orders
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
GO

-- Feedback
CREATE TABLE Feedback (
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    FromUserID INT NOT NULL,
    ToUserID   INT NOT NULL,
    OrderID    INT NOT NULL,
    Rating     INT NOT NULL,
    Comment    NVARCHAR(500) NULL,
    CreatedAt  DATETIME2 NOT NULL
);
GO

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_FromUser
FOREIGN KEY (FromUserID) REFERENCES Users(UserID);

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_ToUser
FOREIGN KEY (ToUserID) REFERENCES Users(UserID);

ALTER TABLE Feedback
ADD CONSTRAINT FK_Feedback_Orders
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
GO


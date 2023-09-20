CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1, 1),
    BookID INT,
    StatusChange VARCHAR(30),
    ChangeDate DATETIME
);
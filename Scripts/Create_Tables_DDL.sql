CREATE TABLE [Borrowers] (
  [BorrowerID] INT PRIMARY KEY IDENTITY(1,1),
  [First Name] VARCHAR(10),
  [Last Name] VARCHAR(10),
  [Email] VARCHAR(30),
  [Date Of Birth] DATE,
  [Membership Date] DATE,
);



CREATE TABLE [Books] (
  [BookID] INT PRIMARY KEY IDENTITY(1,1),
  [Title] VARCHAR(30),
  [Author] VARCHAR(30),
  [ISBN] CHAR(13),
  [Published Date] DATE,
  [Genre] VARCHAR(10),
  [Shelf Location] INT,
  [Current Status] VARCHAR(9),
);

CREATE TABLE [Loans] (
  [LoanID] INT PRIMARY KEY IDENTITY(1,1),
  [BookID] INT NOT NULL,
  [BorrowerID] INT NOT NULL,
  [Date Borrowed] DATE,
  [Due Date] DATE,
  [Date Returned] DATE,
  FOREIGN KEY ([BookID]) REFERENCES [Books] ([BookID]),
  FOREIGN KEY ([BorrowerID]) REFERENCES Borrowers ([BorrowerID])
);


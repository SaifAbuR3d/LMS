DECLARE @BookCounter INT = 1
WHILE @BookCounter <= 1000
BEGIN
    INSERT INTO Books ([Title], [Author], [ISBN], [Published Date], [Genre], [Shelf Location], [Current Status])
    VALUES (
        'Book' + CAST(@BookCounter AS VARCHAR(5)),
        'Author' + CAST(@BookCounter AS VARCHAR(5)),
        'ISBN' + CAST(@BookCounter AS CHAR(13)),
        DATEADD(DAY, -CAST(RAND()*365*50 AS INT), GETDATE()), -- Random published date within the last 50 years
        CASE WHEN @BookCounter % 2 = 0 THEN 'Adventure' ELSE 'Drama' END,
        CAST((@BookCounter % 10) + 1 AS INT), -- Distribute books across 10 shelves
        CASE WHEN @BookCounter % 3 = 0 THEN 'Borrowed' ELSE 'Available' END -- Random status
    )
    SET @BookCounter = @BookCounter + 1
END


DECLARE @BorrowerCounter INT = 1
WHILE @BorrowerCounter <= 1000
BEGIN
    INSERT INTO Borrowers ([First Name], [Last Name], [Email], [Date Of Birth], [Membership Date])
    VALUES (
        'First' + CAST(@BorrowerCounter AS VARCHAR(5)),
        'Last' + CAST(@BorrowerCounter AS VARCHAR(5)),
        'email' + CAST(@BorrowerCounter AS VARCHAR(5)) + '@example.com',
        DATEADD(DAY, -CAST(RAND()*365*63 + 18 AS INT), GETDATE()), -- Random dates of birth for borrowers (between the ages of 18 and 80)
        DATEADD(DAY, -CAST(RAND()*365*5 AS INT), GETDATE()) -- Random membership date within the last 5 years
    )
    SET @BorrowerCounter = @BorrowerCounter + 1
END


-- [Date Borrowed] is a date within the last 5 years
-- [Due Date] is a date greater than [Date Borrowed] and less than ([Date Borrowed] + 60 days)
-- [Date Returned] is a date between [Date Borrowed] and [Due Date], null for some values 

DECLARE @LoanCounter INT = 1
WHILE @LoanCounter <= 1000
BEGIN
    -- Random date borrowed within the last 5 years
    DECLARE @DateBorrowed DATE = DATEADD(DAY, -CAST(RAND()*365*5 AS INT), GETDATE())

    -- Random due date greater than [Date Borrowed] and less than ([Date Borrowed] + 60 days)
    DECLARE @DueDate DATE = DATEADD(DAY, CAST(RAND()*60 AS INT), @DateBorrowed)

    -- Random return date between [Date Borrowed] and [Due Date], null for some values
    DECLARE @DateReturned DATE = CASE 
        WHEN @LoanCounter % 5 = 0 THEN NULL 
        ELSE DATEADD(DAY, CAST(RAND()*DATEDIFF(DAY, @DateBorrowed, @DueDate) AS INT), @DateBorrowed)
    END

    INSERT INTO Loans ([BookID], [BorrowerID], [Date Borrowed], [Due Date], [Date Returned])
    VALUES (
        (SELECT TOP 1 [BookID] FROM Books ORDER BY NEWID()), -- Random book
        (SELECT TOP 1 [BorrowerID] FROM Borrowers ORDER BY NEWID()), -- Random borrower
        @DateBorrowed,
        @DueDate,
        @DateReturned
    )

    SET @LoanCounter = @LoanCounter + 1
END


select * from Loans; 
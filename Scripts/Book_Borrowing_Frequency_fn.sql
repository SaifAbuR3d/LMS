create function fn_BookBorrowingFrequency (@BookId int) 
returns int 
as 
begin
	declare @BorrowCount int
	select @BorrowCount = count(*) 
	from loans 
	where BookID = @BookId; 
	return @BorrowCount
end; 
create procedure sp_AddNewBorrower 
	@FirstName varchar(10), 
	@LastName varchar(10),
	@Email varchar(30),
	@DateOfBirth date,
	@MembershipDate date
as
	declare @RowCount int 
	select @RowCount = COUNT(*)
	from Borrowers 
	where Email = @Email

	if @RowCount > 0 
		begin
         return -1
		end
	else 
		begin 
		 insert into Borrowers values(@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate)
		 return SCOPE_IDENTITY()
		end

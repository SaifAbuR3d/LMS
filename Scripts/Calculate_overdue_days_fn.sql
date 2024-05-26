create function overdues_days_fn (@loanId int) 
returns int 
as 
begin 
  declare @overdueDays int 
  select @overdueDays =  datediff(day, l.[Due Date], COALESCE(l.[Date Returned], GETDATE()))
  from Loans as l
  where l.LoanID = @loanId; 
  return @overdueDays; 
end; 

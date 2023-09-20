create procedure GetBorrowersWithOverdueBooks
as
begin
  create table #TempBorrowers (BorrowerID int primary key)

  insert into #TempBorrowers (BorrowerID)
  select distinct l.BorrowerID
  from Loans l
  where dbo.overdues_days_fn(l.LoanID) > 0

  select bb.BorrowerID, bb.[First Name] + ' ' + bb.[Last Name] as [Full Name], b.BookID, b.[Title], l.[Due Date]
  from #TempBorrowers tb
  join Loans l on tb.BorrowerID = l.BorrowerID
  join Books b on l.BookID = b.BookID
  join Borrowers bb on bb.BorrowerID = l.BorrowerID
  where dbo.overdues_days_fn(l.LoanID) > 0
  order by bb.BorrowerID


  -- Drop the temporary table
  drop table #TempBorrowers
end;
go

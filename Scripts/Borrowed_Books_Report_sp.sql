create procedure sp_borrowedbooksreport
  @StartDate date,
  @EndDate date
as
begin
  select
    b.Title as booktitle,
    b.Author as bookauthor,
    bb.[First Name] as borrowerfirstname,
    bb.[Last Name] as borrowerlastname,
    l.[Date Borrowed] as borrowdate
  from
    Loans as l
    join Books as b on l.BookID = b.BookID
    join Borrowers as bb on l.BorrowerID = bb.BorrowerID
  where
    l.[Date Borrowed] between @StartDate and @EndDate;
end;
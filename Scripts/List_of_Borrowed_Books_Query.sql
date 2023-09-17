-- [BorrowerId = 2500] replace it
select b.title as title, b.Author as author, l.[Date Borrowed] as [Date Borrowd]
from books as b inner join loans as l
on b.BookID = l.BookID
where l.BorrowerID = 2500; 
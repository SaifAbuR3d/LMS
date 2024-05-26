select b.Author, COUNT(l.LoanID) as BorrowingFrequency, RANK() over(order by COUNT(l.loanID) desc) as AuthorRank
from Books as b left join Loans as l on (b.BookID = l.BookID) 
group by Author
order by BorrowingFrequency desc;  

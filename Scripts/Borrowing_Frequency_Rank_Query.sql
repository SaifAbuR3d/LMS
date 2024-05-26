select B.[BorrowerID], B.[First Name], B.[Last Name], 
COUNT(L.LoanID) as BorrowingFrequency,
RANK() over (order by COUNT(L.LoanID) desc) as BorrowingRank
from Borrowers as B LEFT JOIN Loans as L
on B.BorrowerID = L.BorrowerID
group by B.BorrowerID, B.[First Name], B.[Last Name]
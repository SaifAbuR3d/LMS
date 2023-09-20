with Borrower_CountUnreturned(BorrowerId, [Count Unreturned Books]) as (
select BorrowerID, COUNT(*)
from loans 
where [Date Returned] is null 
group by BorrowerID
),

Borrower_CountLoans(BorrowerId, [Count Loans]) as (
select BorrowerID, COUNT(*)
from loans
group by BorrowerID
),

Active_Borrowers(BorrowerId) as (
select A.BorrowerId 
from Borrower_CountUnreturned as A join Borrower_CountLoans as B
on A.BorrowerId = B.BorrowerId
where B.[Count Loans] >= 2 and A.[Count Unreturned Books] = B.[Count Loans]
)
select B.BorrowerID,B.[First Name], B.[Last Name]
from Active_Borrowers as A join Borrowers as B
on (A.BorrowerID = B.BorrowerID)
;
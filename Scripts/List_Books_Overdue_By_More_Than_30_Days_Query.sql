select l.BookID, l.BorrowerID, dbo.overdues_days_fn(l.LoanID) as [Overdue by (days)]
from Loans as l 
where dbo.overdues_days_fn(l.LoanID) > 30
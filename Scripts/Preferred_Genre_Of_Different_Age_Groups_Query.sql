with Borrower_AgeGroup(BorrowerID, AgeGroup) as (
    select
		b.BorrowerID,
			case 
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 0 AND 10 THEN '1-10'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 61 AND 70 THEN '61-70'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 71 AND 80 THEN '71-80'
				WHEN DATEDIFF(YEAR, B.[Date Of Birth], GETDATE()) BETWEEN 81 AND 90 THEN '81-90'
				ELSE 'Too Old'
			END 
		as AgeGroup
	from Borrowers as b
	), 

Genre_AgeGroup_NumberOfLoans(AgeGroup, Genre, [Number of Loans]) as (
	select ba.AgeGroup, b.Genre, COUNT(*) as [Number of Loans]
	from Borrower_AgeGroup as ba join Loans as l on ba.BorrowerID = l.BorrowerID 
	join Books as b on l.BookID = b.BookID  
	group by ba.AgeGroup, b.Genre
	),

Genre_AgeGroup_Rank (AgeGroup, Genre, [Genre Rank]) as (
    select AgeGroup, Genre, ROW_NUMBER() OVER (PARTITION BY AgeGroup ORDER BY [Number Of Loans] DESC) AS GenreRank
    from  Genre_AgeGroup_NumberOfLoans
)

select AgeGroup, Genre
from Genre_AgeGroup_Rank 
where [Genre Rank] = 1 
;
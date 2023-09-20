-- replace 2022 (year) and 1 (month)

with MonthGenreCount as (
select CAST(YEAR(l.[Date Borrowed]) as INT) as year,
	   CAST(MONTH(l.[Date Borrowed]) as INT) as month,
	   b.Genre as Genre,
	   COUNT(*) as GenreCount, 
       ROW_NUMBER() OVER (PARTITION BY CAST(YEAR(l.[Date Borrowed]) as INT), CAST(MONTH(l.[Date Borrowed]) as INT) ORDER BY COUNT(*) DESC) as GenreRank
from Books as b join Loans as l on (b.BookID = l.BookID)
where CAST(YEAR(l.[Date Borrowed]) as INT) = 2022 and CAST(MONTH(l.[Date Borrowed]) as INT) = 1
group by CAST(YEAR(l.[Date Borrowed]) as INT), CAST(MONTH(l.[Date Borrowed]) as INT), b.Genre
)

select Genre from MonthGenreCount where GenreRank = 1; 



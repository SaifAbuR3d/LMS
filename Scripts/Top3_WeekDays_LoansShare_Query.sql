with Day_Freq ([Day], [Frequency]) as (
select datename(dw, [Date Borrowed]) as [Day], COUNT(*) as [Frequency]
from Loans
group by datename(dw, [Date Borrowed])
), 
Total_Freq ([Total]) as (
select SUM([Frequency]) as Total
from Day_Freq
), 
Day_Share ([Day], [Share]) as (
select [Day], ROUND([Frequency] * 100.0 / [Total], 2)
from Day_Freq , Total_Freq
) 
select top 3 * from Day_Share 
order by [Share] desc;
create function fn_calculate_overdue_fees (@loanid int)
returns decimal(10, 2)
as
begin
    declare @overdue_days int
    declare @overdue_fee decimal(10, 2)

    select @overdue_days = datediff(day, l.[Due Date], l.[Date Returned])
    from Loans as l
    where l.LoanID = @loanid

    if @overdue_days <= 0
        set @overdue_fee = 0
    else if @overdue_days <= 30
        set @overdue_fee = cast(@overdue_days as decimal(10, 2))
    else
        set @overdue_fee = cast((30 + (@overdue_days - 30) * 2) as decimal(10, 2))

    return @overdue_fee
end

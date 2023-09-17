create trigger tr_bookstatuschange
on Books
after update
as
begin
    if update([Current Status])
    begin
        insert into AuditLog (BookID, StatusChange, ChangeDate)
        select
            i.BookID,
            case
                when i.[Current Status] = 'Available' then 'Borrowed to Available'
                when i.[Current Status] = 'Borrowed' then 'Available to Borrowed'
                else 'Unknown Status Change'
            end
			as StatusChange,
            getdate()
        from
            inserted i
            join deleted d on i.BookID = d.BookID
        where
            (i.[Current Status] = 'Available' and d.[Current Status] = 'Borrowed')
            or (i.[Current Status] = 'Borrowed' and d.[Current Status] = 'Available');
    end;
end;

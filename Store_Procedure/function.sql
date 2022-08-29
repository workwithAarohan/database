create or replace function fn_calcpercent(p_percentage float) return float
is
begin
    if(p_percentage between 0 and 100) then
        return 1+(p_percentage/100);
    else
    dbms_output.put_line('invalid percentage');
        return 1;
    end if;
end;
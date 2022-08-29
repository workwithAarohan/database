set serveroutput on;
Create or replace procedure UpdateSalary
(
    PSalPct float, 
    PEmployee_id int
)
is 
    SalaryPct float;
begin
    SalaryPct := fn_calcpercent(p_percentage=>PSalPct);
    
    dbms_output.put_line('Salary Percentage: '||SalaryPct);
    update employees set
        salary = salary * SalaryPct
    where employee_id = PEmployee_id;
    
    commit;
    
     dbms_output.put_line('Update Completed');
    
    exception when others then
        dbms_output.put_line('error occured'||chr(13)||sqlerrm);
end;

exec UpdateSalary(PSalPct=>20, PEmployee_id=>207);

select employee_id, last_name, salary from employees where employee_id = 207;

select fn_calcpercent(p_percentage=>20) from employees where employee_id = 207;



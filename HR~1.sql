-- Lab 3

-- Write a query to display the current date. Label the column Date. 
SELECT   
    SYSDATE as "Date"  
FROM 
    dual;
    
--The HR department needs a report to display the employee number, last name, salary, 
--and salary increased by 15.5% (expressed as a whole number) for each employee. 
--Label the column New Salary


SELECT 
    employee_id, first_name, last_name, salary, ROUND(1.155*salary) as   NewSalary 
FROM
    employees;
    
--Modify query of 3 (b) to add a column that subtracts the old salary from the new salary. 
--Label the column Increase.
with emp as 
(
    SELECT 
        employee_id, first_name, last_name, salary, 
        ROUND(1.155*salary) as NewSalary
    FROM
        employees
)
SELECT 
    emp.*, (newsalary - salary) as Increase 
FROM
    emp;
    
-- Lab 4

-- Create a report that produces the following for each employee:
-- <employee last name> earns <salary> monthly but wants <3 times salary>
-- Label the column Dream Salaries. (Hint: Use Concatenation) 

SELECT 
    last_name || ' earns ' || salary || ' monthly but wants ' || salary * 3 as "Dream Salaries"
FROM
    employees;
    
-- Lab 5

-- Find the highest, lowest, sum, and average salary of all employees. 
-- Label the columns Maximum, Minimum, Sum and Average respectively. 
-- Round your results to the nearest whole number

SELECT 
    MAX(salary) as Maximun, 
    MIN(salary) as Minimum, 
    SUM(salary) as Sum, 
    Round(AVG(salary)) as Average
FROM 
    employees;


-- Lab 6

-- Write a query for the HR department to produce the addresses of all the departments. 
-- Use the LOCATIONS and COUNTRIES tables. 
-- Show the location Id, street address, city, and country in the output. 
-- Use a NATURAL JOIN to produce results

SELECT 
    loc.location_id, loc.street_address, loc.city, c.country_name 
from 
    locations loc
natural join
    countries c;


-- ****************************************
--           LAB 1
-- *****************************************

-- a) The HR department wants a query to display the last name, job code, hire date and 
-- employee number for each employee, with the employee number appearing first. 
-- Provide an alias STARTDATE for the hire_date column.
SELECT 
    employee_id, 
    last_name, 
    job_id, 
    hire_date as STARTDATE
FROM
    employees;
    
-- b) The HR department needs a query to display all unique job 
-- codes (job_id) from the employees table.
SELECT 
    DISTINCT job_id
FROM 
    employees;

-- c) The HR department has requested a report of all employees and their job IDs. 
-- Display the last name concatenated with the job ID 
-- (separated by a comma and space) and name the column Employee and Title
SELECT  
    last_name || ', ' || job_id as "Employee and Title"
FROM 
    employees;
    
    
-- ****************************************
--           LAB 2
-- ***************************************** 

-- a) The HR department needs a report that displays the last name and salary 
-- employees earning more than $12,000. 
SELECT 
    last_name, salary
FROM 
    employees
WHERE 
    salary > 12000;
    
-- b) Write a query that displays the last name and department number 
-- for employee number 176. 
SELECT 
    last_name, department_id
FROM 
    employees
WHERE 
    employee_id = 176;
    
-- c) Write a query that displays the last name and salary for all employees 
-- whose salary is not in the $5,000-$12,000 range.
SELECT 
    last_name, salary
FROM
    employees
WHERE 
    salary NOT BETWEEN 5000 and 12000;
    
-- d) Create a query to display the last name,job ID,and start date for the employees 
-- whose last names are Matos and Taylor. 
-- Order the query in ascending order by start date.

SELECT 
    last_name, job_id, hire_date
FROM 
    employees
WHERE 
    last_name in ('Matos', 'Taylor')
ORDER BY 
    hire_date;
    
-- e) Display the last name and department number of all employees in 
-- departments 20 or 50 in ascending alphabetical order by name.
SELECT 
    last_name, department_id
FROM 
    employees
WHERE
    department_id = 20 or department_id = 50
ORDER BY
    last_name;
    
-- f) Write a query to list the last name and salary of employees who earn 
-- between $5,000 and $12,000 and are in department 20 or 50. 
-- Label the columns Employee and Monthly salary, respectively.
SELECT 
    last_name as Employee, 
    salary as "Monthly salary"
FROM
    employees
WHERE
    salary BETWEEN 5000 and 12000
    and
    department_id in (20,50);
    
-- g) The HR department needs a report that displays the Iast name and 
-- hire date for all employees who were hired in 1994.

SELECT 
    last_name, hire_date
FROM
    employees
WHERE to_char(hire_date, 'yyyy') = 2004;

SELECT 
    last_name, hire_date,
    extract(year from hire_date) as Hire_Year
FROM
    employees;
    

-- h) Display all employees last names in which the third letter of the name is a.
SELECT
    last_name 
FROM
    employees
WHERE 
    last_name LIKE '__a%';
    
-- i) Display the last names of all employees who have both an “a" and "e" in their last names.

SELECT 
    last_name
FROM 
    employees
WHERE 
    last_name LIKE '%a%' and last_name LIKE '%e%';
    
-- j) Display the last name and job title of all employees who do not have a manager
SELECT
    emp.last_name, job.job_title
FROM 
    employees emp
JOIN
    jobs job
ON  
    emp.job_id = job.job_id
WHERE
    manager_id is null;  

SELECT last_name, job_id 
FROM employees  
WHERE manager_id IS NULL;

    
-- k) Display the last name, salary and commission for all employees who earn commissions. 
-- Sort data in descending order of salary and commissions.
SELECT 
    last_name, salary, commission_pct
FROM 
    employees
WHERE 
    commission_pct is not null
ORDER BY 
    salary DESC, commission_pct DESC;
    
-- l) Members of the HR department want to have more flexibility 
-- with the queries that you are writing. They would like a report that 
-- displays the last name and salary of employee who earns more than amount 
-- that the user specifies after a prompt.
SELECT 
    last_name,
    salary
FROM
    employees
WHERE
    salary > '&Sal'; -- no need of iverted comma

-- m) The HR department wants to run reports based on a manager. 
-- Create query that prompts the user for a manager ID and generates 
-- the employee ID, last name, salary and department for that manager's employees. 
-- The HR department wants the ability to sort the report on a selected column. 
-- You can test the data with the following values:
-- Manager ID=103, sorted by employee last name
-- Manager ID=201, sorted by salary
-- Manager ID=124, sorted by employee ID
SELECT
    emp.employee_id,
    emp.last_name,
    emp.salary,
    dept.department_name
FROM 
    employees emp
JOIN
    departments dept
ON
    emp.department_id = dept.department_id
    and
    emp.manager_id = '&manager_code'
ORDER BY
    &column ASC;
    

-- n) Display all employee last names in which the third letter of the name is “a”
-- Same as ques no h)
SELECT
    last_name 
FROM
    employees
WHERE 
    last_name LIKE '__a%';
    
-- o) Display the last names of all employees who have both an “a” and “e” in their last names.
-- Same as i)

-- p) Display the last name, job and salary for all employees whose job is either that of a sales representative 
-- (SA_REP) or a stock clerk (ST_CLERK), and whose salary is 
-- not equal to $2,500, $3,500, or $7,000.
SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    job_id IN ('SA_REP', 'ST_CLERK')
    and
    salary NOT IN (2500, 3500, 7000);    
  
  
-- ****************************************
--           LAB 3
-- *****************************************   

-- a) Write a query to display the current date. Label the column Date. 
SELECT 
    SYSDATE as "Date"
From
    dual;
    
-- b) The HR department needs a report to display the employee number, last name, salary, 
-- and salary increased by 15.5% (expressed as a whole number) for each employee. 
-- Label the column New Salary. 

SELECT
    employee_id, 
    last_name, 
    salary,
    ROUND(1.155 * salary) as "New Salary"
FROM 
    employees;

-- c) Modify query of 3 (b) to add a column that subtracts the old salary 
-- from the new salary. Label the column Increase. 
with emp as
(
    SELECT
        employee_id, 
        last_name, 
        salary,
        1.155 * salary as NewSalary
    FROM 
        employees
)
SELECT emp.*, (newsalary - salary) as Increase from emp;

-- d) Write a query that displays the last name and the length of the last name for all employees 
-- whose name starts with letters J, A or M. 
-- Give each column an appropriate label. Sort the results by the employees' last names. 

SELECT 
    last_name as Employee, 
    LENGTH(last_name) as Length
FROM
    employees
WHERE 
    substr(last_name,1,1) in ('J', 'A', 'M')
ORDER BY 
    last_name;
    
-- e) Create a query to display the last name and salary for all employees. 
-- Format the salary to be 15 characters long, left-padded with the "$" symbol. 
-- Label the column SALARY. 
SELECT
    last_name, 
    to_char(salary, 'L99G999D00') as SALARY
FROM 
    employees;
    
-- OR
SELECT 
    last_name,
    LPAD(salary, 15, '$') as SALARY
FROM 
    employees;

    
-- ****************************************
--           LAB 4
-- ***************************************** 

-- a) Create a report that produces the following for each employee:
-- <employee last name> earns <salary> monthly but wants <3 times salary>
-- Label the column Dream Salaries. (Hint: Use Concatenation) 

SELECT
    last_name || ' earns ' || salary || ' monthly but wants ' || 3*salary as "Dream Salaries"
FROM
    employees;
    
-- b) Display each employee's last name, hire date, and salary review date, 
-- which is the first Monday after six months of service. 
-- Label the column REVIEW. 
-- Format the dates to appear in the format similar to “Monday, the Thirty-First of July, 2000."
SELECT 
    last_name,
    hire_date,
    to_char(
        next_day(
            add_months(hire_date,6), 
            'MONDAY'
        ),
        'fmDay, "the" Ddspth "of" Month, YYYY'
    )  REVIEW
FROM
    employees;

-- c) Display the last name, hire date, and day of the week on which the employee started. 
-- Label the column DAY. Order the results by the day of the week, starting with Monday. 

SELECT 
    last_name, hire_date,
    to_char(hire_date, 'DAY') as DAY
FROM
    employees
ORDER BY
    to_char(hire_date - 1, 'd');
 
   
-- d) Create a query that displays the employees' last names and commission amounts. 
-- If an employee does not earn commission, show "No Commission." Label the column COMM. 

SELECT
    last_name,
    nvl(to_char(commission_pct), 'No Commission') as COMM
FROM
    employees;

-- e) Using CASE function, write a query that displays the grade of all employees 
-- based on the value of the column JOB_ID, using the following data: 
-- Job			Grade 
-- AD_PRES		? 
-- ST_MAN 		B
-- IT_PROG 		C
-- SA_REP 		D 
-- ST_CLERK		E
-- None of the above 	0 

SELECT
    job_id,
    CASE job_id
        WHEN 'AD_PRES' THEN 'A'
        WHEN 'ST_MAN' THEN 'B'
        WHEN 'IT_PROG' THEN 'C'
        WHEN 'SA_REP' THEN 'D' 
        WHEN 'ST_CLERK' THEN 'E'
        ELSE '0'
    END GRADE
FROM 
    employees;

-- f) Rewrite the statement in the preceding exercise using the DECODE function
SELECT 
    job_id, 
    decode (job_id,
        'AD_PRES', 'A', 
        'ST_MAN', 'B',
        'IT_PROG', 'C',
        'SA_REP', 'D', 
        'ST_CLERK', 'E',
        '0' 
    ) GRADE
FROM employees;
            

-- ****************************************
--           LAB 5
-- *****************************************

-- a) Find the highest, lowest, sum, and average salary of all employees. 
-- Label the columns Maximum, Minimum, Sum and Average respectively. 
-- Round your results to the nearest whole number. 

SELECT
    MAX(salary) as Maximum,
    MIN(salary) as Minimum,
    SUM(salary) as Sum,
    ROUND(AVG(salary)) as Average
FROM 
    employees;
    
-- b) Modify the query of 4 (a) to display the minimum, maximum, sum and average salary for each job type. 

SELECT
    job_id,
    MAX(salary) as Maximum,
    MIN(salary) as Minimum,
    SUM(salary) as Sum,
    ROUND(AVG(salary)) as Average

FROM 
    employees
GROUP BY 
    job_id;
    
-- c) Write a query to display the number of people with the same job. 
SELECT 
    job_id,
    COUNT(employee_id) as "Total Employees"
FROM 
    employees
GROUP By
    job_id;
    
-- d) Find the difference between the highest and lowest salaries. 
-- Label the column DIFFERENCE. 
WITH emp as
(
    SELECT
        MAX(salary) as Maximum,
        MIN(salary) as Minimum
    FROM
        employees
)
SELECT 
    emp.*, 
    (maximum-minimum) as DIFFERENCE 
FROM 
    emp;
    
-- OR
SELECT 
    MAX(salary) - MIN(salary) as DIFFERENCE
FROM
    employees;
    
-- e) Create a query to display the manager number and the salary 
-- of the lowest-paid employee for the manager. Exclude anyone whose manager is not known. 
-- Exclude any groups where the minimum salary is $6,000 or less. 
-- Sort the output in descending order of salary. 
SELECT
    manager_id, 
    MIN(salary) as "Minimum Salary"
FROM
    employees
WHERE
    manager_id is not null
GROUP BY 
    manager_id
HAVING
    MIN(salary) > 6000
ORDER BY
    MIN(salary) DESC;
    
-- ****************************************
--           LAB 6
-- *****************************************

--a) Write a query for the HR department to produce the addresses of all the departments. 
-- Use the LOCATIONS and COUNTRIES tables. Show the location Id, street address, 
-- city, and country in the output. Use a NATURAL JOIN to produce results.
SELECT 
    loc.location_id,
    loc.street_address,
    loc.city,
    countries.country_name
FROM
    locations loc
NATURAL JOIN
    countries;
    
-- b) The HR department needs a report of all employees.
-- Write a query to display the last name, department number, and department name 
-- for all employees. Use USING to produce results.

SELECT
    last_name,
    department_id,
    department_name
FROM
    employees
JOIN
    departments
USING (department_id);

-- c) The HR department needs a report of employees in Toronto. 
-- Display the last name, department name and city for all employees who work in Toronto. 

SELECT 
    emp.last_name,
    dept.department_name,
    loc.city
FROM 
    departments dept
JOIN
    employees emp
ON
    emp.department_id = dept.department_id
JOIN
    locations loc
ON 
    loc.location_id = dept.location_id
WHERE
    lower(loc.city) = 'toronto';
    
   
-- d) Create a report to display the last name and employee number of employees 
-- along with their manager's last name and manager number. 
-- Label the columns Employee, Emp#, Manager, and Mgr#, respectively.
SELECT 
    emp.last_name as Employee,
    emp.employee_id as Emp#,
    manager.last_name as Manager,
    manager.employee_id as Mgr#
FROM
    employees emp
JOIN 
    employees manager
ON
    emp.manager_id = manager.employee_id;

-- e) The HR department wants to determine the names of all employees who were hired after Davies. 
-- Create query to display the name and hire date of any employee hired after employee Davies.
SELECT 
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Davies');
    
SELECT
    emp.last_name,
    emp.hire_date
FROM 
    employees emp
JOIN
    employees davies
ON
    davies.last_name = 'Davies'
WHERE
    emp.hire_date > davies.hire_date;

-- ****************************************
--           LAB 7
-- *****************************************    
-- a) Create a report that displays the employee number, last name, and salary 
-- of all employees who earn more than the average salary. 
-- Sort the results in ascending order by salary 
 SELECT
    employee_id,
    last_name,
    salary
FROM 
    employees
WHERE
    salary > (SELECT AVG(salary) FROM employees)
ORDER BY
    salary;


-- b) Write a query that displays the employee number and last name of all employees 
-- who work in a department with any employee whose last name contains a u.

SELECT 
    employee_id,
    last_name
FROM
    employees
WHERE
    department_id IN (
        SELECT 
            department_id 
        FROM
            employees
        WHERE
            last_name LIKE '%u%'
    );

-- c) The HR department needs a report that displays the last name, department number,
-- job id of all employees whose department location id is 1700. 
SELECT 
    last_name,
    department_id,
    job_id
FROM
    employees
WHERE
    department_id IN (
        SELECT
            department_id 
        FROM 
            departments
        WHERE
            location_id = 1700
    );

-- d) Create a report for the HR department that displays 
-- the last name and salary of every employee who reports to King. 
SELECT 
    last_name,
    salary
FROM
    employees
WHERE
    manager_id IN (
        SELECT 
            manager_id 
        FROM 
            employees 
        WHERE 
            last_name = 'King'
    );

-- ****************************************
--           LAB 8
-- *****************************************

-- a) The HR department needs a list of departments for departments that do not 
-- contain the job ID ST_CLERK. Use set operators to create this report. 

SELECT
    department_id
FROM
    departments
MINUS
SELECT
    department_id
FROM
    employees
WHERE
    job_id = 'ST_CLERK';
    
-- b) Create a report that lists the employee ID and job ID of those employees 
-- who currently have a job title that is the same as their job title when 
-- they were initially hired by the company (they changed jobs but have now gone 
-- back to doing their original job). 
SELECT
    employee_id,
    job_id
FROM 
    employees
INTERSECT
SELECT
    employee_id,
    job_id
FROM
    job_history;

-- ****************************************
--           LAB 9
-- *****************************************

-- a) The staff in the HR department wants to hide some of the data in the EMPLOYEES table. 
-- They want a view called EMPLOYEES_VU based on the employee numbers, 
-- employee last names, and department numbers from the EMPLOYEES table. 
-- They want the heading for the employee name to be EMPLOYEE.
CREATE OR REPLACE VIEW EMPLOYEE_VU as
    SELECT 
        employee_id,
        last_name as EMPLOYEE,
        department_id
    FROM
        employees;

-- b) Confirm that the view works. Display the contents of the EMPLOYEE VU view. 
SELECT 
    * 
FROM 
    employee_vu;
    
-- c) Using your EMPLOYEE_VU view, write a query for the HR department 
-- to display all employee names and department numbers
SELECT
    employee,
    department_id
FROM
    employee_vu;
    
-- d) You need a sequence that can be used with the primary key column of the DEPT table. 
-- The sequence should start at 200 and have a maximum value of 1000. 
-- Have your sequence increment by 10. Name the sequence DEPT_ID_SEQ.
ALTER TABLE departments 
    ADD DEPT_ID_SEQ INT
        GENERATED ALWAYS as IDENTITY
        START WITH 200 INCREMENT BY 10
        MAXVALUE 1000; 

 -- e) To test your sequence (created in 9 d), write a script to insert two rows in the DEPT table. 
 -- Be sure to use the sequence that you created for the ID column. 
 -- Add two departatments: Education and Administration. 
 -- Confirm your additions. Run the commands in your script.
 INSERT INTO departments 
    (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
    VALUES (
      '280', 'Education and Administration', '103', '1000'
    );
   

--  f) Create a nonunique index on the NAME column in the DEPT table.
CREATE INDEX IDX_NON_UNIQUE_NAME ON DEPARTMENTS (DEPARTMENT_NAME ASC);


-- g) Create a synonym for your EMPLOYEES table. Call it EMP.
CREATE 
    synonym EMP 
FOR 
    employees;

select * from emp;














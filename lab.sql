--

/*1 a*/
SELECT
employee_id, last_name, job_id, hire_date startdate
From employees;

/*b*/
SELECT DISTINCT
job_id
FROM employees;

/*c*/
SELECT 
last_name||', '||job_id "Employee and Title" 
FROM
employees;

/*2 a*/
SELECT * 
FROM employees
WHERE salary > 12000;

/*b*/
SELECT last_name, department_id
FROM employees
WHERE 
employee_id = 176;


/*c*/
SELECT last_name,  salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000
OR
SELECT last_name, salary
FROM employees
WHERE salary>12000 OR  salary<5000;

/*d*/
SELECT last_name, job_id, hire_date
FROM employees
WHERE last_name IN ('Matos', 'Taylor')
ORDER BY hire_date;

/*e*/
SELECT last_name, department_id
FROM employees
WHERE department_id IN(20,50)
ORDER BY last_name ASC;

/*f*/
SELECT last_name, salary, department_id
FROM employees
WHERE department_id IN(20,50) AND salary BETWEEN 5000 AND 12000

/*h*/
SELECT last_name
FROM employees 
WHERE last_name LIKE '__a%';

/*i*/
SELECT last_name 
FROM employees 
WHERE last_name LIKE '%a%' 
AND last_name LIKE '%e%';

/*j*/


/*k*/
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

/*l*/
set prompt off
SELECT * FROM hr.employee WHERE employee_id= &employee_Id

/*m*/


/*n*/
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%'


/*o*/
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%'
AND last_name LIKE '%e%';

/*p*/
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('SA_REP', 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000)


/*3 a*/
SELECT sysdate "Date"
FROM dual;

/*b*/
SELECT employee_id, last_name, salary,
ROUND(salary * 1.155, 0) "New Salary"
FROM employees;

/*c*/
SELECT employee_id, last_name, salary,
ROUND(salary * 1.155, 0) "New Salary",
ROUND(salary * 1.155, 0) - salary "Increase"
FROM employees;

/*d*/
SELECT INITCAP(last_name) "Name",
LENGTH(last_name) "Length"
FROM employees
WHERE last_name LIKE 'J%'
OR last_name LIKE 'M%'
OR last_name LIKE 'A%'
ORDER BY last_name ;

/*e*/
SELECT last_name,
LPAD(salary, 15, '$') SALARY
FROM employees;

/*4 a*/
SELECT last_name || ' earns '
|| TO_CHAR(salary, 'fm$99,999.00')
|| ' monthly but wants '
|| TO_CHAR(salary * 3, 'fm$99,999.00')
|| '.' "Dream Salaries"
FROM employees;

/*b*/
SELECT last_name, hire_date,
TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),'MONDAY'),
'fmDay, "the" Ddspth "of" Month, YYYY') REVIEW
FROM employees;

/*c*/
SELECT last_name, hire_date,
TO_CHAR(hire_date, 'DAY') DAY
FROM employees
ORDER BY TO_CHAR(hire_date - 1, 'd');


/*d*/
SELECT last_name,
NVL(TO_CHAR(commission_pct), 'No Commission') COMM
FROM employees;

/*e*/
SELECT job_id, decode (job_id,
'ST_CLERK', 'E',
'SA_REP', 'D',
'IT_PROG', 'C',
'ST_MAN', 'B',
'AD_PRES', 'A',
'0')GRADE
FROM employees;

/*f*/
SELECT job_id, decode (job_id,
'ST_CLERK', 'E',
'SA_REP', 'D',
'IT_PROG', 'C',
'ST_MAN', 'B',
'AD_PRES', 'A',
'0')GRADE
FROM employees;

/*5a*/
SELECT ROUND(MAX(salary),0) "Maximum",
ROUND(MIN(salary),0) "Minimum",
ROUND(SUM(salary),0) "Sum",
ROUND(AVG(salary),0) "Average"
FROM employees;

/*b*/
SELECT job_id, ROUND(MAX(salary),0) "Maximum",
ROUND(MIN(salary),0) "Minimum",
ROUND(SUM(salary),0) "Sum",
ROUND(AVG(salary),0) "Average"
FROM employees
GROUP BY job_id;

/*c*/

SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

/*d*/
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;

/*e*/
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY MIN(salary) DESC;

/*6 a*/
SELECT location_id, street_address, city, state_province, country_name
FROM locations
NATURAL JOIN countries;

/*b*/
SELECT last_name, department_id, department_name
FROM employees
JOIN departments
USING (department_id)

/*c*/
SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id)
WHERE LOWER(l.city) = 'toronto';

/*d*/
SELECT w.last_name "Employee", w.employee_id "EMP#",
m.last_name "Manager", m.employee_id "Mgr#"
FROM employees w join employees m
ON (w.manager_id = m.employee_id);

/*e*/
SELECT e.last_name, e.hire_date
FROM employees e JOIN employees davies
ON (davies.last_name = 'Davies')
WHERE davies.hire_date < e.hire_date;

/*7a*/
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
FROM employees)
ORDER BY salary;

/*b*/
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id
FROM employees
WHERE last_name like '%u%');

/*c*/

SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (SELECT department_id
FROM departments
WHERE location_id = 1700);

/*d*/
SELECT last_name, salary
FROM employees
WHERE manager_id In (select employee_id from employees where last_name='King');

/*8a*/
SELECT department_id
FROM departments
MINUS
SELECT department_id
FROM employees
WHERE job_id = 'ST_CLERK';

/*b*/
SELECT employee_id,job_id
FROM employees
INTERSECT
SELECT employee_id,job_id
FROM job_history;

/*9 a*/
create or replace view employees_vu as
select employee_Id, last_name as employee, department_id from employees;

/*b */

SELECT *
FROM employees_vu;

/*c*/
SELECT employee, department_id
FROM employees_vu;


/*d*/



/*e*/



/**/



/*g*/
create synonym "HR".epm for "HR"."EMPLOYEES"
SELECT * FROM emp;

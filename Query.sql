SELECT
    *
FROM
    hr.employees;

SELECT
    *
FROM
    hr.departments;

-- inner join
-- employee and department name
SELECT
    e.employee_id,
    first_name,
    last_name,
    e.department_id employee_did,
    d.department_id,
    department_name AS dname
FROM
         hr.employees e
    INNER JOIN hr.departments d ON d.department_id = e.department_id;


-- get list of departments which are not in employees
-- alt question.: list of department which do not have any employees
-- left outer join
SELECT
    d.*,
    e.first_name
FROM
    hr.departments d
    LEFT OUTER JOIN hr.employees   e ON d.department_id = e.department_id
WHERE
    e.department_id IS NULL;


--right outer join
SELECT
    d.*,
    e.first_name
FROM
    hr.employees   e
    RIGHT OUTER JOIN hr.departments d ON d.department_id = e.department_id
WHERE
    e.department_id IS NULL;    


-- employee job history 
SELECT
    *
FROM
    hr.employees;

SELECT
    *
FROM
    hr.job_history;


SELECT
    *
FROM
    hr.job_history
WHERE
    employee_id = 101
ORDER BY
    employee_id;


SELECT
    *
FROM
    hr.employees
WHERE
    employee_id = 101;


SELECT
    e.employee_id,
    first_name,
    last_name,
    (
        SELECT
            job_title
        FROM
            hr.jobs job
        WHERE
            e.job_id = job.job_id
    ) AS current_title,
    h.job_id,
    h.start_date,
    h.end_date,
    j.job_title
FROM
         hr.employees e
    INNER JOIN hr.job_history h ON e.employee_id = h.employee_id
    LEFT JOIN hr.jobs        j ON h.job_id = j.job_id
WHERE
    e.employee_id = 101;








--Modify query 

WITH emp AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        salary,
        ( 1.155 * salary ) AS newsalary
    FROM
        employees
), femp AS (
    SELECT
        emp.*,
        ( newsalary * 1.20 ) AS futuresalary
    FROM
        emp
)
SELECT
    *
FROM
    femp,
    emp
WHERE
    femp.employee_id = emp.employee_id;



-- Group By
SELECT
    *
FROM
    employees;
-- requirement - department total salary
SELECT
    department_id,
    SUM(salary) AS totalsalary
FROM
    employees
GROUP BY
    department_id
ORDER BY
    1;



-- Having sum
SELECT
    *
FROM
    employees;
-- requirement - department total salary
SELECT
    department_id,
    SUM(salary) AS totalsalary
FROM
    employees
GROUP BY
    department_id
HAVING
    SUM(salary) > 7000
ORDER BY
    1;

--count
WITH tb1 AS (
    SELECT
        department_id
    FROM
        employees
)
SELECT
    department_id,
    COUNT(1)
FROM
    tb1
GROUP BY
    department_id
ORDER BY
    2 DESC;


-- Hierarchy level query 
WITH a AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        manager_id,
        level AS hlevel
    FROM
        employees
--start with manager_id is null
    CONNECT BY
        PRIOR employee_id = manager_id
)
SELECT
    *
FROM
    a
ORDER BY
    hlevel;
    

-- 4. a> Create a report that produces the following for each employee:
        --<employee last name> earns <salary> monthly but wants <3 times salary>
        --Label the column Dream Salaries. (Hint: Use Concatenation) 

SELECT
    last_name || ' Earns ' || salary || ' But Wants ' || salary*3 as "Dream Salaries"
FROM
    employees;
    

-- 5. a) Find the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum and Average respectively. Round your results to the nearest whole number.

SELECT
    MIN(salary) as "Minimum",
    MAX(salary) as "Maximum",
    SUM(salary) as "Sum",
    ROUND(AVG(salary)) as "Average"
FROM
    employees;
    

-- 6. 

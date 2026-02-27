-- Topics: SELECT, WHERE, DISTINCT, ORDER BY, LIMIT
use practice;

select * from employee;

update employee set email = "vikas@gmail.com" where empid = 103;

-- ✅ Option 1: Update using each employee’s name (or id)
update employee 
SET email = CASE
when empid = 102 THEN 'anita@gmail.com'
when empid = 104 THEN 'siya@gmail.com'
when empid = 105 THEN 'ani@gmail.com'
when empid = 106 THEN 'prakash@gmail.com'
END
Where empid IN(102,104,105,106);

-- ✅ Option 2: Auto-generate email from name
update employee set email = Lower(ename) || "@gmail.com" where departid = 2;

-- ️✅ Salary greater than 50,000
select ename from employee where salary > 40000;

-- ✅ Employees from Bangalore with salary > 60,000

alter table employee add column city varchar(20);

update employee set city = CASE 
WHEN empid = 101 Then 'Bangalore'
when empid = 102 Then 'Hyderabaad'
when empid = 103 Then 'Betul'
when empid = 104 Then 'Gujrat'
when empid = 105 Then 'Mumbai'
when empid = 106 Then 'Delhi'
END 
where empid in (101,102,103,104,105,106);

select * from employee where city = 'Bangalore' AND salary > 30000;

-- Unique departments

select distinct departid from employee;

-- Unique cities in IT department

select distinct city from employee where departid = 1;

-- Sort employees by salary (low → high) & (high to low)
select ename, salary from employee order by salary ASC;
select ename, salary from employee order by salary DESC;

-- Sort by department, then salary (high → low)
select ename, salary, department from employee order by department ASC, salary DESC;

-- Top 5 employees
select * from employee limit 5;

-- Top 3 highest-paid employees
select ename, salary from employee order by salary DESC limit 3;

-- Top 5 highest-paid IT employees
select ename, salary, department from employee where department = 'IT'
order by salary desc
limit 5;

select * from employee;

-- First 10 employees who joined earliest
select ename,hire_date from employee order by hire_date DESC limit 10;

-- Top 3 unique cities by highest salary

select distinct ename, city, salary from employee order by salary desc limit 3;

-- Highest-paid employee in Bangalore

select ename, city, salary 
from employee 
where city = 'Bangalore' 
order by salary desc limit 1;

-- Second highest salary (simple approach)

select distinct salary from employee 
order by salary desc
limit 1 offset 1;

-- Latest 5 joined employees from IT

select ename, hire_date from employee where department = 'IT'
order by hire_date desc limit 5;

-- Top 3 salaries excluding HR department

select ename, salary from employee where department != 'HR'
order by salary desc
limit 3;

-- Find employees with same city (using DISTINCT + ORDER BY)

select distinct ename, city from employee order by city asc;








-- 1 Find the 3 highest-paid employees from IT department.

select ename, salary from employee where department = 'IT'
order by salary desc limit 3;

-- 2. Find the 2nd highest salary in the company.
select distinct salary from employee order by salary desc limit 1 offset 1;

-- 3. Find the latest 5 employees who joined from Bangalore.

select ename, city from employee where city = 'Bangalore' order by hire_date desc limit 5;

-- 4. Find unique cities where HR employees work, sorted alphabetically.

SELECT DISTINCT city
FROM employee
WHERE department = 'HR'
ORDER BY city ASC;

-- 5. Highest-paid excluding Sales

select ename, salary from employee where department != 'Sales' order by salary desc limit 1;

-- 6. Top 3 distinct salaries

select distinct salary, ename from employee order by salary desc limit 3;

-- 7. Earliest joined employee per department (simple approach per dept)

select ename, department, hire_date from employee order by department asc, hire_date asc;
-- 8. Most recently joined employee

select ename, hire_date from employee order by hire_date desc limit 5;

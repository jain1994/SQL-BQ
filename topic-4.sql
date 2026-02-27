-- 1️⃣ Employees with salary above company average
select empid, ename, salary from employee  where salary > (select avg(salary) from employee);

-- 2️⃣ Employees in departments that have more than 5 employees

select empid, ename, department from employee where department in 
(select department from employee group by department having count(*)>5);

-- Employees working in departments with high total salary cost

select empid, ename, department from employee where department in (select department from employee group by department having sum(salary)>60000);

-- 1️⃣ Employees who earn the maximum salary in the company

select ename, salary from employee where salary = (select max(salary) from employee);

-- 2️⃣ Employees who earn less than the company average
select ename, salary from employee where salary < (select avg(salary) from employee);

-- Employees from cities where average salary > 50,000
select ename, empid, salary from employee where city in (select city from employee group by city having avg(salary)>50000);

-- Employees who work in departments that have at least one employee with salary > 80,000

select empid, ename, salary from employee where department in (select distinct department from employee where salary> 800000);

-- Employees hired earlier than the average hire date
select empid, ename, hire_date from employee where hire_date < (select avg(hire_date) from employee);

-- Department-wise salary summary, then filter
select department, total_salary from 
(select department, sum(salary) as Total_Salary from employee group by department) t 
where total_salary > 50000;

-- 7️⃣ City-wise highest salary, then sort
select city, max_salary from 
(select city, max(salary) As Max_salary from employee group by city) t
order by max_salary desc;

-- Count employees per department, show only top 3 departments
select department, Emp_Count from 
(select department, count(*) as Emp_Count from employee group by department) t
order by emp_count desc limit 3;

select ename from employee e where exists (select 1 from employee where department = e.department AND salary > 80000);select ename from employee e where exists (select 1 from employee where department = e.department AND salary > 80000);
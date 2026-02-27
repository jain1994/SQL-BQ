-- Topics: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, SELF JOIN 

show tables;

update department set location = CASE
When departid = 1 THEN 'Mumbai'
When departid = 2 THEN 'Bangalore'
When departid = 3 THEN 'Hyderabaad'
When departid = 4 THEN 'Betul'
When departid = 5 THEN 'Hyderabaad'
When departid = 6 THEN 'Mumbai'
END
where departid IN( 1,2,3,4,5,6);

select * from department;
select * from employee;

-- 1️⃣ Employee with department name
select e.empid, e.ename, d.depname from employee e inner join department d ON e.departid = d.departid;

-- IT employees with their department name
select e.empid, e.ename, d.location, d.depname from employee e inner join department d ON e.departid = d.departid where d.depname ='IT';

-- All employees + department (NULL if missing)
update department set depname = 'NULL' where departid = 1;
select e.ename, e.salary, d.depname, d.location from employee e left join department d ON e.departid = d.departid;

select departid, count(*)
from employee 
group by departid
having count(*)> 1;

-- 4️⃣ Employees who don’t have a department mapping

select e.ename, d.depname from employee e left join department d on e.departid = d.departid where d.departid is not null;
select e.ename, d.depname from employee e left join department d on e.departid = d.departid where d.depname is null;

-- 5️⃣ All departments + employees (if any)
select d.depname, d.departid, e.ename, e.empid from employee e right join department d on e.departid = d.departid;

-- Departments with no employees
select e.ename, d.depname from employee e right join department d on e.departid = d.departid where e.empid is null;

select e.ename, d.depname from employee e right join department d on e.departid = d.departid where e.empid is null;

select e.empid, e.ename, d.depname from employee e left join department d on e.departid = d.departid 
union 
select e.empid, e.ename, d.depname from employee e right join department d on e.departid = d.departid;

select * from employee_1;

use practice;

select e.emp_id, 
e.name AS Employee_name,
m.name AS Manager_name,
e.salary AS Employee_Salary,
m.salary AS Manager_Salary from employee_1 e join employee_1 m on e.emp_id = m.manager_id where e.salary > m.salary;

-- 7️⃣ Employee with manager name
select e.name AS Employee_name, m.name AS Manager_name from employee_1 e left join employee_1 m on e.emp_id = m.manager_id;

-- 8️⃣ Employees without managers
select e.name AS Employee_name, m.name AS Manager_name from employee_1 e left join employee_1 m on e.emp_id = m.manager_id where m.emp_id is null;


-- 9️⃣ Highest salary in each department (join + sort)

select e.empid, e.ename, d.depname, e.salary from employee e inner join department d on e.departid = d.departid 
order by d.depname, e.salary desc;

-- 🔟 Count employees per department (include empty depts)

select d.depname, count(e.empid) as Emp_Count  
from department d left join employee e
on d.departid = e.departid 
group by d.depname 
order by Emp_Count desc;

-- Count employees per department
select depname, count(*) from department group by depname;

-- Total salary per department
select department, sum(salary) As Department_Salary from employee group by department;

-- Average salary per city

select city, avg(salary) from employee group by city;

-- 4️⃣ Highest salary per department
select department, max(salary) from employee group by department;

-- Department-wise count for IT only

select department, count(*) as Emp_Count from employee where department = 'IT' Group by department;

select department, count(*) as Emp_Count from employee group by department having count(*)> 2;

-- 🧩 Q1️⃣ Find departments having more than 5 employees
select department, count(*) as Emp_Count from employee group by department having count(*)>5;

-- Find average salary per city, but only for cities with avg salary > 50,000
select city, avg(salary) As Avg_Salary from employee group by city having avg(salary)>50000;

-- Find department-wise total salary, excluding HR employees
select department, sum(salary) Total_Salary from employee where department !='HR' group by department;

-- Find the highest-paid employee in each department
select ename, salary from employee order by salary desc limit 1;
select department, max(salary) from employee group by department;

-- Count employees per city for only IT department

select city, count(*) from employee where department = 'IT' group by city;

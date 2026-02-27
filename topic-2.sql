-- Topics: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING, LIKE, IN, BETWEEN, CASE  
-- 1 LOWER / UPPER (text functions)
select ename, lower(ename) as Employee_Name, upper(ename) as Employee_Name from employee;

-- 2. LENGTH (string length)
select ename, length(ename) from employee;

-- 3. Concat String
select ename, concat(ename, ' - ' ,department) as emp_info from employee;

-- 4. Find employees whose name starts with 'A'
select ename from employee where ename like 'A%';
select ename from employee where ename like '%A';

-- 5. Find employees whose email ends with gmail.com
select ename from employee where email like '%@gmail.com';

-- 6. Case-insensitive search for city = bangalore
select city from employee where Upper(city) = 'bangalore';

-- 7. Employees who joined after 2022
select ename from employee where hire_date > '2022-03-20';

-- 8 Employees who joined in 2024
select ename, hire_date from employee where YEAR(hire_date) = '2025';

-- 9. Employees who joined in last 30 days
select ename, hire_date from employee where hire_date >= Date_sub(curdate(), interval 1 year);

-- 10 Round salaries
select ename, Round(salary) as Round_Salary from employee;

-- 11 Employees with salary between 40k and 60k
select ename, salary from employee where salary between 50000 AND 80000;

-- 12. Employees with salary > average salary
select ename, salary from employee where salary > (select avg(salary) from employee);

-- 13 Find employees with NULL email
select ename, email from employee where email is null;

-- 14. Replace NULL city with 'Unknown'
select ename, IFNULL(city, 'Betul') as Employee_city from employee;

-- 15. Employees whose name contains 'an'
select ename from employee where ename like '%an%';

-- 16. Employees from Bangalore or Hyderabad with salary > 50k
select ename from employee where city IN('Bangalore','Hyderabaad') AND salary > 30000;

-- 17 Top 5 highest-paid employees whose email is gmail
select ename, salary, email from employee where email like '%gmail%' order by salary desc limit 5;
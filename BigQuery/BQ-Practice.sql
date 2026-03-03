-- 1. Select all columns from employee table.
select * from `Sales_Dataset.Employee`;

-- 2. Select only empid and ename.
select empid,ename from `Sales_Dataset.employee`;

-- 3. Get employees from Bangalore.
select * from `Sales_Dataset.employee` where City = 'Bangalore';

-- 4. Get employees with salary > 50000.
select * from `Sales_Dataset.employee` where salary > 50000;

-- 5. Get employees hired after 2022-01-01.
select * from `Sales_Dataset.employee` where hire_date > '2022-01-01';

-- 6. Get employees with NULL Manager_ID.
select * from `Sales_Dataset.employee` where manager_id is null;

-- 7. Get employees with salary between 30000 and 60000.
select * from `Sales_Dataset.employee` where salary between 30000 AND 60000;

-- 8. Get employees whose name starts with 'A'.
select * from `Sales_Dataset.employee` where ename like'A%';

-- 9. Get employees whose email contains 'gmail'.
select * from `Sales_Dataset.employee` where email like'%gmail%';

-- 10. Limit output to top 5 rows.
select * from `Sales_Dataset.employee` limit 5;


-- 11. Sort employees by salary descending.
select * from `Sales_Dataset.employee` order by salary asc;

-- 12. Sort by department then salary.
select * from `Sales_Dataset.employee` order by depart_id, salary desc;

-- 13. Get top 3 highest-paid employees.
select * from `Sales_Dataset.employee` order by salary desc limit 3;

-- 14. Get 2nd highest salary.
select * from `Sales_Dataset.employee` order by salary desc limit 1 offset 1;

-- 15. Count total employees.
select count(*) from `Sales_Dataset.employee`;

-- 16. Count employees per city.
select city, count(*) As Total from `Sales_Dataset.employee` group by city;


-- 17. Get distinct cities.
select distinct city from `Sales_Dataset.employee`;


-- 18. Get distinct department IDs.
select distinct depart_id from `Sales_Dataset.employee`


-- 19. Get employees not in department 2.
select ename from `Sales_Dataset.employee` where depart_id !=2;


-- 20. Get total salary.
select sum(salary) from `Sales_Dataset.employee`;


-- 21. Get average salary.
select avg(salary) from `Sales_Dataset.employee`;

-- 22. Get max salary.
select max(salary) from `Sales_Dataset.employee`;

-- 23. Get min salary.
select min(salary) from `Sales_Dataset.employee`;

-- 24. Get average salary per department.
select depart_id, avg(salary) from `Sales_Dataset.employee` group by depart_id;

-- 25. Get highest salary per department.
select depart_id, max(salary) from `Sales_Dataset.employee` group by depart_id; 

-- 26. Get city with highest avg salary.
select city, avg(salary) as Avg_Salary from `Sales_Dataset.employee` group by city order by Avg_salary desc limit 1;

-- 27. Count employees per department.
select d.department_name, count(*) from `Sales_Dataset.employee` e JOIN `Sales_Dataset.department` d ON e.depart_id = d.depart_id group by department_name;

select depart_id, count(*) from `Sales_Dataset.employee` group by depart_id;

-- 28. Get departments having more than 3 employees.
select depart_id, count(*) from `Sales_Dataset.employee` group by depart_id having count(*)>3;

-- 29. Get departments with avg salary > 50000.
select depart_id, avg(salary) from `Sales_Dataset.employee` group by depart_id having avg(salary) > 50000; 

-- 30. Get total salary per city.
select city, sum(salary) from `Sales_Dataset.employee` group by city;

-- 31. Get city with maximum employees.
select city, count(*) as Total_Employee from `Sales_Dataset.employee` group by city order by Total_Employee desc limit 1;

-- 32. Get salary variance per department.
select depart_id, variance(Salary) as Total_Salary from `Sales_Dataset.employee` group by depart_id;

-- 33. Get total salary for last 2 years.
select sum(salary) as Total_Salary from `Sales_Dataset.employee` where hire_date >= date_sub(current_date(), INTERVAL 1 year);

-- 34. Get employees grouped by hire year.
select extract(YEAR FROM hire_date) AS Hire_Year, 
count(*) as total_employee 
from `Sales_Dataset.employee`
Group by Hire_Year
order by hire_Year;


-- 35. Inner join employee & department.
select e.empid, e.ename, e.salary, d.department_name from `Sales_Dataset.employee` e JOIN `Sales_Dataset.department` d ON e.depart_id = d.depart_id;


-- 36. Left join employee & department.
select e.empid, e.ename, e.salary, d.department_name from `Sales_Dataset.employee` e Left JOIN `Sales_Dataset.department` d ON e.depart_id = d.depart_id;

-- 37. Right join employee & department.
select e.empid, e.ename, e.salary, d.department_name from `Sales_Dataset.employee` e RIGHT JOIN `Sales_Dataset.department` d ON e.depart_id = d.depart_id;

-- 38. Full join employee & department.
select e.empid, e.ename, e.salary, d.department_name from `Sales_Dataset.employee` e FULL JOIN `Sales_Dataset.department` d ON e.depart_id = d.depart_id;

-- 39. Self join to get employee-manager details.
select e.emp_id,
e.name as Employee_Name,
m.name as Manager_Name
from `Sales_Dataset.Manager` e JOIN  `Sales_Dataset.Manager` m on e.emp_id = m.manager_id;

-- 40. Get employees earning more than their manager.
select e.emp_id,
e.name As Employee_Name,
m.name As Manager_Name,
e.salary As Employee_Salary,
m.salary As Manager_Salary
from `Sales_Dataset.Manager` e JOIN `Sales_Dataset.Manager` m on e.emp_id = m.manager_id 
Where e.salary > m.salary;

-- 41. Get employees whose manager earns less.
select 
e.name AS Employee_Name,
m.name As Manager_Name,
FROM
`Sales_Dataset.Manager` e Left join `Sales_Dataset.Manager` m ON e.emp_id = m.manager_id Where m.salary < e.salary;

-- 42. Get employees without manager.
select * from `Sales_Dataset.Manager` where manager_id is null;
--  OR
SELECT e.*
FROM `Sales_Dataset.Manager` e
LEFT JOIN `Sales_Dataset.Manager` m
ON e.manager_id = m.emp_id
WHERE m.emp_id IS NULL;


-- 43. Get departments without employees.
select d.* from `Sales_Dataset.employee` e JOIN  `Sales_Dataset.department` d ON e.depart_id = d.depart_id where e.empid is null;


-- 44. Join employee with city summary table. (HOLD)
SELECT e.empid,
       e.ename,
       e.city,
       c.total_employees
FROM `Sales_Dataset.employee` e
JOIN `Sales_Dataset.city_summary` c
ON e.city = c.city;


44. Join using SAFE_CAST for datatype mismatch.
select e.empid, e.ename, d.department_name, e.salary
FROM `Sales_Dataset.employee` e 
JOIN 
`Sales_Dataset.department` d
ON SAFE_CAST(e.depart_id as int64)= d.depart_id;


-- 45. Join using multiple columns.
select * 
FROM
`Sales_Dataset.employee` e JOIN `Sales_Dataset.Manager` d 
ON e.depart_id = d.depart_id 
AND SAFE_CAST(e.Manager_ID as Int64) = d.manager_id;


-- 46. Join and filter on aggregate.
Select d.department_name, count(e.empid)
FROM
`Sales_Dataset.employee` e JOIN `Sales_Dataset.department` d 
ON d.depart_id = e.depart_id
Group By d.department_name
Having count(e.empid) > 5;

-- 47. Join 3 tables.
select
e.ename,
d.department_name,
c.Total_Salary
FROM
`Sales_Dataset.employee` e JOIN `Sales_Dataset.department` d 
ON e.depart_id = d.depart_id
JOIN 
`Sales_Dataset.city_summary` c
ON
e.City = c.City;

-- 48. Get department name with highest salary employee.
select d.department_name, e.ename, e.salary 
from `Sales_Dataset.employee` e JOIN `Sales_Dataset.department` d 
on e.depart_id = d.depart_id 
order by salary desc limit 1;

-- 50. Assign row number by salary.
select *, 
ROW_NUMBER() OVER (order by salary) as rn FROM `Sales_Dataset.employee`;

-- 51. Rank employees by salary.
select *, RANK() OVER (order by salary) as rn 
FROM `Sales_Dataset.employee`;

-- 52. Dense rank employees.
select *, DENSE_RANK() OVER (order by salary) as rn
FROM `Sales_Dataset.employee`;

-- 53. Get top 3 employees per department.
select * FROM (
select e.empid, e.ename,d.department_name,e.salary, ROW_NUMBER() OVER (partition by d.department_name order by salary desc) as rn 
FROM 
`Sales_Dataset.employee` e 
JOIN
`Sales_Dataset.department` d
ON
e.depart_id = d.depart_id
)
Where rn <= 3;
-- 54. Get second highest salary per department.
select * FROM(
select *, DENSE_RANK() OVER (partition by depart_id order by salary desc) as rnk FROM `Sales_Dataset.employee`
)
where rnk = 2;


-- 55. Get cumulative salary by department.
select *, sum(salary) OVER (partition by depart_id order by salary) as cumulative_salary FROM `Sales_Dataset.employee`;

-- 56. Get running total salary.
select *, sum(salary) OVER (order by salary) as total_salary FROM `Sales_Dataset.employee`;

-- 57. Get lag salary.
select *, lag(salary) OVER (order by salary) as Previous_Salary FROM `Sales_Dataset.employee`;

-- 58. Get lead salary.
select *, lead(salary) OVER (order by salary) as Next_Salary FROM `Sales_Dataset.employee`;

-- 59. Compare salary difference from previous employee.
select *, salary - lag(salary) OVER (order by salary) as Diff_Salary FROM `Sales_Dataset.employee`;

-- 60. Get first hire per department.
select * FROM (
select e.*, ROW_NUMBER() OVER (partition by d.department_name order by e.hire_date asc) as rn
FROM `Sales_Dataset.employee` e
JOIN `Sales_Dataset.department` d
ON
e.depart_id = d.depart_id
) 
Where rn = 1;

-- 61. Get last hire per department.
select * from (
select e.*, ROW_NUMBER() OVER (partition by d.department_name order by e.hire_date desc) as rn 
FROM `Sales_Dataset.employee` e
JOIN `Sales_Dataset.department` d
ON e.depart_id = d.depart_id
)
where rn = 1;

-- 62. Percent rank employees.
select *, percent_rank() OVER (order by salary) as percent_rank FROM `Sales_Dataset.employee`;

-- 63. NTILE(4) salary quartiles.
select *, ntile(4) OVER (order by salary desc) as ntitle FROM `Sales_Dataset.employee`;

-- 64. Get employees above department average salary.
select * FROM (
  select *, Avg(Salary) OVER (partition by depart_id) as dept_avg FROM `Sales_Dataset.employee`
)
Where salary > dept_avg;


-- 65. Get employees earning above average salary.
select * from `Sales_Dataset.employee` where salary > (select avg(salary) from `Sales_Dataset.employee`);

-- 66. Get employees earning below department average.
select * from `Sales_Dataset.employee` where salary < (select avg(salary) from `Sales_Dataset.employee` where depart_id = depart_id);

-- 67. Get employees in department with highest total salary.
select * from `Sales_Dataset.employee` where depart_id = (select depart_id FROM(
select depart_id, sum(salary) as Total_Salary from `Sales_Dataset.employee` group by depart_id order by Total_Salary desc limit 1
)
);

-- 68. Get employees hired after max hire date in dept 1.
select * from `Sales_Dataset.employee` where hire_date > (select max(hire_date) from `Sales_Dataset.employee` where depart_id = 2);

-- 69. Get employees whose salary equals max salary.
select * from `Sales_Dataset.employee` where salary = (select max(salary) from `Sales_Dataset.employee`);

-- 70. Get employees not in manager list.
select * from `Sales_Dataset.Manager` where emp_id not in (select distinct manager_id from `Sales_Dataset.Manager` where manager_id is not null);

-- 71. Get departments with no managers.
select * from `Sales_Dataset.employee` Where Manager_ID is null;


-- 72. Extract year from hire_date.
select extract(YEAR FROM hire_date) As Extract_Year FROM `Sales_Dataset.employee`;

-- 73. Extract month.
select extract(Month FROM hire_date) As Extract_Month FROM `Sales_Dataset.employee`;

-- 74. Get employees hired in 2023.
SELECT *
FROM `Sales_Dataset.employee`
WHERE EXTRACT(YEAR FROM hire_date) = 2023;

-- 75. Calculate years of experience.
Select empid, EXTRACT(YEAR FROM current_date) - extract(YEAR FROM hire_date) as emp_total_exprience FROM `Sales_Dataset.employee`; 

select empid, Date_Diff(current_Date,hire_date, YEAR) as Year_of_Expereince FROM `Sales_Dataset.employee`;

-- 76. Get employees hired last 6 months.
select * from `Sales_Dataset.employee` where hire_date >= date_sub(current_date, interval 6 month);

-- 77. Get employees hired this year.
select * from `Sales_Dataset.employee` where Extract(Year FROM hire_date) = extract(Year FROM CURRENT_Date);

-- 78. Difference between hire_date and today.
SELECT empid,
       DATE_DIFF(CURRENT_DATE, hire_date, DAY) AS days_worked
FROM `Sales_Dataset.employee`;

-- 79. Group by hire year.
select extract(YEAR FROM Hire_Date) As Hire_Year, count(*) AS Total_Employee FROM `Sales_Dataset.employee`
group by Hire_Year order by Hire_Year;

-- 80. Format date.
select empid, FORMAT_DATE('%d-%m-%y', hire_date) FROM `Sales_Dataset.employee`;

-- 81. Get last day of month from hire_date.
select empid, LAST_DAY(hire_date) FROM `Sales_Dataset.employee`;

-- 82. Uppercase names.
select empid, upper(ename) FROM `Sales_Dataset.employee`;

-- 83. Lowercase emails.
select empid, lower(email) FROM `Sales_Dataset.employee`;

-- 84. Get first 3 characters of name.
select empid, substr(ename, 1, 3) FROM `Sales_Dataset.employee`;

-- 85. Replace 'M' in Manager_ID.
select empid, Manager_ID,replace(Manager_ID, 'C','1') FROM `Sales_Dataset.employee`;

-- 86. Trim spaces.
select empid, ename, ltrim(ename) as Trim_Name from `Sales_Dataset.employee`;

-- 87. Get length of name.
select empid, ename, length(ename) FROM `Sales_Dataset.employee`;

-- 88. Concatenate name + city.
select empid, concat(ename,' ', city) As Employee_City from `Sales_Dataset.employee`;


-- 89. Create partitioned table.
Create or Replace Table `Sales_Dataset.employee_p` (
order_id Int64,
customer_id int64,
order_date Date,
amount Float64
)
partition by order_date;

-- 90. Create clustered table.
Create or Replace Table `Sales_Dataset.employee_c` (
order_id Int64,
customer_id int64,
order_date Date,
amount Float64
)
partition by order_date
cluster by customer_id;


-- 91. Use SAFE_CAST.
select safe_cast('123' as int64) as vaild_number,
safe_cast('abc' as int64) as invaild_number;

-- 92. Create external table from GCS.
create external table `Sales_Dataset.external_sales` 
Options(
format = 'csv',
uris = ['gs://demo-data-flow/employee_500_records.csv'],
skip_leading_rows = 1
);

select * from `Sales_Dataset.external_sales`;

-- 93. Use STRUCT datatype.
select struct('Bhavna' as name, 123 as Age);

-- 94. Flatten nested JSON.
{
"name": 'Bhavna'
"skills" : ['SQL','GCP']
}
select name, skill FROM `Sales_Dataset.employee_c`, unnest(skills) as skill;


-- 95. Optimize query using partition filter.
select * from `Sales_Dataset.employee` where hire_date between '2024-01-01' AND '2024-01-31';

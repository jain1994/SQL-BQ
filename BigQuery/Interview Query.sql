
-- Tech Mahindera Intervew Questions
-- 1. Join the tables and tell me the total count of the rows

Create OR replace Table `Sales_Dataset.Table_1` (
   Id int64,
   Name String
);

Create OR replace Table `Sales_Dataset.Table_2` (
   Id int64,
   Salary Int64
);

insert into `Sales_Dataset.Table_1` Values(101, 'A'),(101,'B'),(101,'C'),(101,'D'),(102,'E'),(102,'F'); 
insert into `Sales_Dataset.Table_2` Values(101, 100),(102,100),(101,200),(102,200),(102,300),(103,400);

select * from `Sales_Dataset.Table_1` t1 Inner Join `Sales_Dataset.Table_2` t2 on t1.Id = t2.Id;
select * from `Sales_Dataset.Table_1` t1 Left Join `Sales_Dataset.Table_2` t2 on t1.Id = t2.Id;
select * from `Sales_Dataset.Table_1` t1 Right Join `Sales_Dataset.Table_2` t2 on t1.Id = t2.Id;
select * from `Sales_Dataset.Table_1` t1 Full Outer Join `Sales_Dataset.Table_2` t2 on t1.Id = t2.Id;


-- 1. Here id's are duplicate so result will be 14 records in inner join as both the table comman data will come
-- 2. Here id's are duplicate so result will be 14 records in left join
-- 3. Here id's are duplicate but one id is diff so right table will show 15 records and name and id will be null as that is not there in left table 
-- 2. Here id's are duplicate so result will be 15 records in full outer join as it will take all the data from both the tables.

-- 2. Find the employee who has highest salary and working in org more than 2 years?

SELECT e.empid, e.ename, e.salary, e.hire_date, d.department_name 
FROM `Sales_Dataset.employee` e
JOIN `Sales_Dataset.department` d
ON e.depart_id = d.depart_id 
Where salary = (select max(salary) from `Sales_Dataset.employee`) AND hire_date <= date_sub(current_date(), INTERVAL 2 Year) limit 1;

Select empid, ename, salary from `Sales_Dataset.employee` where hire_date <= date_sub(current_date(), INTERVAL 2 year) order by salary desc limit 1;


-- Cabgamini Interview Questions
-- 1. Fine the emp where salary is greater than his manager 

Create OR replace Table `Sales_Dataset.Manager` (
   emp_id int64,
   Name String,
   Sal Int64,
   manager_id int64
);

insert into `Sales_Dataset.Manager` 
values(1,'Alice',900000,Null), 
(2,'Bob',85000,1),
(3,'Charlie',950000,1),
(4,'David',880000,2),
(5,'Eve',87000,2);

select e.name As Employee_Name,
m.name As Manager_Name,
e.salary As Employee_Salary,
m.salary As Manager_Salary 
FROM `Sales_Dataset.Manager` e JOIN `Sales_Dataset.Manager` m
ON e.emp_id = m.manager_id 
Where e.salary > m.salary;

-- 2. Show the Manager hirerarchu(Who reporting whome)

select e.emp_id, 
e.name As Employee_Name,
m.name As Manager_name
FROM `Sales_Dataset.Manager` e LEFT JOIN `Sales_Dataset.Manager` m
ON e.emp_id = m.manager_id;

select e.emp_id, 
e.name As Employee_Name,
m.name As Manager_name
FROM `Sales_Dataset.Manager` e LEFT JOIN `Sales_Dataset.Manager` m
ON m.manager_id = e.emp_id;

-- HCL SQL Question

-- 1. How to remove duplicate from BQ

Create or Replace Table `Sales_Dataset.Employee_2` As
Select distinct * from `Sales_Dataset.employee`;

Create or Replace Table `Sales_Dataset.Employee_3` As
Select * except(rn)
FROM
(
  Select *, row_number() over (partition by empid order by empid) as rn From `Sales_Dataset.employee`
)
Where rn = 1;

Select * from `Sales_Dataset.Employee_3`;

-- 2. Apply inner join for below tables & tell the result

Create OR replace Table `Sales_Dataset.Table1` (
   Id int64,
   Name String
);

Create OR replace Table `Sales_Dataset.Table2` (
   Id int64,
   Name String
);

insert into `Sales_Dataset.Table1` values(1,'a'),(2,'b'),(Null,'c');
insert into `Sales_Dataset.Table2` values(1,'a'),(Null,'c');

select * from `Sales_Dataset.Table1` t1 INNER JOIN `Sales_Dataset.Table2` t2 ON t1.Id = t2.Id;

-- 3. Write the query to find the employee with top 3 salary in each department?

select * FROM (

select e.ename,e.salary,d.department_name, row_number() OVER (Partition by d.department_name order by e.salary desc) as rn FROM 
`Sales_Dataset.employee` e 
JOIN
`Sales_Dataset.department` d
ON e.depart_id = d.depart_id

)
where rn <=3;
 

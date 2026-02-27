Create or Replace Table `Sales_Dataset.Table1` (
Id int64,
Name String

);

Create or Replace Table `Sales_Dataset.Table2` (
Id int64,
Name String

);

insert into `Sales_Dataset.Table1` values(1,'a'),(4,'b'),(null,'c');

insert into `Sales_Dataset.Table2` values(1,'a'),(null,'c');


select * from `Sales_Dataset.Table1`;
select * from `Sales_Dataset.Table2`;


select t1.id, t1.name, t2.id, t2.name from `Sales_Dataset.Table1` t1 inner join `Sales_Dataset.Table2` t2 on t1.Id = t2.Id;


select t1.id, t1.name, t2.id, t2.name from `Sales_Dataset.Table1` t1 left join `Sales_Dataset.Table2` t2 on t1.Id = t2.Id;

select t1.id, t1.name, t2.id, t2.name from `Sales_Dataset.Table1` t1 right join `Sales_Dataset.Table2` t2 on t1.Id = t2.Id;

select t1.id, t1.name, t2.id, t2.name from `Sales_Dataset.Table1` t1 full outer join `Sales_Dataset.Table2` t2 on t1.Id = t2.Id;

select * from `Sales_Dataset.Table1` where id is null;


Create or Replace Table `Sales_Dataset.Tabl3` As select distinct * from `Sales_Dataset.Table1`;

select * from `Sales_Dataset.Table3`;
Alter Table `Sales_Dataset.Tabl3` rename TO `Table3`;


-- Find the duplicate 
select empid, count(*) As Count_Dup 
from `Sales_Dataset.employee`group by empid having count(*) > 1;


-- Create Internal Table by using External Table
Create or Replace Table `ha-demo-486408.Sales_Dataset.employee` As
select * from `ha-demo-486408.Sales_Dataset.Employee`;

Create or Replace Table `ha-demo-486408.Sales_Dataset.department` As
select * from `ha-demo-486408.Sales_Dataset.Department`;

Create or Replace Table `ha-demo-486408.Sales_Dataset.Table5` As
select * FROM (
  select *, ROW_NUMBER() Over (partition by empid order by empid desc) as rn from `ha-demo-486408.Sales_Dataset.employee`

) where rn > 1;

select * from `ha-demo-486408.Sales_Dataset.Table5`;

select * from (
select empid, salary, row_number() over (partition by department order by salary desc) as rn from `ha-demo-486408.Sales_Dataset.employee`
);

-- top 3 salary for each department

select empid, ename, salary, department_name
FROM (
      select 
      e.empid,
      e.ename,
      e.salary,
      d.department_name,
      ROW_NUMBER() OVER
      (partition by d.department_name 
      order by salary desc) 
      as rn 
      from `Sales_Dataset.employee` e
      join
      `Sales_Dataset.department`  d
      ON
      e.depart_id = d.depart_id
)
where rn <= 3;





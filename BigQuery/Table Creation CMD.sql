Create OR Replace Table `Sales_Dataset.Employee` 
(
empid int64,
ename String,
depart_id Int64,
Salary Int64,
Email String,
Date Date,
Hire_Date Date,
City String,
Manager_ID String
);

Create or replace table `Sales_Dataset.Department` (
depart_id int64,
department_name String
);

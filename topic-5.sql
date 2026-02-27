-- Topics: ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, PARTITION BY    

-- Rank employees by salary within each department

SELECT *
FROM (
  SELECT 
    empid, ename, department, salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
  FROM employee
) t
WHERE rn = 1;

-- 2️⃣ Rank employees by salary within department (ties get same rank)
select empid,ename, department, salary, 
rank() over (partition by department order by salary desc) as rnk from employee;

-- Dense rank by salary within department
select empid, ename, department, salary, dense_rank() over (partition by department order by salary desc) as d_rank from employee ;

-- Compare each employee’s salary with previous employee in same department
select empid, ename, department, salary, 
lag(salary) over (partition by department order by salary desc) as Prv_Salary  from employee;

SELECT 
  empid, ename, department, salary,
  salary - LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS diff_from_prev
FROM employee;

-- Compare with next employee’s salary

select empid, ename, department, salary, 
Lead(Salary) over (partition by department order by salary desc) as Next_Salary from employee;

-- Find 2nd highest salary in each department

select empid, ename, salary, department from 
(
select empid,ename, department, salary, dense_rank() over (partition by department order by salary desc) as drank from employee 
)t
where drank = 2;


-- Top 3 highest-paid employees in each department 
select empid, ename, department, salary from (
select empid, ename, department, salary, row_number() over (partition by department order by salary desc) as rn from employee 
) t
where rn <=3;


-- 2nd highest salary in each department
select empid, ename, department, salary from (
select empid, ename, department, salary, dense_rank() over (partition by department order by salary desc) as dnrk from employee
) t
where dnrk = 2;

-- Rank employees by salary across whole company

select empid, ename, department, salary, Rank() over (order by salary desc) as company_rank  from employee;
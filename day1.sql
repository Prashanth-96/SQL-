select top 5 * from HumanResources.Employee
select top 5 * from [HumanResources].[Department]
select top 5 * from [HumanResources].[Shift]
select top 5 * from [HumanResources].[EmployeePayHistory]
select top 5 * from[HumanResources].[EmployeeDepartmentHistory]

/* 1.Average age of employees*/
select AVG(DATEDIFF("YYYY",BirthDate,GETDATE())) as Average_date from HumanResources.Employee 

/* 2. 10 Departments with maximum employees working the night shift */select * from [HumanResources].[Department]select  * from [HumanResources].[Shift]select * from[HumanResources].[EmployeeDepartmentHistory]select * from HumanResources.Employeeselect count(ShiftID) as number_of_employee,DepartmentID from [HumanResources].[EmployeeDepartmentHistory] where (DepartmentID between 1 and 10) and ShiftID=3 group by DepartmentID/*select [EmployeeDepartmentHistory].BusinessEntityID  ,DepartmentID,(ShiftID) from [HumanResources].[EmployeeDepartmentHistory] inner join HumanResources.Employee on HumanResources.EmployeeDepartmentHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID   where ((DepartmentID between 1 and 10) and ShiftID=3) *//*3.  10 departments with highest average salary for employees (also 
display avg employee salary) */

select  * from [HumanResources].[EmployeePayHistory]
select * from[HumanResources].[EmployeeDepartmentHistory]

select top 10 AVG(HumanResources.EmployeePayHistory.Rate) as Average,HumanResources.EmployeeDepartmentHistory.DepartmentID from HumanResources.EmployeePayHistory inner join HumanResources.EmployeeDepartmentHistory on (HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID) group by HumanResources.EmployeeDepartmentHistory.DepartmentID
 
/* 4. Sum total of all earnings of employees holding highest title 
across all departments */select  * from HumanResources.Employeeselect  * from [HumanResources].[EmployeePayHistory]select HumanResources.Employee.JobTitle,sum(HumanResources.EmployeePayHistory.Rate) as Total_amount from HumanResources.Employee inner join HumanResources.EmployeePayHistory on HumanResources.Employee.BusinessEntityID=HumanResources.EmployeePayHistory.BusinessEntityID group by HumanResources.Employee.JobTitle order by Total_amount desc/*5.Write a view to display Maximum Salary earned by the employee with the highest title in each of these 10 departments */select top 2  * from HumanResources.Employeeselect top 2  * from [HumanResources].[EmployeePayHistory]select top 2  * from [HumanResources].[Department]create view Highest_salary asselect top 10 HumanResources.Employee.LoginID,HumanResources.Employee.JobTitle,HumanResources.EmployeePayHistory.Rate from HumanResources.Employee inner joinHumanResources.EmployeePayHistory on HumanResources.Employee.BusinessEntityID=HumanResources.EmployeePayHistory.BusinessEntityID order by  HumanResources.EmployeePayHistory.Rate desc/* 6.Older high-title employee earns more than younger high-title 
employee. True or False? Write a view to justify */select HumanResources.Employee.BirthDate from HumanResources.Employee order by HumanResources.Employee.BirthDate asccreate view Elder_vs_Younger asselect  HumanResources.Employee.BirthDate,HumanResources.EmployeePayHistory.Rate from HumanResources.Employee inner join HumanResources.EmployeePayHistory on HumanResources.Employee.BusinessEntityID=HumanResources.Employee.BusinessEntityID order by HumanResources.Employee.BirthDate desc offset 1000 rows fetch first 80000 rows only;select * from Elder_vs_Younger/*YOUNGER EARNS MORE THAN ELDER*//* 7.Write a stored procedure - when BusinessEntityID is passed as an 
input: To display employee first name, age (in years), 'Department 
Code' (1st two and last two
letters of department name, all in CAPS) and salary */

/* STRING EXTRACTION PART */
select HumanResources.Department.Name from HumanResources.Department
select Upper(Substring(HumanResources.Department.Name,1,LEN(HumanResources.Department.Name)-8)) from HumanResources.Department
select upper((Substring(HumanResources.Department.Name,1,2)+SUBSTRING(HumanResources.Department.Name,LEN(HumanResources.Department.Name)-1,2))) from HumanResources.Department

select DATEDIFF("YYYY",HumanResources.Employee.BirthDate,GETDATE()) as Age,HumanResources.Employee.LoginID ,HumanResources.EmployeePayHistory.Rate,upper((Substring(HumanResources.Department.Name,1,2)+SUBSTRING(HumanResources.Department.Name,LEN(HumanResources.Department.Name)-1,2))) as Dept_Name  from HumanResources.Employee inner join HumanResources.EmployeeDepartmentHistory
on HumanResources.EmployeeDepartmentHistory.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
inner join HumanResources.EmployeePayHistory on HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
inner join HumanResources.Department on HumanResources.EmployeeDepartmentHistory.DepartmentID=HumanResources.Department.DepartmentID


/*stored procedure*/
create procedure UC7 @businessid int
as
select DATEDIFF("YYYY",HumanResources.Employee.BirthDate,GETDATE()) as Age,TRIM('adventure-works' from HumanResources.Employee.LoginID) as Name ,HumanResources.EmployeePayHistory.Rate,upper((Substring(HumanResources.Department.Name,1,2)+SUBSTRING(HumanResources.Department.Name,LEN(HumanResources.Department.Name)-1,2))) as Dept_Name  from HumanResources.Employee inner join HumanResources.EmployeeDepartmentHistory
on HumanResources.EmployeeDepartmentHistory.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
inner join HumanResources.EmployeePayHistory on HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID
inner join HumanResources.Department on HumanResources.EmployeeDepartmentHistory.DepartmentID=HumanResources.Department.DepartmentID
where HumanResources.EmployeeDepartmentHistory.BusinessEntityID=@businessid
go


exec UC7 @businessid = 10

/*8. To display employee first name, years worked for and total 
salary earned by an employee in
those years, assuming salary to be constant*/

select * from HumanResources.Employee
select * from HumanResources.EmployeePayHistory

select (HumanResources.Employee.LoginID),HumanResources.EmployeePayHistory.BusinessEntityID,(DateDIFF("YYYY",HumanResources.Employee.HireDate,GETDATE())) as Number_of_years ,HumanResources.EmployeePayHistory.Rate,(HumanResources.EmployeePayHistory.Rate*(DateDIFF("YYYY",HumanResources.Employee.HireDate,GETDATE()))) as Total_salary
from HumanResources.employee inner join HumanResources.EmployeePayHistory on ( HumanResources.Employee.BusinessEntityID=HumanResources.EmployeePayHistory.BusinessEntityID) 



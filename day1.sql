select top 5 * from HumanResources.Employee
select top 5 * from [HumanResources].[Department]
select top 5 * from [HumanResources].[Shift]
select top 5 * from [HumanResources].[EmployeePayHistory]
select top 5 * from[HumanResources].[EmployeeDepartmentHistory]

/* 1.Average age of employees*/
select AVG(DATEDIFF("YYYY",BirthDate,GETDATE())) as Average_date from HumanResources.Employee 

/* 2. 10 Departments with maximum employees working the night shift */
display avg employee salary) */

select  * from [HumanResources].[EmployeePayHistory]
select * from[HumanResources].[EmployeeDepartmentHistory]

select top 10 AVG(HumanResources.EmployeePayHistory.Rate) as Average,HumanResources.EmployeeDepartmentHistory.DepartmentID from HumanResources.EmployeePayHistory inner join HumanResources.EmployeeDepartmentHistory on (HumanResources.EmployeePayHistory.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID) group by HumanResources.EmployeeDepartmentHistory.DepartmentID
 
/* 4. Sum total of all earnings of employees holding highest title 
across all departments */
employee. True or False? Write a view to justify */
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


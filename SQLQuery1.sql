select * 
from HumanResources.Employee

-------------creation of view----------
create view vwDesignEng
as
Select BusinessEntityID,BirthDate,Gender,HireDate
from HumanResources.Employee		--underlying/ base table
where JobTitle='Design Engineer'


select * from vwDesignEng --------Display the record

---------------alter view---------------------
  alter view vwDesignEng  
as  
Select BusinessEntityID,BirthDate,Gender,HireDate,VacationHours 
from HumanResources.Employee  
where JobTitle='Design Engineer'

------------update-------------
update vwDesignEng
set VacationHours=20
where BusinessEntityID=6

------------update multicolumns--------
update HumanResources.Employee
set VacationHours=29,SickLeaveHours=30
where BusinessEntityID=5

-------------
create view vwEmployeeDepartment
as
select Name,d.ModifiedDate,edh.BusinessEntityID,
edh.ShiftID
from HumanResources.Department d join
HumanResources.EmployeeDepartmentHistory edh
on d.DepartmentID=edh.DepartmentID
where BusinessEntityID=46

select * from vwEmployeeDepartment


-------------cannot update multiple table-------
update vwEmployeeDepartment
set Name='Engineering', ShiftID=3
where BusinessEntityID=46

-------------
select * from HumanResources.Employee
where BusinessEntityID=46

sp_rename 'vwDesignEng', 'vwDesignEngineer'

select * from vwDesignEngineer

-------------drop-------------------
drop view vwDesignEngineer

create view vwEmployee
as
select JobTitle,MaritalStatus,Gender
from HumanResources.Employee

select * from vwEmployee




create view vwDeptName
as
select Name
from AdventureWorks2012.HumanResources.Department
where DepartmentID=(select DepartmentID 
from AdventureWorks2012.HumanResources.EmployeeDepartmentHistory
where  BusinessEntityID=46 and EndDate is null)

select * from vwDeptName;


create view vwCananda
as
select StateProvinceID,StateProvinceCode,Name,TerritoryID
from AdventureWorks2012.Person.StateProvince
where CountryRegionCode ='CA';

create view vwUS
as
select StateProvinceID,StateProvinceCode,Name,TerritoryID
from AdventureWorks2012.Person.StateProvince
where CountryRegionCode ='US';

--Creating Views from multiple DBs
create view vwEmployeeBooks
as
select emp.FirstName,cw.BookName
from CrossWorld cw, 
AdventureWorks2012.Person.Person emp

select * from vwEmployeeBooks;

--Write A QUERY TODisplay the BisinessEntityIDs of employees whose JobTitle is same as NationalIDNumber is 658797903
Select * from AdventureWorks2012.HumanResources.Employee;

--Step 1.Framing inner query first: Find the designation of vikas
select JobTitle
from AdventureWorks2012.HumanResources.Employee
where NationalIDNumber=658797903;

--Step 2.Framing outer query: Display other employee as same designation
select BusinessEntityID
from AdventureWorks2012.HumanResources.Employee
where JobTitle='Research and Development Engineer';

--Step3: PUT 1st QUERY INSIDE SECOND QUERY
select BusinessEntityID
from AdventureWorks2012.HumanResources.Employee
where JobTitle=
(
select JobTitle
from AdventureWorks2012.HumanResources.Employee
where NationalIDNumber=658797903
);

--dsiplay employeeid, loginid whose vacationhours is > than avg vh
--Subquery
select BusinessEntityID, LoginID, VacationHours
from AdventureWorks2012.HumanResources.Employee where
VacationHours>(select AVG(VacationHours)
from AdventureWorks2012.HumanResources.Employee)
order by VacationHours;

--display the departmenthistory of employeeid = 46;
select BusinessEntityID,d.DepartmentID,ShiftID
from AdventureWorks2012.HumanResources.Department d
inner join AdventureWorks2012.HumanResources.EmployeeDepartmentHistory dh
on d.DepartmentID=dh.DepartmentID
where BusinessEntityID=46
order by DepartmentID;
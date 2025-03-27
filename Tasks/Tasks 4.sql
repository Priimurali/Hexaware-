create table SalesData(SalesID int primary key,
ProductName varchar(100),
SalesAmount decimal(10,2),
SalesDate date);

DECLARE @sql NVARCHAR(MAX);
DECLARE @monthName NVARCHAR(20);

SET @monthName = DATENAME(MONTH, GETDATE());

SET @sql = 
    'SELECT SalesID, ProductName, SalesAmount AS Sales_' + @monthName + ', SalesDate FROM SalesData;';

EXEC sp_executesql @sql;

create table EmployeeSalary(EmpId int primary key,empName varchar(100),
SalaryMonth varchar(10),salaryAmount decimal(10,2)
);

SELECT * 
FROM (
    SELECT EmpID, EmpName, SalaryMonth, SalaryAmount
    FROM EmployeeSalary
) AS SourceTable
PIVOT (
    MAX(SalaryAmount) 
    FOR SalaryMonth IN ([January], [February], [March], [April], [May], [June], 
                        [July], [August], [September], [October], [November], [December])
) AS PivotTable;


CREATE TABLE Students (
    StudentID INT PRIMARY KEY,  -- Ensures uniqueness
    Name VARCHAR(100) NOT NULL,
    Marks INT CHECK (Marks BETWEEN 0 AND 100)  -- Ensures valid marks range
);

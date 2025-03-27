select name from sys.databases;

SELECT name, physical_name, type_desc  
FROM sys.master_files  
WHERE database_id = DB_ID('EmployeeDB');

CREATE DATABASE HRDB  
ON PRIMARY  
(  
    NAME = 'HRDB_Data',  
    FILENAME = 'D:\MSSQL\HRDB.mdf',   
    SIZE = 10MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 2MB  
)  
LOG ON  
(  
    NAME = 'HRDB_Log',  
    FILENAME = 'D:\MSSQL\HRDB.ldf', 
    SIZE = 5MB,  
    MAXSIZE = 50MB,  
    FILEGROWTH = 1MB  
);


alter database HRDB modify name = EmployeeDB;

drop database EmployeeeDb;

select name as datatype,system_type_id,user_type_id 
from sys.types;
use EmployeeDB;
create table emp(empid int primary key,empname varchar(100) not null,
joindate date not null,salary decimal(10,2) default 30000.00);

alter table emp add department varchar(50);

SELECT name, physical_name, size, max_size, growth  
FROM sys.master_files  
WHERE database_id = DB_ID('EmployeeDB');




exec sp_rename 'emp','staff';

select * from staff;

drop table staff;






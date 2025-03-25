SELECT name FROM sys.databases 
WHERE database_id < 4;


SELECT name, physical_name, type_desc  
FROM sys.master_files  
WHERE database_id = DB_ID('SalesDB');


CREATE DATABASE InventoryDB  
ON PRIMARY  
(  
    NAME = 'InventoryDB_Data',  
    FILENAME = 'D:\MSSQL\InventoryDB.mdf',  
    SIZE = 5MB,  
    MAXSIZE = 50MB,  
    FILEGROWTH = 5MB  
)  
LOG  on
(  
    NAME = 'InventoryDB_Log',  
    FILENAME = 'D:\MSSQL\InventoryDB.ldf',  
    SIZE = 2MB,  
    MAXSIZE = 25MB,  
    FILEGROWTH = 2MB  
);


alter database InventoryDB modify name = StockDB;

select name as datatype,system_type_id,user_type_id 
from sys.types
order by name;

use StockDB;
create table Products(ProductID int primary key,ProductName varchar(50) not null,
Price decimal(10,2),stockQuantity int default 0);

alter table products add category varchar(30);

exec sp_rename 'Products','Inventory';

--drop table Inventory;

--drop database StockDB;

select name,database_id,state_desc
from sys.databases
where database_id<=4;

select name,physical_name,type_desc
from sys.master_files
where database_id = DB_ID('InventoryDB');



create database SalesDB;
ON PRIMARY  
(  
    NAME = 'SalesDB_Data',  
    FILENAME = 'D:\MSSQL\SalesDB.mdf',  
    SIZE = 10MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 10MB  
)  
LOG ON  
(  
    NAME = 'SalesDB_Log',  
    FILENAME = 'D:\MSSQL\SalesDB.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 50MB,  
    FILEGROWTH = 5MB  
);


ALTER DATABASE SalesDB MODIFY NAME = RetailDB;


drop database retailDB;
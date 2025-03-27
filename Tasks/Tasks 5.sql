use fd3
CREATE TABLE Employees(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);


INSERT INTO Employees (Name, Age, Department, Salary) VALUES
('John Doe', 35, 'HR', 50000),
('Jane Smith', 28, 'IT', 60000),
('Alice Johnson', 40, 'Finance', 75000);


UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR';

select * from employees ; 

DELETE FROM Employees
WHERE Department = 'IT';


INSERT INTO Employees (Name, Age, Department, Salary)
VALUES ('Michael Brown', 45, 'Sales', 30000);


UPDATE Employees
SET Department = 'Senior Staff'
WHERE Salary > 50000;


DELETE FROM Employees
WHERE Age > 60;


--sec b
SELECT Name, Salary FROM Employees;


SELECT * FROM Employees
WHERE Department = 'Senior staff' AND Salary > 50000;


SELECT * FROM Employees
ORDER BY Salary DESC;



SELECT * FROM Employees
WHERE Age > 30;


SELECT * FROM Employees
WHERE Department IN ('Senior Staff', 'Finance');


SELECT * FROM Employees
WHERE Salary BETWEEN 30000 AND 60000;


SELECT * FROM Employees
WHERE Name LIKE 'A%';


SELECT * FROM Employees
WHERE Department <> 'IT';



SELECT * FROM Employees
WHERE Department IN ('Sales', 'Marketing');


SELECT DISTINCT Department FROM Employees;


SELECT EmployeeID AS ID, Name, Salary AS "Monthly Income"
FROM Employees;


SELECT * FROM Employees
WHERE Name LIKE '%John%' AND Salary > 40000;

--Task -- 2
SELECT FirstName, LastName, Email FROM Customers;


SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;


INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Alice', 'Brown', 'alice@example.com', '9876001234', 'Delhi');


UPDATE Products
SET Price = Price * 1.10;


DECLARE @OrderID INT = 1; -- Input OrderID

DELETE FROM OrderDetails WHERE OrderID = @OrderID;
DELETE FROM Orders WHERE OrderID = @OrderID;


INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, '2025-03-10', 45000);


DECLARE @CustomerID INT = 1; 
DECLARE @NewEmail NVARCHAR(100) = 'newemail@example.com';
DECLARE @NewAddress NVARCHAR(255) = 'New Address';

UPDATE Customers
SET Email = @NewEmail, Address = @NewAddress
WHERE CustomerID = @CustomerID;



UPDATE Orders
SET TotalAmount = (
    SELECT SUM(p.Price * od.Quantity)
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = Orders.OrderID
);



DECLARE @CustomerID INT = 2; -- Input CustomerID

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID);
DELETE FROM Orders WHERE CustomerID = @CustomerID;


INSERT INTO Products (ProductName, Description, Price)
VALUES ('Tablet', 'High-performance tablet', 25000);




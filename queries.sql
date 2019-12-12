-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.

SELECT
 p.ProductName
, c.CategoryName 
FROM Product as p

JOIN Category as c
ON p.CategoryId = c.Id
;

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.

SELECT 
o.Id
, sh.CompanyName
, o.OrderDate

FROM [Order] as o

JOIN Shipper as sh
ON o.ShipVia = sh.Id

WHERE  o.orderDate < '2012-08-09' 

                --BONUS ON THIS ONE, CHAINING CONDITIONALS

                SELECT 
                o.Id
                , sh.CompanyName
                , o.OrderDate

                FROM [Order] as o

                JOIN Shipper as sh
                ON o.ShipVia = sh.Id

                WHERE  o.orderDate < '2012-08-08' 
                    AND o.orderDate BETWEEN '0000-00-00' AND '2012-08-09'
                ;


-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.

SELECT 
p.ProductName 
, od.Quantity
, od.OrderId
FROM [OrderDetail] as od


JOIN Product as p
ON od.ProductId = p.Id

WHERE od.OrderId = 10251
;

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.

SELECT 
o.Id as OrderId
, c.CompanyName as 'Company Name'
, e.LastName as 'Employee Lastname'

FROM [Order] as o

JOIN Customer as c
ON o.CustomerId = c.Id

JOIN Employee as e
ON e.Id = o.EmployeeId
;




--STRETCH using group by and aggregate functions
 SELECT

od.OrderID as 'Order ID'
, COUNT(od.Quantity) as 'Item Count'
, COUNT(p.productID)

FROM [OrderDetails] as od

JOIN Products as p
ON p.productID = od.ProductID
GROUP BY od.OrderID
;

--this one was better
SELECT

od.OrderID as 'Order ID'
, SUM(od.Quantity) as 'Total Products on Order'
, COUNT(p.productID) as 'Item Count'

FROM [OrderDetails] as od

JOIN Products as p
ON p.productID = od.ProductID
GROUP BY od.OrderID
;
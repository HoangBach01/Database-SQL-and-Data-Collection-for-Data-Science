USE ProductShipping;
-- Cau 1.a
SELECT 
	orderid,
    custid,
    empid,
    DATE_FORMAT(orderdate, '%Y/%m/%d') as orderdate,
    DATE_FORMAT(shippeddate, '%Y/%m/%d') as shippeddate,
    shipcountry
FROM Orders
WHERE orderdate BETWEEN '2008-01-01' AND '2008-06-30'
ORDER BY orderdate DESC;

-- Cau 1.b
SELECT 
	orderid,
    custid,
    empid,
    DATE_FORMAT(orderdate, '%Y/%m/%d') as orderdate,
    DATE_FORMAT(shippeddate, '%Y/%m/%d') as shippeddate,
    shipcountry
FROM Orders
WHERE shippeddate BETWEEN '2007-01-01' AND '2007-06-30' 
	AND shipcountry = 'Germany'
ORDER BY shippeddate DESC;

-- Cau 1.c
SELECT 
	custid, 
    contactname,
    city,
    phone
FROM Customers
WHERE city REGEXP '^S|^O|^R'
ORDER BY contactname;

-- Cau 1.d
SELECT 
	custid, 
    contactname,
    city,
    phone
FROM Customers
WHERE city NOT REGEXP '^S|^O|^R'
ORDER BY contactname;

-- Cau 1.e
SELECT 
	custid, 
    contactname,
    city,
    phone
FROM Customers
WHERE city LIKE '_y%'
ORDER BY contactname;

-- Cau 1.f
SELECT 
	custid, 
    contactname,
    city,
    phone
FROM Customers
WHERE city REGEXP 'o$'
ORDER BY city;

-- Cau 1.g
SELECT 
	custid, 
    contactname,
    city,
    phone
FROM Customers
WHERE city REGEXP 'on$';

-- Cau 1.h
SELECT 
	e.empid,
    e.lastname,
    e.mgrid,
    m.lastname as manager_name
FROM Employees e
JOIN Employees m
	ON e.mgrid = m.empid
ORDER BY manager_name;

-- Cau 1.i
SELECT 
	e.empid,
    e.lastname,
    e.mgrid,
    m.lastname as manager_name
FROM Employees e
LEFT JOIN Employees m
	ON e.mgrid = m.empid
ORDER BY e.empid;

-- Cau 1.j
SELECT *
FROM Products
WHERE productid NOT IN (
		SELECT DISTINCT productid
		FROM Orderdetails
);

-- Cau 1.k
SELECT *
FROM Employees
WHERE empid NOT IN (
	SELECT DISTINCT empid
	FROM Orders
);

-- Cau 1.l
SELECT 
	o.custid,
    o.shipcountry,
    o.orderid,
    DATE_FORMAT(o.orderdate, '%Y/%m/%d') as orderdate,
    DATE_FORMAT(o.shippeddate, '%Y/%m/%d') as orderdate,
	e.lastname
FROM Orders o
LEFT JOIN Employees e USING (empid)
WHERE o.shipcountry IN ('Germany', 'Brazil')
ORDER BY orderdate DESC;
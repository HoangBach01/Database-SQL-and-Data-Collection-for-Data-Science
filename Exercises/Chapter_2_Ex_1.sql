USE ProductShipping;
SELECT 
	empid AS ID,
    CONCAT(lastname, ' ',firstname) as full_name,
    title,
    DATE_FORMAT(hiredate, '%d/%m/%Y') as hire_date
FROM Employees;
-- 
SELECT DISTINCT title
FROM Employees;
-- 
SELECT 
	productid,
    LPAD(productid, 10, 0) AS productid_new
FROM Products;
-- 
SELECT 
	orderid,
    custid,
    empid,
    DATE_FORMAT(orderdate, '%d/%m/%Y') as orderdate,
    DATE_FORMAT(shippeddate, '%d/%m/%Y') as shippeddate,
    shipcountry
FROM Orders
WHERE orderdate BETWEEN '2008-01-01' AND '2008-06-30'
ORDER BY orderdate DESC;
-- 
SELECT 
	orderid,
    custid,
    empid,
    DATE_FORMAT(orderdate, '%d/%m/%Y') as orderdate,
    DATE_FORMAT(shippeddate, '%d/%m/%Y') as shippeddate,
    shipcountry
FROM Orders
WHERE (shippeddate BETWEEN '2007-06-01' AND '2007-06-30')
		AND shipcountry = 'Germany'
-- END --
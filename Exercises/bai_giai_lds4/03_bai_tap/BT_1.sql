--1a
SELECT *
FROM orders 
WHERE orderdate BETWEEN '2008-01-01' AND '2008-06-30'
ORDER BY orderdate DESC;

--1b
SELECT *
FROM orders 
WHERE MONTH(orderdate)=6 AND YEAR(orderdate)=2007 AND shipcountry='Germany'
AND requireddate IS NOT NULL;

--1c
SELECT * 
FROM customers
WHERE LEFT(city,1) IN ('S','O','R')
ORDER BY contactname;

--1d
SELECT * 
FROM customers
WHERE LEFT(city,1) NOT IN ('S','O','R')
ORDER BY contactname;

--1e
SELECT * 
FROM customers
WHERE city LIKE '_Y%'
ORDER BY contactname;

--1f
SELECT * 
FROM customers
WHERE city LIKE '%o'
ORDER BY city;

--1g
SELECT * 
FROM customers
WHERE city LIKE '%on'
ORDER BY city;

--1h
SELECT e.empid, e.lastname, e.mgrid, m.lastname
FROM employees e JOIN employees m ON e.mgrid=m.empid
ORDER BY e.mgrid;

--1i
SELECT e.empid, e.lastname, e.mgrid, m.lastname
FROM employees e LEFT JOIN employees m ON e.mgrid=m.empid
ORDER BY e.mgrid;

--1j
SELECT *
FROM products
WHERE productid NOT IN (SELECT DISTINCT productid FROM orderdetails);

--1k
SELECT *
FROM employees
WHERE empid IN (SELECT empid FROM orders);

--1.l
SELECT o.`custid`, o.`shipcountry`, o.`orderid`, o.`orderdate`, o.`requireddate`, e.lastname
FROM orders o JOIN employees e ON o.empid=e.empid
WHERE o.`shipcountry` IN ('Germany','Brazil')
ORDER BY o.`orderdate`;

--2a
SELECT productid, productname, unitprice,
	CASE
    		WHEN Unitprice < 20 THEN 'Thấp'
        	WHEN Unitprice < 40 THEN 'Trung bình'
        	ELSE 'Cao'
    END AS 'Giá'
FROM products;

--2b
SELECT productid, SUM(unitprice*qty) AS 'Giá trị'
FROM orderdetails
GROUP BY productid
HAVING SUM(unitprice*qty)>11000;

--2c
SELECT d.productid, p.productname, COUNT(*) AS dem
FROM orderdetails d JOIN 	p ON d.productid=p.productid
GROUP BY d.productid, p.productname
ORDER BY dem DESC
LIMIT 1;

--3a
SELECT year(orderdate) as nam, count(*) as dem
from orders
where year(orderdate) between 2005 and 2008
group by year(orderdate)
order by nam;

SELECT
    SUM(IF(YEAR(orderdate)=2005,1,0)) AS 'Nam 2005',
    SUM(IF(YEAR(orderdate)=2006,1,0)) AS 'Nam 2006',
	SUM(IF(YEAR(orderdate)=2007,1,0)) AS 'Nam 2007',
    SUM(IF(YEAR(orderdate)=2008,1,0)) AS 'Nam 2008',
    COUNT(*) AS 'Tong'
FROM orders
WHERE YEAR(orderdate) BETWEEN 2005 AND 2008

--3b
SELECT
	empid,
    SUM(IF(YEAR(orderdate)=2005,1,0)) AS 'Nam 2005',
    SUM(IF(YEAR(orderdate)=2006,1,0)) AS 'Nam 2006',
	SUM(IF(YEAR(orderdate)=2007,1,0)) AS 'Nam 2007',
    SUM(IF(YEAR(orderdate)=2008,1,0)) AS 'Nam 2008',
    COUNT(*) AS 'Tong'
FROM orders
WHERE YEAR(orderdate) BETWEEN 2005 AND 2008
GROUP BY empid
ORDER BY empid;

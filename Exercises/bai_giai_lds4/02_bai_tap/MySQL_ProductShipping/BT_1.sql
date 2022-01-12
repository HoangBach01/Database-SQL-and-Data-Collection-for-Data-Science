--4a
SELECT empid AS 'Mã nhân viên', CONCAT(firstname,' ',lastname) AS 'Họ và tên',
	title AS 'Chức danh', DATE_FORMAT(hiredate, "%d/%m/%Y") AS 'Ngày vào làm'
FROM employees;

--4b
SELECT DISTINCT title AS 'Chức danh'
FROM employees;

--4c
SELECT productid AS 'Mã hàng hóa', LPAD(productid, 10, 0) AS 'Mã hàng hóa mới'
FROM products;

--5a
SELECT *
FROM orders 
WHERE orderdate BETWEEN '2008-01-01' AND '2008-06-30'
ORDER BY `orderdate` DESC;

--5b
SELECT *
FROM orders 
WHERE MONTH(orderdate)=6 AND YEAR(orderdate)=2007 AND shipcountry='Germany';
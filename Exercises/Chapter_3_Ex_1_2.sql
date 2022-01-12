USE ProductShipping;
-- Cau 2.a
SELECT 
	productid,
    productname,
    unitprice,
    (CASE 
		WHEN unitprice < 20 THEN 'Thap'
        WHEN unitprice BETWEEN 20 AND 40 THEN 'Trung Binh'
        ELSE 'cao'
	END) AS price_type
FROM Products;

-- Cau 2.b
SELECT *
FROM (
	SELECT 
		orderid,
		SUM(unitprice * qty * (1-discount)) as total_value
	FROM Orderdetails
	GROUP BY orderid
) q
WHERE total_value > 11000;

-- Cau 2.c

SELECT 
	a.productid,
    p.productname,
    p.supplierid
FROM
	(SELECT
		productid,
		COUNT(orderid) as count_order
	FROM Orderdetails
	GROUP BY productid
    ORDER BY count_order DESC
    LIMIT 1) a
JOIN Products p USING (productid);

-- Cau 3.a
SELECT
	SUM(year_order = 2005) AS count_2005,
    SUM(year_order = 2006) AS count_2006,
    SUM(year_order = 2007) AS count_2007,
    SUM(year_order = 2008) AS count_2008,
    SUM(year_order IN (2005, 2006, 2007, 2008)) AS total
FROM
	(SELECT 
		orderid, 
		year(orderdate) AS year_order
    FROM orders) a;

-- Cau 3.b
SELECT empid,
	SUM(year_order = 2005) AS count_2005,
    SUM(year_order = 2006) AS count_2006,
    SUM(year_order = 2007) AS count_2007,
    SUM(year_order = 2008) AS count_2008,
    SUM(year_order IN (2005, 2006, 2007, 2008)) AS total
FROM
	(SELECT 
        orderid,
        empid,
		year(orderdate) AS year_order
    FROM orders) a
GROUP BY empid WITH ROLLUP;
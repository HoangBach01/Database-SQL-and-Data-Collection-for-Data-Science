USE salesdb;
-- Cau 1.1
SELECT 
	city,
    companyname,
    productname,
    unitprice
FROM products p
JOIN suppliers s ON p.supplierid = s.id
WHERE country = 'Japan'
ORDER BY city;

-- Cau 1.2
SELECT 
	country,
    AVG(unitprice) AS avg_unitprice,
    COUNT(DISTINCT p.id) AS count_product,
    COUNT(DISTINCT city) AS count_city
FROM suppliers s
LEFT JOIN products p ON p.supplierid = s.id
GROUP BY country
ORDER BY count_product;

-- Cau 1.3
SELECT 
	CONCAT(firstname, ' ', lastname) as customer_name,
    ordernumber,
    DATE_FORMAT(orderdate, '%d/%m/%Y') as order_date,
    totalamount
FROM customers c
LEFT JOIN orders o ON c.id = o.customerid
WHERE orderdate BETWEEN '2014-03-01' AND '2014-03-31'
ORDER BY orderdate DESC, totalamount DESC;

-- Cau 1.4
CREATE OR REPLACE VIEW yearly_product_values AS
SELECT 
	year(orderdate) as sale_year,
	productname,
	SUM(oi.unitprice * oi.quantity) AS sum_amount
FROM orders o
JOIN orderitems oi ON o.id = oi.orderid
JOIN products p ON oi.productid = p.id
GROUP BY sale_year, productname;

SELECT * 
FROM yearly_product_values yp
WHERE (
	SELECT COUNT(DISTINCT productname)
    FROM yearly_product_values
    WHERE sale_year = yp.sale_year AND sum_amount > yp.sum_amount
) < 5
ORDER BY sale_year, sum_amount DESC;

-- Cau 1.5
SELECT 
	ordernumber,
    orderdate,
    CONCAT(firstname, ' ', lastname) as customer_name,
    totalamount
FROM orders o
LEFT JOIN customers c ON o.customerid = c.id
WHERE orderdate BETWEEN '2014-03-01' AND '2014-03-31' 
	AND WEEKDAY(orderdate) = 6
ORDER BY orderdate DESC;

-- Cau 1.6
SELECT *
FROM (
	SELECT
		CONCAT(firstname, ' ', lastname) as customer_name,
		country,
		city,
		COUNT(o.id) as count_order
	FROM customers c
	LEFT JOIN orders o ON o.customerid = c.id
	GROUP BY customer_name, country, city
) q
WHERE count_order > 15
ORDER BY count_order DESC;

-- Cau 1.7 
SELECT 
	year(orderdate) as year,
    quarter(orderdate) as quarter,
    SUM(totalamount) as sum_totalamount
FROM orders
GROUP BY year, quarter
ORDER BY sum_totalamount DESC
LIMIT 2;

-- Cau 1.8
SELECT 
	CONCAT(firstname, ' ', lastname) as customer_name,
    COUNT(o.id) as count_orders
FROM customers c
LEFT JOIN orders o ON c.id = o.customerid
GROUP BY customer_name
ORDER BY count_orders;

-- Cau 1.9
SELECT 
	o.id,
    orderdate,
    ordernumber,
    customerid,
    totalamount
FROM orders o
JOIN orderitems oi ON o.id = oi.orderid
JOIN products p on oi.productid = p.id
WHERE productname LIKE '%Chai%'
ORDER BY totalamount DESC
LIMIT 10;

-- Cau 1.10
-- Ý nghĩa câu truy vấn: Thống kê số lượng đã bán được của các sản phẩm trong danh mục
-- mà các sản phẩm đó hiện vẫn đang bán, sắp xếp theo tăng dần về số lượng
SELECT 
	p.ProductName, 
	IFNULL(SUM(i.Quantity),0) AS sum_quantity
FROM products p 
LEFT JOIN orderitems i on p.Id = i.ProductId
LEFT JOIN orders o ON o.Id = i.OrderId
WHERE p.IsDiscontinued = 0
GROUP BY p.ProductName
ORDER BY sum_quantity;

-- Cau 2.1
SELECT 
	CONCAT(firstname, ' ', lastname) as customer_name,
	(SELECT COUNT(DISTINCT(ordernumber))
	 FROM orders
	 WHERE customerid = c.id) AS count_order
FROM customers c
ORDER BY count_order DESC
LIMIT 10;

-- Cau 2.2
SELECT 
	CONCAT(firstname, ' ', lastname) as customer_name,
	(SELECT COUNT(DISTINCT(ordernumber))
	 FROM orders
	 WHERE customerid = c.id AND year(orderdate)=2012) AS year_2012,
	(SELECT COUNT(DISTINCT(ordernumber))
	 FROM orders
	 WHERE customerid = c.id AND year(orderdate)=2013) AS year_2013,
	(SELECT COUNT(DISTINCT(ordernumber))
	 FROM orders
	 WHERE customerid = c.id AND year(orderdate) IN (2012, 2013)) AS count_order
FROM customers c
ORDER BY count_order DESC
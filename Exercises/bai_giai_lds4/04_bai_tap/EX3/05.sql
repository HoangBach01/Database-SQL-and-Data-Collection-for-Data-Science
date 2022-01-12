SELECT 'customer' AS Type, Id AS ID, CONCAT(FirstName,' ',lastname) AS Name, City, Country, Phone
FROM Customers WHERE Id NOT IN (SELECT CustomerId FROM orders)
UNION ALL
SELECT 'Supplier', id, companyname, City, Country, Phone
FROM suppliers WHERE Id IN (SELECT DISTINCT supplierId FROM products WHERE IsDiscontinued);
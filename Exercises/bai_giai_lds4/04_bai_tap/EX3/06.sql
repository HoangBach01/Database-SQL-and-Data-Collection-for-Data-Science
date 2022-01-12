SELECT CONCAT(c.FirstName, ' ', c.LastName), o.Id, o.OrderDate
FROM customers c LEFT JOIN orders o ON c.Id=o.CustomerId
ORDER BY o.Id;
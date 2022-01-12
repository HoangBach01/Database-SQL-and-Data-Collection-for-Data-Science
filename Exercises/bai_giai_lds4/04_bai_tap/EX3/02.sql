SELECT o.Id, o.OrderDate, p.ProductName, i.Quantity, i.UnitPrice, i.Quantity*i.UnitPrice, CONCAT(c.FirstName, ' ', c.LastName)
FROM orders o JOIN orderitems i ON o.Id=i.OrderId
JOIN products p ON i.ProductId=p.Id
JOIN customers c ON o.CustomerId=c.Id
WHERE c.FirstName='Thomas' AND c.LastName='Hardy';
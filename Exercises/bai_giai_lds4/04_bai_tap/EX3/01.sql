SELECT p.Id, p.ProductName, p.UnitPrice, s.CompanyName
FROM products p JOIN suppliers s ON p.SupplierId=s.Id
ORDER BY s.CompanyName;
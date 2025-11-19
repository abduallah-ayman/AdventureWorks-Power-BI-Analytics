create VIEW vw_FactOrderDetails AS
SELECT od.SalesOrderID AS OrderID
      ,od.SalesOrderDetailID AS OrderDetailID 
      ,od.ProductID
      ,od.OrderQty
      ,od.UnitPrice 
      ,od.LineTotal 

	  --,o.OrderDate
	  ,CAST(FORMAT(o.OrderDate, 'yyyyMMdd') AS INT) OrderDateKey
      ,CAST(FORMAT(o.DueDate  , 'yyyyMMdd') AS INT) DueDateKey
      ,CAST(FORMAT(o.ShipDate , 'yyyyMMdd') AS INT) ShipDateKey

      ,o.[Status] StatusID
      ,o.OnlineOrderFlag
      ,o.CustomerID
      ,o.SalesPersonID
      ,o.TerritoryID 
      ,o.ShipMethodID 
      
      ,(CAST(od.[LineTotal] AS DECIMAL(18,5)) / o.SubTotal ) * o.TaxAmt AS TaxAmt
      ,(CAST(od.[LineTotal] AS DECIMAL(18,5)) / o.SubTotal ) * o.Freight AS Freight
      ,(CAST(od.[LineTotal] AS DECIMAL(18,5)) / o.SubTotal ) * o.TotalDue AS TotalDue 
FROM Sales.SalesOrderDetail od
LEFT JOIN Sales.SalesOrderHeader o ON o.SalesOrderID = od.SalesOrderID
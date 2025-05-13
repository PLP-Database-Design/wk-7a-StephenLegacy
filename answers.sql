--question 1


-- SQL query to transform ProductDetail into 1NF
-- We will use the `UNION ALL` to split the multiple products into individual rows
-- This query ensures that each row represents a single product for an order.

SELECT OrderID, CustomerName, 'Laptop' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Laptop', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Mouse' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Mouse', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Tablet' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Tablet', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Keyboard' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Keyboard', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Phone' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Phone', Products) > 0;

-- After running this query, the data will be in 1NF with a separate row for each product.

-- To achieve 2NF, we need to split the table into two: one for Order information and one for the order's Product details.
-- The `CustomerName` should be stored in a separate table because it depends on `OrderID`.

-- Creating a new `Orders` table for the OrderID and CustomerName relationship
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Inserting data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Creating the `OrderProducts` table to store Product and Quantity information
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting data into the OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;


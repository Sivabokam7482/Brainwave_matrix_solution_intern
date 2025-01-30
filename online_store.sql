-- create database online store
CREATE DATABASE online_store;

-- Create the Users table
CREATE TABLE User (
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(75) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(150) NOT NULL,
    phone VARCHAR(15),
    address TEXT(200),
    Created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    role ENUM('admin', 'customer','vendor') DEFAULT 'customer');

-- Create the category table
CREATE TABLE categories (
  category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Description TEXT(1000));

-- Create the Product Table
CREATE TABLE products (
  Product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(200) NOT NULL,
  description TEXT NULL,
  Price DECIMAL(10,2) NOT NULL,
  stock_quantity INT NOT NULL DEFAULT 0,
  category_id INT NULL,
  Image_url VARCHAR(300) NULL,
  Created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories (category_id));

-- Create the Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id));

-- Create the Order Items table 
CREATE TABLE Order_items(
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id));

-- Create the table Payments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit card','Debit card', 'UPI', 'Bank transfer') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id));

-- Create the table Shipping
CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_address TEXT NOT NULL,
    shipping_date TIMESTAMP,
    delivery_date TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id));

-- Create the table Reviews
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id));



-- Insert the values in user table
Insert INTO User (name, email, password, phone, address, role) 
VALUES
-- ('John Doe', 'john.doe@example.com', 'password123', '1234567890', '123 Main St, City, Country', 'customer');
-- ('Alice Smith', 'alice.smith@example.com', 'hashed_password2', '8765432109', '456 Elm St, Los Angeles, CA', 'Admin');
-- ('John Doe', 'johndoe@example.com', 'hashed_password1', '9876543210', '123 Main St, New York, NY', 'Customer');
-- ('Bob Johnson', 'bob.johnson@example.com', 'hashed_password3', '7654321098', '789 Oak St, Chicago, IL', 'Customer');
-- ('Emma Brown', 'emma.brown@example.com', 'hashed_password4', '6543210987', '321 Pine St, Houston, TX', 'Vendor');
-- ('Sophia Wilson', 'sophia.wilson@example.com', 'hashed_password6', '4321098765', '654 Cedar St, San Francisco, CA', 'Admin');
('David Miller', 'david.miller@example.com', 'hashed_password7', '3210987654', '852 Walnut St, Seattle, WA', 'Vendor');

select * from user;

-- Insert the values in Category Table
INSERT INTO Categories (name, description) 
VALUES 
('Electronics', 'Devices such as smartphones, laptops, and accessories'),
('Clothing', 'Men’s and women’s apparel including shirts, jeans, and jackets'),
('Home & Kitchen', 'Furniture, kitchen appliances, and home decor items'),
('Books', 'Fiction, non-fiction, educational, and self-help books'),
('Beauty & Personal Care', 'Skincare, haircare, and grooming products'),
('Sports & Outdoors', 'Fitness equipment, outdoor gear, and sports accessories'),
('Toys & Games', 'Children’s toys, board games, and puzzles');

select * from categories;

-- Insert the values in products Table.
INSERT INTO Products (name, description, price, stock_quantity, category_id, image_url) 
VALUES 
('iPhone 14', 'Apple iPhone 14 with A15 Bionic chip and 128GB storage', 799.99, 50, 1, 'https://example.com/images/iphone14.jpg'),
('Samsung Galaxy S23', 'Samsung flagship phone with Snapdragon 8 Gen 2 and 256GB storage', 899.99, 40, 1, 'https://example.com/images/galaxys23.jpg'),
('Nike Air Max 270', 'Men’s running shoes with Air cushioning for comfort', 149.99, 100, 2, 'https://example.com/images/nike270.jpg'),
('Levi’s 501 Jeans', 'Classic straight-fit denim jeans for men', 59.99, 75, 2, 'https://example.com/images/levis501.jpg'),
('Instant Pot Duo', '7-in-1 electric pressure cooker for easy meal prep', 89.99, 30, 3, 'https://example.com/images/instantpot.jpg'),
('The Subtle Art of Not Giving a F*ck', 'Bestselling self-help book by Mark Manson', 14.99, 200, 4, 'https://example.com/images/subtleart.jpg'),
('L’Oreal Face Cream', 'Hydrating face moisturizer for glowing skin', 24.99, 60, 5, 'https://example.com/images/lorealcream.jpg'),
('Adidas Soccer Ball', 'Official size and weight soccer ball for training and matches', 29.99, 80, 6, 'https://example.com/images/adidassoccer.jpg'),
('LEGO Star Wars Set', 'LEGO building set featuring iconic Star Wars characters', 99.99, 25, 7, 'https://example.com/images/legostarwars.jpg'),
('Sony WH-1000XM5', 'Wireless noise-canceling headphones with high-quality sound', 349.99, 35, 1, 'https://example.com/images/sonyheadphones.jpg');

select * from products;

-- Insert the values in Orders table.
INSERT INTO Order (user_id, order_date, status, total_amount) 
VALUES 
(1, '2024-01-20 14:30:00', 'Pending', 249.99),
(2, '2024-01-21 09:15:00', 'Completed', 89.50),
(3, '2024-01-22 18:45:00', 'Shipped', 159.75),
(4, '2024-01-23 12:00:00', 'Cancelled', 0.00),
(5, '2024-01-24 16:20:00', 'Completed', 329.99),
(6, '2024-01-25 08:10:00', 'Pending', 199.99);

select * from Orders;

-- Insert the values in Order_details Table.
INSERT INTO Order_details (order_id, product_id, quantity, price) 
VALUES 
(1, 3, 2, 299.98),
(1, 5, 1, 89.99),
(2, 2, 1, 899.99),
(3, 7, 3, 74.97),
(4, 4, 1, 59.99),
(5, 10, 2, 699.98);

select * from order_details;

-- Insert the values in shipping Table.
INSERT INTO Shipping (order_id, shipping_address, shipping_date, delivery_date) 
VALUES
(1, '123 Main St, New York, NY 10001', '2024-01-21 10:00:00', '2024-01-24 15:00:00'),
(2, '456 Elm St, Los Angeles, CA 90001', '2024-01-22 12:30:00', '2024-01-26 17:30:00'),
(3, '789 Oak St, Chicago, IL 60601', '2024-01-23 09:15:00', '2024-01-27 13:45:00'),
(4, '101 Pine St, Houston, TX 77001', '2024-01-24 14:45:00', '2024-01-28 18:00:00'),
(5, '202 Maple St, Miami, FL 33101', '2024-01-25 16:00:00', '2024-01-29 20:30:00');

select * from Shipping;

-- FETCH THE DATA IN THE TABLES :
--  Fetches only customers,names and emails
SELECT name, email, role FROM User WHERE role = 'Customer';

-- Fetches categories whose names start with "E".
SELECT name FROM Categories WHERE name LIKE 'E%';

--  Fetches products in stock (>10) and sorts them by price in descending order.
SELECT name, price FROM Products WHERE stock_quantity > 10 ORDER BY price DESC;

-- Fetches product names along with their category names.
SELECT p.name, c.name AS category_name 
FROM Products p JOIN Categories c 
ON p.category_id = c.category_id;

-- Retrieves only pending orders and their total amount.
SELECT order_id, total_amount FROM Orders WHERE status = 'Pending';

-- Fetches order details along with customer names.
SELECT o.order_id, u.name AS customer_name, o.total_amount 
FROM Orders o JOIN User u 
ON o.user_id = u.user_id;

-- Fetches ordered products with quantity and price.
SELECT od.order_id, p.name AS product_name, od.quantity, od.price 
FROM Order_details od JOIN Products p 
ON od.product_id = p.product_id;

-- Fetches only completed payments.
SELECT order_id, amount, payment_method FROM Payments WHERE status = 'Completed';

--  Retrieves payments with order and customer details.
SELECT p.payment_id, o.order_id, u.name AS customer, p.amount, p.status 
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
JOIN User u ON o.user_id = u.user_id;

--  Fetches reviews along with the product name and reviewer.
SELECT r.rating, r.comment, u.name AS reviewer, p.name AS product 
FROM Reviews r JOIN User u 
ON r.user_id = u.user_id JOIN Products p 
ON r.product_id = p.product_id;
DROP DATABASE IF EXISTS Bookstore;
CREATE DATABASE Bookstore; 
USE Bookstore; 


-- ADDRESS TABLE AND VALUES
CREATE TABLE Address(
addressID CHAR(10), 
num INT,
street CHAR(20),
city CHAR(20),
state_zip CHAR(20),

PRIMARY KEY (addressID)
);
INSERT INTO Address(addressID, num, street, city, state_zip)
VALUES ('00001', 1100, 'Grand Road', 'New York', 'NY 10001'),
('00002', 441, 'East Fordham Road', 'Bronx', 'NY 10458'),
('00003', 442, 'Fordham Road', 'Bronx', 'NY 10458'),
('00004', 383, '56th Street', 'New York', 'NY 10002'),
('00005', 1, 'Fordham Road', 'Bronx', 'NY 10458');



-- CUSTOMER TABLE AND VALUES
CREATE TABLE Customers(
customerID CHAR(10),
username CHAR(10),
pswd CHAR(10),
full_name CHAR(20), 
bdate DATE, 
gender CHAR(10), 
email CHAR(30),
addressID CHAR(10), 

PRIMARY KEY (customerID),
UNIQUE (username), 
UNIQUE (pswd),

FOREIGN KEY (addressID) REFERENCES Address (addressID)
); 
INSERT INTO Customers(customerID, username, pswd, full_name, bdate, gender, email, addressID)
VALUES ('00001', 'xxyy', '0808', 'Tom Hunks', '1990-12-01', 'M', 'thunks@yahoo.com', '00001'),
('00002', 'xzzz', '11223', 'Tom Cruise', '1991-10-01', 'M', 'tcruise@yahoo.com', '00002'),
('00003', 'abcde', 'xyz123', 'Tina Fei', '1956-12-01', 'F', 'tfei11@yahoo.com', '00003'),
('00004', 'iama', '34ii', 'Rice Brown', '1970-12-01', 'F', 'rbrown1999@hotmail.com', '00004'),
('00005', 'lisaw', '8877', 'Lisa Warren', '1972-12-01', 'F', 'lisawarren@gmail.com', '00005');



-- PHONE NUMBERS TABLE AND VALUES
CREATE TABLE Phone_Numbers(
customerID CHAR(10), 
num CHAR(20), 
phone_type CHAR(10),

PRIMARY KEY (num),
FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);
INSERT INTO Phone_Numbers (customerID, num, phone_type)
VALUES ('00001', '212-400-0001', 'Home'),
('00001', '212-100-2222', 'Cell'),
('00002', '718-817-3333', 'Cell'),
('00003', '817-718-0001',  'Work'), 
('00003', '212-100-2234', 'Cell'),
('00004', '212-001-7788', 'Cell'),
('00005', '212-300-1199', 'Cell'), 
('00005', '212-300-7777', 'Home');



-- PAYMENT METHOD TABLE AND VALUES
CREATE TABLE Payment_Method(
paymentID CHAR(10), 
customerID CHAR(10), 
holder_full_name CHAR(20),

PRIMARY KEY (paymentID),

FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);
INSERT INTO Payment_Method(paymentID, customerID, holder_full_name)
VALUES ('01', '00001', 'Tom Hunks'),
('02', '00001', 'Tom Hunks'),
('03', '00002', 'Tom Cruise'),
('04', '00003', 'Tina Fei'),
('05', '00003', 'Tom Fei'),
('06', '00004', 'Rice Brown'),
('07', '00005', 'Lisa Warren'),
('08', '00005', 'Lisa Warren');



-- DEBIT/CREDIT TABLE AND VALUES
CREATE TABLE Debit_Credit_Card(
cardID CHAR(10),
paymentID CHAR(10),
card_type CHAR(20),
card_num CHAR(20), 
exp_date CHAR(20), 
phone_num CHAR(20), 
billing_address CHAR(10),

PRIMARY KEY (cardID),
FOREIGN KEY (paymentID) REFERENCES Payment_Method (paymentID),
FOREIGN KEY (billing_address) REFERENCES Address (addressID)
);
INSERT INTO Debit_Credit_Card(cardID, paymentID, card_type, card_num, exp_date, phone_num, billing_address)
VALUES ('00001', '01', 'Credit card', '9999 9999 8888 8888', '08/17', '212-400-0001', '00001'),
('00002', '03', 'Credit card', '2222 4444 5555 6666', '12/14', '718-817-333', '00002'),
('00003', '04', 'Debit card', '1234 1234 5678 5678', '10/18', '817-718-0001', '00003'),
('00004', '06', 'Credit Card', '1122 3344 5566 7788', '01/16', '212-001-7788', '00004'), 
('00005', '07', 'Credit Card', '1111 2222 3333 4444', '01/17', '212-300-1199', '00005');



-- BANK ACCOUNTS TABLE AND VALUES
CREATE TABLE Bank_Account(
accountID CHAR(10),
paymentID CHAR(10), 
account_num INT,
account_type CHAR(20),
bank_name CHAR(20),

PRIMARY KEY (accountID),

FOREIGN KEY (paymentID) REFERENCES Payment_Method (paymentID)
);
INSERT INTO Bank_Account(accountID, paymentID, account_num, account_type, bank_name)
VALUES ('00001', '02', 1112223, 'Checking', 'Chase'),
('00002', '05', 12667, 'Checking', 'Capital One'),
('00003', '08', 9922882, 'Checking', 'Chase');



-- AUTHORS TABLE AND VALUES
CREATE TABLE Authors(
authorID CHAR(10),
author_full_name CHAR(20),
PRIMARY KEY (authorID)
);
INSERT INTO Authors(authorID, author_full_name)
VALUES ('00001', 'Ramez A. Elmasri'),
('00002', 'Shamkant Navathe'),
('00003', 'Ian H. Witten'), 
('00004', 'Eibe Frank'),
('00005', 'Mark Hall'),
('00006', 'Matt Florence'),
('00007', 'Raghu Ramakrishnan'),
('00008', 'Johannes Gehrke');



-- BOOKS TABLE AND VALUES
CREATE TABLE Books(
ISBN CHAR(14),
title CHAR(80),
edition CHAR(20),  
year_and_publisher CHAR(20), 
price INT,
section CHAR(20),
inventory INT,
PRIMARY KEY (ISBN)
);
INSERT INTO Books (ISBN, title, edition, year_and_publisher, price, section, inventory)
VALUES ('0805317554', 'Fundamentals of Database Systems', '3rd edition', '2000, Addison Wesley', 100, 'Sciences', 20),
('9780123748560', 'Data Mining, Practical Machine Learning Tools and Techniques', '3rd edition', '2011, Elsevier', 120, 'Sciences', 25),
('0115325555', 'Writing Skills', '1st edition ', '2010, Addison Wesley', 30, 'Arts', 10),
('9780072465631','Database Management Systems', '3rd edition', '2003, McGraw-Hill', 110, 'Sciences', 15);



-- CONNECTION BETWEEN BOOKS AND AUTHORS TABLE AND VALUES
CREATE TABLE BooksAuthors(
ISBN CHAR(14),
authorID CHAR(10),

FOREIGN KEY (ISBN) REFERENCES Books (ISBN),
FOREIGN KEY (authorID) REFERENCES Authors (authorID)
);
INSERT INTO BooksAuthors(ISBN, authorID)
VALUES ('0805317554', '00001'),
('0805317554', '00002'),
('9780123748560', '00003'),
('9780123748560', '00004'),
('9780123748560', '00005'),
('0115325555', '00006'),
('9780072465631', '00007'),
('9780072465631', '00008');



-- SHOPPING CART TABLES AND VALUES
CREATE TABLE Shopping_cart(
cartID INT, 
customerID CHAR(10),
session_date DATE,

PRIMARY KEY (cartID),
FOREIGN KEY (customerID) REFERENCES Customers (customerID)
);
INSERT INTO Shopping_cart(cartID, customerID, session_date)
VALUES (1, '00001', '2017-11-24'),
(2, '00002', '2017-11-23'),
(3, '00003', '2017-12-01'),
(4, '00004', '2017-11-24');



-- CART ITEMS TABLES AND VALUES
CREATE TABLE Cart_items(
cartID INT,
ISBN CHAR(14),
quantity INT, 

FOREIGN KEY (cartID) REFERENCES Shopping_cart (cartID),
FOREIGN KEY (ISBN) REFERENCES Books (ISBN)
);
INSERT INTO Cart_items (cartID, ISBN, quantity)
VALUES (1, '9780123748560', 1),
(1, '9780072465631', 2),
(1, '0115325555', 1),
(2, '9780123748560', 1),
(2, '9780072465631', 1),
(2, '0115325555', 1),
(3, '9780123748560', 1),
(3, '9780072465631', 1),
(3, '0115325555', 1),
(3, '0805317554', 1),
(4, '9780123748560', 1),
(4, '9780072465631', 1),
(4, '0115325555', 2),
(4, '0805317554', 1);



-- BILLS TABLES AND VALUES 
CREATE TABLE Bills(
billID INT,
cartID INT,
customerID CHAR(10),
paymentID CHAR(10),
total INT,

PRIMARY KEY (billID),

FOREIGN KEY (cartID) REFERENCES Shopping_cart (cartID),
FOREIGN KEY (customerID) REFERENCES Customers (customerID),
FOREIGN KEY (paymentID) REFERENCES Payment_Method (paymentID)
);
INSERT INTO Bills(billID, cartID, customerID, paymentID, total)
VALUES 
-- TOTAL IS CALCULATED NOT HARD CODED
(1, 1, '00001', '02', (SELECT SUM(ci.quantity * b.price) AS total
					   FROM Cart_items ci
					   JOIN Books b ON ci.ISBN = b.ISBN
					   WHERE ci.cartID = 1
					   GROUP BY ci.cartID)),
(2, 2, '00002', '03', (SELECT SUM(ci.quantity * b.price) AS total
					   FROM Cart_items ci
                       JOIN Books b ON ci.ISBN = b.ISBN
                       WHERE ci.cartID = 2
                       GROUP BY ci.CARTID)),
(3, 3, '00003', '04', (SELECT SUM(ci.quantity * b.price) AS total
					   FROM Cart_items ci
                       JOIN Books b ON ci.ISBN = b.ISBN
                       WHERE ci.cartID = 3
                       GROUP BY ci.CARTID)), 
(4, 4, '00004', '06', (SELECT SUM(ci.quantity * b.price) AS total
					   FROM Cart_items ci
					   JOIN Books b ON ci.ISBN = b.ISBN
                       WHERE ci.cartID = 4
                       GROUP BY ci.CARTID));



							-- Queries

-- Is there any customer who does not purchase any books at all? 
-- If there is, list their names. 
SELECT DISTINCT Cu.full_name
FROM Customers Cu, Shopping_cart Sc
WHERE Cu.customerID NOT IN 
	(SELECT Sc2.customerID
	 FROM Shopping_cart Sc2);
-- ANSWER : LISA WARREN


-- Who bought the book - "Writing Skills"?
SELECT DISTINCT Cu.full_name
FROM Customers Cu, Shopping_cart Sc, Books B, Cart_items Ci
WHERE Cu.customerID = Sc.customerID AND Sc.cartID = Ci.cartID AND Ci.ISBN = B.ISBN AND B.title = 'Writing Skills';
-- ANSWER : Tom Hunks, Tom Cruise, Tina Fei, and Rice Brown all bought "Writing Skills"


-- Who bought more than 2 different books?
SELECT DISTINCT Cu.full_name
FROM Customers Cu
JOIN Shopping_cart Sc ON Cu.customerID = Sc.customerID
JOIN Cart_items Ci ON Sc.cartID = Ci.cartID
GROUP BY Cu.customerID
HAVING COUNT(DISTINCT Ci.ISBN) > 2; 
-- ANSWER : Tom Hunks, Tom Cruise, Tina Fei, and Rice Brown


-- Which book is the msot popular book among all customers? 
-- Please list its title and the number of copies sold. 
SELECT B.title, SUM(Ci.quantity) AS total_sold
FROM Books B
JOIN Cart_items Ci ON B.ISBN = Ci.ISBN
GROUP BY B.ISBN
HAVING SUM(Ci.quantity) = (SELECT MAX(total_quantity)
						   FROM (SELECT SUM(quantity) AS total_quantity
								 FROM Cart_items
                                 GROUP BY ISBN) AS MAX_quantity);
-- ANSWER : DATABASE MANAGEMENT SYSTEMS, 5 copies
-- 			WRITING SKILLS, 5 copies


-- Which book is the most popular book among female customers?
SELECT b.title, SUM(ci.quantity) AS total_quantity
FROM Books B
JOIN Cart_items Ci ON B.ISBN = Ci.ISBN
JOIN Shopping_cart Sc ON Ci.cartID = Sc.cartID
JOIN Customers Cu ON Sc.customerID = Cu.customerID
WHERE Cu.gender = 'F'
GROUP BY B.ISBN, B.title
ORDER BY total_quantity DESC
LIMIT 1;
-- ANSWER : WRITING SKILLS, 3 copies


-- How many customers would like to use credit cards as a payment method?
SELECT COUNT(Bi.billID)
FROM Bills Bi
JOIN Debit_Credit_Card DC ON Bi.paymentID = DC.paymentID
WHERE DC.card_type = 'Credit card';
-- ANSWER : 2


-- In which zipcode is this bookstore popular? 
-- (with the largest number of customers)
-- (it does not matter whether the customer has bought or not)
SELECT A.state_zip
FROM Address A
JOIN Customers Cu ON A.addressID = Cu.addressID
GROUP BY A.state_zip
ORDER BY COUNT(DISTINCT Cu.customerID) DESC
LIMIT 1;
-- ANSWER : NY 10458


-- Among all customers, whose purchase amount is the highest?
SELECT Cu.customerID, Cu.full_name
FROM Customers Cu
JOIN Bills Bi ON Cu.customerID = Bi.customerID
WHERE total = (SELECT MAX(total) FROM Bills Bi); 
-- ANSWER : Rice Brown
 




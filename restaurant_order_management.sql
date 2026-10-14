-- Restaurant Order Management Database
-- Oracle SQL
-- WARNING: Running this script removes existing tables with these names.
-- Drop child tables before parent tables to respect foreign keys.
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE CustomerPhone CASCADE CONSTRAINTS;
DROP TABLE Product CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE Cus_order CASCADE CONSTRAINTS;
DROP TABLE Customer CASCADE CONSTRAINTS;

CREATE TABLE Customer (
    Customer_no NUMBER(10) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    Email VARCHAR2(50) UNIQUE
);

CREATE TABLE Cus_order (
    order_id CHAR(10) PRIMARY KEY,
    Customer_no NUMBER(10) NOT NULL,
    status VARCHAR2(15) NOT NULL,
    order_type VARCHAR2(30),
    order_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (Customer_no) REFERENCES Customer(Customer_no)
);

CREATE TABLE Staff (
    staff_ID CHAR(10) PRIMARY KEY,
    order_id CHAR(10) NOT NULL,
    Name VARCHAR2(10) NOT NULL,
    phone_number VARCHAR2(10) NOT NULL,
    city VARCHAR2(11),
    street VARCHAR2(12),
    zip VARCHAR2(5),
    FOREIGN KEY (order_id) REFERENCES Cus_order(order_id)
);

CREATE TABLE Product (
    item_id CHAR(10) PRIMARY KEY,
    order_id CHAR(10) NOT NULL,
    price NUMBER(10, 2) NOT NULL CHECK (price >= 0),
    food_type VARCHAR2(30) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Cus_order(order_id)
);

CREATE TABLE CustomerPhone (
    phone_number VARCHAR2(15) PRIMARY KEY,
    Customer_no NUMBER(10) NOT NULL,
    FOREIGN KEY (Customer_no) REFERENCES Customer(Customer_no)
);

CREATE TABLE Payment (
    payment_id CHAR(10) PRIMARY KEY,
    order_id CHAR(10) NOT NULL,
    Customer_no NUMBER(10) NOT NULL,
    status VARCHAR2(10) NOT NULL,
    Amount NUMBER(10, 2) NOT NULL CHECK (Amount >= 0),
    payment_method VARCHAR2(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Cus_order(order_id),
    FOREIGN KEY (Customer_no) REFERENCES Customer(Customer_no)
);

-- Sample data
INSERT INTO Customer (Customer_no, name, Email) VALUES (1, 'John Doe', 'john.doe@example.com');
INSERT INTO Customer (Customer_no, name, Email) VALUES (2, 'Jane Smith', 'jane.smith@example.com');
INSERT INTO Customer (Customer_no, name, Email) VALUES (3, 'Alice Johnson', 'alice.johnson@example.com');

INSERT INTO Cus_order (order_id, Customer_no, status, order_type, order_date) VALUES ('ORD001', 1, 'Completed', 'Online', TO_DATE('2023-11-01', 'YYYY-MM-DD'));
INSERT INTO Cus_order (order_id, Customer_no, status, order_type, order_date) VALUES ('ORD002', 2, 'Pending', 'In-Store', TO_DATE('2023-11-02', 'YYYY-MM-DD'));
INSERT INTO Cus_order (order_id, Customer_no, status, order_type, order_date) VALUES ('ORD003', 3, 'Shipped', 'Online', TO_DATE('2023-11-03', 'YYYY-MM-DD'));

INSERT INTO Staff (staff_ID, order_id, Name, phone_number, city, street, zip) VALUES ('STF001', 'ORD001', 'Mike', '1234567890', 'New York', '5th Avenue', '10001');
INSERT INTO Staff (staff_ID, order_id, Name, phone_number, city, street, zip) VALUES ('STF002', 'ORD002', 'Rachel', '0987654321', 'Los Angeles', 'Sunset Blvd', '90001');
INSERT INTO Staff (staff_ID, order_id, Name, phone_number, city, street, zip) VALUES ('STF003', 'ORD003', 'Harvey', '1122334455', 'Chicago', 'Michigan Ave', '60601');

INSERT INTO Product (item_id, order_id, price, food_type) VALUES ('PROD001', 'ORD001', 19.99, 'Pizza');
INSERT INTO Product (item_id, order_id, price, food_type) VALUES ('PROD002', 'ORD002', 9.99, 'Burger');
INSERT INTO Product (item_id, order_id, price, food_type) VALUES ('PROD003', 'ORD003', 5.49, 'Soda');

INSERT INTO CustomerPhone (phone_number, Customer_no) VALUES ('1234567890', 1);
INSERT INTO CustomerPhone (phone_number, Customer_no) VALUES ('0987654321', 2);
INSERT INTO CustomerPhone (phone_number, Customer_no) VALUES ('1122334455', 3);

INSERT INTO Payment (payment_id, order_id, Customer_no, status, Amount, payment_method) VALUES ('PAY001', 'ORD001', 1, 'Completed', 19.99, 'Credit Card');
INSERT INTO Payment (payment_id, order_id, Customer_no, status, Amount, payment_method) VALUES ('PAY002', 'ORD002', 2, 'Pending', 9.99, 'Cash');
INSERT INTO Payment (payment_id, order_id, Customer_no, status, Amount, payment_method) VALUES ('PAY003', 'ORD003', 3, 'Completed', 5.49, 'Debit Card');

-- Example queries
SELECT * FROM Staff WHERE city = 'New York';
SELECT * FROM Cus_order WHERE order_type = 'Online' AND status = 'Completed';
SELECT * FROM Payment WHERE Amount BETWEEN 8 AND 20;
SELECT Customer_no, COUNT(payment_id) AS total_payments FROM Payment GROUP BY Customer_no;
SELECT order_type, COUNT(order_id) AS total_orders FROM Cus_order GROUP BY order_type;
SELECT o.order_id, c.name, o.status, o.order_date
FROM Cus_order o JOIN Customer c ON o.Customer_no = c.Customer_no;

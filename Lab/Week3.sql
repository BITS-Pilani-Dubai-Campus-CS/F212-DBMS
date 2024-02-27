use 20220xxxdb
CREATE TABLE SALESMAN
(
    salesman_id INT PRIMARY KEY,
    name        VARCHAR(255),
    city        VARCHAR(255),
    commission  DECIMAL(4, 2)
);

CREATE TABLE CUSTOMER
(
    customer_id INT PRIMARY KEY,
    cust_name   VARCHAR(255),
    city        VARCHAR(255),
    grade       INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES SALESMAN (salesman_id)
);

CREATE TABLE ORDERS
(
    ord_no      INT PRIMARY KEY,
    purch_amt   DECIMAL(10, 2),
    ord_date    DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER (customer_id),
    FOREIGN KEY (salesman_id) REFERENCES SALESMAN (salesman_id)
);

INSERT INTO SALESMAN (salesman_id, name, city, commission)
VALUES (5001, 'James Hoog', 'New York', 0.15),
       (5002, 'Nail Knite', 'Paris', 0.13),
       (5005, 'Pit Alex', 'London', 0.11),
       (5006, 'Mc Lyon', 'Paris', 0.14),
       (5003, 'Lauson Hen', 'New York', 0.12),
       (5007, 'Paul Adam', 'Rome', 0.13);


INSERT INTO CUSTOMER (customer_id, cust_name, city, grade, salesman_id)
VALUES (3002, 'Nick Rimando', 'New York', 100, 5001),
       (3005, 'Graham Zusi', 'California', 200, 5002),
       (3001, 'Brad Guzan', 'London', 300, 5005),
       (3004, 'Fabian Johns', 'Paris', 300, 5006),
       (3007, 'Brad Davis', 'New York', 200, 5001),
       (3009, 'Geoff Camero', 'Berlin', 100, 5003),
       (3008, 'Julian Green', 'London', 300, 5002),
       (3003, 'Jozy Altidor', 'Moscow', 200, 5007);


INSERT INTO ORDERS (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70001, 150.5, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.5, '2012-08-17', 3009, 5003),
       (70007, 948.5, '2012-09-10', 3005, 5002),
       (70005, 2400.6, '2012-07-27', 3007, 5001),
       (70008, 5760, '2012-09-10', 3002, 5001),
       (70010, 1983.43, '2012-10-10', 3004, 5006),
       (70003, 2480.4, '2012-10-10', 3009, 5003),
       (70012, 250.45, '2012-06-27', 3008, 5002),
       (70011, 75.29, '2012-08-17', 3003, 5007),
       (70013, 3045.6, '2012-04-25', 3002, 5001);

-- Q1
SELECT c.cust_name AS CustomerName, s.name AS SalesmanName, s.city, c.city
FROM CUSTOMER c
         JOIN SALESMAN s ON c.city = s.city;

-- Q2
SELECT c.cust_name AS CustomerName, s.name AS SalesmanName
FROM CUSTOMER c
         INNER JOIN SALESMAN s ON c.salesman_id = s.salesman_id;

-- Q3
SELECT c.cust_name AS CustomerName, c.city AS CustomerCity, s.name AS SalesmanName, s.city AS SalesmanCity
FROM CUSTOMER c
         INNER JOIN SALESMAN s ON c.salesman_id = s.salesman_id
WHERE s.city <> c.city;

-- Q4
SELECT o.ord_no AS OrderNumber, c.cust_name AS CustomerName
FROM ORDERS o
         INNER JOIN CUSTOMER c ON o.customer_id = c.customer_id;

-- Q5
SELECT DISTINCT c.cust_name AS CustomerName, c.grade AS CustomerGrade
FROM CUSTOMER c
         JOIN ORDERS o ON c.customer_id = o.customer_id
         JOIN SALESMAN s ON c.salesman_id = s.salesman_id
WHERE c.grade IS NOT NULL
  AND s.city IS NOT NULL
ORDER BY c.cust_name;

-- Q6
SELECT c.cust_name AS CustomerName, c.city AS CustomerCity, s.name AS SalesmanName, s.commission as SalesmanCommission
FROM CUSTOMER c
         JOIN SALESMAN s ON c.salesman_id = s.salesman_id
WHERE s.commission >= 0.12
  AND s.commission <= 0.14;

-- Q7
SELECT DISTINCT o.ord_no                   AS OrderNum,
                c.cust_name                AS CustomerName,
                s.commission               as SalesmanCommission,
                o.purch_amt * s.commission as CommisionAmount
FROM CUSTOMER c
         JOIN ORDERS o ON c.customer_id = o.customer_id
         JOIN SALESMAN s ON c.salesman_id = s.salesman_id
WHERE c.grade > 200
  AND c.salesman_id IS NOT NULL
ORDER BY c.cust_name;

-- Q8
SELECT *
FROM CUSTOMER
WHERE grade > 100;

-- Q9
SELECT *
FROM CUSTOMER
WHERE grade > 100 AND city = 'New York';

-- Q10
SELECT *
FROM CUSTOMER
WHERE grade < 100 OR city = 'New York';

-- Q11
SELECT *
FROM CUSTOMER
WHERE grade > 100 <> city = 'New York';

-- Q12
SELECT o.ord_no, o.purch_amt, o.ord_date, o.salesman_id
FROM ORDERS o
         JOIN SALESMAN s ON o.salesman_id = s.salesman_id
WHERE (o.ord_date != '2012-09-10' AND s.salesman_id <= 5005)
   OR o.purch_amt <= 1000.00;

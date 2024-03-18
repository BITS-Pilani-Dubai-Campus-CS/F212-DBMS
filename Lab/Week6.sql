use 20220276db

--1
SELECT s.name AS "Salesman", c.cust_name AS "Customer"
FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id;

--2
SELECT c.cust_name, s.name, s.commission 
FROM customer c
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

--3
SELECT c.cust_name, s.name, c.city, s.city, s.commission
FROM customer c 
JOIN salesman s ON c.salesman_id = s.salesman_id
WHERE c.city <> s.city AND s.commission > 0.12;

--4
SELECT s.name, c.cust_name, o.ord_no, o.ord_date, o.purch_amt
FROM salesman s
JOIN customer c ON s.salesman_id = c.salesman_id  
JOIN orders o ON c.customer_id = o.customer_id;

--5
SELECT cust_name 
FROM customer
WHERE salesman_id IS NOT NULL
UNION
SELECT cust_name
FROM customer 
WHERE salesman_id IS NULL
ORDER BY cust_name;

--6
SELECT s.name, c.cust_name
FROM salesman s
CROSS JOIN customer c;

--7
CREATE VIEW salesperson_view AS
SELECT salesman_id, name, city 
FROM salesman;

--8
CREATE VIEW ny_salespeople AS
SELECT salesman_id, name, city, commission
FROM salesman
WHERE city = 'New York';

--9
CREATE VIEW cust_grade_count AS
SELECT grade, COUNT(*) AS number
FROM customer
GROUP BY grade;

--10
CREATE VIEW cust_order_summary AS
SELECT ord_date, COUNT(DISTINCT customer_id) AS count, 
       AVG(purch_amt) AS avg, SUM(purch_amt) AS `sum`  
FROM orders
GROUP BY ord_date
ORDER BY ord_date;

--11
SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM course c
LEFT OUTER JOIN prereq p ON c.course_id = p.course_id;

--12
SELECT c.course_id, c.title, p.prereq_id, p.prereq_title  
FROM course c
RIGHT OUTER JOIN prereq p ON c.course_id = p.course_id;

--13
SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM course c
LEFT JOIN prereq p ON c.course_id = p.course_id
UNION
SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM course c  
RIGHT JOIN prereq p ON c.course_id = p.course_id
WHERE c.course_id IS NULL;

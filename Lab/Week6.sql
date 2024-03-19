use 20220276DB;

SELECT s.name AS "SALESMAN", c.cust_name AS "CUSTOMER"
FROM SALESMAN s
JOIN CUSTOMER c ON s.salesman_id = c.salesman_id;

SELECT c.cust_name, s.name, s.commission
FROM CUSTOMER c
JOIN SALESMAN s ON c.salesman_id = s.salesman_id
WHERE s.commission > 0.12;

SELECT c.cust_name, s.name, c.city, s.city, s.commission
FROM CUSTOMER c
JOIN SALESMAN s ON c.salesman_id = s.salesman_id
WHERE c.city <> s.city AND s.commission > 0.12;

SELECT s.name, c.cust_name, o.ord_no, o.ord_date, o.purch_amt
FROM SALESMAN s
JOIN CUSTOMER c ON s.salesman_id = c.salesman_id
JOIN ORDERS o ON c.customer_id = o.customer_id;

SELECT cust_name
FROM CUSTOMER
WHERE salesman_id IS NOT NULL
UNION
SELECT cust_name
FROM CUSTOMER
WHERE salesman_id IS NULL
ORDER BY cust_name;

SELECT s.name, c.cust_name
FROM SALESMAN s
CROSS JOIN CUSTOMER c;

CREATE VIEW SALESPERSON_VIEW AS
SELECT salesman_id, name, city
FROM SALESMAN;

CREATE VIEW NY_SALESPEOPLE AS
SELECT salesman_id, name, city, commission
FROM SALESMAN
WHERE city = 'New York';

CREATE VIEW CUST_GRADE_COUNT AS
SELECT grade, COUNT(*) AS number
FROM CUSTOMER
GROUP BY grade;

CREATE VIEW CUST_ORDER_SUMMARY AS
SELECT ord_date, COUNT(DISTINCT customer_id) AS count,
      AVG(purch_amt) AS avg, SUM(purch_amt) AS `sum`
FROM ORDERS
GROUP BY ord_date
ORDER BY ord_date;

SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM COURSE c
LEFT OUTER JOIN PREREQ p ON c.course_id = p.course_id;

SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM COURSE c
RIGHT OUTER JOIN PREREQ p ON c.course_id = p.course_id;

SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM COURSE c
LEFT JOIN PREREQ p ON c.course_id = p.course_id
UNION
SELECT c.course_id, c.title, p.prereq_id, p.prereq_title
FROM COURSE c
RIGHT JOIN PREREQ p ON c.course_id = p.course_id
WHERE c.course_id IS NULL;

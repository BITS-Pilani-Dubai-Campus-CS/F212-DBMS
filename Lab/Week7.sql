use 20220276db

--3NF and 4NF design
CREATE TABLE R1 (
  holidaycode VARCHAR(10) PRIMARY KEY,
  cost DECIMAL(10, 2)
);

INSERT INTO R1 (holidaycode, cost) VALUES
('B563', 363.00),
('B248', 248.00),
('B428', 322.00),
('C930', 568.00),
('A270', 972.00),
('B728', 248.00),
('A430', 279.00);

CREATE TABLE R2 (
  airportcode VARCHAR(10) PRIMARY KEY,
  airportname VARCHAR(50)
);

INSERT INTO R2 (airportcode, airportname) VALUES
('1', 'Luton'),
('12', 'Edinburgh'),
('11', 'Glasgow'),
('14', 'Newcastle');

CREATE TABLE R3 (
  agentno INT PRIMARY KEY,
  agentname VARCHAR(50)
);

INSERT INTO R3 (agentno, agentname) VALUES
(76, 'Bairns travel'),
(142, 'Active Holidays');

CREATE TABLE R4 (
  batchno INT,
  agentno INT,
  holidaycode VARCHAR(10),
  airportcode VARCHAR(10),
  quantitybooked INT,
  PRIMARY KEY (batchno, agentno, holidaycode, airportcode),
  FOREIGN KEY (holidaycode) REFERENCES R1(holidaycode),
  FOREIGN KEY (airportcode) REFERENCES R2(airportcode),
  FOREIGN KEY (agentno) REFERENCES R3(agentno)
);

INSERT INTO R4 (batchno, agentno, holidaycode, airportcode, quantitybooked) VALUES
(1, 76, 'B563', '1', 10),
(1, 76, 'B248', '12', 20),
(1, 76, 'B428', '11', 18),
(2, 142, 'B563', '1', 15),
(2, 142, 'C930', '14', 2),
(2, 142, 'A270', '14', 1),
(2, 142, 'B728', '12', 5),
(3, 76, 'C930', '1', 11),
(3, 76, 'A430', '11', 15);

--creating a view for the problem
CREATE VIEW agent_booking_details AS
SELECT R3.agentname, R1.holidaycode, R1.cost, R4.quantitybooked, R2.airportname, R4.batchno, (R1.cost * R4.quantitybooked) AS totalcost
FROM R4
JOIN R1 ON R4.holidaycode = R1.holidaycode
JOIN R2 ON R4.airportcode = R2.airportcode
JOIN R3 ON R4.agentno = R3.agentno;

--1
CREATE TABLE COURSESTUDENT (
  CourseID VARCHAR(10),
  StudentID VARCHAR(10),
  PRIMARY KEY (CourseID, StudentID)
);

INSERT INTO COURSESTUDENT (CourseID, StudentID) VALUES
('CSC101', 'S001'),
('CSC101', 'S002'),
('CSC102', 'S003'),
('CSC102', 'S004'),
('CSC102', 'S005'),
('CSC103', 'S006'),
('CSC103', 'S001'),
('CSC103', 'S002');

CREATE TABLE COURSEBOOK (
  CourseID VARCHAR(10),
  RefBook VARCHAR(50),
  PRIMARY KEY (CourseID, RefBook)
);

INSERT INTO COURSEBOOK (CourseID, RefBook) VALUES
('CSC101', 'Introduction to Programming'),
('CSC101', 'Data Structures and Algorithms'),
('CSC102', 'Database Systems Concepts'),
('CSC102', 'SQL Fundamentals'),
('CSC103', 'Computer Networks'),
('CSC103', 'Operating Systems Concepts');

--2a
CREATE VIEW course_students AS
SELECT CourseID, GROUP_CONCAT(StudentID) AS StudentIDs
FROM COURSESTUDENT
GROUP BY CourseID;

--2b
CREATE VIEW course_books AS
SELECT CourseID, GROUP_CONCAT(RefBook) AS RefBooks
FROM COURSEBOOK
GROUP BY CourseID;

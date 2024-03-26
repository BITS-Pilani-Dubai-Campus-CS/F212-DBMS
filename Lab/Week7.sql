use 20220276db

--3NF and 4NF design
CREATE TABLE R1 (
  holidaycode VARCHAR(10) PRIMARY KEY,
  cost DECIMAL(10, 2)
);

CREATE TABLE R2 (
  airportcode VARCHAR(10) PRIMARY KEY,
  airportname VARCHAR(50)
);

CREATE TABLE R3 (
  agentno INT PRIMARY KEY,
  agentname VARCHAR(50)
);

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

CREATE TABLE COURSEBOOK (
  CourseID VARCHAR(10),
  RefBook VARCHAR(50),
  PRIMARY KEY (CourseID, RefBook)
);

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

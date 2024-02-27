use 20220xxxdb
CREATE TABLE `student`
(
    `id`         int(11)     NOT NULL AUTO_INCREMENT,
    `name`       varchar(50) NOT NULL,
    `age`        int(11),
    `department` varchar(15),
    `semester`   int,
    `courseID`   int,
    PRIMARY KEY (`id`)
);

ALTER TABLE students
    MODIFY COLUMN department VARCHAR(30);
  
INSERT INTO students (name, age, department, semester, courseID)
VALUES ('John Doe', 19, 'Computer Science', 5, 23);

INSERT INTO students (name, age, department, semester, courseID)
VALUES ('Jane Doe', 20, 'Physics', 7, 43);

RENAME TABLE students TO student;

SELECT *
FROM student;


-- DROP TABLE `student`;

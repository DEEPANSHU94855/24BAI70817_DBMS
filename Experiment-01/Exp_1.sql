-- Create Database
CREATE DATABASE University_DB;
USE University_DB;

-- Create Student Table
CREATE TABLE Student(
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- Create Course Table
CREATE TABLE Course(
    course_id INT PRIMARY KEY,
    course_title VARCHAR(100)
);

-- Create Enrollment Table
CREATE TABLE Enrollment(
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY(student_id) REFERENCES Student(student_id),
    FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

-- Insert Students
INSERT INTO Student VALUES
(11,'Aarush Mehta'),
(12,'Kiara Sharma'),
(13,'Vivaan Kapoor');

-- Insert Courses
INSERT INTO Course VALUES
(301,'Cloud Infrastructure'),
(302,'Blockchain Fundamentals'),
(303,'Cyber Threat Analysis');

-- Start Transaction
START TRANSACTION;

-- Valid Enrollment
INSERT INTO Enrollment
VALUES(1,11,302,'A');

-- Savepoint
SAVEPOINT SP1;

-- Invalid Enrollment
INSERT INTO Enrollment
VALUES(2,99,301,'B');

-- Rollback Invalid Record
ROLLBACK TO SP1;

-- Save Valid Record
COMMIT;

-- Display Result
SELECT
s.student_name,
c.course_title,
e.grade
FROM Enrollment e
INNER JOIN Student s
ON e.student_id=s.student_id
INNER JOIN Course c
ON e.course_id=c.course_id;
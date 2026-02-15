CREATE DATABASE campus_db;
USE campus_db;

CREATE TABLE student_details (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email_id VARCHAR(100),
    mobile_no VARCHAR(15),
    branch VARCHAR(50)
);

CREATE TABLE subject_details (
    subject_code VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100),
    instructor_id INT,
    student_id INT,
    instructor_email VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES student_details(student_id)
);

INSERT INTO student_details VALUES
(1,'SanjayKurakul','SanjayKurakul@gmail.com','9032299762','CSE'),
(2,'Lally','lally13@gmail.com','9032299323','CSE'),
(3,'Pandu','Pandu11@gmail.com','9032287878','CSE'),
(4,'Surya','surya1918@gmail.com','8723782382','ECE'),
(5,'Adhi','adhi06@gmail.com','9032278795','ITI');

INSERT INTO subject_details VALUES
('SUB01','Database Systems',401,1,'db.faculty@univ.edu'),
('SUB02','Probability and Statistics',402,2,'stats.faculty@univ.edu'),
('SUB03','Computer Architecture',401,3,'ca.faculty@univ.edu'),
('SUB04','Engineering Graphics',403,4,'eg.faculty@univ.edu'),
('SUB05','Artificial Intelligence',404,5,'ai.faculty@univ.edu');

SELECT * FROM student_details;
SELECT * FROM subject_details;

SELECT * FROM student_details WHERE branch = 'CSE';

SELECT * FROM subject_details ORDER BY subject_name;

SELECT full_name, email_id
FROM student_details
WHERE email_id LIKE '%gmail.com';

SELECT * FROM student_details LIMIT 4;

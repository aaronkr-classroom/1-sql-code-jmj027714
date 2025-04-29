create table course(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	teacher_id INT
);

INSERT INTO course (name, teacher_id)
VALUES 
('Database design', 1),
('English literature', 2),
('Python programming', 1);



create table student(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name  VARCHAR(100)
);

INSERT INTO student (first_name, last_name)
VALUES 
('Shreya', 'Bain'),
('Rianna', 'Foster'),
('Yosef', 'Naylor');




create table student_course
(
	student_id int,
	course_id int
);

INSERT INTO student_course (student_id, course_id)
VALUES 
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 1);


create table teacher(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name  VARCHAR(100)
);

INSERT INTO teacher (first_name, last_name)
VALUES 
('Taylah', 'Booker'),
('Sarah-Louise', 'Blake');




select * from course



--student 테이블에 student_course 조인
SELECT student.id, student.first_name, student.last_name, student_course.course_id
FROM student
INNER JOIN student_course
ON student.id = student_course.student_id;


-- teacher테이블을 course에 조인
SELECT course.id, course.name, teacher.first_name, teacher.last_name
FROM course
INNER JOIN teacher
ON course.teacher_id = teacher.id;


--course 테이블을 student_course에 조인
SELECT student_course.student_id, course.id AS course_id, course.name
FROM student_course
INNER JOIN course
ON student_course.course_id = course.id;



-- STUDENT (rollno, name, class, birthdate)
-- COURSE (courseno, coursename, max_marks, pass_marks)
-- SC (rollno, courseno, marks)


CREATE TABLE STUDENT(
    rollno number NOT NULL PRIMARY KEY, 
    name VARCHAR2(100), 
    class VARCHAR2(10), 
    birthdate date
    );

CREATE TABLE COURS(
    courseno number NOT NULL PRIMARY KEY, 
    coursename VARCHAR2(20), 
    max_marks number check(max_marks=100), 
    pass_marks number check(pass_marks>=35)  
);

CREATE TABLE SC(
    rollno number NOT NULL REFERENCES STUDENT(rollno), 
    courseno number NOT NULL REFERENCES cours(courseno), 
    marks number,
    PRIMARY KEY(rollno,courseno)
);

ALTER TABLE STUDENT MODIFY birthdate DATE;
ALTER TABLE STUDENT MODIFY class VARCHAR2(10);

--Student Data
insert into student values(1,'pankaj','MCA-sem-1','27-jan-1989');
insert into student values(2,'rahul','MCA-sem-1','15-aug-1988');
insert into student values(3,'priyesh','MCA-sem-3','30-apr-1990');
insert into student values(4,'ravinder','MCA-sem-1','27-jan-1989');
insert into student values(5,'dheru','MCA-sem-3','15-feb-1987');
insert into student values(6,'amit','MCA-sem-1','19-jun-1989');
insert into student values(7,'deepak','MCA-sem-3','25-dec-1989');
insert into student values(8,'xyz','MCA-sem-3','25-dec-1989');

--Cours Data
insert into COURS values(01,'c',100,50);
insert into COURS values(02,'java',100,50);
insert into COURS values(03,'dbms',100,50);
insert into COURS values(04,'BCC',100,50);
insert into COURS values(05,'MATHS',100,50);


--Sc Data
insert into SC values(7,04,75);
insert into SC values(4,03,45);
insert into SC values(5,03,70);
insert into SC values(4,02,90);
insert into SC values(1,01,75);
insert into SC values(4,05,80);
insert into SC values(6,04,55);
insert into SC values(1,03,68);
insert into SC values(4,01,36);
insert into SC values(3,03,59);
insert into SC values(1,05,48);
insert into SC values(2,04,99);
insert into SC values(2,05,30);
insert into sc values(8,01,100);
insert into sc values(8,02,100);
insert into sc values(8,03,100);
insert into sc values(8,04,100);
insert into sc values(8,05,100);



-- 3. Add a constraint that the marks entered should strictly be between 0 and 100.
ALTER TABLE SC ADD CONSTRAINT  CHK_marks CHECK(marks>=0 AND marks<=100);

-- 4. While creating SC table, composite key constraint was forgotten. Add the composite
--  keynow.
ALter TABLE sc add PRIMARY Key(rollno,courseno);

-- 5. Display details of student who takes ‘Database Management System’ course.
select s.rollno,s.name,c.coursename 
from 
student s,cours c,sc a 
where 
s.rollno=a.rollno 
and c.courseno=a.courseno 
and c.coursename='MATHS'; 

or 

SELECT * from STUDENT where rollno IN(
    SELECT rollno from sc where COURSENO IN(
        SELECT COURSENO from COURS where COURSENAME='MATHS'
    ));

-- 6. Display the names of students who have scored more than 70% in Computer
-- Networksand have not failed in any subject.
SELECT DISTINCT s.*,c.coursename,a.marks from student s,sc a,cours c 
where  c.coursename='BCC'and a.marks>70 
and
a.rollno=s.rollno 
and
a.rollno in 
(select rollno from sc where rollno not in
(select rollno from sc,COURS where sc.marks<cours.pass_marks));


-- 7. Display the average marks obtained by each student.
SELECT s.name,avg(marks)  from student s,sc A where 
s.rollno=A.rollno GROUP BY s.name;
-- //min,max,sum,count,avg

-- 8. Select all courses where passing marks are more than 30% of average maximum mark.
select * from Cours where pass_marks
>=(SELECT avg(max_marks)*30/100 from cours);


-- 9. Display details of students who are born in 1980 or 1982.
select * from student where TO_CHAR(birthdate,'YYYY') in (1988,1990,2000);

-- 10. Create a view that displays student courseno and its corresponding marks.
--Create a new Relational View

CREATE VIEW v1
AS
SELECT sc.courseno,sc.marks,c.coursename FROM Cours c,sc where
sc.courseno=c.courseno;



 








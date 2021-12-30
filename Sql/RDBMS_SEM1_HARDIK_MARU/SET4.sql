-- Create the database COMPANY and create given tables with all necessary constraints such as 
-- primary key, foreign key, unique key, not null and check constraints.
-- EMPLOYEE (emp_id, emp_name, birth_date, gender, dept_no, address, designation, salary, 
--  experience, email)
-- DEPART (dept_no, dept_name, total_employees, location)
-- PROJECT (proj_id, type_of_project, status, start_date, emp_id)


--Employee Table

CREATE table EMP(
    emp_id NUMBER PRIMARY KEY NOT NULL, 
    emp_name VARCHAR2(100), 
    birth_date DATE,
    gender VARCHAR2(6), 
    dept_no number references DEPART(dept_no), 
    address VARCHAR2(100), 
    designation VARCHAR2(50), 
    salary number CHECK(salary>=0), 
    experience VARCHAR2(50), 
    email VARCHAR2(100) CHECK(REGEXP_LIKE(email,'^[A-Za-z0-9._%+]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'))
);

-- DEPARTMENT TABLE (dept_no, dept_name, total_employees, location)
CREATE TABLE DEPART(
    dept_no number PRIMARY KEY NOT NULL, 
    dept_name VARCHAR2(20), 
    total_employees NUMBER, 
    location VARCHAR2(20)
);

-- PROJECT (proj_id, type_of_project, status, start_date, emp_id)
CREATE TABLE PROJECT(
    proj_id NUMBER primary key not NULL, 
    type_of_project VARCHAR2(50), 
    status VARCHAR2(20), 
    start_date DATE, 
    emp_id REFERENCES EMP(emp_id)
    );


alter table EMP MODIFY CHECK(gender IN('male','female'));
alter table EMP MODIFY experience Number;
alter table employee add constraint chk_designation check (designation in ('manager', 'clerk', 'leader', 'analyst', 'designer', 'coder', 'tester'));


--Depart Data
INSERT INTO DEPART values(10,'account',10,'NY'); 
INSERT INTO DEPART values(20,'HR',15,'NY'); 
INSERT INTO DEPART values(30,'Production',5,'DL'); 
INSERT INTO DEPART values(40,'Sales',12,'NY'); 
INSERT INTO DEPART values(50,'EDP',14,'MU'); 
INSERT INTO DEPART values (60,'TRG',0,' ');
INSERT INTO DEPART values(110,'RND',7,'AH');


--Employess Data

INSERT INTO EMP  values(1,'pc','29-SEP97','male',10,'AMRELI','manager',20000,3,'pc@gmail.com');
INSERT INTO EMP values(2,'naresh','31-oct98','male',20,'ahemdabad','clerk',20000,1,'vj@gmail.com');
INSERT INTO EMP values(3,'jay','15-jan98','male',30,'vyara','leader',5000,1,'df9j@gmail.com');
INSERT INTO EMP values(4,'annu','10-jan95','female',40,'vyara','analyst',50000,3,'annulf9j@gmail.com');
INSERT INTO EMP values(5,'prem','10-jan96','male',50,'amrely','designer',4000,3,'prem@gmail.com');
INSERT INTO EMP values(6,'jay','15-mar99','male',60,'songadh','coder',34000,5,'jay@gmail.com');
INSERT INTO EMP values(7,'anil','30-mar87','male',110,'bardoli','tester',54000,6,'anil@gmail.com');


--Project Data
INSERT INTO Project values(1,'project1','Running','21-mar02',1); 
INSERT INTO Project values(2,'project2','Pending','20-jan03',2); 
INSERT INTO Project values(3,'project3','Running','15-feb04',3); 
INSERT INTO Project values(4,'project4','Running','16-sep02',4); 
INSERT INTO Project values(5,'project5','Pending','17-oct02',5); 
INSERT INTO Project values (6,'project6','Running','10-mar03',6);
INSERT INTO Project values(7,'project7','Pending','05-sep02',7);



-- 1. Delete the department whose total number of employees less than 1. 
DELETE from DEPART where total_employees<1;

-- 2. Display the names and the designation of all female employee in descending order.
select emp_name,designation from emp where gender='female' ORDER by emp_name DESC;

-- 3. Display the names of all the employees who names starts with ‘A’ ends with ‘A’.
select emp_name from emp where emp_name LIKE 'a%l';

-- 4. Find the name of employee and salary for those who had obtain minimum salary.
SELECT emp_name,salary from emp where salary=(select min(salary) from emp);

-- 5. Add 10% raise in salary of all employees whose department is ‘CIVIL’.

UPDATE emp set salary=(salary+(salary*0.10))
where 
dept_no=(SELECT dept_no from Depart where dept_name='account'); 

-- 6. Count total number of employees of ‘MCA’ department.
select count(emp_name) from emp  
where 
dept_no=(SELECT dept_no from Depart where dept_name='account'); 

-- 7. List all employees who born in the current month.
select * from employee 
where TO_CHAR(birth_date,'MON')=(select to_char(SYSDATE,'MON')from dual);

-- 8. Print the record of employee and dept table as “Employee works in department ‘CE’. 
SELECT e.emp_name ||' Works in '|| d.dept_name 
from emp e,Depart d
where e.dept_no=d.dept_no;

-- 9. List names of employees who are fresher’s(less than 1 year of experience).
SELECT * from emp where experience<=1;

-- 10. List department wise names of employees who has more than 5 years of experience. 
select e.emp_name,e.experience,d.dept_name from emp e,Depart d
WHERE
e.experience<=5 AND
e.dept_no=d.dept_no
order by d.dept_no

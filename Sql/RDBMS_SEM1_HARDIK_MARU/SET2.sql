-- EMPLOYEE (emp_id, emp_name, birth_date, gender, dept_no, address, designation, salary, 
-- experience, email)
-- DEPARTMENT (dept_no, dept_name, location)

-- 1. Create the EMP Table with all necessary constraints such as
-- In EMP TABLE: Employee id should be primary key, Department no should be
-- Foreign key, employee age (birth_date) should be greater than 18 years, salary should 
-- be greater than zero, email should have (@ and dot) sign in address, designation of 
-- employee can be “manager”, “clerk”, “leader”, “analyst”, “designer”, “coder”, 
-- “tester”

-- Create a new relational table with 3 columns

-- Examples: '24/4/97' or '24-04-1997'
-- for email validation https://docs.oracle.com/cd/B12037_01/server.101/b10759/conditions018.htm

CREATE TABLE Employee 
(
    emp_id number primary key NOt Null,
    EMP_name varchar2(20),
    birth_date DATE,
    gender VARCHAR2(6),
    address VARCHAR2(200),
    designation varchar2(20),
    salary number check(salary>=0),
    experience number,
    email VARCHAR2(50) CHECK(REGEXP_LIKE(email,'^[A-Za-z0-9._%+]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')),
    dept_no number references department(dept_no),
    CONSTRAINT check_designation CHECK(designation in('manager' ,'clerk' ,'leader','analyst','designer','coder','tester'))
);


-- Department no should be primary key, department name should be unique.
alter table department add unique(dept_name);

---Employee Data


INSERT INTO Employee  values(1,'pc','29-SEP97','male','AMRELI','manager',20000,3,'pc@gmail.com',10);
INSERT INTO Employee values(2,'naresh','31-oct98','male','ahemdabad','clerk',20000,1,'vj@gmail.com',20);
INSERT INTO Employee values(3,'jay','15-jan98','male','vyara','leader',5000,1,'df9j@gmail.com',30);
INSERT INTO Employee values(4,'annu','10-jan95','female','vyara','analyst',50000,3,'annulf9j@gmail.com',40);
INSERT INTO Employee values(5,'prem','10-jan96','male','amrely','designer',4000,3,'prem@gmail.com',50);
INSERT INTO Employee values(6,'sita','15-mar99','female','songadh','coder',34000,5,'sita@gmail.com',40);
INSERT INTO Employee values(7,'anil','30-mar87','male','bardoli','tester',54000,6,'anil@gmail.com',110);

-- 12. Find the names of the employee who has salary less than 5000 and greater than 2000.

SELECT EMP_name,salary from Employee where salary BETWEEN 2000 and 5000;

-- 13. Display the names and the designation of all female employee in descending order

SELECT emp_name,designation,gender from employee where gender='female' order by emp_name desc;

-- 14. Display the names of all the employees who names starts with ‘A’ ends with ‘A’.

select emp_name from employee where emp_name like 'a%';

-- 15. Find the name of employee and salary for those who had obtain minimum salary
select emp_name,salary from employee where salary=(SELECT MIN(salary) from employee);

-- 16. Add 10% raise in salary of all employees whose department is ‘IT’

update employee set salary=(salary+(salary*0.10))
where dept_no=(select dept_no from department where dept_name='HR'); 

-- 17. Count total number of employees of ‘IT’ department.
SELECT count(*) from EMPLOYEE where 
dept_no=(select dept_no from department where dept_name='IT');

-- 18. List all employees who born in the current month.

select emp_name,BIRTH_DATE from employee
where to_char(BIRTH_DATE,'MON')=(SELECT to_char(SYSDATE,'MON') from dual);


-- 19. Print the record of employee and dept table as “Employee works in department MBA
select emp_name from employee where dept_no=(SELECT dept_no from department where dept_name='IT');
SELECT e.emp_name ||' Works in '|| d.dept_name 
from employee e,department d
where e.dept_no=d.dept_no; 



-- 20. List names of employees who are fresher’s (less than 1 year of experience).
SELECT emp_name,experience from employee where experience<=1;

-- 21. List department wise names of employees who has more than 5 years of experience
SELECT e.emp_name,e.experience,d.dept_name  
from employee e,department d 
where 
experience>=5 and e.dept_no=d.dept_no
order by d.dept_no;


-- 22. Crete Sequence to generate department ID

CREATE SEQUENCE department_ID 
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;


-- 23. List department having no employees
select dept_name 
from department 
where dept_no 
NOT IN
(select dept_no from employee);






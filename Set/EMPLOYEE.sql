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
    EMPTY_name varchar2(20),
    birth_date DATE,
    gender VARCHAR2(6),
    address VARCHAR2(200),
    designation varchar2(20),
    salary number check(salary>0),
    experience number,
    email VARCHAR2(20) CHECK(REGEXP_LIKE(email,'^[A-Za-z0-9._%+]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')),
    dept_no number references department(dept_no),
    CONSTRAINT check_designation CHECK(designation in('manager' ,'clerk' ,'leader','analyst','designer','coder','tester'))
);


-- Department no should be primary key, department name should be unique.
alter table department add unique(dept_name);
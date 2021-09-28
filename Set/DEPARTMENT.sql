create table Department
(
    dept_no number ,
    dept_name varchar(20),
    location varchar(20)
);

-- Insert rows in a Table

INSERT INTO Department VALUES(10,'Account','NY');
INSERT INTO Department VALUES(20,'HR','NY');
INSERT INTO Department VALUES(30,'Production','DL');
INSERT INTO Department VALUES(40,'Sales','NY');
INSERT INTO Department VALUES(50,'EDP','MU');
INSERT INTO Department VALUES(60,'TRG','');
INSERT INTO Department VALUES(110,'RND','AH');

--4. Display all records of Department table

SELECT * from Department;

--5. Display all department belonging to location 'NY'

SELECT * from department where location='NY';

-- 6. Display details of Department 10 

SELECT * from department where dept_no=10;

-- 7. List all department names starting with 'A

SELECT * from department where dept_name LIKE 'A%';

-- 8. List all departments whose number is between 1 and 100

SELECT * from department where dept_no BETWEEN 1 and 100;

-- 9. Delete 'TRG' department

DELETE from department where dept_name='TRG';

-- 10. Change department name 'EDP' to 'IT

UPDATE department SET dept_name='IT' where dept_name='EDP';
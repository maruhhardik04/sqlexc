CREATE TABLE EMP(
    empno NUMBER, 
    empnm VARCHAR2(20), 
    empadd VARCHAR2(20), 
    salary NUMBER CHECK(salary >= 0), 
    date_birth DATE,
    joindt DATE, 
    deptno NUMBER);


CREATE TABLE ITEM(
    itemno int primary key, 
    itemname VARCHAR2(25), 
    colour VARCHAR2(10), 
    weight NUMBER
    );


CREATE TABLE JOB(
    jobid int, 
    type_of_job VARCHAR2(20), 
    status VARCHAR2(20)
    );

CREATE TABLE WORKER(
     workerid int, 
     name VARCHAR2(10), 
     wage_per_hour NUMBER, 
     specialized_in VARCHAR2(20),
     manager_id int
);   
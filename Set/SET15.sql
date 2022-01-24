
CREATE TABLE DEPT(
    deptno NUMBER primary key, 
    deptnm VARCHAR2
    );

CREATE TABLE EMP(
    empno NUMBER, 
    empnm VARCHAR2(20), 
    empadd VARCHAR2(20), 
    salary NUMBER CHECK(salary >= 0), 
    date_birth DATE,
    joindt DATE, 
    deptno NUMBER REFERENCES DEPT(deptno));
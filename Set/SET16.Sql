
CREATE TABLE DEPT(
     deptno NUMBER primary key,     
    deptnm VARCHAR2
    ); 

CREATE TABLE EMPMAST(
    empno int, 
    name VARCHAR2(10), 
    pfno NUMBER, 
    empbasic NUMBER, 
    deptno NUMBER REFERENCES DEPT(deptno), 
    designation VARCHAR2(10)
    );
    
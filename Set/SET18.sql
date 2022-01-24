CREATE TABLE BRANCH(
    branch_no int primary key, 
    area VARCHAR2(20), 
    city VARCHAR2(10)
);

CREATE TABLE MEMBERS(
    mno int, 
    name VARCHAR2(10)
    branch_no REFERENCES BRANCH(branch_no), 
    salary NUMBER,
    manager_no int
);
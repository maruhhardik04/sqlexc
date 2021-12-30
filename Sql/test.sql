create table employes
(
    emp_no number PRIMARY KEY NOt NUll,
    fname VARCHAR2(20) UNIQUE,
    mname varchar2(20) NOT NULL,
    lname varchar(20),
    city varchar2(10) default 'jamnagar',
    age number  check(age>=18)
);

create table dep
(
    dep_no number PRIMARY KEY NOT NULL,
    dep_name VARCHAR2(20),
    emp_no number REFERENCES employes(emp_no)
);

CREATE table demo
(
    demo_no number,
    fname VARCHAR2(20),
    mname varchar2(20),
    lname varchar2(20),
    primary key(fname,mname,lname)
);
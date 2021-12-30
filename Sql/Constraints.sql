--Constraints 
--Constraints are the rules 

-- NOT NULL
CREATE TABLE stud
(
    no number,
    fname VARCHAR2(20),
    mname VARCHAR2(20) NOt NULL,
    lname VARCHAR2(20)
);

-- Insert rows in a Table

INSERT INTO stud VALUES( 1, 'a','b','c');
INSERT into stud(no,mname) VALUES(2,'b');
 
 
--UNIQUE
CREATE TABLE stud
(
    no number,
    fname VARCHAR2(20) UNIQUE,
    mname VARCHAR2(20) NOt NULL,
    lname VARCHAR2(20)
);

INSERT INTO stud VALUES( 1, 'a','b','c');
INSERT into stud(no,mname) VALUES(2,'b');
INSERT into stud(no,fname) VALUES(2,'a');

--DEFAULT
CREATE TABLE stud
(
    no number,
    fname VARCHAR2(20) UNIQUE,
    mname VARCHAR2(20) NOt NULL,
    lname VARCHAR2(20),
    city VARCHAR2(10) DEFAULT 'jamnagar'
);

INSERT INTO stud VALUES( 1, 'a','b','c','rajkot');
INSERT into stud(no,mname) VALUES(2,'b');

--CHECK on Table
CREATE TABLE stud
(
    no number,
    fname VARCHAR2(20) UNIQUE,
    mname VARCHAR2(20) NOt NULL,
    lname VARCHAR2(20),
    city VARCHAR2(10) DEFAULT 'jamnagar',
    age number CHECK(age>18)
);
INSERT into stud(no,mname,age) VALUES(2,'b',21);

--Primary KEY
CREATE TABLE stud
(
    no number PRIMARY KEY,
    fname VARCHAR2(20) UNIQUE,
    mname VARCHAR2(20) NOt NULL,
    lname VARCHAR2(20),
    city VARCHAR2(10) DEFAULT 'jamnagar',
    age number CHECK(age>18)
);
INSERT INTO stud VALUES(1, 'a','b','c','rajkot',19);
INSERT INTO STUD (no,mname,age)values(2,'a',21);

--Table level PRIMARY KEY
CREATE TABLE stud
(
    no number,
    fname VARCHAR2(20),
    mname VARCHAR2(20),
    lname VARCHAR2(20),
    PRIMARY KEY(fname,mname,lname)
);

INSERT into stud values(1,'a','b','c');

INSERT into stud values(1,'a','b','d');

INSERT into stud values(1,'a','b','b');

INSERT into stud values(1,'b','b','b');

-- Create a new relational table with 3 columns

CREATE TABLE course 
(
  no number NOT NULL PRIMARY KEY,
  name VARCHAR2(5)
);
INSERT INTO course(no,name) VALUES(1,'BCA');
INSERT INTO course VALUES(2,'MCA');
INSERT INTO course VALUES(3,'MBA');
INSERT INTO course VALUES(4,'BBA');

CREATE TABLE stud
(
    no number NOT NULL PRIMARY KEY,
    fname VARCHAR2(20),
    mname VARCHAR2(20),
    lname VARCHAR2(20),
    cno number REFEREnces course(no)
);
insert into stud values(1,'a','b','c',2)
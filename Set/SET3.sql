-- STUDENT (rollno, name, class, birthdate)
-- COURSE (courseno, coursename, max_marks, pass_marks)
-- SC (rollno, courseno, marks)


CREATE TABLE STUDENT(
    rollno number NOT NULL PRIMARY KEY, 
    name VARCHAR2(100), 
    class VARCHAR2(10) UNIQUE, 
    birthdate number
    );

CREATE TABLE COURS(
    courseno number NOT NULL PRIMARY KEY, 
    coursename VARCHAR2(20), 
    max_marks number check(max_marks=100), 
    pass_marks number check(pass_marks>=35)  
);

CREATE TABLE SC(
    rollno number NOT NULL, 
    courseno number NOT NULL, 
    marks number,
    srollno number references student(rollno),
    scourseno NUMBER references COURS(courseno),
    PRIMARY KEY(rollno,courseno)
);

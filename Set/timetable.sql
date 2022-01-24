Department
Dno
DName

semester
Sem


Subject 
Sno
SName

Faculty
Fno
Fname

TimeTable
Dno 
Sem
Sno
Fno
Strat_lec
End_lec
Day('MON','TUE','WED','THU','FRI','SAT')
Type(T,P)


CREATE TABLE Department
(
    Dno int,
    Dname VARCHAR2(25),
    PRIMARY KEY(Dno)
);


INSERT into Department values(1,'MCA');
INSERT into Department values(2,'BCA');
INSERT into Department values(3,'BBA');


CREATE TABLE Semester
(
    Semno int,
    PRIMARY KEY(Semno)
);

INSERT into Semester VALUES(1);
INSERT into Semester VALUES(2);
INSERT into Semester VALUES(3);
INSERT into Semester VALUES(4);
INSERT into Semester VALUES(5);
INSERT into Semester VALUES(6);

CREATE TABLE Subject
(
    Sno int,
    Subject_Name VARCHAR2(25),
    PRIMARY KEY(Sno)
); 


insert into Subject VALUES(1,'RDBMS');
insert into Subject VALUES(2,'WDT');
insert into Subject VALUES(3,'C');
insert into Subject VALUES(4,'JAVA');
insert into Subject VALUES(5,'BCC');
insert into Subject VALUES(6,'BM');
insert into Subject VALUES(7,'SP-2');
insert into Subject VALUES(8,'E-1');
insert into Subject VALUES(9,'DAA');
insert into Subject VALUES(10,'E-2');
insert into Subject VALUES(11,'ML');
insert into Subject VALUES(12,'SE');

CREATE TABLE Faculties
(
    Fno int,
    Fname VARCHAR2(50),
    PRIMARY KeY(Fno)
);


insert into Faculties VALUES(1,'BR');
insert into Faculties VALUES(2,'BJ');
insert into Faculties VALUES(3,'NL');



CREATE TABLE TimeTable
(
    Dno 
    Sem
    Sno
    Fno
    Strat_lec
    End_lec
    Day('MON','TUE','WED','THU','FRI','SAT')
    Type(T,P)
);
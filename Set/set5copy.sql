create table HOSTEL(
    hno number(10) PRIMARY KEY,
    hname VARCHAR2(20) NOT NULL,
    haddr VARCHAR2(20) NOT NULL,
    total_capacity number(10),
    warden VARCHAR2(20)
);

insert into HOSTEL(hno,hname,haddr,total_capacity,warden)values(1,'DELUX HOSTEL','RJKT CITY',10,'KESHWALA');
insert into HOSTEL(hno,hname,haddr,total_capacity,warden)values(2,'ECONOMY HOSTEL','JMGR CITY',8,'RAMWALA');
insert into HOSTEL(hno,hname,haddr,total_capacity,warden)values(3,'A ONE HOSTEL','AHMD CITY',5,'BHAIWALA');
insert into HOSTEL(hno,hname,haddr,total_capacity,warden)values(4,'B ONE HOSTEL','DUBAI CITY',15,'ATARWALA');
insert into HOSTEL(hno,hname,haddr,total_capacity,warden)values(5,'NEW HOSTEL','LS CITY',2,'WALA');

create table ROOM(
    hno number(10) REFERENCES HOSTEL(hno),
    rno number(10) NOT NULL,
    rtype VARCHAR2(20) NOT NULL,
    location VARCHAR2(20) NOT NULL,
    no_of_students number(10),
    status VARCHAR2(20),
    PRIMARY KEY(hno,rno)
);

insert into ROOM (hno,rno,rtype,location,no_of_students,status)values (1,1,'ONE BAD','1 floor',1,'OCCUPIED');
insert into ROOM (hno,rno,rtype,location,no_of_students,status)values(1,2,'DOUBLE BAD','1 floor',2,'OCCUPIED');
insert into ROOM (hno,rno,rtype,location,no_of_students,status)values(1,3,'THREE BAD','1 floor',3,'OCCUPIED');
insert into ROOM (hno,rno,rtype,location,no_of_students,status)values(1,4,'FOUR BAD','1 floor',4,'OCCUPIED');
insert into ROOM (hno,rno,rtype,location,no_of_students,status)values(1,5,'FIVE BAD','1 floor',5,'OCCUPIED');
insert into ROOM values(1,6,'FIVE BAD','1 floor',5,'vacant');


create table CHARGES(
    hno number(10) REFERENCES HOSTEL(hno),
    rtype VARCHAR2(20) NOT NULL,
    charges number(20),
    PRIMARY KEY(hno,rtype)
);


insert into CHARGES (hno,rtype,charges)values (1,'ONE BAD',10000);
insert into CHARGES (hno,rtype,charges)values (2,'DOUBLE BAD',20000);
insert into CHARGES (hno,rtype,charges)values (3,'THREE BAD',30000);
insert into CHARGES (hno,rtype,charges)values (4,'FOUR BAD',40000);
insert into CHARGES (hno,rtype,charges)values (5,'FIVE BAD',50000);


create table STUDENTS(
    sid int PRIMARY KEY,
    sname VARCHAR(20) NOT NULL,
    mobile_no number(10),
    gender VARCHAR(10)CHECK(gender in('Male','Female')),
    faculty VARCHAR(10) NOT NULL,
    dept VARCHAR(10) NOT NULL,
    class VARCHAR(10) NOT NULL,
    hno int REFERENCES HOSTEL(hno),
    rno int 
);

insert into STUDENTS(sid,sname,mobile_no,gender,faculty,dept,class,hno,rno)values(1,'HARSHIT',99999999,'Male','BR','IT','A',1,1);
insert into STUDENTS(sid,sname,mobile_no,gender,faculty,dept,class,hno,rno)values(2,'PRIYANK',99988999,'Male','BR','IT','B',2,2);
insert into STUDENTS(sid,sname,mobile_no,gender,faculty,dept,class,hno,rno)values(3,'BHURO',99119999,'Male','BR','IT','A',3,3);
insert into STUDENTS(sid,sname,mobile_no,gender,faculty,dept,class,hno,rno)values(4,'BRO',99333999,'Male','BR','IT','B',4,4);
insert into STUDENTS(sid,sname,mobile_no,gender,faculty,dept,class,hno,rno)values(5,'BHAI',992229999,'Male','BR','IT','A',5,5);
insert into STUDENTS(sid,sname,mobile_no,gender,faculty,dept,class,hno,rno)values(6,'BHAI',99229999,'Male','BR','IT','A',5,5);


create table FEES(
    sid int PRIMARY KEY,
    fdate date,
    famount number(10)
);


insert into FEES(sid,fdate,famount)values(1,'27-AUG-2000',10000);
insert into FEES(sid,fdate,famount)values(2,'17-AUG-2000',20000);
insert into FEES(sid,fdate,famount)values(3,'07-AUG-2000',30000);
insert into FEES(sid,fdate,famount)values(4,'25-AUG-2000',40000);
insert into FEES(sid,fdate,famount)values(5,'21-AUG-2000',50000);






CREATE or REPLACE TRIGGER t2
BEFORE INSERT or UPDATE  on STUDENTS
FOR EACH ROW
DECLARE
    msg VARCHAR2(100);
BEGIN
        msg:='';
        IF LENGTH(:NEW.mobile_no)<10 
        THEN
            IF inserting THEN
                msg:=' insert ';
            ELSIF updating then
                msg:=' update '; 
            END IF;
        RAISE_APPLICATION_ERROR(-20000,'You can not'||msg||'record if mobile_no  is less than 10 digits');
        END IF;               
END;
/


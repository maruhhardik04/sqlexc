create table hostel
(
hno number(10) primary key,
hname varchar2(20) NOT NULL,
haddr varchar2(20) NOT NULL,
total_capacity number(10),
warden varchar2(20)
);


insert into hostel values(1,'Tejash Patel','navsari',500,'vidhi');
insert into hostel values(2,'Shashi Patel','surat',100,'vidhi');
insert into hostel values(3,'Dhaval Shah','surat',500,'kamini');
insert into hostel values(4,'Raju','bombay',500,'pooja');
insert into hostel values(5,'viren','bombay',100,'pooja');

create table room(
    hno number(10) references hostel(hno),
    rno number(10) not null,
    rtype varchar2(10) not null,
    location varchar2(10) not null,
    no_of_students number(5),
    status varchar2(20),
    primary key(hno,rno)
);


insert into room values(1,1,'s','haj',500,'vacant');
insert into room values(2,1,'f','haj',500,'occupied');
insert into room values(2,3,'s','haj',500,'vacant');
insert into room values(2,2,'t','haj',500,'vacant');
insert into room values(2,4,'f','haj',500,'vacant');
insert into room values(1,5,'s','haj',500,'occupied');

create table charges(
hno number(10) references hostel(hno),
rtype varchar2(10) not null,
          charges number(10),
          primary key(hno,rtype)
);

insert into charges VALUES(1,'d',5000);
insert into charges VALUES(2,'s',5000);
insert into charges VALUES(3,'t',5000);
update charges set rtype='s' where hno='3';

create table STUDENTS(
    sid number(10) primary key,
    sname varchar2(20),
    saddr varchar2(20),
    faculty varchar2(20),
    dept varchar2(10),
    class varchar2(10),
    hno number(10) references hostel(hno),
    rno number(10)
);

insert into STUDENTS VALUES(1,'meet','city light','Tejash sir',1,'mca2',1,2);
insert into STUDENTS VALUES(2,'karan','Undhana road','Shashi sir',2,'mca2',2,2);
insert into STUDENTS VALUES(3,'jay','city light','neha mam',3,'mca2',3,2);
insert into STUDENTS VALUES(4,'sami','Undhana road','khusbhoo mam',2,'mca2',4,2);
insert into STUDENTS VALUES(5,'kunal','city light','Tejash sir',3,'mca2',5,2);

create table fees(
          sid number(10),
          fdate date,
          famount number(10),
          primary key(sid,fdate)
);

insert into fees VALUES(1,'02-OCT-18',500);
insert into fees VALUES(2,'08-OCT-18',500);
insert into fees VALUES(3,'12-OCT-18',500);
insert into fees VALUES(4,'22-OCT-18',500);
insert into fees VALUES(5,'27-OCT-18',500);


-- 1. Display the total number of rooms that are presently vacant.
SELECT count(rno) from room where status='vacant';

-- 2. Display number of students of each faculty and department wise staying in each
-- hostel.
select s.faculty,s.dept,h.hname,count(sid) 
from students s,hostel h
where s.hno=h.hno 
GROUP by faculty,dept,hname;

-- 3. Display hostels, which have at least one single-seated room
SELECT h.hname from hostel h, room r
where 
r.rtype='s'
and 
h.hno=r.hno;

or

SELECT h.* from hostel h, room r
where 
r.rtype='s'
and 
h.hno=r.hno;

-- 4. Display the warden name and hostel address of students of Computer Science
-- department.

SELECT warden,haddr from 
hostel a,students b WHERE a.hno=b.hno and b.dept=3

-- 5. Display those hostel details where single seated or double-seated rooms are vacant
    SELECT * from hostel  where 
    hno in(SELECT a.hno from hostel h,room a 
    where a.status='vacant'
    and a.rtype in('s','f') 
    AND h.hno=a.hno
    ); 


-- 6. Display details of hostels occupied by medical students
SELECT * from hostel where hno in
(select r.hno 
from room r,hostel h
where r.hno=h.hno
and r.rno in
(SELECT s.rno from room r,students s where s.dept=3 and s.rno=r.rno)
);


-- 7. Display hostels, which are totally occupied to its fullest capacity
select a.* from hostel a, room b
where b.hno = a.hno and b.status = 'occupied';

SELECT  * from hostel where (hno,total_capacity)
in
(SELECT hno,count(sid) from students GROUP by hno);


-- 8. List details about students who are staying in the double-seated rooms of Chanakya
-- Hostel.
select * from students  where  hno in(
    SELECT a.hno from hostel a,room b 
    where a.hno=b.hno
    AND a.hname='Shashi Patel'
    and b.rtype='f'
);

-- 9. Display the total number of students staying in each room type of each hostel.
SELECT sum(no_of_students) as Total_Students,rtype 
FROM room
GROUP by rtype;


-- 10. Display details about students who have paid fees in the month of Nov. 2017.

SELECT * FROM students where sid in(
    SELECT sid from fees where to_char(fdate,'mon-yy')='oct-18'
);

-- 11. For those hostels where total capacity is more than 300, display details of students
-- studying in Science faculty.
select * from students where hno in(select hno from hostel where total_capacity>=300) and dept=3; 

-- 12. Display hostel details where there are at least 10 vacant rooms
SELECT * from hostel 
where hno in
(SELECT hno from room where  status='vacant' group by hno HAVING count(rno)=4);


-- 13. Display details of students who have still not paid fees. 
SELECT * from students 
where
sid not in(select a.sid from fees a,students b where a.sid=b.sid);

-- 14. Display those hostels where single-seated room is the costliest
SELECT a.* from hostel a,charges b where b.rtype='s' 
and 
a.hno=b.hno
AND
charges=(SELECT MAX(charges) from charges);
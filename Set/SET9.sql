-- Create the database EXAM and create given tables with all necessary constraints such as
-- primary key, foreign key, unique key, not null and check constraints.
-- APPLICANT (AID, ANAME, ADDR, ABIRTH_DT)
-- ENTRANCE_TEST (ETID, ETNAME, MAX_SCORE, CUT_SCORE)
-- ETEST_CENTRE (ETCID, LOCATION, INCHARGE, CAPACITY)
-- ETEST_DETAILS (AID, ETID, ETCID, ETEST_DT, SCORE)
-- (This database is for a common entrance test which is being conducted at a number of centers
-- and can be taken by an applicant on any day except holidays)

CREATE TABLE APPLICANT(
    AID VARCHAR2(10) CHECK(AID LIKE 'A%'), 
    ANAME VARCHAR2(40) NOT NULL, 
    ADDR VARCHAR2(100) NOT NULL, 
    ABIRTH_DT DATE,
    primary key(AID)
    );

INSERT INTO APPLICANT VALUES('A1','x','ab','28-OCT-00');
INSERT INTO APPLICANT VALUES('A2','y','ac','19-FEB-99');    
INSERT INTO APPLICANT VALUES('A3','z','ad','28-SEP-98');
INSERT INTO APPLICANT VALUES('A4','w','ae','28-DEC-97');
INSERT INTO APPLICANT VALUES('A5','u','af','28-JAN-96');

CREATE TABLE ENTRANCE_TEST(
    ETID NUMBER primary key, 
    ETNAME VARCHAR2(30) not NULL,  
    MAX_SCORE NUMBER, 
    CUT_SCORE NUMBER 
    );

INSERT INTO ENTRANCE_TEST VALUES(1,'CMAT',400,200);
INSERT INTO ENTRANCE_TEST VALUES(2,'ORACLE FUNDAMENTALS',100,85);   
INSERT INTO ENTRANCE_TEST VALUES(3,'NEET',400,200);
INSERT INTO ENTRANCE_TEST VALUES(4,'JEE',400,250);
INSERT INTO ENTRANCE_TEST VALUES(5,'TAT',400,300);
INSERT INTO ENTRANCE_TEST VALUES(6,'abc',400,300);

CREATE TABLE ETEST_CENTRE(
    ETCID NUMBER primary key, 
    LOCATION VARCHAR(20) not null, 
    INCHARGE VARCHAR2(20) UNIQUE not NULL, 
    CAPACITY NUMBER
    );

INSERT INTO ETEST_CENTRE VALUES(1,'jamnagar','t',150);
INSERT INTO ETEST_CENTRE VALUES(2,'rajkot','u',200);
INSERT INTO ETEST_CENTRE VALUES(3,'surat','w',300);
INSERT INTO ETEST_CENTRE VALUES(4,'gandhinagar','q',250);
INSERT INTO ETEST_CENTRE VALUES(5,'porbandar','ti',150);


CREATE TABLE ETEST_DETAILS(
    AID VARCHAR2(10) REFERENCES APPLICANT(AID), 
    ETID NUMBER REFERENCES ENTRANCE_TEST(ETID), 
    ETCID NUMBER REFERENCES ETEST_CENTRE(ETCID), 
    ETEST_DT DATE, 
    SCORE NUMBER check(SCORE>=0),
    primary key(AID,ETID,ETCID)
    );

INSERT INTO ETEST_DETAILS VALUES('A1',1,1,'12-DEC-21',250);
INSERT INTO ETEST_DETAILS VALUES('A1',2,1,'12-DEC-21',90);
INSERT INTO ETEST_DETAILS VALUES('A1',3,1,'12-DEC-21',250);
INSERT INTO ETEST_DETAILS VALUES('A1',4,1,'12-DEC-21',300);
INSERT INTO ETEST_DETAILS VALUES('A1',5,1,'12-DEC-21',350);
INSERT INTO ETEST_DETAILS VALUES('A2',1,1,'12-DEC-21',250);
INSERT INTO ETEST_DETAILS VALUES('A2',2,2,'12-de-21',95);
INSERT INTO ETEST_DETAILS VALUES('A2',3,1,'12-DEC-21',250);
INSERT INTO ETEST_DETAILS VALUES('A2',4,1,'12-DEC-21',300);
INSERT INTO ETEST_DETAILS VALUES('A2',5,1,'12-DEC-21',350);
INSERT INTO ETEST_DETAILS VALUES('A3',2,3,'14-SEP-21',97);
INSERT INTO ETEST_DETAILS VALUES('A3',2,1,'12-DEC-21',95);
INSERT INTO ETEST_DETAILS VALUES('A4',3,4,'12-JAN-21',300);
INSERT INTO ETEST_DETAILS VALUES('A5',4,4,'12-OCT-21',350);
INSERT INTO ETEST_DETAILS VALUES('A5',4,5,'12-OCT-21',100);
INSERT INTO ETEST_DETAILS VALUES('A5',5,1,'12-OCT-21',400);

-- 1. Modify the APPLICANT table so that every applicant id has an ‘A’ before its
-- value. E.g. if value is ‘1123’, it should become ‘A1123’.
-- Display test center details where no tests were conducted.
-- Display details about applicants who have the same score as that of Ajaykumar in
-- ‘ORACLE FUNDAMENTALS’.

SELECT * from  ETEST_CENTRE where ETCID not in
(select ET.ETCID from 
ETEST_DETAILS ET,ETEST_CENTRE EC
where ET.ETCID=EC.ETCID
);



--  2. Display details of applicants who appeared for all tests.
select Aid from ETEST_DETAILS where ETID=ALL(select ETID from ENTRANCE_TEST);

select AID from
(
select Aid,Etid from ETEST_DETAILS where EXISTS (select ETID from ENTRANCE_TEST) 
) where ROWNUm<=(SELECT COUNT(etid) from ENTRANCE_TEST) GROUP BY aid;

select a.aid from ETEST_DETAILS a INNER JOIN  ENTRANCE_TEST b on a.Etid=b.Etid;

-- . Display those tests where no applicant has failed.
SELECT ETNAME from ENTRANCE_TEST where etid not in
(
select a.ETID from ETEST_DETAILS a,ENTRANCE_TEST b where 
a.SCORE<b.CUT_SCORE 
and a.ETID=b.ETID
);

--Sub Query
select a.AID,b.ETNAME from ETEST_DETAILS a,ENTRANCE_TEST b where 
a.SCORE<b.CUT_SCORE 
and a.ETID=b.ETID;



-- 4. Display details of entrance test centers which had full attendance between 1st Oct 15
-- and 15th Oct 16
    

        
select ETCID,CAPACITY from ETEST_CENTRE  where (ETCID,CAPACITY) in (SELECT ETCID,count(ETEST_DT) as Attd from  ETEST_DETAILS where ETEST_DT BETWEEN '14-SEP-21' and '12-OCT-21' GROUP by ETCID); 

SELECT count(ETEST_DT) as Attd,ETCID  from  ETEST_DETAILS where ETEST_DT BETWEEN '14-SEP-21' and '12-OCT-21' GROUP by ETCID


-- 5. Display details of the applicants who scored more than the cut score in the tests they
-- appeared in


select ap.* from APPLICANT ap,ETEST_DETAILS a,ENTRANCE_TEST b where 
a.SCORE>=b.CUT_SCORE 
and a.ETID=b.ETID
and ap.AID=a.aid;


-- 6.Display average and maximum score test wise of tests conducted at Mumbai

SELECT et.ETNAME,ec.LOCATION,avg(SCORE),MAX(SCORE) 
from 
ENTRANCE_TEST et,ETEST_CENTRE ec,ETEST_DETAILS ed
WHERE
et.ETID=ed.ETID and 
ed.ETCID=ec.ETCID and 
ec.LOCATION='jamnagar' 
GROUP by et.ETNAME,ec.LOCATION;



-- 7. Display the number of applicants who have appeared for each test, test center wise.
select count(AId) as NO_STUDENTS,e.ETNAME,ec.LOCATION 
from ETEST_DETAILS ed,ETEST_CENTRE ec,ENTRANCE_TEST e where
ed.ETCID=ec.ETCID AND
ed.etid=e.etid 
GROUP by ec.LOCATION,e.ETNAME order by NO_STUDENTS 

-- 8. Display details about test centers where no tests have been conducted.
 select * from ETEST_CENTRE WHERE ETCID not in(
 select DISTINCT ETCID from ETEST_DETAILS
 );


-- 9. For tests, which have been conducted between 2-3-17 and 23-4-17, show details of
-- the tests as well as the test centre.
select e.ETNAME,ec.LOCATION,ed.ETEST_DT
from ETEST_DETAILS ed,ETEST_CENTRE ec,ENTRANCE_TEST e where
ed.ETCID=ec.ETCID AND
ed.etid=e.etid and
ETEST_DT BETWEEN '14-SEP-21' and '12-OCT-21' 
GROUP by ec.LOCATION,e.ETNAME,ed.ETEST_DT;  

-- 10. How many applicants appeared in the ‘ORACLE FUNDAMENTALS’ test at
-- Chennai in the month of February?
select ed.AID,e.ETNAME,ec.LOCATION,ed.ETEST_DT
from ETEST_DETAILS ed,ETEST_CENTRE ec,ENTRANCE_TEST e where
ed.ETCID=ec.ETCID AND
ed.etid=e.etid and
e.ETNAME='ORACLE FUNDAMENTALS' andGROUP by ETCID,etid
ec.LOCATION='jamnagar' and
TO_CHAR(ed.ETEST_DT,'MON')='DEC';


-- 11. Display details about applicants who appeared for tests in the same month as the
-- month in which they were born
SELECT a.aid,a.ABIRTH_DT,b.ETEST_DT from APPLICANT a,ETEST_DETAILS b where a.aid=b.aid 
and 
TO_CHAR(a.ABIRTH_DT,'MON')=TO_CHAR(b.ETEST_DT,'MON');

-- 12. Display the details about APPLICANTS who have scored the highest in each test,
-- test centre wise.

SELECT ed.aid,ed.score,e.ETNAME,ec.LOCATION 
from ETEST_DETAILS ed,ETEST_CENTRE ec,ENTRANCE_TEST e where (ed.score,ed.ETCID,ed.etid) 
in
(
select max(score),ETCID,etid from ETEST_DETAILS GROUP by ETCID,etid  
)
and
ed.ETCID=ec.ETCID
and 
ed.etid=e.etid order by ed.etid;


-- 13. Design a read only view, which has details about applicants and the tests that he
-- has appeared for
CREATE VIEW app as
select a.AID,b.ETNAME from ETEST_DETAILS a,ENTRANCE_TEST b where a.ETID=b.ETID;


-- 14. Write a procedure which will print maximum score centre wise.
--Create a new Procedure



CREATE or REPLACE PROCEDURE max_score_center_wise 
IS

        CURSOR  ct
        is
        SELECT ETCID,max(score) as high from ETEST_DETAILS GROUP by ETCID;
BEGIN
    dbms_output.put_line(
            RPAD('CenterID',10)||
            RPAD('SCORE',10)   
    );
    for i in ct LOOP
            dbms_output.put_line(
                    RPAD(i.ETCID,10)||
                    RPAD(i.high,10)                
            );
    end loop;
End;
/


-- 15. Write a procedure which will print details of entrance test.


CREATE or REPLACE PROCEDURE details
IS

        CURSOR  ct
        is
        select a.AID,ec.LOCATION,ed.ETEST_DT,ed.score
        from 
        APPLICANT a,
        ETEST_DETAILS ed,
        ETEST_CENTRE ec,
        ENTRANCE_TEST e where
        a.aid=ed.aid and
        ed.etid=e.etid and
        ed.ETCID=ec.ETCID;
        
BEGIN
    dbms_output.put_line(
            RPAD('LOCATION',15)||
            RPAD('AID',10)||
            RPAD('ETEST_DATE',15)||   
            RPAD('SCORE',10)
    );
    for i in ct LOOP
            dbms_output.put_line(
                    RPAD(i.Location,15)||
                    RPAD(i.Aid,10)  ||
                    RPAD(i.ETEST_DT,15)  ||             
                    RPAD(i.score,10)
            );
    end loop;
End;
/

exec details;
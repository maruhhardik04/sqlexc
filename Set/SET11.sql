CREATE TABLE TRAIN_MASTER(
        TRAIN_NUMBER VARCHAR2(6) CHECK((TRAIN_NUMBER LIKE '%DN') or  (TRAIN_NUMBER LIKE '%UP')),
        TRAIN_NAME VARCHAR2(25) NOT NULL,
        ARRIVAL_TIME DATE NOT NULL,
        DEPARTURE_TIME DATE NOT NULL,
        NO_OF_HOURS NUMBER(5,2) NOT NULL,
        SOURCE_STATION VARCHAR2(25) NOT NULL,
        END_STATION VARCHAR2(25) NOT NULL,
        PRIMARY KEY(TRAIN_NUMBER)
);


INSERT into TRAIN_MASTER VALUES(
    '1972DN',
    'Rajdhani',
    TO_DATE('12/01/2016 7:08:25 AM', 'MM/DD/YYYY HH:MI:SS AM'),
    TO_DATE('12/01/2016 9:18:25 AM', 'MM/DD/YYYY HH:MI:SS AM'),
    2,
    'JAM',
    'RJK'
);


INSERT into TRAIN_MASTER VALUES(
    '9012DN',
    'EXPRESS',
    TO_DATE('12/16/2016 7:08 PM', 'MM/DD/YYYY HH:MI AM'),
    TO_DATE('12/17/2016 9:18 AM', 'MM/DD/YYYY HH:MI AM'),
    14,
    'Bombay',
    'Ahmedabad'
);




CREATE TABLE PASSENGER_DETAILS(
        TICKET_NUMBER NUMBER(5),
        TRAIN_NUMBER VARCHAR2(6),
        SEAT_NUMBER NUMBER(2) NOT NULL,
        PASSENGER_NAME VARCHAR2(35) NOT NULL,
        AGE NUMBER(2) NOT NULL,
        GENDER CHAR(1) CHECK(GENDER in('F','M')),
        TRAVEL_DATE DATE,
        CLASS VARCHAR2(4) CHECK(CLASS IN('IA', 'IIA', 'IIIA', 'IC','II')),
        FOREIGN KEY(TRAIN_NUMBER) REFERENCES TRAIN_MASTER (TRAIN_NUMBER) ON DELETE CASCADE
);

INSERT into PASSENGER_DETAILS VALUES(1,'9012DN',31,'xyz',25,'M','1-DEC-2016','IC');
INSERT into PASSENGER_DETAILS VALUES(2,'9012DN',30,'xyz',30,'F','2-DEC-2016','IA');
INSERT into PASSENGER_DETAILS VALUES(3,'9012DN',32,'xyz',30,'F','2-DEC-2016','IA');



CREATE TABLE TRAIN_SEAT_MASTER(
        TRAIN_NUMBER VARCHAR2(6) REFERENCES TRAIN_MASTER(TRAIN_NUMBER)  ON DELETE CASCADE,
        CLASS VARCHAR2(4) check(CLASS IN ('IA', 'IIA', 'IIIA', 'IC', 'II')), 
        TOTAL_SEATS NUMBER(2) CHECK(TOTAL_SEATS>= 25 AND TOTAL_SEATS<= 90)   
);

INSERT into TRAIN_SEAT_MASTER VALUES('9012DN','IA',25);
INSERT into TRAIN_SEAT_MASTER VALUES('9012DN','IIA',25);
INSERT into TRAIN_SEAT_MASTER VALUES('9012DN','IIIA',25);
INSERT into TRAIN_SEAT_MASTER VALUES('9012DN','IC',25);
INSERT into TRAIN_SEAT_MASTER VALUES('9012DN','II',25);



CREATE TABLE TRAIN_DAY_MASTER(
TRAIN_NUMBER VARCHAR2(6) REFERENCES TRAIN_MASTER(TRAIN_NUMBER) ON DELETE CASCADE,
DAY VARCHAR2(3) CHECK(DAY in('MON','TUE','WED','THU','FRI','SAT','SUN'))
);

INSERT INTO TRAIN_DAY_MASTER VALUES('9012DN','WED');
INSERT INTO TRAIN_DAY_MASTER VALUES('9012DN','TUE');
INSERT INTO TRAIN_DAY_MASTER VALUES('1972DN','WED');
INSERT INTO TRAIN_DAY_MASTER VALUES('1972DN','MON');
INSERT INTO TRAIN_DAY_MASTER VALUES('1972DN','SUN');




---1 Give all the train nanes starting from “Bombay” and going to “Ahmedabad” on Tuesday and Wednesday.
select tm.TRAIN_NAME
from 
TRAIN_MASTER tm, TRAIN_DAY_MASTER tdm
where 
tm.TRAIN_NUMBER=tdm.TRAIN_NUMBER and
(tm.SOURCE_STATION='Bombay' and tm.END_STATION='Ahmedabad') and 
tdm.TRAIN_NUMBER in(select TRAIN_NUMBER from TRAIN_DAY_MASTER where DAY='WED' and TRAIN_NUMBER in
(select TRAIN_NUMBER from TRAIN_DAY_MASTER where DAY='TUE'));
---or

select TRAIN_NAME from TRAIN_MASTER 
where 
TRAIN_NUMBER 
in
(select TRAIN_NUMBER from TRAIN_DAY_MASTER where DAY='WED' 
and TRAIN_NUMBER in
(select TRAIN_NUMBER from TRAIN_DAY_MASTER where DAY='TUE')) 
and 
(SOURCE_STATION='Bombay' and END_STATION='Ahmedabad');


---2 List all trains which is available on Sunday.
select TRAIN_NAME,TRAIN_NUMBER from TRAIN_MASTER where 
TRAIN_NUMBER in(select TRAIN_NUMBER from TRAIN_DAY_MASTER where DAY='MON');


---3 Give classwise seat availability on 10-June-2018 for train 9012DN


SELECT t.class,(t.TOTAL_SEATS-count(p.TRAIN_NUMBER)) as availability from 
PASSENGER_DETAILS p,TRAIN_SEAT_MASTER t
where p.class=t.class AND
t.TRAIN_NUMBER=p.TRAIN_NUMBER and 
p.TRAIN_NUMBER='9012DN' GROUP by t.class,t.TOTAL_SEATS;

--or

SELECT t.class,(t.TOTAL_SEATS-count(p.TRAIN_NUMBER)) as availability 
from 
PASSENGER_DETAILS p right join TRAIN_SEAT_MASTER t
on p.class=t.class AND
t.TRAIN_NUMBER=p.TRAIN_NUMBER 
and 
p.TRAIN_NUMBER='9012DN' GROUP by t.class,t.TOTAL_SEATS order by t.class;


--select count(TRAIN_NUMBER) as total,class from PASSENGER_DETAILS where TRAIN_NUMBER='9012DN' GROUP by class order by class
--select TOTAL_SEATS,class from  TRAIN_SEAT_MASTER where TRAIN_NUMBER='9012DN' order by class


---4 List total seats classwise for train running on thrusday.
select tsm.* from 
 TRAIN_SEAT_MASTER tsm, TRAIN_DAY_MASTER tdm
where tsm.TRAIN_NUMBER=tdm.TRAIN_NUMBER and
tdm.DAY='TUE';

-- 5. List train names which have no sleeper class.
select  tm.TRAIN_NAME 
from TRAIN_MASTER tm,PASSENGER_DETAILS pd
where 
tm.TRAIN_NUMBER=pd.TRAIN_NUMBER 
and 
class NOT IN ('sleeper class');




-- 6. List train number which run on Monday during 8:00: am to 1:00pm.

select tm.TRAIN_NUMBER 
from 
TRAIN_MASTER tm, TRAIN_DAY_MASTER tdm
where (to_char(ARRIVAL_TIME,'HH')>=07 or
to_char(DEPARTURE_TIME,'HH')<=09) and 
tdm.DAY='MON' and
tm.TRAIN_NUMBER=tdm.TRAIN_NUMBER;



-- 7. Write a procedure which will print all train details going from Baroda to Banglore.
select * from TRAIN_MASTER where SOURCE_STATION='Bombay' and  END_STATION='Ahmedabad';

CREATE OR REPLACE PROCEDURE p1
IS
        CURSOR ct is
        select * from TRAIN_MASTER where SOURCE_STATION='Bombay' and  END_STATION='Ahmedabad';
BEGIN
        for r in ct loop
        
                        dbms_output.put_line(
                        rpad (r.TRAIN_NUMBER,15)||
                        rpad (r.TRAIN_NAME,15)||
                        rpad (r.ARRIVAL_TIME,15)||
                        rpad (r.DEPARTURE_TIME,15)||
                        rpad (r.NO_OF_HOURS,15)||
                        rpad (r.SOURCE_STATION,15)||
                        rpad (r.END_STATION,15)
                );
        end  loop;             
END;        
/

-- 8. Write a function which will print arrival time and departure time for a given train. (
-- pass train no as a parameter)

create or replace function f1(tno VARCHAR2)
RETURN VARCHAR2
IS
    x VARCHAR2(20);
    y VARCHAR2(20);
    z VARCHAR2(20);
    BEGIN
            select TRAIN_NUMBER,ARRIVAL_TIME ,DEPARTURE_TIME into x,y,z from 
            TRAIN_MASTER where TRAIN_NUMBER=tno;
            RETURN ('Train No:'||x||
                    '  Arrival:'||y||
                    '  Departure:'||z
            );  
    END;
/    

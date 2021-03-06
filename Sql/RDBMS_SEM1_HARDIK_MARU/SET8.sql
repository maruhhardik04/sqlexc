-- SCREEN (SCREEN_ID, LOCATION, SEATING_CAP)
-- MOVIE (MOVIE_ID, MOVIE_NAME, DATE_OF_RELEASE)
-- CURRENT (SCREEN_ID, MOVIE_ID, DATE_OF_ARRIVAL,
-- DATE_OF_CLOSURE)

CREATE TABLE SCREEN(
    SCREEN_ID VARCHAR(10) check(SCREEN_ID LIKE 'S%'), 
    LOCATION VARCHAR(2)CHECK(LOCATION in('FF','SF','TF')), 
    SEATING_CAP NUMBER CHECK(SEATING_CAP <=100),
    primary key(SCREEN_ID)
    );

insert into SCREEN values('S1','FF',80);
insert into SCREEN values('S2','SF',70);
insert into SCREEN values('S3','TF',60);
insert into SCREEN values('S4','FF',50);
insert into SCREEN values('S5','SF',40);
insert into SCREEN values('S6','SF',40);



CREATE TABLE MOVIE(
    MOVIE_ID NUMBER primary key, 
    MOVIE_NAME VARCHAR2(15), 
    DATE_OF_RELEASE date
    );

insert into MOVIE values(1,'MOVIE 1','21-AUG-2021');
insert into MOVIE values(2,'MOVIE 2','22-AUG-2021');
insert into MOVIE values(3,'MOVIE 3','23-AUG-2021');
insert into MOVIE values(4,'MOVIE 4','24-AUG-2021');
insert into MOVIE values(5,'MOVIE 5','25-AUG-2021');
INSERT INto Movie VALUES(6,'star wars III','28-FEB-2005');
INSERT INto Movie VALUES(7,'star wars III','18-FEB-2005');


CREATE TABLE CURR(
    SCREEN_ID VARCHAR2(10) REFERENCES SCREEN(SCREEN_ID), 
    MOVIE_ID NUMBER REFERENCES MOVIE(MOVIE_ID), 
    DATE_OF_ARRIVAL date,
    DATE_OF_CLOSURE date
    );

insert into CURR values('S1',1,'21-AUG-2021','11-SEP-2021');
insert into CURR values('S2',2,'22-AUG-2021','12-SEP-2021');
insert into CURR values('S3',3,'23-AUG-2021','13-SEP-2021');
insert into CURR values('S4',4,'24-AUG-2021','14-SEP-2021');
insert into CURR values('S4',4,'25-AUG-2021','18-OCT-2021');
insert into CURR values('S5',5,'25-AUG-2021','15-SEP-2021');
insert into CURR values('S5',5,'25-AUG-2021','17-SEP-2021');

COMMIT

-- 1. Get the name of movie which has run the longest in the multiplex so far.
SELECT MOVIE_NAME from movie where MOVIE_ID=
(
        select MOVIE_ID from
        (select MOVIE_ID,(DATE_OF_CLOSURE - DATE_OF_ARRIVAL) as t from curr order by t desc) 
        where ROWNUM=1
);

-- 2. Get the average duration of a movie on screen number ???S4???.
select SCREEN_ID,AVG(DATE_OF_CLOSURE- DATE_OF_ARRIVAL) as average_duration from curr where SCREEN_ID='S4' GROUP by SCREEN_ID;

-- 3. Get the details of movie that closed on date 24-november-2004.
SELECT * FROM MOVIE a,curr b  where SCREEN_ID=(select SCREEN_ID from curr where  DATE_OF_CLOSURE='12-SEP-2021') and a.MOVIE_ID=b.MOVIE_ID;


-- 4. Movie ???star wars III ???was released in the 7th week of 2005. Find out the date of its
-- release considering that a movie releases only on Friday.


to_char(DATE_OF_RELEASE,'W')='7' AND
to_char(DATE_OF_RELEASE,'DAY')='FRI' AND
--or
select MOVIE_NAME,to_char(DATE_OF_RELEASE,'iW') as week,to_char(DATE_OF_RELEASE,'DAY') as day,to_char(DATE_OF_RELEASE,'YYYY') as yy from movie
WHERE
to_char(DATE_OF_RELEASE,'YYYY')='2005' AND
MOVIE_NAME='star wars III';
;
--or
select * from movie
WHERE
to_char(DATE_OF_RELEASE,'iW')=7 AND
trim(to_char(DATE_OF_RELEASE,'DAY')) = 'FRIDAY' AND
to_char(DATE_OF_RELEASE,'YYYY')=2005 AND
 MOVIE_NAME='star wars III';


--  5. Get the full outer join of the relations screen and current.
select s.*, c.* from SCREEN s FULL OUTER JOIN CURR c on s.screen_id=c.screen_id
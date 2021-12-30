
CREATE TABLE DOCTOR(
                    DNO number PRIMARY KEY NOT NULL, 
                    DNAME varchar2(50), 
                    SPECIALIZATION VARCHAR2(50), 
                    CLINIC_ADDR VARCHAR2(50));

insert into DOCTOR values(1,'DR.SHAH','SURGION','PARK ROAD');
insert into DOCTOR values(2,'DR.MEHTA','SURGION','NEHRU ROAD');
insert into DOCTOR values(3,'DR.VIRANI','SURGION','P.N ROAD');
insert into DOCTOR values(4,'DR.VORA','SURGION','M.N ROAD');
insert into DOCTOR values(5,'DR.RUPANI','SURGION','O.K ROAD');
insert into DOCTOR values(6,'DR.RUPA','SURGION','O.K ROAD');


CREATE TABLE MEDICINE(
                    MNO NUMBER PRIMARY KEY NOT NULL, 
                    MNAME VARCHAR2(200), 
                    TYPE VARCHAR2(100), 
                    CONTENT VARCHAR2(100), 
                    MANUFACTURER VARCHAR2(100));



insert into MEDICINE values(1,'METACINE','FEVER','NOT BELOW 18','VIRANI');
insert into MEDICINE values(2,'O2','INFECTION','NOT BELOW 19','SHAH');
insert into MEDICINE values(3,'COMBIFLAME','THROUGHT','NOT BELOW 20','VORA');
insert into MEDICINE values(4,'O2H','INFECTION','NOT BELOW 21','MEHTA');
insert into MEDICINE values(5,'STREPSEEL','COUGH','NOT BELOW 22','NEHRA');                    

CREATE TABLE DISEASE(
                    DISEASE_NAME VARCHAR2(100) PRIMARY KEY NOT NULL, 
                    SYMPTOM1 VARCHAR2(100), 
                    SYMPTOM2 VARCHAR2(100), 
                    SYMPTOM3 VARCHAR2(100));


insert into DISEASE values('CANCER','PAIN','COUGH','COLD');
insert into DISEASE values('COVID','COUGH','PAIN','COLD');
insert into DISEASE values('DANGUE','COLD','COUGH','PAIN');
insert into DISEASE values('N1H1','PAIN','COUGH','COLD');
insert into DISEASE values('FLU','PAIN','COUGH','COLD');


CREATE TABLE TREATMENT(
                    TNO NUMBER PRIMARY KEY NOT NULL, 
                    DNO NUMBER REFERENCES DOCTOR(DNO), 
                    DISEASE_NAME VARCHAR2(100) REFERENCES DISEASE(DISEASE_NAME), 
                    MNO NUMBER REFERENCES MEDICINE(MNO), 
                    DOSAGE int , 
                    AVG_CURE_TIME NUMBER);


insert into TREATMENT values(1,1,'CANCER',1,100,1);
insert into TREATMENT values(2,2,'COVID',2,200,2);
insert into TREATMENT values(3,3,'DANGUE',3,300,3);
insert into TREATMENT values(4,4,'N1H1',4,400,4);
insert into TREATMENT values(5,5,'FLU',5,500,5); 
insert into TREATMENT values(6,5,'FLU',5,400,5);               

-- 1. Display records of each table in ascending order.
select * from DOCTOR order by DNO;
select * from MEDICINE order by MNO;
select * from DISEASE order by DISEASE_NAME;
select * from TREATMENT order by TNO;

-- 2. Count total number of doctors which has not given any treatment
select * from DOCTOR where dno  not in(select dno from TREATMENT); 

-- 3. Display all Chennai doctors who treat cancer
select * from doctor where dno=(select dno from TREATMENT where DISEASE_NAME='CANCER') and CLINIC_ADDR='PARK ROAD'; 

-- 4. Remove disease “polio” from disease table as well as treatment table
DELETE from  TREATMENT where DISEASE_NAME='COVID';
DELETE from DISEASE where DISEASE_NAME='COVID';

-- 5. Delete all those treatment related to liver of Dr.Shah.
DELETE  from TREATMENT a where dno 
in
(select dno from TREATMENT where DISEASE_NAME='N1H1' 
and dno=(select dno from doctor where DNAME='DR.VORA'));

DELETE from TREATMENT where DISEASE_NAME='N1H1' and
dno=(select dno from doctor where DNAME='DR.VORA');


-- 6. Create index on dno, Disease name in the treatment table
CREATE INDEX indx_dno_desname on TREATMENT(dno,DISEASE_NAME);

-- 7. Display details of doctors who treat migraines
select * from doctor where dno=(select dno from TREATMENT where DISEASE_NAME='DANGUE');

--8. What is the maximum dosage of “penicillin” prescribe by the doctor for the
-- treatment of any disease?

SELECT MAX(DOSAGE) from TREATMENT where mno=(select mno from MEDICINE WHERE MNAME='STREPSEEL');

-- 9. Display total number of disease treated by every doctor.
SELECT COUNT(DISEASE_NAME)  as NumberofD,dno from TREATMENT GROUP by  dno;
SELECT COUNT(a.DISEASE_NAME)  as NumberofD,b.DNAME from TREATMENT a ,DOCTOR b where a.dno=b.dno GROUP by DNAME ;    

-- 10. Which doctor have no treatment for “depression”?

SELECT * FROM `doctor` WHERE dno not in (SELECT dno FROM treatment WHERE disease_name = 'fever');
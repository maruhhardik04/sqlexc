
create table DISTRIBUTOR
(
    dno int PRIMARY KEY,
    dname VARCHAR2(10),
    daddress VARCHAR2(10),
    dphone number(10),
    CONTACT_PERSON VARCHAR2(20) NOT NULL ---altered in 1st query.
);


insert into DISTRIBUTOR values(1,'SHAH','DUBAI',1293998880,'mr.bhuro');
insert into DISTRIBUTOR values(2,'MEHTA','RAJKOT',4295998880,'mr.bha');
insert into DISTRIBUTOR values(3,'VORA','SURAT',5294928880,'Mr.Talkative');
insert into DISTRIBUTOR values(4,'OBO','ADCITY',67828880,'mr.bro');
insert into DISTRIBUTOR values(5,'ABCDOHOB','ACITY',6787680,'mr.handsome');

CREATE TABLE ITEM(
    itemno int primary key, 
    itemname VARCHAR2(25), 
    colour VARCHAR2(10), 
    weight NUMBER
    );


insert into ITEM values(1,'IPHONE','RED',100);
insert into ITEM values(2,'CHARGER','WHITE',200);
insert into ITEM values(3,'CABLE','BLACK',300);
insert into ITEM values(4,'WIRELESS','BLACK',500);
insert into ITEM values(5,'LESS','BLACK',400);


CREATE TABLE DIST_ITEM(
    dno int REFERENCES DISTRIBUTOR(dno), 
    itemno int REFERENCES ITEM(itemno), 
    qty NUMBER
    );


insert into DIST_ITEM values(1,1,10);
insert into DIST_ITEM values(1,1,20);
insert into DIST_ITEM values(4,1,40);
insert into DIST_ITEM values(2,4,600);
insert into DIST_ITEM values(2,4,600);
insert into DIST_ITEM values(3,3,30);
insert into DIST_ITEM values(3,3,15);

---1 Add a column CONTACT_PERSON to the DISTRIBUTOR table with the not null constraint.
alter table DISTRIBUTOR add CONTACT_PERSON VARCHAR2(20) NOT NULL;


---3 Display the details of all those items that have never been supplied.
select itemname from ITEM where itemno not in(select itemno from DIST_ITEM);


---4 Delete all those items that have been supplied only once.
DELETE FROM DIST_ITEM 
WHERE dno IN(SELECT dno FROM DIST_ITEM GROUP BY dno HAVING COUNT(*)=1);

---5 List names of distributors who have an ‘A’ and also a ‘B’ somewhere in their names.
select dname from DISTRIBUTOR where dname like '%A%' or dname like '%B%';

---6 Count the number of items having the same colour but not having weight
--- between 20 and 100.
select count(*) from ITEM 
WHERE weight not BETWEEN 100 and 200 group by colour having count(*)>1;


--7 Display all those distributors who have supplied more than 1000 parts of the same type.
select d.dname
from DISTRIBUTOR d, DIST_ITEM di
where d.dno=di.dno group by d.dname having sum(di.qty)>=1000;


--8 Display the average weight of items of the same colour provided at least three items
-- have That colour.
select avg(weight) from ITEM group by colour having count(*)>2;

--9 Display the position where a distributor name has an ‘OH’ in its spelling somewhere
-- after the fourth character.
select dname from DISTRIBUTOR where dname like '____OH%';

-- 10. Count the number of distributors who have a phone connection and are supplying item
-- number ‘I100’.
select count(dname) from DISTRIBUTOR where dno in(select dno from DIST_ITEM where itemno=1);


-- 12 List the name, address and phone number of distributors who have the same three
-- digits in their number as ‘Mr. Talkative’.
select dphone from DISTRIBUTOR 
where dphone like (select dphone from DISTRIBUTOR where dname='SHAH');

-- 13. List all distributor names who supply either item I1 or I7 or the 
-- quantity supplied is more than 100.


-- 14. Display the data of the top three heaviest ITEMS.
SELECT weight
FROM (SELECT weight FROM ITEM order by weight DESC)
WHERE ROWNUM <= 3;
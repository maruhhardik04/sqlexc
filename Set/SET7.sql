-- Create the database SHOPPING and create given tables with all necessary constraints such as
-- primary key, foreign key, unique key, not null and check constraints.
-- CUSTOMER (cno, cust_name, cust_phone, location,gender)
-- ITEM (itemno, itemname, color, weight, expire_date, price, shop_name)
-- CUST_ITEM (cno, itemno, quantity_purchased, date_purchase)


-- Create a new relational table with 3 columns

CREATE TABLE CUSTOMER(       
    cno NUMBER primary Key NOt NUll, 
    cust_name VARCHAR2(50), 
    cust_phone NUMBER(10) UNIQUE, 
    location VARCHAR2(10),
    gender VARCHAR2(6) CHECK(gender in('Male','Female'))
);

CREATE TABLE ITEM
(   itemno Number primary key NOT NULL, 
    itemname VARCHAR2(20) UNIQUE, 
    color VARCHAR2(10), 
    weight NUMBER(10), 
    expire_date date,
    price NUMBER(5), 
    shop_name VARCHAR2(10)
);

CREATE table CUST_ITEM(
    cno number REFERENCES CUSTOMER(cno), 
    itemno number references ITEM(itemno), 
    quantity_purchased NUMBER, 
    date_purchase date,
    PRIMARY key(cno,itemno)
);

alter TABLE 

--data of CUSTOMER
insert into  CUSTOMER VALUES(1,'xyz',9999999999,'NY','Male');
insert into  CUSTOMER VALUES(2,'wxyz',9988888888,'NY','Male');
insert into  CUSTOMER VALUES(3,'uwxyz',9777777777,'DL','Female');
insert into  CUSTOMER VALUES(4,'tuwxyz',9666666666,'MU','Female');
insert into  CUSTOMER VALUES(5,'cxyz',9555555555,'MU','Male');

--data of items
INSERT into item values(1,'Laptop','white',5000,'28-AUG-22',60000,'x');
INSERT into item values(2,'SMARTPHONE','black',200,'29-DEC-21',15000,'x');
INSERT into item values(3,'CHARGER','brown',100,'20-JAN-22',1000,'x');
INSERT into item values(4,'xyz','red',500,'10-MAR-23',25000,'x');
INSERT into item values(5,'yz','green',250,'28-SEP-23',30000,'x');

--data of cust_item
INSERT into cust_item VALUES(1,1,5,'19-AUG-20');
INSERT into cust_item VALUES(2,2,5,'19-JAN-21');
INSERT into cust_item VALUES(3,3,5,'19-DEC-20');
INSERT into cust_item VALUES(3,4,10,'19-DEC-20');
INSERT into cust_item VALUES(1,4,10,'19-DEC-20');
INSERT into cust_item VALUES(1,5,10,'19-DEC-20');

-- 1. Delete the items whose price is more than 50000.
DELETE from item where price>=50000;

-- 2. Find the names of the customer who is located in same location as that of other
-- customer

SELECT * from CUSTOMER where location 
in
(
 select location from CUSTOMER GROUP by location HAVING count(*)>=2
); 

-- 3. Display the names of items which is black, white & brown in color.
select * from item WHERE color in ('black','white','brown');


-- 4. Display the names of all the items whose names lies between ‘p’ and‘s’
select * from item where itemname BETWEEN 'C' and 'Z';

-- 5. Find the item which is having less weight
select * from item where weight=(SELECT MIN(weight) from item);

-- 6. Add one month more to those items whose item no =40.
UPDATE item set 
expire_date=ADD_MONTHS(expire_date,1)
where itemno=1;

-- 7. Count total number of items which is going to expire in next month
SELECT count(*) from item where TO_CHAR(expire_date,'MON')=(select TO_CHAR(ADD_MONTHS(SYSDATE,1),'MON') from DUAL);

-- 8. List all customers whose phone number starts with ‘99’.
SELECT * from customer where cust_phone LIKE '99%';

-- 9. Display total value (qty*price) for all items.

select a.price,b.quantity_purchased,(a.price*b.quantity_purchased) as  Toatal_value 
from item a,cust_item b 
where a.itemno=b.itemno;

-- 10. List customer details who has purchased maximum number of items
-- select * from customer where  customer where cno= 
-- -- select MAX(MAXI), from (select  count(cno) as MAXI ,cno from cust_item GROUP by cno) cust_item GROUP by cno;

-- select  count(cno),cno from cust_item GROUP by cno;

SELECT * from customer where cno=(
select cno from cust_item  GROUP by cno having count(cno)=(
select  max(ic) from (select cno, count(cno) as ic from cust_item GROUP by cno)));

or
SELECT * from(select cno, count(cno) as ic from cust_item GROUP by cno) where ROWNUM=1;


-- 11. Display total price item wise.
As above 9

-- 12. List name of items, customer details and qty purchased
select c.*,a.itemname,b.quantity_purchased  from customer c,item a,cust_item b where a.itemno=b.itemno and c.cno=b.cno;


-- 3. Write a PL/SQL procedure which will display records in the following forma
-- Item number
-- Item name
-- Expire date
-- Quantity 
--Price 
-- Total Rs

CREATE or REPLACE PROCEDURE detail
is 
    CURSOR c1
    is
        select a.itemno,itemname,expire_date,quantity_purchased,price,shop_name,(quantity_purchased*price) as Total 
        from  ITEM a,cust_item 
        where 
        a.itemno = cust_item.itemno
        and shop_name='x';
        DT Date;
        SP_NAME VARCHAR2(20);
        Total_Rs NUMBER;
    BEGIN
            SP_NAME:='Shop-1';
            Total_Rs:=0;
            Select SYSDATE into DT from DUAL;
            dbms_output.put_line('------------------------------------------------------');
            dbms_output.put_line('Today Date: '||DT ||'             '||'Shop Name: '||SP_NAME);
            dbms_output.put_line('------------------------------------------------------');

            for r in c1 LOOP    
                dbms_output.put_line
                (
                    RPAD(TO_CHAR(r.itemno),5) ||
                    RPAD(TO_CHAR(r.itemname),15) ||
                    LPAD(TO_CHAR(r.expire_date),12) ||
                    LPAD(TO_CHAR(r.price),8) ||
                    LPAD(TO_CHAR(r.quantity_purchased),8) ||
                    LPAD(TO_CHAR(r.Total),8) 
                );
                Total_Rs:=Total_Rs+r.Total;
           end loop;     

             dbms_output.put_line('------------------------------------------------------');
            dbms_output.put_line('Grand Total Rs:'||Total_Rs);
            dbms_output.put_line('------------------------------------------------------');
    END;    
    /

   exec detail; 


--    14. Write a trigger which do not allow insertion / updation / deletion of Item details on
-- Sunday.
 

CREATE or REPLACE TRIGGER t1 
BEFORE DELETE or INSERT or UPDATE on item 
for EACH ROW
when('SUNDAY'== (SELECT trim(to_char(sysdate,'DAY'))from dual))
BEGIN
     dbms_output.put_line('Sunday');
END;
/


-- 14. Write a trigger which do not allow insertion / updation / deletion of Item details on
-- Sunday.


CREATE or REPLACE TRIGGER t5
BEFORE INSERT or UPDATE or DELETE on item
FOR EACH ROW
DECLARE
    msg VARCHAR2(100);
BEGIN
        msg:='';
        IF  trim(to_char(sysdate,'DAY'))='SUNDAY' THEN
            IF inserting THEN
                msg:=' insert ';
            ELSIF updating then
                msg:=' update ';
            else
                msg:= ' delete '; 
            END IF;
        RAISE_APPLICATION_ERROR(-20000,'You can not'||msg||'record because today is sunday');
        END IF;               
END;
/
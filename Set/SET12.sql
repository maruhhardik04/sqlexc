

CREATE TABLE CUSTOMER(
    cid int Primary Key, 
    fname VARCHAR2(15), 
    lname VARCHAR2(15), 
    city VARCHAR2(20), 
    country VARCHAR2(20), 
    phone NUMBER);

INSERT into CUSTOMER VALUES(1,'a','b','xya','qta',1234567890);
INSERT into CUSTOMER VALUES(2,'d','e','xyb','qtb',1234567890);   
INSERT into CUSTOMER VALUES(3,'g','h','xyc','qtc',1234567890);
INSERT into CUSTOMER VALUES(4,'j','k','xyd','qtd',1234567890); 
INSERT into CUSTOMER VALUES(5,'m','n','xyf','qte',1234567890);

CREATE TABLE ORD(
    oid int, 
    oDate DATE, 
    oNumber NUMBER, 
    cid REFERENCES CUSTOMER(cid), 
    oTotalAmount NUMBER
);

INSERT into Ord VALUES(1,'19-DEC-21',10,1,5000);
INSERT into Ord VALUES(2,'19-NOV-21',11,2,6500);
INSERT into Ord VALUES(3,'19-SEP-21',12,3,8000);
INSERT into Ord VALUES(4,'19-FEB-21',13,4,4000);
INSERT into Ord VALUES(5,'19-JAN-21',14,5,11000);
INSERT into Ord VALUES(6,'19-DEC-21',10,1,5000);
INSERT into Ord VALUES(7,'19-DEC-21',10,2,5000);


---1 List the number of customers in each country. Only include countries with more than 100 customers
select count(fname),country from CUSTOMER group by country having count(fname)>2;


---2 List the number of customers in each country, except China, sorted high to low.
-- Only include countries with 5 or more customers
select count(fname),country from CUSTOMER where country not in('US') group by country order by country DESC;


---3 List all customers with average orders between Rs.5000 and Rs.6500.
select fname from CUSTOMER where cid in(
select cid from Ord group by cid having avg(oTotalAmount) between 5000 and 10000);



-- 4. Create a trigger that executes whenever country is updated in CUSTOMER table.

CREATE or REPLACE TRIGGER T7
BEFORE   UPDATE  on CUSTOMER
FOR EACH ROW

BEGIN
        dbms_output.put_line('You are updating record customer'||:OLD.country || ' to '||:NEW.country||' country in customer');               
END;
/





-- 5. Create a function to return customer with maximum orders.

create or replace function f1
RETURN VARCHAR2
IS
    name VARCHAR2(25);
    BEGIN
            SELECT fname||' '||lname into name from CUSTOMER where cid in(
            select cid  from Ord group by  cid having count(cid)
            =(select max(count(cid)) from ord GROUP by cid));
            RETURN name;
    END;
/
--query
SELECT fname,lname from CUSTOMER where cid in(
select cid  from Ord group by  cid having count(cid)
=(select max(count(cid)) from ord GROUP by cid));

--for multiple value
create or REPLACE function test_cursor 
            return SYS_REFCURSOR
            as
                    name  SYS_REFCURSOR;
            begin
                    open name 
                    for
                        SELECT fname,lname from CUSTOMER where cid in (
                        select cid  from Ord group by  cid having count(cid)
                        =(select max(count(cid)) from ord GROUP by cid));
                    return name;
            end;
 /     

-- DECLARE
--        CURSOR c is test_cursor;
-- BEGIN   
        
--         OPEN c
--         for i in c loop
--             dbms_output.put_line(i.fname);
--         end loop;    
-- END;


--  6. Create a procedure to display month names of dates of ORDER table. The month
-- names should be unique.


CREATE OR REPLACE PROCEDURE p1
IS
        CURSOR ct is
        select DISTINCT  UPPER(to_char(oDate,'month')) as mname from ord;
BEGIN
        dbms_output.put_line('------------');
        dbms_output.put_line('Month Name');
        dbms_output.put_line('------------');
        for r in ct loop
                dbms_output.put_line(r.mname);
        end  loop;       
        dbms_output.put_line('-------');      
END;        
/




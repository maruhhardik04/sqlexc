

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



---1 List the number of customers in each country. Only include countries with more than 100 customers
select count(fname),country from CUSTOMER group by country having count(fname)>2;


---2 List the number of customers in each country, except China, sorted high to low.
-- Only include countries with 5 or more customers
select count(fname),country from CUSTOMER where country not in('US') group by country order by country DESC;


---3 List all customers with average orders between Rs.5000 and Rs.6500.
select fname from CUSTOMER where cid in(
select cid from Ord group by cid having avg(oTotalAmount) between 5000 and 10000);



-- 1. Find out the names of all the tables, views and constraints associated with current
-- tables in the system
SELECT * from  tab;

select OBJECT_NAME from user_objects
WHERE
object_type='TABLE' or object_type='VIEW'; 

select OBJECT_NAME from user_objects
WHERE object_type='VIEW';

SELECT * from user_cons_columns where TABLE_name='EMP';



-- 2. Write a query to add 15 days to the current date.
SELECT SYSDATE,SYSDATE+15 from dual;


-- 3. Write a query to Add and subtract 5 months from the current month.
SELECT 
sysdate,
ADD_MONTHS(SYSDATE,5) as "Add_Month_5",
ADD_MONTHS(SYSDATE,-5) as "Sub_Month_5"
from dual;

-- 4. Find out the ASCII equivalent of character ‘M’
SELECT ASCII('M') from dual;

-- 5. Find out the character equivalent of ASCII 67, 65 and 84.
select CHR(67),CHR(65),CHR(84) from dual;

-- 6. Write a query to find the last day of the month.  
select LAST_DAY(SYSDATE) from dual;


-- 7. Find out how many days are left in the current month.
select (LAST_DAY(SYSDATE)-SYSDATE) as "left_days_in_current_month" from dual;

-- 8. Write a query to calculate the Date difference between current date and 20/05/2015.
select (SYSDATE-TO_DATE('20/05/2015','dd-mm-yyyy')) from dual;

-- 9. Write a query to Calculate the number of months between current date and
-- 03/03/2016.
SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('03/03/2016','DD-MM-YYYY')) "Months" from dual;

-- 10. Find out the second occurrence of ‘or’ from third position in the string ‘corporate floor
    -- .
SELECT INSTR('Corporate Floor','or') from dual;


-- 11. Find out log to the base 3 of 81.
SELECT LOG(3,81) from dual;

-- 12. Convert the string ‘gujarat technological university’ so that first character of each
-- work is in capital.
SELECT INITCAP('gujarat technological university')from dual;

-- 13. Convert the string ‘jack and jue’ Into ‘black and blue’.
SELECT REPLACE('jack and jue','j','bl') from dual;

-- 14. Round off the date 27-July-2016 to the current year.
SELECT TRUNC(to_date('27-July-2016','dd-mm-yyyy') /*DATE*/,
                 'YEAR'/*FMT*/) from dual;

SELECT ROUnd(to_date('27-July-2016','dd-mm-yyyy') /*DATE*/,
                 'YEAR'/*FMT*/) from dual;                 

-- 15. Find out the user name and user id off currently logged on user.
SELECT USERNAME from V$SESSION;                 
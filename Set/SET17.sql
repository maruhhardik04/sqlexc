
CREATE TABAUTH ACCOUNT (
        AC_NO int primary key,
        NAME VARCHAR2(10),
        AC_TYPE VARCHAR2(10),
        BALANCE_AMT int, 
        BALANCE_DATE DATE
);



CREATE TABAUTH TTRANSACTION(
AC_NO int REFERENCES ACCOUNT(AC_NO),
TDATE DATE,
TR_TYPE VARCHAR2(20),
AMOUNT int, 
PREV_BALANCE int,
REMARK VARCHAR2(20));

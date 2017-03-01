--=================================================================
-- Class:       CIT 325 
-- Assignment:  Lab11, Triggers
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        November 26, 2016
--===================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Create a DDL trigger on an event.
-- Create a test program that creates the action to trigger the event.
--===================================================================
-- create a table to use for trigger event--
CREATE TABLE employee
( emp_id          NUMBER
, first_name      VARCHAR2(8)
, last_name       VARCHAR2(8)
);
-- create a table to use for trigger event--
CREATE TABLE employee_log
( emp_log_id      NUMBER
, trigger_name    VARCHAR2(20)
, trigger_timing  VARCHAR2(8)
, trigger_event   VARCHAR2(8)
, trigger_type    VARCHAR2(20) 
);

-- create a trgger to ensure securit--
CREATE OR REPLACE TRIGGER time_check
           BEFORE INSERT ON employee

DECLARE 
        days_of_week      NUMBER(8);
        hours_of_week     VARCHAR2(40);

BEGIN
        -- set aa local variables
        days_of_week   := TO_CHECK(SYSDATE, 'DY');
        hours_of_week  := TO_CHECK(SYSDATE, 'HH24');

       -- test the days and time
        IF days_of_week IN ('SAT', 'SUN') OR 
           hours_of_week NOT BETWEEN 8 AND 17
THEN 
        --rasie error and stop activity
        dbm_output.put_line('TRANSACTION REJECT FOR SECURITY REASON');

END IF;
END;
/

--=================================================================
-- Create a DML trigger on INSERT or UPDATE action. It should work 
-- against a single table. The trigger should write to a log of the 
-- transaction to a table when the logic allows the DML statement to 
-- complete normally or when the logic disallows the DML statement.
--===================================================================
CREATE OR REPLACE TRIGGER emp_t1
    BEFORE INSERT OR UPDATE ON employee
    FOR EACH ROW

DECLARE
-- Declare local trigger veriables--
trigger_emp_id      NUMBER:= employee_id.NEXTVAL;
trigger_emp_name    VARCHAR2(20):='EMP_T1';
trigger_emp_timing  VARCHAR2(8):= 'BEFORE';
trigger_emp_event   VARCHAR2(8):= 'INSERT';
trigger_emp_type    VARCHAR2(20):= 'STATEMENT';

BEGIN
-- Event into employee--
INSERT INTO employee_log
( emp_log_id
, trigger_name
, trigger_timing
, trigger_type
, trigger_event)

VALUES
( trigger_emp_id
, trigger_emp_name
, trigger_emp_timing
, trigger_emp_type
, trigger_emp_event);

CREATE OR REPLACE TRIGGER emp_t2
  AFTER INSERT ON employee

-- change the value of strings After--
trigger_emp_name    VARCHAR2(20):='EMP_T2';
trigger_emp_timing  VARCHAR2(8):= 'AFTER';
trigger_emp_event   VARCHAR2(8):= 'INSERT';
trigger_emp_type    VARCHAR2(20):= 'STATEMENT';

-- Insert a row into the employee table--
INSERT INTO employee
VALUES
( employee_id.NEXTVAL
, 'Alberto'
, 'Razo'
);

-- Query the employee_log table--
COLUMN emp_log_id FORMAT 999 HEADING "Employee| Log ID #"
COLUMN emp_name   FORMAT A20 HEADING "Trigger | Name"
COLUMN emp_timing FORMAT 999 HEADING "Trigger | Timing"
COLUMN emp_type   FORMAT 999 HEADING "Trigger | Type"
COLUMN emp_event  FORMAT 999 HEADING "Trigger | Event"

UPDATE employee
SET   emp_name = 'Micke'
WHERE emp_name = 'Alberto';

DELETE  FROM employee
WHERE emp_name = 'Alberto';

--================================================================
--Create an INSTEAD OF trigger on a view across two or more tables.
--Create a test program that creates the action to trigger the event.
--=================================================================
-- create employee user--
CREATE TABLE emp_user
( user VARCHAR(20) 
, login VARCHAR(20)  
, password VARCHAR(40));

-- trigger on a view emp_login-- 
CREATE VIEW emp_login(login, password) 
AS SELECT login, decrypt_char(password) 
     FROM emp_user AS u WHERE u.emp_user = USER
-- create instead trigger--
CREATE TRIGGER emp_login INSTEAD OF INSERT 
  ON employee REFERENCING NEW AS e 
  FOR EACH ROW MODE DB2SQL 
  
INSERT INTO emp_user
    VALUES(user_id, e.password, e.login); 
-- create a trigger to update the login in my emp table 
CREATE TRIGGER update_emp_login INSTEAD OF UPDATE 
  ON emp_login REFERENCING OLD AS o NEW AS e 
  FOR EACH ROW MODE DB2SQL 
  
  -- update the login and passord--
  UPDATE emp_user 
    SET login = e.login, 
        password = encrypt(e.password) 
  WHERE password = o.password 
      AND login = o.login 
      AND emp_user = USER

SET ENCRYPTION PASSWORD = 'unbreakable'

INSERT INTO emp_login 
  VALUES('Johan',   'johan','Gospel'), 
        ('Matthew', 'matt', 'JesusLovesUs'), 
        ('Peter',  'peter',  'LoveOneAnother');

--test my login--
UPDATE emp_login 
  SET password = 'loveTheLord' 
  WHERE password = 'Gospel' AND login = 'johan';

         
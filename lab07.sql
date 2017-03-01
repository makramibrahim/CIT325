--===================================================================
-- Class:       CIT 325 
-- Assignment:  Lab7, Function Procedures
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        October 29, 2016
--===================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Create a procedure that writes to the contact, address, 
-- and telephone tables, as qualified above.
--===================================================================
CREATE OR REPLACE PROCEDURE write_to_tables
         -- insert into the table all the columns 
                   ( pv_first_name        VARCHAR2
                   , pv_middle_name       VARCHAR2 := NULL
                   , pv_last_name         VARCHAR2
                   , pv_contact_type      VARCHAR2 
                   , pv_address_type      VARCHAR2
                   , pv_city              VARCHAR2
                   , pv_state             VARCHAR2
                   , pv_area_code         VARCHAR2 
                   , pv_telephone_number  NUMBER
                   , pv_created_by        NUMBER := 1
                   , creation_date        DATE := SYSDATE
                   , last_update_by       NUMBER := 1
                   , last_update_date     DATE := SYSDATE)
IS 
       -- Declare
        lv_contact_type      VARCHAR2(50);
        lv_address_type      VARCHAR2(50);
        lv_telephone_type    VARCHAR2(50);

BEGIN 
        -- Assign
        lv_contact_type    := pv_contact_type;
        lv_address_type    := pv_address_type;
        lv_telephone_type  := pv_telephone_number;

 SAVEPOINT start_point;

--=============================================================
--INSERT INTO THE CONTACT TABLE
--=============================================================
INSERT INTO contact 

VALUES  (contact_s1.nextval
        , member_s1.currval
        , pv_contact_type
        , pv_last_name
        , pv_middle_name
        , pv_created_by
        , pv_creation_date
        , pv_last_update_by
        , pv_last_update_date);

--=============================================================
--INSERT INTO THE ADDRESS TABLE
--=============================================================
INSERT INTO address
-- insert values for these col
VALUES  (address_s1_nexval
        , contact_s1.currval
        , pv_address_type
        , pv_city
        , pv_state_province 
        , pv_postal_code 
        , pv_created_by
        , pv_creation_date
        , pv_last_updated_by
        , pv_last_update_date);

--=============================================================
--INSERT INTO THE TELEPHONE TABLE
--=============================================================
INSERT INTO telephone
-- insert values for these col
VALUES  (telephone_s1.nextval
        , contact_s1.currval 
        , address_s1.currval
        , pv_telephone_type
        , pv_country_code
        , pv_area_code
        , pv_telephone_number
        , pv_created_by
        , pv_creation_date
        , pv_last_update_by
        , pv_last_update_date);

  COMMIT;
        write_to_tables('Commits after a successful insert into all tables' 
              || pv_contact_type || ' ' || pv_address_type || ' '
              || pv_telephone_number);

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK TO start_point;
    RETURN;
END write_to_tables;
/
          
--================================================================
-- Create an autonomous procedure that writes to the rental and 
-- rental_item tables. It should use transaction control languag 
-- (TCL) to commit inserts to both tables or not insert into either -- table.
--================================================================
CREATE OR REPLACE PROCEDURE write_to_rental
                        (pv_rental_id         NUMBER
                        ,pv_customer_id       NUMBER
                        ,pv_check_out_date    DATE
                        ,pv_return_date       DATE
                        ,pv_created_by        NUMBER := 1
                        ,pv_creation_date     DATE := SYSDATE
                        ,pv_last_updated_by   NUMBER := 1
                        ,pv_last_update_date  DATE := SYSDATE) 

IS 
       -- Declare 
        lv_contact_type      VARCHAR2(50);
        lv_address_type      VARCHAR2(50);
        lv_telephone_type    VARCHAR2(50);

BEGIN 
        -- assign
        lv_contact_type    := pv_contact_type;
        lv_address_type    := pv_address_type;
        lv_telephone_type  := pv_telephone_number;

SAVEPOINT start_point;

--=============================================================
--INSERT INTO RENTAL TABLE
--=============================================================
INSERT INTO rental
-- insert values for these col
VALUES
    (rental_s1.nextval
    ,pv_customer_id
    ,pv_check_out_date
    ,pv_return_date
    ,pv_created_by
    ,pv_creation_date
    ,pv_last_updated_by
    ,pv_last_update_date);

--=============================================================
--INSERT INTO RENTAL ITEM TABLE
--=============================================================
INSERT INTO rental_item
-- insert values for these col
 VALUES
    (rental_item_s1.nextval
    ,rental_s1.currval
    ,pv_item_id
    ,pv_rental_item_price
    ,pv_rental_item_type
    ,pv_created_by
    ,pv_creation_date
    ,pv_last_updated_by
    ,pv_last_update_date);

COMMIT;
        write_to_tables('Commits after a successful insert into all tables' 
                        || pv_contact_type || ' ' || pv_address_type || ' '
                        || pv_telephone_number);

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK TO start_point;
    RETURN;
END write_to_rental;
/

SELECT * FROM rental      WHERE CREATION_DATE = '29-OCT-16'; 
SELECT * FROM rental_item WHERE CREATION_DATE = '29-OCT-16';

--=================================================================
-- Create an autonomous function that calls the procedure that
-- writes to the contact, address, and telephone tables
--=================================================================
CREATE OR REPLACE FUNCTION call_procedure

IS 
        v_number NUMBER;

BEGIN
    -- insert values for these col
     write_to_tables ( 'David'
                     , 'NULL'
                     , 'HEARMAN' 
                     , 'CUSTOMER'
                     , '200-NORTH-400-WEST'
                     , 'PROVO'
                     , 'UTAH'
                     , '84601'
                     , '801-400-0000'
                     , '01'
                     , '29-OCT-2016'
                     , '01'
                     , '29-OCT-2016'
                     );

COMMIT;
  v_number := 1;
  dbms_output.put_line('Call Procedure')

  SELECT MAX(c.contact_id)
    INTO v_number
    FROM contact c;
  
  RETURN v_number;

END call_procedure;
/

--=================================================================
-- Create a query test case that calls the autonomous function.
-- Create a function that returns a list of full names in the 
-- last_name, first_name middle name format.
--================================================================
CREATE OR REPLACE FUNCTION test_case(last_name   VARCHAR2
                               ,first_name  VARCHAR2
                               ,middle_name VARCHAR2) 
RETURN VARCHAR2
  
IS
BEGIN
  RETURN last_name || ', ' || first_name || ' ' || middle_name;
END;
/

--==============================================================
-- Create a query test case that calls the function that returns 
-- formatted full_name value from the contact table.
--==============================================================
SELECT test_case(last_name, first_name, middle_name) AS full_name
  FROM contact
 ORDER BY last_name
         ,first_name
         ,middle_name;


        















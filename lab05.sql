--=====================================================================
-- Class:       CIT 325 
-- Assignment:  Lab5, Control Structures
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        October 15, 2016
--=====================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 

--=====================================================================
-- Create an anonymous block program that processes three to four external 
-- parameters, and assigns them as members of a three element varray of 
-- strings (VARCHAR2 data type).
--=====================================================================
DECLARE
  TYPE record IS VARRAY(4) OF VARCHAR2(20);
  
      -- Declare data collection here
  lv_record record := record(); 
  lv_record1 VARCHAR2(20);
  lv_record2 VARCHAR2(20);
  lv_record3 VARCHAR2(20);
  lv_record4 VARCHAR2(20);

BEGIN
       -- Prompt the user for input
  lv_record1 := '&1';
  lv_record2 := '&2';
  lv_record3 := '&3';
  lv_record4 := '&4';
  
        -- IF statement will check the length and mange varrary 
  IF lv_record1 IS NOT NULL AND LENGTH(lv_record1) > 0 
        THEN lv_record.EXTEND;
    lv_record(lv_record.COUNT) := lv_record1;
  END IF;

        --check the length
  IF lv_record2 IS NOT NULL AND LENGTH(lv_record2) > 0 
  THEN lv_record.EXTEND;
    lv_record(lv_record.COUNT) := lv_record2;
  END IF;

         --check the length
  IF lv_record3 IS NOT NULL AND LENGTH(lv_record3) > 0 
  THEN lv_record.EXTEND;
    lv_record(lv_record.COUNT) := lv_record3;
  END IF;

        --check the length
  IF lv_record4 IS NOT NULL AND LENGTH(lv_record4) > 0 
  THEN lv_record.EXTEND;
    lv_record(lv_record.COUNT) := lv_record4;
  END IF;

  --check the length
  dbms_output.put_line('Print data here:');
  FOR i in 1..lv_record.COUNT  LOOP
    dbms_output.put_line(lv_record(i));
  END LOOP;
  
END;
/

--=====================================================================
-- Create an anonymous block program that declares a RECORD, 
-- A table collection, a cursor loop, and a range loop.
--=====================================================================
DECLARE 
     
        -- table collection of the locally declared record type
        TYPE rec_table IS RECORD (full_name    VARCHAR(50)
                                 , city        VARCHAR(20)
                                 , state       VARCHAR(20)
                                 , street_address  VARCHAR(50)
                                );

        -- Declare record table 
        lv_record record := record();

        
    -- Cursor for loop that populates the collection by reading them
 
 CURSOR name 
  IS 
  SELECT street_address,
      (c.last_name ||  ', ' || c.first_name ||  ', ' || 
      c.middle_name) full_name , a.city , a.state
 -- cursor that joins the CONTACT, ADDRESS, and STREET_ADDRESS tables   
    FROM member m
         INNER JOIN contact c ON m.member_id = c.member_id
         INNER JOIN address a ON c.contact_id = a.contact_id
         INNER JOIN street_address sa ON a.address_id = sa.address_i      
-- orders the set in ascending alphabetical order on the full_name column
    WHERE line_number = 1
    ORDER BY full_name;

BEGIN
        --
        FOR R in name  LOOP
        
        lv_record.EXTEND
        lv_record(lv_record.COUNT).full_name      := R.full_name;
        lv_record(lv_record.COUNT).city           := R.city;
        lv_record(lv_record.COUNT).state          := R.state;
        lv_record(lv_record.COUNT).street_address := R.street_address;
END LOOP;
         
        --loop that reads through the list in descending order 
        dbms_output.put_line('Ge all data in descending order')
        
        FOR I IN REVERSE 1..lv_record.COUNT  LOOP
        dmbs_output.put_line(lv_record(i).full_name || ' ' 
                               || lv_record(i).city || ', '
                               || lv_record(i).state || ' '
                               || lv_record(i).street_address );
        END LOOP;
END;
/
                                
--=====================================================================
-- Create an anonymous block program that declares a RECORD, 
-- an associative array collection, a cursor loop, and a range loop.
--====================================================================
DECLARE

    TYPE rec_member IS RECORD (item_title  VARCHAR2(50)
                             , item_rating VARCHAR2(50)
                             );
                                                             
 -- An associate array of the locally declared RECORD type 
  TYPE array IS TABLE OF rec_member INDEX BY PLS_INTEGER;

  array array2;
  i_record rec_member

 i PLS_INTEGER;

  CURSOR R
  IS
  SELECT item_title , item_rating FROM item;

BEGIN
        i := 1; -- declare i by 1
        OPEN R;
         -- Fetch data to the record table.
         FETCH R into record;
         WHILE (R % FOUND) 
         LOOP
          array(i) := i_record;
          i := i + 1;    
          FETCH R into i_record;
        END LOOP
        CLOSE;

        -- Print all data 
        dbms_output.put_line('Get data here');

        FOR i IN array2.FIRST..array2.LAST LOOP

        dbms_output.put_line(array2(i).item_title
          || ' - ' || array2 (i).item_rating);
  END LOOP;

END;
/
         


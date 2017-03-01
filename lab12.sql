--=================================================================
-- Class:       CIT 325 
-- Assignment:  Lab12, Native Dynamic 
-- Instructor:  Brother MacLochlain,
-- Author:      Makram Ibrahim,
-- Date:        DECEMBER 15, 2016
--===================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Create a package specification that defines a record type and
-- table collection of the record type. Make sure the record type -- that matches one of your already defined tables, like
-- MEMBER,CONTACT, orRENTAL, et cetera.-===================================================================
CREATE OR REPLACE PACKAGE rec_type IS
 
-- Define a PL/SQL record structure
  TYPE member_record IS RECORD
  ( member_id         NUMBER
  , member_type       VARCHAR2(30)
  , member_name       VARCHAR2(50));
 
-- Define a PL/SQL record structure based on an Object-relational varray.
TYPE member_record_varray IS VARRAY(10) OF member_record;
 
--=================================================================
-- Create a pipelined table function that takes a table name as its
-- formal parameter and returns the contents of the table as
-- collection of records, where the collection data type is defined 
-- by your package specification.-===================================================================
CREATE OR REPLACE FUNCTION get_member_record_varray
( table_name  VARCHAR2
, column_name VARCHAR2 )
RETURN rec_type.member_record_varray IS
 
  -- Define a dynamic cursor that takes two formal parameters.
  CURSOR c (table_name_in VARCHAR2, table_column_name_in VARCHAR2) IS
    SELECT   member_id
    ,        member_type
    ,        member_meaning
    FROM     member_record
    WHERE    member_record_table = UPPER(table_name_in)
    AND      member_record_column = UPPER(table_column_name_in);
 
  -- Declare a counter variable.
  counter INTEGER := 1;
 
  -- Declare a package collection data type as the table function return type.
  list REC_TYPE.MEMBER_RECORD_VARRAY := rex_type.member_record_varray();
 
BEGIN
 
  -- Assign the cursor return values to a record collection.
  FOR i IN c(table_name, column_name) LOOP
    list.EXTEND;
	list(counter) := i;
    counter := counter + 1;
  END LOOP;
 
  -- Return the record collection.
  RETURN list;
END get_member_record_varray;
/

--=================================================================
-- Write an anonymous block program to test your newly created pipelined
-- table function.
--===================================================================
DECLARE
  -- Define a collection base on a package specification collection type.
  list REC_TYPE.MEMBER_RECORD_VARRAY;
BEGIN
  -- Assign the result of the function to a locally scoped variable.
  list := get_member_record_varray('ITEM','ITEM_TYPE');
 
  -- Read through the collection and reference the elements of the record structure.
  FOR i IN 1..list.COUNT LOOP
    DBMS_OUTPUT.put('['||list(i).member_id||']');
    DBMS_OUTPUT.put('['||list(i).member_type||']');
    DBMS_OUTPUT.put_line('['||list(i).member_name||']');
  END LOOP;
END;
/

--===================================================================
CREATE OR REPLACE PROCEDURE member_cursor
( table_name  VARCHAR2
, column_name VARCHAR2 ) SYS_REFCURSOR IS
  member_record SYS_REFCURSOR;
BEGIN
  OPEN member_record FOR
  SELECT   member_id
  ,        member_type
  ,        member_name
  FROM     member_record
  WHERE    member_record_table = UPPER(table_name)
  AND      member_record_column = UPPER(column_name);
      member_record := member_record;
END member_cursor;
/















 

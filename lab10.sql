--=================================================================
-- Class:       CIT 325 
-- Assignment:  Lab10, Packages
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        November 19, 2016
--===================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Create a BASE_T object with two attributes (or columns), the obj_id
-- and obj_name fields and a to_string method.
--===================================================================
CREATE OR REPLACE TYPE base_t IS OBJECT
(obj_id  NUMBER , obj_name VARCHAR2(50)
, CONSTRUCTOR FUNCTION base_t
(obj_id NUMBER, obj_name VARCHAR) 
RETURN SELF AS RESULT
, MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

--=================================================================
-- Create a HOBBIT_T object as a subtype of the BASE_T object that 
-- adds an hobbit_name attribute.
--===================================================================
CREATE OR REPLACE TYPE DERIVED UNDER base_t
(hobbit_name VARCHAR(20)
CONSTRUCTOR FUNCTION DERIVED 
RETURN SELF AS RESULT);

CREATE OR REPLACE TYPY BODY DERIVED AS
CONSTRUCTOR FUNCTION DERIVED 
RETURN SELF AS RESULT IS 
BEGIN 
       base_t(5);
END;

--=================================================================
-- Extends the to_string method of the parent class to use general
-- invocation for the obj_id and obj_name, and then add the hobbit_name
-- attribute of the HOBBIT_T object subtype.
--===================================================================
CREATE OR REPLACE TYPE BODY base_t AS
  
  CONSTRUCTOR FUNCTION base_t
 ((obj_id NUMBER, obj_name VARCHAR, hobbit_name VARCHAR2)  
  CONSTRUCTOR FUNCTION base_t 

  RETURN SELF AS RESULT IS
  BEGIN
    self.obj_id := obj_id;
    self.obj_name := obj_name;
    self.hobbit_name := hobbit_name;
    RETURN;
  END base_t;
  
  MEMBER FUNCTION to_string RETURN VARCHAR2 IS
  BEGIN
    dbm_output.put_line('BASE ID: '|| self.obj_id);
    dbm_output.put_line('BASE NAME: '|| self.obj_name);
    dbm_output.put_line('DERIVED NAME: '|| self.hobbit_name);
  END to_string;
  
END;
/
--=================================================================
-- As a test case, create a collection of 5 HOBBIT_T objects and then loop -- through the list of HOBBIT_T objects while printing their overriding
-- to_string method's results.
--===================================================================
-- Test whether the collection constructor works.
SELECT      DISTINCT *
FROM        TABLE(base_t(base_t.to_string(5)).hobbit_name)
ORDER BY 1;

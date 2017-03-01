/*
-- We need to see the output!
CLEAR SCREEN
SET SERVEROUTPUT ON

-----------------------------------------------------------------------------------------------------------
/*
Part 1

[20 points] Create a base_t object type that complies with the definition in the CIT325_Object_Types.pdf document. 

The base_t object should have a 
  get_oname function 
  get_name function 
  set_oname procedure 
  to_string function 

To that end, the get_name function should return a NULL value, which effectively creates a common definition without an implementation. 
The get_name function serves as an abstract method, which you'll implement in subtypes of the base_t object. 
(HINT: The ordering of columns in constructors must mirror the sequence of their definition in supertypes to their lowest subtypes. 
Any violation of that sequencing would raise a "too many declarations of ..." error.)
*/

-- Conditionally drop objects.
BEGIN
  FOR i IN (SELECT null
            FROM   user_sequences
            WHERE  sequence_name = 'TOLKIEN_S') LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE tolkien_s';
  END LOOP;
  FOR i IN (SELECT null
            FROM   user_tables
            WHERE  table_name = 'TOLKIEN') LOOP
    EXECUTE IMMEDIATE 'DROP TABLE tolkien CASCADE CONSTRAINTS';
  END LOOP;
  FOR i IN (SELECT null
            FROM   user_types
            WHERE  type_name = 'BASE_T') LOOP
    EXECUTE IMMEDIATE 'DROP TYPE base_t';
  END LOOP;
END;
/


CREATE OR REPLACE TYPE base_t IS OBJECT
(
  OID    NUMBER
, NAME   VARCHAR2(30)
, FINAL  CONSTRUCTOR FUNCTION base_t RETURN SELF AS RESULT
, MEMBER FUNCTION get_name RETURN VARCHAR2
, MEMBER PROCEDURE set_oname
, MEMBER FUNCTION to_string RETURN VARCHAR2
)
INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE BODY base_t IS

  CONSTRUCTOR FUNCTION base_t RETURN SELF AS RESULT IS
  BEGIN
    RETURN base_t;
  END base_t;

  MEMBER FUNCTION get_name RETURN VARCHAR2 IS
  BEGIN
    RETURN 'test';
  END get_name;

  MEMBER PROCEDURE set_oname IS
  BEGIN
    dbms_output.put_line('set_oname');
  END set_oname;

  MEMBER FUNCTION to_string RETURN VARCHAR2 IS
  BEGIN
    RETURN 'test';
  END to_string;

END;
/


/*
Part 2

[5 points] Create a tolkien table that has two columns: 
a tolkien_id primary key column that uses a NUMBER data type; 
and a character column that uses a BASE_T data type; 
and create a tolkien_s sequence that starts with a value of 1001.
*/

CREATE TABLE tolkien
( tolkien_id NUMBER PRIMARY KEY
, tolkien_c  BASE_T);

CREATE SEQUENCE tolkien_s START WITH 1001;


/*
Part 3

[25 points] Create the dwarf, elf, goblin, hobbit, maia, man, and orc object types and bodies that extend the behavior 
of the base_t object and complies with the definition of the hobbit object type (found in the CIT325_Final_Project.pdf document).
These the dwarf, elf, goblin, hobbit, maia, man, and orc object types and bodies should:

- Override the to_string function found in the base_t object type.
- Override the get_name function found in the base_t object type.
- Implement the get_genus function.
- Implement the set_name and set_genus procedures.
*/

/*
Part 4

[25 points] Create the noldor, silvan, sindar, and teleri object types and bodies that extend the behavior of the elf object 
and complies with the definition of the elf object type in the CIT325_Final_Project.pdf document. 
These object types and bodies should override the to_string function of the base_t object type. 
The noldor, silvan, sindar, and teleri object types should also implement the get_elfkind function and set_elfkind procedure.
*/


/*
Part 5

[25 points] Write an anonymous block program that inserts the object instances. Then, use the confirmation query from the 
CIT325_Final_Project.pdf file to verify the project.
*/


/*
Confirmation Query

*/

/*SET PAGESIZE 999
COLUMN objectid FORMAT 9999 HEADING "Object ID"
COLUMN name FORMAT A20 HEADING "Name"
COLUMN description FORMAT A40 HEADING "Description"

SELECT t.tolkien_oid AS objectid
      ,treat        (t.character AS base_t).get_name()  AS NAME
      ,treat        (t.character AS base_t).to_string() AS description
  FROM tolkien t
 ORDER BY treat(t.character AS base_t).get_name();*/
--=================================================================
-- Class:       CIT 325 
-- Assignment:  Final Project
-- Prof:        McLaughlinm
-- Author:      Makram Ibrahim
-- Date:        December 10, 2016
--=================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Create a base_t object type with comments that complies with 
-- the description.
--==================================================================
SET ECHO OFF
SET FEEDBACK ON
SET NULL '<Null>'
SET PAGESIZE 999

DROP TYPE BASE_T FORCE; 
DROP TYPE ELF_T FORCE;

-- creat a base object base table--
CREATE OR REPLACE TYPE base_t IS OBJECT 
( oid          NUMBER
, oname        VARCHAR2(30)
, name         VARCHAR2(20)
, CONSTRUCTOR FUNCTION base_t RETURN SELF AS RESULT
, CONSTRUCTOR FUNCTION base_t (oid NUMBER, oname VARCHAR2, name VARCHAR2) RETURN SELF AS RESULT
, MEMBER FUNCTION  get_oname RETURN VARCHAR2
, MEMBER FUNCTION  get_name  RETURN VARCHAR2
, MEMBER PROCEDURE set_oname 
, MEMBER PROCEDURE set_name 
, MEMBER FUNCTION  to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/
-- create the body type and define the objects
CREATE OR REPLACE TYPE BODY base_t IS

/* Default constructor */
CONSTRUCTOR FUNCTION base_t RETURN SELF AS RESULT IS
-- decalre local base object --
        lv_base_t BASE_T := base_t('BASE_T');
        BEGIN 
                self := lv_base_t; 
        RETURN;
        END base_t;    

/* Overide signature*/
CONSTRUCTOR FUNCTION base_t (oid NUMBER, oname VARCHAR2, name VARCHAR2)RETURN SELF AS RESULT
-- decalre local base object --
        BEGIN 
                self.oid := oid;
                self.oname := oname;
                self.name := name; 
        RETURN;
        END base_t; 
              
MEMBER FUNCTION get_oname RETURN VARCHAR2 IS 
 	BEGIN
 		RETURN self.oname;
 	END get_oname;

MEMBER PROCEDURE set_oname (oname VARCHAR2) IS 
	BEGIN
		self.oname := oname;
	END set_oname;

MEMBER FUNCTION get_name RETURN VARCHAR2 IS 
 	BEGIN
 		RETURN get_name;
 	END get_name;

MEMBER PROCEDURE set_name (name VARCHAR2) IS 
	BEGIN
		self.name := name;
	END set_name;

MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
	   RETURN (SELF AS base_t).to_string ||
           '['|| self.oid || '] ['|| self.oname ||'] ['|| self.name||']';
	END to_string;
END;
/
--=================================================================
-- Create a tolkien table that has two columns: a tolkien_id primary key
-- column that uses a NUMBER data type; and a character column that uses a
-- BASE_T data type; and create a tolkien_s sequence that starts with a 
-- value of 1001.
--==================================================================
CREATE TABLE tolkien 
( tolkien_id          NUMBER PRIMARY KEY
, c                   BASE_T);

CREATE SEQUENCE tolkien_s START WITH 1001;
--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE dwarf_t UNDER base_t  
( genus VARCHAR2(20) 
, CONSTRUCTOR FUNCTION dwarf_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2)  RETURN SELF AS RESULT

, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2
, MEMBER FUNCTION  get_genus RETURN VARCHAR2
, MEMBER PROCEDURE set_genus)

INSTANTIABLE NOT FINAL;
/ 

CREATE OR REPLACE TYPE BODY dwarf_t IS

CONSTRUCTOR FUNCTION dwarf_t(oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.oid   := oid;
               self.oname := oname;
               self.name  := name;
               self.genus := genus;
               
        RETURN;
        END dwarf_t;
 
MEMBER FUNCTION get_genus RETURN VARCHAR2 IS 
 	BEGIN
 		RETURN get_genus;
 	END get_genus;

MEMBER PROCEDURE set_genus (genus VARCHAR2) IS 
	BEGIN
	     --  self.oid   := lv_base_t_s.NEXTVAL;
               self.genus := 'DWARF_T'; 
	END set_genus;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
                '['|| self.genus || ']';
	END to_string;
END;
/
--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE elf_t UNDER base_t 
(CONSTRUCTOR FUNCTION elf_t 
(oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) 
RETURN SELF AS RESULT 
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 

CREATE OR REPLACE TYPE BODY elf_t IS

CONSTRUCTOR FUNCTION elf_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.oid   := oid;
               self.oname := oname;
               self.name  := name;
               self.genus := genus;              
        RETURN;
        END elf_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
                '['|| self.name ||'] ['|| self.genus ||']';
	END to_string;

END;
/
--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE goblin_t UNDER base_t 
(CONSTRUCTOR FUNCTION goblin_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 

CREATE OR REPLACE TYPE BODY goblin_t  IS
CONSTRUCTOR FUNCTION goblin_t 
(oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.oid   := oid;
               self.oname := oname;
               self.name  := name;
               self.genus := genus;               
        RETURN;
        END goblin_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
       '['|| self.oid || '] ['|| self.oname ||'] ['|| self.name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE hobbit_t UNDER base_t 
(CONSTRUCTOR FUNCTION hobbit_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION hobbit_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name;             
        RETURN;
        END hobbit_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
              '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['||   self.pv_name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE maia_t UNDER base_t 
(CONSTRUCTOR FUNCTION maia_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION maia_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name;             
        RETURN;
        END maia_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
              '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['||   self.pv_name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE man_t UNDER base_t 
(CONSTRUCTOR FUNCTION man_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION man_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name;             
        RETURN;
        END man_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
              '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['||   self.pv_name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE orc_t UNDER base_t 
(CONSTRUCTOR FUNCTION orc_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION orc_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name;             
        RETURN;
        END orc_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
              '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['||   self.pv_name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE noldor_t UNDER elf_t 
( elfkind VARCHAR2(20)
, CONSTRUCTOR FUNCTION noldor_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION noldor_t(oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name;             
        RETURN;
        END noldor_t;

MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS 
 	BEGIN
 		RETURN self.elfkind;
 	END get_elfkind;

MEMBER PROCEDURE set_elfkind (elfkind VARCHAR2) IS 
	BEGIN
		self.elfkind := elfkind;
	END set_elfkind;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS elf_t).to_string ||
              '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['||   self.pv_name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE silvan_t UNDER elf_t 
(CONSTRUCTOR FUNCTION  silvan_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION silvan_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name;             
        RETURN;
        END  silvan_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS elf_t).to_string ||
 '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['|| self.pv_name ||']';
	END to_string;

END;
/
--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE sindar_t UNDER elf_t 
(CONSTRUCTOR FUNCTION sindar_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION sindar_t(oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name; 
               self.elfkind := elfkind;
                            
        RETURN;
        END  silvan_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
        RETURN (SELF AS elf_t).to_string ||
     '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['|| self.pv_name ||']';
	END to_string;

END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE teleri_t UNDER elf_t 
(CONSTRUCTOR FUNCTION  teleri_t(oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/ 
 
CREATE OR REPLACE TYPE BODY goblin_t  IS

CONSTRUCTOR FUNCTION teleri_t (oid NUMBER, oname VARCHAR2, name VARCHAR2, genus VARCHAR2, elfkind VARCHAR2) RETURN SELF AS RESULT
        BEGIN 
               -- assign a parmeter to the subtype arrtibute--
               self.pv_number := oid;
               self.pv_oname  := oname;
               self.pv_name   := name; 
               self.elfkind := elfkind;            
        RETURN;
        END  teleri_t;

OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS elf_t).to_string ||
  '['|| self.pv_number || '] ['|| self.pv_oname ||'] ['|| self.pv_name ||']';
	END to_string;

END;
/

-------Confirm the object types were created correctly:-----
COLUMN  type_name      FORMAT A10 
COLUMN  supertype_name FORMAT A16 
COLUMN  final          FORMAT A5

SELECT type_name
, supertype_name
, final
FROM user_types
WHERE type_name IN ('BASE_T','DWARF_T','ELF_T','GOBLIN_T'
,'HOBBIT_T','MAIA_T','MAN_T','ORC_T' ,'NOLDOR_T','SILVAN_T','SINDAR_T','TELERI_T')
ORDER BY CASE
WHEN supertype_name IS NULL THEN 1
WHEN supertype_name = 'BASE_T' THEN 2
WHEN supertype_name = 'ELF_T' THEN 3 END
, type_name;

--=======================================================================
-- Write an anonymous block program that inserts the object instances.
-- Then, use the confirmation query from the CIT325_Final_Project.pdf file -- to verify the project.
--=======================================================================
DECLARE
       t.tolkien tolkien; 
BEGIN 
   INSERT INTO tolkien
VALUES(base_t(base_t_s.nextval, 'BASE_T'));
            
END;
/

SET PAGESIZE 999
COLUMN          objectid    FORMAT 9999 HEADING "Object ID" 
COLUMN          name        FORMAT A20 HEADING "Name"
COLUMN          description FORMAT A40 HEADING "Description"

SELECT t.tolkien_id AS objectid
,       TREAT(t.tolkien_character AS base_t).get_name() AS name 
,       TREAT(t.tolkien_character AS base_t).to_string() AS description 
FROM    tolkien t
ORDER BY TREAT(t.tolkien_character AS base_t).get_name();















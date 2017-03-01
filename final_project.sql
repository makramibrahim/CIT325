--=================================================================
-- Class:       CIT 325 
-- Assignment:  Final Project
-- Prof:        McLaughlinm
-- Author:      Makram Ibrahim
-- Date:        December 16, 2016
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

DROP TYPE base_t FORCE;
DROP TYPE dwarf_t FORCE;
DROP TYPE elf_t FORCE;
DROP TYPE noldor_t FORCE;
DROP TYPE silvan_t FORCE;
DROP TYPE sindar_t FORCE;
DROP TYPE teleri_t FORCE;
DROP TYPE goblin_t FORCE;
DROP TYPE hobbit_t FORCE;
DROP TYPE maia_t FORCE;
DROP TYPE man_t FORCE;
DROP TYPE orc_t FORCE;

DROP TABLE TOLKIEN;
DROP SEQUENCE BASE_S;
--CREATE SEQUENCE BASE_TS;

 
-- creat a base object base table--
CREATE OR REPLACE
  TYPE base_t IS OBJECT
  ( oid   NUMBER
  , oname VARCHAR2(30)
  , CONSTRUCTOR FUNCTION base_t RETURN SELF AS RESULT
  , MEMBER FUNCTION get_name RETURN VARCHAR2
  , MEMBER FUNCTION get_oname RETURN VARCHAR2
  , MEMBER PROCEDURE set_oname (oname VARCHAR2)
  , MEMBER FUNCTION to_string RETURN VARCHAR2)
  INSTANTIABLE NOT FINAL;
/

LIST
SHOW ERRORS

CREATE OR REPLACE
  TYPE BODY base_t IS
  /* Default constructor. */
  CONSTRUCTOR FUNCTION base_t RETURN SELF AS RESULT IS
  BEGIN
    /* Assign a sequence value and string literal
       to the instance. */
    self.oid := base_t_s.NEXTVAL;
    self.oname := 'BASE_T';
    RETURN;
  END;

  /* Get name. */
  MEMBER FUNCTION get_name RETURN VARCHAR2 IS
  BEGIN
    RETURN null;
  END get_name;

  /* Get oname. */
  MEMBER FUNCTION get_oname RETURN VARCHAR2 IS
  BEGIN
    RETURN self.oname;
  END get_oname;

  /* Set oname. */
  MEMBER PROCEDURE set_oname (oname VARCHAR2) IS
  BEGIN
    self.oname := oname;
  END set_oname;

  /* A text output function. */
  MEMBER FUNCTION to_string RETURN VARCHAR2 IS
  BEGIN
    RETURN '['||self.oid||']['||self.oname||']';
  END;
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
, character           BASE_T);

CREATE SEQUENCE tolkien_s START WITH 1001;

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE dwarf_t UNDER base_t  
( name VARCHAR2(20), genus VARCHAR2(20)
, CONSTRUCTOR FUNCTION dwarf_t 
(oid NUMBER, oname VARCHAR2, name VARCHAR2) RETURN SELF AS RESULT
, MEMBER FUNCTION  get_genus RETURN VARCHAR2
, MEMBER PROCEDURE set_genus(genus VARCHAR2)
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY dwarf_t IS

CONSTRUCTOR FUNCTION dwarf_t 
(oid NUMBER, oname VARCHAR2, name VARCHAR2)
RETURN SELF AS RESULT IS
        BEGIN 
  ----Assign a sequence value and string literal to the instance-----
               self.oid := base_t_s.NEXTVAL;
               self.oname := 'DWARF_T';
               self.name := name;
  ----Assign a parameter to the subtype only attribute----             
               self.genus := genus;
               
        RETURN;
        END;

 ------get genus-------
MEMBER FUNCTION get_genus RETURN VARCHAR2 IS 
 	BEGIN
 		RETURN slef.genus;
 	END get_genus;

---------set genus-------
MEMBER PROCEDURE set_genus (genus VARCHAR2) IS 
	BEGIN
               self.genus := genus; 
	END set_genus;

---------output function-----
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
              '['||oname||']['||name||'] ['||genus||']';
	END;
END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE elf_t UNDER base_t  
( name VARCHAR2(20), genus VARCHAR2(20)
, CONSTRUCTOR FUNCTION elf_t 
(oid NUMBER, oname VARCHAR2, name VARCHAR2) RETURN SELF AS RESULT
, MEMBER FUNCTION  get_genus RETURN VARCHAR2
, MEMBER PROCEDURE set_genus(genus VARCHAR2)
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/ 

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY elf_t IS

CONSTRUCTOR FUNCTION elf_t 
(oid NUMBER, oname VARCHAR2, name VARCHAR2)
RETURN SELF AS RESULT IS
        BEGIN 
  ----Assign a sequence value and string literal to the instance-----
               self.oid := base_t_s.NEXTVAL;
               self.oname := 'ELF_T';
               self.name := name;
  ----Assign a parameter to the subtype only attribute----             
               self.genus := genus;
               
        RETURN;
        END;

 ------get genus-------
MEMBER FUNCTION get_genus RETURN VARCHAR2 IS 
 	BEGIN
 		RETURN slef.genus;
 	END get_genus;

---------set genus-------
MEMBER PROCEDURE set_genus (genus VARCHAR2) IS 
	BEGIN
               self.genus := genus; 
	END set_genus;


---------output function-----
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
	BEGIN
		RETURN (SELF AS base_t).to_string ||
             '['||oname||']['||name||'] ['||genus||']';
	END;
END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE goblin_t UNDER base_t
( name VARCHAR2(30)
, CONSTRUCTOR FUNCTION goblin_t 
( name VARCHAR2 ) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY goblin_t IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION goblin_t 
( name VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'GOBLIN_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
        RETURN;
        END;

  --Get name.--
OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS
        BEGIN
                RETURN self.name;
        END get_name;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
        '['||oname||']['||name||'] ['||genus||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE hobbit_t UNDER base_t
( name VARCHAR2(30)
, CONSTRUCTOR FUNCTION hobbit_t
( name VARCHAR2 ) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY hobbit_t  IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION hobbit_t
( name VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'HOBBIT_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
        RETURN;
        END;

  --Get name.--
OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS
        BEGIN
                RETURN self.name;
        END get_name;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
        '['||oname||']['||name||'] ['||genus||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE maia_t UNDER base_t
( name VARCHAR2(30)
, CONSTRUCTOR FUNCTION maia_t
( name VARCHAR2 ) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY maia_t  IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION maia_t
( name VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'MAIA_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
        RETURN;
        END;

  --Get name.--
OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS
        BEGIN
                RETURN self.name;
        END get_name;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
        '['||oname||']['||name||'] ['||genus||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE man_t UNDER base_t
( name VARCHAR2(30)
, CONSTRUCTOR FUNCTION man_t
( name VARCHAR2 ) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY man_t  IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION man_t
( name VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'MAN_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
        RETURN;
        END;

  --Get name.--
OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS
        BEGIN
                RETURN self.name;
        END get_name;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
        '['||oname||']['||name||']['||genus||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE orc_t UNDER base_t
( name VARCHAR2(30)
, CONSTRUCTOR FUNCTION orc_t
( name VARCHAR2 ) RETURN SELF AS RESULT
, OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2)
INSTANTIABLE NOT FINAL;
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY orc_t IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION orc_t
( name VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'ORC_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
        RETURN;
        END;

  --Get name.--
OVERRIDING MEMBER FUNCTION get_name RETURN VARCHAR2 IS
        BEGIN
                RETURN self.name;
        END get_name;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
        '['||oname||']['||name||'] ['||genus||']';
    END;
  END;
/


--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE noldor_t UNDER elf_t
(elfkind VARCHAR2(30)
, CONSTRUCTOR FUNCTION noldor_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT
, MEMBER FUNCTION get_elfkind RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY noldor_t IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION noldor_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'NOLDOR_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
                self.elfkind := elfkind;
        RETURN;
        END;

  --Get name.--
MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
        BEGIN
                RETURN self.elfkind;
        END get_elfkind;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
        '['||oname||']['||name||']['||elfkind||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE silvan_t UNDER elf_t
(elfkind VARCHAR2(30)
, CONSTRUCTOR FUNCTION silvan_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT
, MEMBER FUNCTION get_elfkind RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY silvan_t IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION silvan_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'SILVAN_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
                self.elfkind := elfkind;
        RETURN;
        END;

  --Get name.--
MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
        BEGIN
                RETURN self.elfkind;
        END get_elfkind;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||']['||elfkind||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE sindar_t UNDER elf_t
(elfkind VARCHAR2(30)
, CONSTRUCTOR FUNCTION sindar_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT
, MEMBER FUNCTION get_elfkind RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY sindar_t IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION sindar_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'SINDAR_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
                self.elfkind := elfkind;
        RETURN;
        END;

  --Get name.--
MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
        BEGIN
                RETURN self.elfkind;
        END get_elfkind;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||
         '['||oname||']['||name||']['||elfkind||']';
    END;
  END;
/

--=================================================================
-- Create the dwarf_t, elf_t, goblin_t, hobbit_t, maia_t, man_t, and orc_t
-- object types and bodies that extend the behavior of the base_t object 
-- and complies with the definition of the hobbit object type (found in 
-- the CIT325_Final_Project.pdf document).
--==================================================================
CREATE OR REPLACE TYPE teleri_t UNDER elf_t
(elfkind VARCHAR2(30)
, CONSTRUCTOR FUNCTION teleri_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT
, MEMBER FUNCTION get_elfkind RETURN VARCHAR2
, OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2);
/

LIST
SHOW ERRORS

CREATE OR REPLACE TYPE BODY teleri_t IS
  
  --- One argument constructor --
CONSTRUCTOR FUNCTION teleri_t
(elfkind VARCHAR2 ) RETURN SELF AS RESULT IS
        BEGIN
    --Assign a sequence value and string literalto the instance--
                self.oid := base_t_s.NEXTVAL;
                self.oname := 'TELERI_T';

    --Assign a parameter to the subtype only attribute.--
                self.name := name;
                self.genus := genus;
                self.elfkind := elfkind;
        RETURN;
        END;

  --Get name.--
MEMBER FUNCTION get_elfkind RETURN VARCHAR2 IS
        BEGIN
                RETURN self.elfkind;
        END get_elfkind;

  --An output function. --
OVERRIDING MEMBER FUNCTION to_string RETURN VARCHAR2 IS
        BEGIN
   RETURN (self AS base_t).to_string||']['||elfkind||']';
    END;
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
INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, base_t(1, 'BASE_T'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, man_t(1,'MAN','BOROMIR'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, man_t(1,'MAN','FARAMIR'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, hobbit_t(1,'HOBBIT_T','Bilbo'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, hobbit_t(2,'HOBBIT_T','FROFO'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, hobbit_t(3,'HOBBIT_T','MERRY'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, dwarf_t(1,'DWARF','GIMLI', 'DWARVES'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, elf_t(1,'ELF','FEANOR', 'NOLDOR'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, elf_t(2,'ELF','TAURIEL','SILVAN'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, elf_t(3,'ELF','EARWEN','TELERI'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, elf_t(4,'ELF','CELEBORN','TELERI'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, elf_t(5,'ELF','THRANDUIL','SINDAR'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, elf_t(6,'ELF','LEGOLAS','SINDAR'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, orc_t(1,'ORC','AZOG THE DEFILER'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, orc_t(2,'ORC','BOLG'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, maia_t(1,'MAIA','GANDALF THE GREY'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, maia_t(2,'MAIA','RADAGAST THE BROWN'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, maia_t(3,'MAIA','SARUMAN THE WHITE'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, goblin_t(1,'GOBLIN','THE GREAT GOBLIN'));

INSERT INTO tolkien
VALUES (base_t_s.NEXTVAL, man_t(1,'MAN','ARAGORN'));


DROP TYPE character_obj;
CREATE TYPE character_obj IS OBJECT
( oname VARCHAR2(30)
, name  VARCHAR2(30));
/

DECLARE
  TYPE character_list IS TABLE OF character_obj;
  lv_character_list character_list :=
    character_list(character_obj('HOBBIT_T','Frodo')
                  ,character_obj('HOBBIT_T','Sam'));
BEGIN
  FOR i IN 1..lv_character_list.COUNT LOOP
    INSERT INTO tolkien
    VALUES (i, hobbit_t(i
                       ,lv_character_list(i).oname
                       ,lv_character_list(i).name));
  END LOOP;
END;
/





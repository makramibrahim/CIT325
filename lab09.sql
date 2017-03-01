SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Class:       CIT 325 
-- Assignment:  Lab9, Packages
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        November 12, 2016
--===================================================================
-- Create a series of large text files (at least 5 text files of 
-- a two or more paragraphs - use wikipedia.org as a source) that 
-- describe films stored in the ITEM table.
--===================================================================
CREATE OR REPLACE FUNCTION files_list
(pv_text_files VARCHAR2(2000) RETURN CLOB AS 

-- Declare containers for view-- 
lv_input_view   CLOB;
lv_output_view  CLOB;

--- Declare a variable--
lv_long_view LONG;


--================================================================
-- Write an anonymous block program that creates a list of file 
-- names from any named directory (where the directory is an absolute
--  reference from a mount point).
--================================================================
CREATE OR REPLACE DIRECTORY list_files AS 'c:\FILE_LIST';

DECLARE
	 -- DECLARE VARIBALES
	 text_record   VARCHAR(2000)
	 text_file     utl.file.File_TYPE;

	 -- Create explicit
	COURSOR 




--=================================================================
-- Inside a loop, read the list of file names and call them to read 
-- large files from a directory and store the large text in the 
-- style= "font-family: 'courier new', courier, sans-serif;"ITEM_DESC 
-- column of the ITEM table.
--================================================================


      














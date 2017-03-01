SET SERVEROUTPUT ON SIZE UNLIMITED 
--==============================================================================
-- CIT 325 
-- Assignment: Lab3, Language Fundamentals.
-- Instractor: Brother Page,
-- Author: Makram Ibrahim,
-- Date: September 30, 2016
--=============================================================================

-- Create an anonymous block program that takes three input parameters.

DECLARE 
    TYPE lv_record IS RECORD 
            (lv_num    NUMBER       -- Declares record type of number
            , lv_char  VARCHAR2(10) -- Declares record type of char 10
            , lv_date  DATE);       -- Declares record type of date
                            
    lv_record_inst lv_record;  /* here declare a local variable record*/
     

BEGIN 
--Prompt the user for the input--
       lv_record_inst.lv_num  := '&1_number NUMBER'; --store number variable in record_inst
       lv_record_inst.lv_char := '&2_char   CHAR';   --store char variable in record_inst
       lv_record_inst.lv_date := '&3_date   DATE';   --store date variable in record_inst
    

--Check Number
        IF(REGEXP_LIKE(lv_record_inst.lv_num, '[0-9]*')) THEN
                        dbms_output.put_line('Good Number!');
                ELSE 
                        dbms_output.put_line('Bad Number!');
                END IF;
--Check Char 
    IF lv_record_inst.lv_char > 10 THEN           -- if the input more than 10
               lv_record_inst.lv_char := substr(  -- always mange different input
                                lv_record_inst.lv_char
                                , 1, 10); 
    END IF;

--Check date
    IF (REGEXP_LIKE(lv_record_inst.lv_date, 'mm/dd/yyyy')) THEN
        dbms_output.put_line('Good input'); 
    ELSE    
        dbms_output.put_line('ERROR! please enter a valid data');
    END IF;


-- Print the individual elements from the RECORD type.
        dbms_output.put_line('Number: ' || lv_record_inst.lv_num);
        dbms_output.put_line('Name: ' || lv_record_inst.lv_char);
        dbms_output.put_line('Date: ' || lv_record_inst.lv_date);

-- Manage errors through exception, 
EXCEPTION 
        WHEN others THEN    
           dbms_output.put_line('Goodbye! Note > ' || SQLERRM);
             
END;
/
--===========================================================================
-- Class:       CIT 325 
-- Assignment:  Lab4, Control Structures
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        October 8, 2016
--===========================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 

--===========================================================================
-- Create an anonymous block program that takes a single input parameter 
-- and validates whether it's equal to a literal number between 1 and 10.
--===========================================================================
DECLARE 
        lv_num NUMBER;

BEGIN
     -- Prompt the user for a number 
     lv_num := '&Number';

     -- walk through the assign number only.
         IF lv_num >= 0 AND lv_num <= 10
     THEN  
        -- if the number inside range print Match               
         dbms_output.put_line('Match!');
     ELSE 
        -- if the number outside the range put not match     
         dbms_output.put_line('Does not match.'); 
     END IF;
END;
/ 

--===========================================================================                       
-- Create an anonymous block program that reads the item_title column 
-- from the ITEM table and prints it inside the loop.
--===========================================================================
DECLARE 

BEGIN
        -- for loop will get the item_title from item table
        FOR col IN (SELECT item_title FROM item)
   
   LOOP 
        --read item_title column from the ITEM table
        dbms_output.put_line(col.item_title);
   END LOOP;
END;
/

--==========================================================================
-- Create an anonymous block program that uses a WHILE loop to print the
--  print the number 0 to 10 in reverse order.
--========================================================================== 
DECLARE 
        -- decalre number for 10 
        lv_numOrder NUMBER := 10; 

BEGIN 
        -- numbers between 0 to 10.
        WHILE lv_numOrder >= 0 AND lv_numOrder <= 10
   
    LOOP
        -- print the number
        dbms_output.put_line(lv_numOrder);   

        -- assign the same variable to count in reverse 
        lv_numOrder := lv_numOrder -1;       

    END LOOP;

END;
/

        
         


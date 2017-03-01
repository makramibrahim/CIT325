--=====================================================================
-- Class:       CIT 325 
-- Assignment:  Lab6, Control Structures
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        October 22, 2016
--=====================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 

--=====================================================================
-- Create an anonymous block program that demonstrates how to handle 
-- a run-time exceptions.
--=====================================================================
DECLARE
                                   
        monthly_income   NUMBER := 1000; -- assign income for 1000 
        monthly_tithe    NUMBER := 0;    -- assign tithe for 0 
        total_income     NUMBER;	 -- 
BEGIN
        
    -- calculate the month income 
    total_income := monthly_income / monthly_tithe;
        

        dbms_output.put_line('Total month expenses = ' || total_income);

EXCEPTION -- exception handlers begin

        WHEN ZERO_DIVIDE THEN -- handles error when divided 
        dbms_output.put_line('================');  
        dbms_output.put_line('Monthly tithe: ' || monthly_tithe 
        || '.  "Will a Man Bribe God?"');
        dbms_output.put_line('================');  

END;
/

--=====================================================================
-- Create an anonymous block program that demonstrates how to declare 
-- and manage a user-defined exception.
--=====================================================================
DECLARE 
        
        full_tithe  NUMBER := 10; -- assign full tithe for 10%
        half_tithe  NUMBER := 5;  -- assign half tithe pay for 5%  
       -- error_tithe NUMBER;
        tithe_half_pay EXCEPTION;
         
BEGIN  -- block begins
     
    IF  half_tithe < full_tithe THEN 
        RAISE tithe_half_pay; -- raise the exception here
    END IF;

  EXCEPTION    
     WHEN tithe_half_pay THEN 
     -- handel error herer 
     dbms_output.put_line('Tithe ' 
     || half_tithe || '% is not full paying. "Will a Man bribe God?"'); 
     
     dbms_output.put_line('Tithe '|| full_tithe || '% full tithe paying!'); 
            
END;
/

--=====================================================================
-- Create an anonymous block program that demonstrates how to manage 
-- an error stack.
--====================================================================
DECLARE

        lv_char1 VARCHAR(2);  -- assing two characters
        lv_char2 VARCHAR(4):= 'TITH'; -- assing and declare 4 char
        
        e EXCEPTION;        -- exception handlers begin   
       
BEGIN
  
  RAISE e; -- raise if it's missing'
       dbms_output.put_line('letter not found here');
  
EXCEPTION 
     WHEN e THEN 
         dbms_output.put_line('No erros!');  
         dbms_output.put_line(dbms_utility.format_error_backtrace);        
END;
/
















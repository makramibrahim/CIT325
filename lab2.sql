--===================================================
-- CIT 325 
-- Assignment: Lab2
-- Author: Makram Ibrahim
-- Date: September 24, 2016
--====================================================

DECLARE
	lv_boolean BOOLEN; /*assign blooen for true or false*/
	lv_input VARCHAR2(10); /*assign variable for 10 characters only*/

BEGIN 
	lv_input := 'Hello?!'; /* decalre variable*/
IF NVL(lv_boolean, FALSE) THEN /* Check it true or false*/
	dmb_output.put_line(lv_input); /*if true print*/
ELSEIF NVL (lv_input < 10), FALSE) THEN /*outout not more than 10 characters*/
	dmb_output.put_line(lv_input); /*print the output*/
ELSE
	dmb_output.put_line(lv_input); /*if it's long then pring 10 first letters only*/

 END IF;

END;
/

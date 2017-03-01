--=================================================================
-- Class:       CIT 325 
-- Assignment:  Lab11, Triggers
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        November 26, 2016
--===================================================================
SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Create a DDL trigger on an event.
-- Create a test program that creates the action to trigger the event.
--===================================================================
CREATE OR REPLACE TRIGGER event
AFTER DDL ON DATABASE
BEGIN



--=================================================================
-- Create a HOBBIT_T object as a subtype of the BASE_T object that 
-- adds an hobbit_name attribute.
--===================================================================


--=================================================================
-- Extends the to_string method of the parent class to use general
-- invocation for the obj_id and obj_name, and then add the hobbit_name
-- attribute of the HOBBIT_T object subtype.
--===================================================================

--=================================================================
-- As a test case, create a collection of 5 HOBBIT_T objects and then loop -- through the list of HOBBIT_T objects while printing their overriding
-- to_string method's results.
--===================================================================
-- Test whether the collection constructor works.

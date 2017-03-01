SET SERVEROUTPUT ON SIZE UNLIMITED 
--=================================================================
-- Class:       CIT 325 
-- Assignment:  Lab8, Packages
-- Instructor:  Brother Page,
-- Author:      Makram Ibrahim,
-- Date:        November 5, 2016
--===================================================================
-- Create a package specification that defines an overloaded function 
-- and overloaded procedure.
--===================================================================
CREATE OR REPLACE PACKAGE vehicle AS

-- define overloaded funciton ---
  FUNCTION get_vehicle(car_type VARCHAR2) 

RETURN VARCHAR2;

  FUNCTION get_vehicle(car_type VARCHAR2, model_year NUMBER) 

RETURN VARCHAR2;

-- define overloaded procedure--
  PROCEDURE car_spec(car_type VARCHAR2);

  PROCEDURE car_spec(car_type VARCHAR2, country_made  VARCHAR2);

END vehicle;
/
          
--================================================================
-- Create a package body that implements an overloaded function 
-- and overloaded procedure.
--================================================================
CREATE OR REPLACE PACKAGE BODY vehicle AS

-- define overloaded funciton ---
FUNCTION get_vehicle(car_type VARCHAR2) 
        RETURN VARCHAR2 AS
BEGIN 
        RETURN car_type;
END;


FUNCTION get_vehicle(car_type VARCHAR2, model_year NUMBER) 
        RETURN VARCHAR2 AS
BEGIN 
        RETURN car_type ||' ' || model_year;
END;

-- define overloaded procedure--
PROCEDURE car_spec(car_type VARCHAR2) AS
BEGIN
        dbms_output.put_line(car_type);
END;


PROCEDURE car_spec(car_type VARCHAR2, country_made  VARCHAR2) AS
BEGIN 
        dbms_output.put_line(car_type || ' ' || country_made);
   END;
END vehicle;
/

--=================================================================
-- Create an anonymous block that test the overloaded function.
--=================================================================
SELECT vehicle.get_vehicle('Whats your favorite car?')
     , vehicle.get_vehicle('"Volvo"', '2016')
FROM dual;

--=================================================================
-- Create an anonymous block that test the overloaded procedure.
--=================================================================
DECLARE
       lv_test VARCHAR2(200);
BEGIN 
     -- test function and procedure
     dbms_output.put_line('****************************************');
     dbms_output.put_line(' The most safest car in the whole world');
     vehicle.car_spec('"Volvo-S80"');
     vehicle.car_spec('Made in', '*Sweden*');
     dbms_output.put_line('*****************************************');
END;
/
--=================================================================
-- Create a test case that calls the two anonymous blocks that 
-- test the overloaded function and procedure.
--================================================================
DECLARE 
       --declare a variables to test our case--
       lv_test1 VARCHAR(100); 
       lv_test2 VARCHAR(100);
BEGIN
      --test overloaded function--
      dbms_output.put_line('*********************************');
      lv_test1 := vehicle.get_vehicle('Whats your favorite car?');
      dbms_output.put_line(lv_test1);
      
      lv_test2 := vehicle.get_vehicle('"Volvo"', '2016');      
      dbms_output.put_line(lv_test2);
      dbms_output.put_line('*********************************');
      
     -- test overloaded procedure --
      vehicle.car_spec('"Volvo-S80"');
      vehicle.car_spec('Made in', '*Sweden*');
END;
/

      














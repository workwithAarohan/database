CREATE OR REPLACE PROCEDURE TESTPROCEDURE
(
    PARAM1 IN VARCHAR2,
    PARAM2 OUT VARCHAR2
) AS
BEGIN
    PARAM2 := PARAM1;
END TESTPROCEDURE;

SET serveroutput on;
decLare varout varchar2(100);
begin 
    TESTPROCEDURE(PARAM1=>'THIS IS IN VALUE', PARAM2=>varout);
    
    dbms_output.put_line(varout);
END;


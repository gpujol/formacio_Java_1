create or replace PACKAGE BODY pack_ex AS
  
  PROCEDURE xxxx (fecha DATE) AS
    BEGIN
      DBMS_OUTPUT.PUT_LINE(avui);
    END;
  
  FUNCTION avui RETURN DATE IS
    BEGIN
      RETURN SYSDATE;
    END;
    
END pack_ex;
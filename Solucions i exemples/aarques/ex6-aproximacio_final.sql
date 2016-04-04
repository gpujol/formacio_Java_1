CREATE OR REPLACE PACKAGE PACK_EMPLOYEE AS

  PROCEDURE UPDATE_EMP;

  FUNCTION PERCENT_CLI(EMP_ID NUMBER) RETURN NUMBER;
  
END PACK_EMPLOYEE;
/

CREATE OR REPLACE PACKAGE BODY PACK_EMPLOYEE AS 

  PROCEDURE UPDATE_EMP AS

    PERCENT_CLI_EMPL NUMBER(5,2);
    CURSOR EMPLEADOS_CUR IS
      SELECT *
      FROM EMPLOYEE;
    EMP_AUX EMPLOYEE%ROWTYPE;

  BEGIN
  
    OPEN EMPLEADOS_CUR;
    LOOP
      FETCH EMPLEADOS_CUR INTO EMP_AUX;
      EXIT WHEN EMPLEADOS_CUR%NOTFOUND;
        
        PERCENT_CLI_EMPL := PERCENT_CLI(EMP_AUX.ID);
        
        UPDATE EMPLOYEE
        SET PERCENT_CUSTOMER = PERCENT_CLI_EMPL, PERCENT_DATE = SYSDATE
        WHERE ID = EMP_AUX.ID;
        
      DBMS_OUTPUT.PUT_LINE('Empleado: ' || EMP_AUX.NAME || ' Percent clientes: ' || PERCENT_CLI_EMPL);
    END LOOP;
    CLOSE EMPLEADOS_CUR;
    COMMIT;  
  
  END;

  FUNCTION PERCENT_CLI(EMP_ID NUMBER) RETURN NUMBER IS
    PERCENT_CLI_EMPL NUMBER(5,2);
    TOTAL_CLI NUMBER(5,2);
  BEGIN
  
    SELECT COUNT(*) INTO TOTAL_CLI
    FROM CUSTOMER;
    
    SELECT CAST(COUNT(*)*100 / TOTAL_CLI AS DECIMAL(5,2)) INTO PERCENT_CLI_EMPL
    FROM CUSTOMER 
    WHERE EMPLOYEE_ID IN EMP_ID;
    RETURN PERCENT_CLI_EMPL;
  END;
  
END PACK_EMPLOYEE;
/






CREATE OR REPLACE PACKAGE PACK_CUSTOMER AS

  PROCEDURE UPDATE_CLI;

  FUNCTION PERCENT_PROD(CLI_ID NUMBER) RETURN NUMBER;
  
END PACK_CUSTOMER;
/


CREATE OR REPLACE PACKAGE BODY PACK_CUSTOMER AS 

  PROCEDURE UPDATE_CLI AS

  PERCENT_PRO_CLI NUMBER(5,2);
  CURSOR CLIENT_CUR IS
		SELECT *
		FROM CUSTOMER;
	CLI_AUX CUSTOMER%ROWTYPE;

  BEGIN
  
    OPEN CLIENT_CUR;
    LOOP
      FETCH CLIENT_CUR INTO CLI_AUX;
      EXIT WHEN CLIENT_CUR%NOTFOUND;
      
        PERCENT_PRO_CLI := PERCENT_PROD(CLI_AUX.ID);
        
        UPDATE CUSTOMER
        SET PERCENT_PRODUCT = PERCENT_PRO_CLI, PERCENT_DATE = SYSDATE
        WHERE ID = CLI_AUX.ID;
        
      DBMS_OUTPUT.PUT_LINE('Cliente: ' || CLI_AUX.NAME || ' Percent productos: ' || PERCENT_PRO_CLI);
    END LOOP;
    CLOSE CLIENT_CUR;
    COMMIT;
  
  END;

  FUNCTION PERCENT_PROD(CLI_ID NUMBER) RETURN NUMBER IS
    PERCENT_PRO_CLI NUMBER(5,2);
    TOTAL_PROD NUMBER(5,2);
  BEGIN
  
    SELECT COUNT(*) INTO TOTAL_PROD
    FROM PRODUCT;
    
    SELECT CAST(COUNT(*)*100 / TOTAL_PROD AS DECIMAL(5,2)) INTO PERCENT_PRO_CLI
    FROM PRODUCT_CUSTOMER 
    WHERE CUSTOMER_ID IN CLI_ID;
    RETURN PERCENT_PRO_CLI;
  END;
  
END PACK_CUSTOMER;
/  


CREATE OR REPLACE PROCEDURE ACTUALIZA_PORCENTAJES_EMPRESA AS

BEGIN

  --el porcentaje de clientes que gestiona ese empleado del total de la compañía
  PACK_EMPLOYEE.UPDATE_EMP();
  
  --y como dato de cliente el porcentaje de productos que compra del total que ofrece la compañía.
  PACK_CUSTOMER.UPDATE_CLI();
  
END;
/

SET SERVEROUTPUT ON
BEGIN
  ACTUALIZA_PORCENTAJES_EMPRESA;
END;
CREATE OR REPLACE PACKAGE pack_emp AS
  --PROCEDURE xxxx (fecha DATE);
  FUNCTION retPorcEmp RETURN VARCHAR2;
END pack_emp;
/

CREATE OR REPLACE PACKAGE BODY pack_emp AS
  
  /*PROCEDURE xxxx (fecha DATE) AS
    avui DATE;
    BEGIN
      DBMS_OUTPUT.PUT_LINE(fecha);
    END;*/

  FUNCTION retPorcEmp RETURN VARCHAR2 IS
    REG_ID EMPLOYEE.ID%TYPE;
    REG_NAME EMPLOYEE.NAME%TYPE;
    PERC_TOT NUMBER(5,2);
    PERC_EMP NUMBER(5,2);
    FECHA_HOY DATE := SYSDATE;
    CURSOR CUR_EMP IS
      SELECT E.ID, E.NAME
      FROM EMPLOYEE E;
      
    BEGIN
      SELECT COUNT(C.ID) INTO PERC_TOT
      FROM CUSTOMER C;
      
      OPEN CUR_EMP;
      LOOP
        FETCH CUR_EMP INTO REG_ID, REG_NAME;
          EXIT WHEN CUR_EMP%NOTFOUND;
          
          SELECT COUNT(C.ID)*100/PERC_TOT INTO PERC_EMP
          FROM CUSTOMER C
          INNER JOIN EMPLOYEE E
            ON(C.EMPLOYEE_ID = E.ID)
          WHERE E.ID=REG_ID;
          
          UPDATE EMPLOYEE SET PERCENT_CUSTOMER=PERC_EMP WHERE ID=REG_ID;
          UPDATE EMPLOYEE SET PERCENT_DATE=FECHA_HOY WHERE ID=REG_ID;
          
          DBMS_OUTPUT.PUT_LINE(' ');
          DBMS_OUTPUT.PUT_LINE('ID: ' || REG_ID || '  ----  Nombre trabajador: ' || REG_NAME);
          DBMS_OUTPUT.PUT_LINE('Porcentaje de clientes respecto del total: ' || PERC_EMP || '%');
          
      END LOOP;  
      CLOSE CUR_EMP;
      COMMIT;
      
      RETURN 'OK';
      
    END;
END pack_emp;
/

SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(pack_emp.retPorcEmp);
END;
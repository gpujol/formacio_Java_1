/*
Recorrer un cursor con el FOR, declara de forma implícita una variable nueva con el contenido de cada fila

NO NECESITÁIS CREAR UN TIPO O UNA VARIABLE PARA ALMACENAR EL RESULTADO DEL FETCH con el FOR, lo crea implícitamente, con el TIPO ADECUADO
*/

SET SERVEROUTPUT ON
DECLARE
  
  CURSOR EMP_CUR IS
    SELECT E.ID, E.NAME, E.SURNAME
    FROM EMPLOYEE E;
  
  CURSOR CUR_EMP_CLIENTS (emp_id NUMBER) IS
    SELECT CUST.NAME
    FROM CUSTOMER CUST
    INNER JOIN EMPLOYEE E
      ON(CUST.EMPLOYEE_ID = E.ID)
    WHERE E.ID=emp_id;
    
BEGIN
  FOR REG_AUX IN EMP_CUR
  LOOP
      DBMS_OUTPUT.PUT_LINE(' ');
      DBMS_OUTPUT.PUT_LINE('Nombre del trabajador: ' || REG_AUX.NAME);
      DBMS_OUTPUT.PUT_LINE('Apellido del trabajador: ' || REG_AUX.SURNAME);  
      FOR CLI_NAME IN CUR_EMP_CLIENTS(REG_AUX.ID)
      LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(CLI_NAME.NAME));        
      END LOOP;  
  END LOOP;
END;



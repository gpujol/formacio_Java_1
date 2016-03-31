SET SERVEROUTPUT ON
DECLARE
  
  ID NUMBER(8);
  NOM_EMP VARCHAR2(50);
  DATA_NAIX DATE;
  COGNOM VARCHAR2(50);

  CURSOR empleats_cur IS
    SELECT *
    FROM EMPLOYEE;
    
  CURSOR empleats_data_cur (data_naix IN DATE) IS
    SELECT *
    FROM EMPLOYEE
    WHERE DATE_OF_BIRTH > data_naix;

BEGIN
  
  
  DATA_NAIX := TO_DATE('01/02/1980','DD/MM/YYYY');
    
  IF DATA_NAIX < TO_DATE('01/01/1980','DD/MM/YYYY') THEN
    DBMS_OUTPUT.PUT_LINE('Avui!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Demà');
  END IF;
  
  OPEN empleats_cur;
  
  LOOP
    FETCH empleats_cur INTO ID, NOM_EMP, DATA_NAIX, COGNOM;
    EXIT WHEN empleats_cur%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(NOM_EMP);
  
  END LOOP;
  
  CLOSE empleats_cur;

  DBMS_OUTPUT.PUT_LINE('01/01/1980');

  OPEN empleats_data_cur(TO_DATE('01/01/1980','DD/MM/YYYY'));
  
  LOOP
    FETCH empleats_data_cur INTO ID, NOM_EMP, DATA_NAIX, COGNOM;
    EXIT WHEN empleats_data_cur%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(NOM_EMP);
  
  END LOOP;
  
  CLOSE empleats_data_cur;

END;
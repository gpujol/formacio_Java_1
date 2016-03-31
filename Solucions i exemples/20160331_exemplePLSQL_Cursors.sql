SET SERVEROUTPUT ON
DECLARE

  E_NAME VARCHAR2(50);
  E_ID NUMBER(8);
  C_ID NUMBER(8);
  P_ID NUMBER(8);
  
BEGIN

    SELECT MAX(E.ID) INTO E_ID
    FROM EMPLOYEE E;
    
    SELECT SEQ_CUSTOMER.NEXTVAL INTO C_ID
    FROM DUAL;
    
    DBMS_OUTPUT.PUT_LINE('ID del cliente nuevo: ' || C_ID);
    
    INSERT INTO CUSTOMER (ID, NAME, EMPLOYEE_ID)
    VALUES (C_ID,'Nom client variable',E_ID);

    DBMS_OUTPUT.PUT_LINE('Se ha insertado el cliente: ' || C_ID);
  
    SELECT SEQ_PRODUCT.NEXTVAL INTO P_ID
    FROM DUAL;
    
    DBMS_OUTPUT.PUT_LINE('ID del producto nuevo: ' || P_ID);

    
    INSERT INTO PRODUCT (ID, NAME)
    VALUES (P_ID,'Nom producte variable');
    
    DBMS_OUTPUT.PUT_LINE('Se ha insertado el producto: ' || P_ID);
    
    INSERT INTO PRODUCT_CUSTOMER (PRODUCT_ID, CUSTOMER_ID, CREATION_DATE)
    VALUES (P_ID,C_ID,SYSDATE);
    
    DBMS_OUTPUT.PUT_LINE('Se ha insertado la relación entre el cliente ' || C_ID || ' y el producto ' || P_ID);
  
    COMMIT;

END;
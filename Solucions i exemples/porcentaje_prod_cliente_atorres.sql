create or replace PROCEDURE ACTUALIZAR_PORCENTAJE_CLIENTES IS

num_total_productos number(2);
num_prod_cliente NUMBER(2);
id_cliente number(8);
porcentaje number(5,2);

CURSOR prod_por_cliente is

SELECT C.ID, count(PC.PRODUCT_ID) FROM CUSTOMER C LEFT OUTER JOIN PRODUCT_CUSTOMER PC ON (PC.CUSTOMER_ID = C.ID)
GROUP BY C.ID
HAVING count(PC.PRODUCT_ID) > 0;

BEGIN
    open prod_por_cliente;
    
      loop
        fetch prod_por_cliente into id_cliente, num_prod_cliente;
        EXIT WHEN prod_por_cliente%NOTFOUND; 
        
            SELECT COUNT(PC.customer_id) INTO num_total_productos FROM PRODUCT_CUSTOMER PC;
            
            porcentaje := (num_prod_cliente/num_total_productos);
            porcentaje := porcentaje*100;
          
            UPDATE CUSTOMER C SET PORCENTAJE = porcentaje, FECHA = sysdate WHERE C.ID = id_cliente;
			
       DBMS_OUTPUT.PUT_LINE (id_cliente || ', ' || porcentaje);
      end loop;   
    close prod_por_cliente;
  COMMIT;
  
  
END;


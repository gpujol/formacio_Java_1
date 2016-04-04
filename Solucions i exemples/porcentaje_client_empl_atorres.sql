create or replace PROCEDURE ACTUALIZAR_PORCENTAJES IS

num_total_clientes number(2);
num_clientes_emp NUMBER(2);
id_empleado number(8);
porcentaje number(5,2);

cursor clientes_por_empleado is
SELECT E.ID, count(C.EMPLOYEE_ID) FROM EMPLOYEE E
LEFT OUTER JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
GROUP BY E.ID
HAVING count(C.EMPLOYEE_ID) > 0;

BEGIN
    open clientes_por_empleado;
    
      loop
        fetch clientes_por_empleado into id_empleado, num_clientes_emp;
        EXIT WHEN clientes_por_empleado%NOTFOUND; 
        
            SELECT COUNT(C.ID) INTO num_total_clientes FROM CUSTOMER C;
            
            porcentaje := (num_clientes_emp/num_total_clientes);
            porcentaje := porcentaje*100;
          
            UPDATE EMPLOYEE SET PORCENTAJE = porcentaje, fecha = sysdate WHERE ID = id_empleado;
        
      end loop;   
    close clientes_por_empleado;
  COMMIT;
  
  
END;
select *
from employee;

select *
from customer;

select *
from employee e, customer c
where e.id = c.EMPLOYEE_ID;

select *
from employee e
  inner join customer c on (e.id = c.employee_id);
  
select e.name empleado, DECODE(count(c.id),0,'No tiene clientes',count(c.id)) "NÚM. CLIENTES"
from employee e
  left outer join customer c on (e.id = c.employee_id)
group by e.name
order by e.name asc;

SELECT e.name as EMPLEADO,-- count(c.id) as "NÚM. CLIENTES"
  /*CASE
    WHEN count(c.employee_id) = 0
    THEN 'No tiene clientes'
    ELSE to_char(count(c.employee_id))
    END
    AS "NÚM. CLIENTES"*/
    DECODE(COUNT(c.employee_id),
      '0','No tiene clientes',
      count(c.employee_id)) AS "NÚM. CLIENTES"
FROM EMPLOYEE E
  LEFT JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
GROUP BY e.id, e.name
order by e.id asc;

INSERT INTO CUSTOMER (ID, NAME, EMPLOYEE_ID) VALUES (7,'Client nou',2);
COMMIT;



SELECT e.name as EMPLEADO, count(c.id) AS "NÚM. CLIENTES"
FROM EMPLOYEE E
  LEFT JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
GROUP BY e.id, e.name
order by e.id asc;

select max(NUM_CLIENTS)
FROM (
  SELECT count(c.id) NUM_CLIENTS
    FROM EMPLOYEE E
      LEFT JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
    GROUP BY e.id, e.name
);

SELECT max(count(c.id)) MAX_CLIENTS
  FROM EMPLOYEE E
    LEFT JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
  GROUP BY e.id, e.name;



SELECT e.name as EMPLEADO, count(c.id) NUM_CLIENTS
  FROM EMPLOYEE E
    LEFT JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
  GROUP BY e.id, e.name
  HAVING COUNT(c.id) = (
      SELECT max(count(c.id)) MAX_CLIENTS
      FROM EMPLOYEE E
        LEFT JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
      GROUP BY e.id, e.name)
;


DELETE FROM EMPLOYEE WHERE ID IN (
	SELECT E.ID
	FROM EMPLOYEE E
		LEFT OUTER JOIN CUSTOMER C ON (E.ID = C.EMPLOYEE_ID)
	GROUP BY E.ID
	HAVING COUNT(C.ID) = 0
);

/*
PER DESPRÉS DE CREAR LES COLUMNES CORRESPONENTS
*/

UPDATE EMPLOYEE SET SURNAME = 'Cognom treballador ' || ID;

UPDATE CUSTOMER SET SURNAME = 'Cognom client ' || SUBSTR(name,LENGTH(name)-2,3);

COMMIT;

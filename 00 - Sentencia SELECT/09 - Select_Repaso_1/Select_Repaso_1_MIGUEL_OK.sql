/*
EJER Select_Repaso_1

POR MIGUEL OLMO HERNANDO

Utilizando las tablas emple y depart responde a las siguientes cuestiones.
*/

-- 1� Seleccionar aquellos departamentos en los que al menos exista un empleado con comisi�n.
SELECT DISTINCT DEPT_NO 
  FROM EMPLE
  WHERE COMISION_PCT IS NOT NULL;

-- 2� Listar aquellos departamentos en los que todos sus empleados carezcan de informaci�n sobre su comisi�n.
SELECT DEPT_NO "N� DEPARTAMENTO", DNOMBRE Departamento
  FROM DEPART 
  WHERE DEPT_NO = ANY (SELECT DISTINCT DEPT_NO 
                          FROM EMPLE
                          WHERE COMISION_PCT IS NOT NULL);

-- 3� Visualizar el departamento con m�s empleados.
SELECT DEPT_NO, COUNT(*)
  FROM EMPLE
  GROUP BY DEPT_NO
  HAVING COUNT(*)= (SELECT MAX(COUNT(*))
                      FROM EMPLE
                      GROUP BY DEPT_NO);
 
-- 4� Obtener el n�mero y el nombre del departamento con m�s personal de oficio �PROGRAMADOR�.
SELECT DEPT_NO, DNOMBRE
  FROM DEPART
  WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMPLE
                      WHERE UPPER(OFICIO)= 'PROGRAMADOR'
                      GROUP BY DEPT_NO
                      HAVING COUNT(*)=(SELECT MAX(COUNT(*))
                                          FROM EMPLE
                                          WHERE UPPER(OFICIO)='PROGRAMADOR'
                                          GROUP BY DEPT_NO));

-- 5� Buscar el departamento con m�s presupuesto asignado para pagar el salario y la comisi�n de sus empleados.
SELECT * FROM EMPLE;

SELECT DEPART.* 
  FROM DEPART
  WHERE DEPART.DEPT_NO = (SELECT EMPLE.DEPT_NO 
                            FROM EMPLE
                            GROUP BY EMPLE.DEPT_NO
                            HAVING SUM (EMPLE.SALARIO+NVL(EMPLE.COMISION_PCT, 0)) IN
                                (SELECT MAX (SUM(EMPLE.SALARIO+NVL(EMPLE.COMISION_PCT,0)))
                                    FROM EMPLE
                                    GROUP BY EMPLE.DEPT_NO));

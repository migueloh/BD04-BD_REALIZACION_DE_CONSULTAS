/*
EJER Select_Repaso_1

POR MIGUEL OLMO HERNANDO

Utilizando las tablas emple y depart responde a las siguientes cuestiones.
*/

-- 1º Seleccionar aquellos departamentos en los que al menos exista un empleado con comisión.
SELECT DISTINCT DEPT_NO 
  FROM EMPLE
  WHERE COMISION_PCT IS NOT NULL;

-- 2º Listar aquellos departamentos en los que todos sus empleados carezcan de información sobre su comisión.
SELECT DEPT_NO "Nº DEPARTAMENTO", DNOMBRE Departamento
  FROM DEPART 
  WHERE DEPT_NO = ANY (SELECT DISTINCT DEPT_NO 
                          FROM EMPLE
                          WHERE COMISION_PCT IS NOT NULL);

-- 3º Visualizar el departamento con más empleados.
SELECT DEPT_NO, COUNT(*)
  FROM EMPLE
  GROUP BY DEPT_NO
  HAVING COUNT(*)= (SELECT MAX(COUNT(*))
                      FROM EMPLE
                      GROUP BY DEPT_NO);
 
-- 4º Obtener el número y el nombre del departamento con más personal de oficio “PROGRAMADOR”.
SELECT DEPT_NO, DNOMBRE
  FROM DEPART
  WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMPLE
                      WHERE UPPER(OFICIO)= 'PROGRAMADOR'
                      GROUP BY DEPT_NO
                      HAVING COUNT(*)=(SELECT MAX(COUNT(*))
                                          FROM EMPLE
                                          WHERE UPPER(OFICIO)='PROGRAMADOR'
                                          GROUP BY DEPT_NO));

-- 5º Buscar el departamento con más presupuesto asignado para pagar el salario y la comisión de sus empleados.
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

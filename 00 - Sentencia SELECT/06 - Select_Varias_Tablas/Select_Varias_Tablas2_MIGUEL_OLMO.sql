/*
REALIZACION DE CONSULTAS

Select_Varias_Tablas 2

POR MIGUEL OLMO HERNANDO

*/

--1. Crear un listado único con todos los oficios que haya en el departamento 10. 
--Incluir la localidad del departamento en el resultado.

DESC DEPART
DESC EMPLE

SELECT DISTINCT EMPLE.OFICIO, DEPART.LOC
  FROM EMPLE, DEPART
  WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO AND DEPART.DEPT_NO=10; -- JOIN

--2. Obtener la siguiente salida:

SELECT DEPART.DEPT_NO, DEPART.DNOMBRE, COUNT(EMPLE.EMP_NO) "Nº DE EMPLEADOS"
  FROM DEPART, EMPLE
  WHERE EMPLE.DEPT_NO(+) = DEPART.DEPT_NO 
  GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE
  ORDER BY DEPART.DEPT_NO;

--3. Visualizar el número de departamento, el nombre del departamento, 
--y la cantidad de empleados del departamento con más empleados.

SELECT DEPART.DEPT_NO, DEPART.DNOMBRE, COUNT(EMPLE.EMP_NO) "CANTIDAD DEPARTAMENTOS"
  FROM DEPART, EMPLE
  WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
  GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE
  HAVING COUNT(*) = (SELECT MAX(COUNT(EMPLE.EMP_NO))
                                      FROM EMPLE
                                      GROUP BY EMPLE.DEPT_NO);

--4. Mostrar el apellido, el nombre del departamento y el salario de cualquier empleado cuyo salario
--y comisión coincidan con los de cualquier empleado que trabaje en Barcelona, incluidos los que no tienen comisión.

SELECT E.APELLIDO, D.DNOMBRE, E.SALARIO, D.LOC
  FROM EMPLE E, DEPART D
  WHERE E.DEPT_NO = D.DEPT_NO -- JOIN
  AND (SALARIO, NVL(E.COMISION_PCT, -1)) IN (SELECT SALARIO, NVL(E.COMISION_PCT, -1)
                                                                        FROM EMPLE E, DEPART D
                                                                        WHERE E.DEPT_NO = D.DEPT_NO
                                                                        AND UPPER(D.LOC)='BARCELONA')
                                                                        AND UPPER(D.LOC)!='BARCELONA'; --OJO ESTO ES PARA INCLUIR LOS QUE NO TIENEN COMISION EN BARCELONA 
  



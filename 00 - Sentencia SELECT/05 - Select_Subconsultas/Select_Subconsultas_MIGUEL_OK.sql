/*

Select_Subconsultas 
POR MIGUEL OLMO HERNANDO

*/

-- 1. Obtener el apellido de los empleados que tienen el mismo oficio que ‘GIL’.

DESC EMPLE

-- DE AQUI SACO QUE EL OFICIO DE GIL ES ANALISTA  
SELECT APELLIDO, OFICIO
  FROM EMPLE;

-- MIRO SI HAY MAS ANALISTAS Y SI HAY ALGUN GIL MAS
SELECT APELLIDO
  FROM EMPLE
  WHERE UPPER(OFICIO)='ANALISTA';  
  
-- APLICANDO LA SUBCONSULTA
SELECT APELLIDO "EMPLEADOS MISMO OFICIO"
  FROM EMPLE
  WHERE UPPER(OFICIO) IN (
    SELECT OFICIO
    FROM EMPLE
    WHERE UPPER(APELLIDO)='GIL');
  

-- 2. Queremos consultar los datos de los empleados que trabajan en las localidades de ‘MADRID’ o ‘BARCELONA’.

DESC EMPLE

-- COMPRUEBO QUE LAS LOCALIZACIONES EN PRIMER LUGAR EXISTEN Y SI EN ESAS HAY EMPLEADOS
SELECT * 
  FROM EMPLE, DEPART 
  WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO;
  
-- SOLUCION
SELECT *
  FROM EMPLE, DEPART
  WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO
AND
  UPPER(LOC) IN ('MADRID','BARCELONA');


-- 3. Obtener el apellido de los empleados con el mismo oficio y salario que ‘GIL’.

DESC EMPLE

--ASI MUESTRO TODOS LOS EMPLEADOS INCLUYENDO A GIL
SELECT APELLIDO, OFICIO, SALARIO
  FROM EMPLE
  WHERE (OFICIO,SALARIO) IN (
    SELECT OFICIO, SALARIO
      FROM EMPLE
      WHERE UPPER(APELLIDO)='GIL');

-- ASI MUESTRO A TODOS LOS EMPLEADOS MENOS A GIL
SELECT APELLIDO, OFICIO, SALARIO
  FROM EMPLE
  WHERE (OFICIO, SALARIO) IN (
    SELECT OFICIO, SALARIO
      FROM EMPLE
      WHERE UPPER(APELLIDO)='GIL') 
        AND
            UPPER(APELLIDO)!='GIL';

/*
4. Mostrar los empleados (nombre, oficio, salario y fecha de alta) que desempeñen 
el mismo oficio que "JIMENEZ" o que tengan un salario mayor o igual que "FERNANDEZ".

Nota: se supone que puede haber mas que un fernandez y un jimenez en la empresa
*/

DESC EMPLE

SELECT APELLIDO, OFICIO, SALARIO, FECHA_ALTA
  FROM EMPLE
  WHERE OFICIO IN 
  
(SELECT OFICIO
  FROM EMPLE
  WHERE UPPER(APELLIDO)='JIMENEZ') OR SALARIO >=

(SELECT SALARIO 
  FROM EMPLE
  WHERE UPPER(APELLIDO)='FERNANDEZ'
  );
                                

-- 5. Visualizar el número de departamento y la cantidad de empleados del departamento con más empleados.

SELECT EMPLE.DEPT_NO "Nº DEPARTAMENTO", COUNT(EMPLE.EMP_NO) "Nº EMPLEADOS" 
  FROM EMPLE, DEPART
  WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
  GROUP BY EMPLE.DEPT_NO
  HAVING EMPLE.DEPT_NO = 
  
(SELECT MIN(DEPT_NO)
  FROM EMPLE
); 

-- 6. Buscar el oficio con el salario medio más bajo.

SELECT OFICIO, AVG(SALARIO) "BAJO MEDIO SALARIO"
  FROM EMPLE
  GROUP BY OFICIO
  HAVING AVG(SALARIO) =

(SELECT ROUND(MIN(AVG(SALARIO)),1)
  FROM EMPLE
  GROUP BY OFICIO
);

/*
7. ¿Qué es incorrecto en esta sentencia?
SELECT EMP_NO, APELLIDO
FROM EMPLE
WHERE SALARIO = ( SELECT MIN(SALARIO))
				FROM EMPLE
				GROUP BY DEPT_NO);
*/

/*8.  ¿Qué ocurre con la siguiente sentencia?
SELECT APELLIDO, OFICIO
FROM EMPLE
WHERE OFICIO = ( SELECT OFICIO
			FROM EMPLE
			WHERE APELLIDO = 'PEREZ');
¿Qué ocurriría si existiera un oficio con valor nulo?
*/

-- 9. Mostrar los apellidos de los empleados que no tienen subordinados.

SELECT apellido
  FROM emple 
  WHERE DEPT_NO IN ( SELECT ID_JEFE FROM EMPLE);

-- 10. Mostrar los apellidos de los empleados que tienen subordinados.

SELECT APELLIDO
  FROM EMPLE;

--11. Escribir una consulta para mostrar los códigos de empleado y los apellidos de todos los empleados 
--que trabajen en un departamento con cualquier empleado cuyo apellido contenga una 'U'.

SELECT emp_no, apellido
  FROM emple
  GROUP BY dept_no, emp_no, apellido
  HAVING upper(apellido) LIKE '%U%';

--12. Modificar la consulta anterior para mostrar los códigos de empleado y los apellidos de todos los empleados 
--que ganan más del salario medio y que trabajen en un departamento con un empleado que tenga una 'U' en su apellido.

SELECT EMP_NO, APELLIDO, SALARIO
  FROM EMPLE
  WHERE DEPT_NO IN (SELECT DEPT_NO FROM EMPLE WHERE LOWER(APELLIDO) LIKE '%u%')
  AND SALARIO; (SELECT EMP_NO, APELLIDO AVG(SALARIO) FROM EMPLE);

13. Escribir una consulta para mostrar el apellido, número de departamento y el salario de cualquier empleado cuyo número de departamento  y salario coincidan con el número de departamento y salario de cualquier empleado que ganen comisión.

SELECT emple.APELLIDO, depart.DEPT_NO, COMISION_PCT
  FROM emple, depart
  WHERE emple.DEPT_NO = depart.DEPT_NO
  AND COMISION_PCT IS NOT NULL;

14. Escribir una consulta para encontrar todos los empleados que ganan más que el salario medio de sus departamentos. Mostrar el apellido, el salario y el código del departamento .

SELECT APELLIDO, SALARIO, DEPART.DEPT_NO
  FROM EMPLE, DEPART
  WHERE SALARIO (ROUND(AVG(SALARIO)) AS "Salario Medio" 
                FROM emple)

15. Modificar el ejercicio anterior para visualizar el apellido, el salario, el código del departamento y el salario medio de los sueldos de ese departamento. Ordenar por salario medio.


SELECT APELLIDO, SALARIO, (AVG(SALARIO)) AS "Salario Medio"
FROM EMPLE, DEPART
GROUP BY DEPT_NO
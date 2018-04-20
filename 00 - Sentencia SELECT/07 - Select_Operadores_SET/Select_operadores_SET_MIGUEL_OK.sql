/*
Select_operadores_SET

POR MIGUEL OLMO HERNANDO
*/

-- 3. Realiza las siguientes consultas:

/*
1. Visualizar el código de empleado y el código de los trabajos actuales y 
anteriores de todos los empleados. Cada empleado aparecerá una sola vez.
*/

DESC EMPLEADOS

-- TRABAJOS AHORA
SELECT DISTINCT E.EMP_NO "CODIGO EMPLEADO", E.TRAB_COD
  FROM EMPLEADOS E;
  
-- ANTERIORES A LA ACTUAL

SELECT DISTINCT T.EMP_NO "CODIGO EMPLEADO", T.TRAB_COD
  FROM HISTORIAL_LABORAL T;
  
-- PEDIR LOS DOS CONJUNTOS

SELECT E.EMP_NO, E.TRAB_COD
  FROM EMPLEADOS E
UNION
SELECT T.EMP_NO, T.TRAB_COD
  FROM HISTORIAL_LABORAL T;
  
/*
2.  Visualizar el código de empleado, el código de los trabajos actuales y anteriores de todos los empleados. 
También saldrá en que departamento desarrolla y desarrollaba cada trabajo.  Mostrar la salida ordenada por departamento.
*/

SELECT EMP_NO, TRAB_COD, DPTO_COD
  FROM EMPLEADOS
UNION
SELECT EMP_NO, TRAB_COD, DPTO_COD
  FROM HISTORIAL_LABORAL 
ORDER BY DPTO_COD
;


/*
3. Visualizar los códigos de los empleados y de los trabajos de los empleados que 
actualmente tengan un trabajo que ocuparon ya anteriormente en la compañía.
*/

--AHORA
SELECT E.EMP_NO, E.TRAB_COD
  FROM EMPLEADOS E;

--ANTERIORMENTE
SELECT T.EMP_NO, T.TRAB_COD
  FROM HISTORIAL_LABORAL T;


-- INTERSECCION LO QUE HAY EN COMUN ENTRE LAS DOS TABLAS

SELECT E.EMP_NO, E.TRAB_COD
  FROM EMPLEADOS E
INTERSECT
SELECT T.EMP_NO, T.TRAB_COD
  FROM HISTORIAL_LABORAL T;


--4. Visualizar los códigos de los empleados que no hayan ejercido nunca el trabajo que tienen actualmente.

SELECT E.EMP_NO, E.TRAB_COD
  FROM EMPLEADOS E
MINUS
SELECT T.EMP_NO, T.TRAB_COD
  FROM HISTORIAL_LABORAL T;


/*
5. ¿Qué hace la siguiente sentencia?

VISUALIZA EL CODIGO DEL EMPLEADO Y DEL TRABAJO DE 

Visualizar el código de empleado, el código de los trabajos actuales y anteriores de todos los empleados sacando su salario actual y que no salgan duplicados

*/

SELECT EMP_NO, TRAB_COD, to_char(SALARIO)
FROM EMPLEADOS
UNION
SELECT EMP_NO, TRAB_COD, 'Sin salario'
FROM HISTORIAL_LABORAL;

/*
SELECT ORIGINAL DEL ENUNCIADO

SELECT EMP_NO, TRAB_COD, SALARIO
FROM EMPLEADOS
UNION
SELECT EMP_NO, TRAB_COD, 0
FROM HISTORIAL_LABORAL;

*/
 
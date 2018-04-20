/*

Select_Funciones_Grupo_2

POR MIGUEL OLMO HERNANDO

*/

/*
1.	Visualizar ( n� departamento y n� de empleados) s�lo los departamentos con m�s de 4 empleados,
pero ordenar la salida en descendente por n�mero de empleados.
*/

DESC EMPLE

SELECT DEPT_NO "N� DEPARTAMENTO", COUNT(EMP_NO) "N� EMPLEADOS"
  FROM EMPLE 
  GROUP BY DEPT_NO
  HAVING COUNT(EMP_NO)>4
  ORDER BY COUNT(EMP_NO) DESC;

/*
2.	Partiendo de la tabla EMPLE, obtener la suma de salarios, 
el salario m�ximo y el salario m�nimo por cada departamento (n� departamento).
*/

DESC EMPLE

SELECT SUM(SALARIO) "SUMA SALARIOS", MAX(SALARIO) "SALARIO MAXIMO", MIN(SALARIO) "SALARIO MINIMO", DEPT_NO "N� DEPARTAMENTO"
  FROM EMPLE
  GROUP BY DEPT_NO;
  
/*
3.	Calcular el n�mero de empleados que realizan cada oficio por departamento. 
Los datos que se visualizan son: departamento, oficio y n�mero de empleados.
*/

DESC EMPLE 

SELECT * FROM EMPLE;

SELECT DEPT_NO DEPARTAMENTO, OFICIO, COUNT(*) "N� EMPLEADOS" 
  FROM EMPLE 
  GROUP BY DEPT_NO, OFICIO;
  
/*
4.	Visualizar el valor num�rico que nos indique el n�mero de empleados 
que hay en el departamento que m�s empleados hay.
*/

DESC EMPLE

-- EL DEPARTAMENTO 20>5 EMPLEADOS EL 30>6 EMPLEADOS Y EL 40>3 EMPLEADOS
SELECT * FROM EMPLE ORDER BY DEPT_NO;

SELECT MAX(COUNT(*)) "DEPART CON MAS EMPLEADOS"
  FROM EMPLE
  GROUP BY DEPT_NO; 
  
/*
5.	Mostrar los n�meros de departamento y el salario medio para los 
departamentos cuyos salarios m�ximos sean mayores de 250000.
*/

DESC EMPLE
DESC DEPART

SELECT * FROM EMPLE;


SELECT DEPT_NO DEPARTAMENTOS, ROUND(AVG(SALARIO),0) "SALARIO MEDIO"
  FROM EMPLE
  GROUP BY DEPT_NO
  HAVING MAX(SALARIO)>250000
;

-- 6.	Visualizar el salario medio m�ximo por departamento.
DESC EMPLE

SELECT MAX(ROUND(AVG(SALARIO),1)) "SALARIO MEDIO MAXIMO" 
  FROM EMPLE
  GROUP BY DEPT_NO;
  
-- 7.	Escribir una consulta para mostrar el n�mero de personas con el mismo oficio.

DESC EMPLE

SELECT OFICIO, COUNT(EMP_NO) "N� PERSONAS OFICIO"
  FROM EMPLE
  GROUP BY OFICIO;

--8.	Mostrar el n�mero de director y el salario del empleado peor pagado para ese director. 

-- CREO QUE CON EL DIRECTOR SE REFIERE AL PRESIDENTE
DESC EMPLE

-- AHORA SE QUE REY ES EL PRESIDENTE DEL DEPARTAMENTO 40 Y SU NUMERO ES EL 7839
SELECT * FROM EMPLE;

-- AHORA SE QUE EL PEOR PAGADO POR EL DIRECTOR DEL DEPARTAMENTO 40 ES SANCHEZ CON 1521
SELECT *
  FROM EMPLE
  WHERE DEPT_NO=40;

-- POSIBLE SOLUCION 1

SELECT EMP_NO "N� DIRECTOR", APELLIDO EMPLEADO, SALARIO "PEOR PAGADO" 
  FROM EMPLE 
  WHERE SALARIO=(SELECT MIN(SALARIO) 
    FROM EMPLE
    WHERE DEPT_NO=40);
    
  
-- Excluir los empleados de los que se desconozca el director. 
?????
GROUP BY NVL2(EMP_NO, 'NOT NULL', 'NULL')

O

EMP_NO IS NOT NULL 


SELECT EMP_NO "N� DIRECTOR", APELLIDO EMPLEADO, SALARIO "PEOR PAGADO" 
  FROM EMPLE 
  WHERE EMP_NO IS NOT NULL AND SALARIO=(SELECT MIN(SALARIO) 
    FROM EMPLE
    WHERE DEPT_NO=40);

-- Excluir los grupos en los que el salario m�nimo sea 200000 o menos. 
HAVING MIN(SALARIO)<200000

-- Ordenar el resultado por salario de forma descendente.
ORDER BY MIN(SALARIO) DESC


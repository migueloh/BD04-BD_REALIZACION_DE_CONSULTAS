/*

Select_Funciones_Grupo_1

POR MIGUEL OLMO HERNANDO

*/ 

-- 1.	Mostrar la media, salario mayor, menor y suma de salarios mensuales de todos los comerciales.

DESC EMPLE

SELECT * FROM EMPLE;

SELECT SALARIO, OFICIO
  FROM EMPLE
  WHERE OFICIO=UPPER('COMERCIAL');
  
SELECT ROUND(AVG(NVL(SALARIO, 0))) "MEDIA DE LOS SALARIOS", 
       MAX(SALARIO) "SALARIO MAYOR", 
       MIN(SALARIO) "SALARIO MENOR", 
       SUM(SALARIO) "SUMA DE LOS SALARIOS"
  FROM EMPLE
  WHERE OFICIO=UPPER('COMERCIAL');

-- 2.	Mostrar la fecha de mayor antig�edad y la de menor antig�edad.

DESC EMPLE

SELECT FECHA_ALTA FROM EMPLE;

SELECT MIN(FECHA_ALTA) "FECHA MAS ANTIG�A", MAX(FECHA_ALTA) "FECHA MENOS ANTIG�A"
  FROM EMPLE;
  
  
SELECT MIN(FECHA_ALTA) "ANTIG�A - MENOS ANTIG�A"
  FROM EMPLE
UNION 
SELECT MAX(FECHA_ALTA) 
FROM EMPLE;

-- 3.	Mostrar el primer apellido y el �ltimo de la lista alfab�tica de todos los empleados.

DESC EMPLE

SELECT APELLIDO FROM EMPLE;

SELECT MIN(APELLIDO) "PRIMER APELLIDO", MAX(APELLIDO) "ULTIMO APELLIDO"
  FROM EMPLE
  ORDER BY APELLIDO ASC;
  
-- 4.	Mostrar el n�mero de empleados del departamento 40.

DESC EMPLE

SELECT * FROM EMPLE WHERE DEPT_NO=40;
-- VEO QUE SON 3

SELECT COUNT(*) "NUMERO DE EMPLEADOS"
  FROM EMPLE
  WHERE DEPT_NO=40;
  

-- 5.	Mostrar el n�mero de empleados del departamento 30 que pueden percibir comisi�n.

DESC EMPLE

SELECT * FROM EMPLE WHERE DEPT_NO=30;
-- VEO QUE SON 4 PORQUE NEGRO Y JIMENO SON NULAS

-- CON ESTA SELECT VEO QUE EL EMPLEADO SALA O MARTIN ME LO CUENTA COMO SOLO 1 PORQUE SU COMISION ES LA MISMA
SELECT COUNT(COMISION_PCT) "EMPLEADOS DEPART 30"
  FROM EMPLE
  WHERE DEPT_NO=30;

-- LA FORMA CORRECTA SERIA LA SIGUIENTE
SELECT COUNT(*) "EMPLEADOS DEPART 30"
  FROM EMPLE
  WHERE DEPT_NO=30 AND COMISION_PCT IS NOT NULL;

-- 6.	Visualizar la cantidad de departamentos distintos que hay en la tabla empleados.

DESC DEPART
DESC EMPLE

SELECT * FROM DEPART; -- DEPARTAMENTOS EN TOTAL 5: 10 - 11 - 20 - 30 -40
SELECT * FROM EMPLE; -- DEPARTAMENTOS EN LA TABLA EMPLEADOS 3: 20 - 30 - 40

SELECT COUNT(DISTINCT DEPT_NO) "TOTAL DEPART EN EMPLE" 
  FROM EMPLE;
  
-- LA PRIMERA VEZ QUE SALE UN DEPARTAMENTO Y CONTARLO, POR ESO ES NECESARIO EL DISTINCT

-- 7.	Visualizar el n�mero de empleados que hay en cada departamento. Mostrar las columnas n� departamento y n� de empleados -cantidad-.

DESC EMPLE

SELECT DEPT_NO "N� DEPARTAMENTO", COUNT(*) "N� EMPLEADOS"
  FROM EMPLE
  GROUP BY DEPT_NO;
  
-- AGRUPADAS POR DEPARTAMENTO

-- 8.	Visualizar ( n� departamento y n� de empleados -cantidad-) s�lo de los departamentos con m�s de 4 empleados.

DESC EMPLE

SELECT DEPT_NO "N� DEPARTAMENTO", COUNT(EMP_NO) "N� EMPLEADOS"
  FROM EMPLE
  GROUP BY DEPT_NO
  HAVING COUNT(DEPT_NO)>4;
  
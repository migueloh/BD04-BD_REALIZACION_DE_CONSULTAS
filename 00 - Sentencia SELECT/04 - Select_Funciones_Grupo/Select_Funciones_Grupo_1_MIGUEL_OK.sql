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

-- 2.	Mostrar la fecha de mayor antigüedad y la de menor antigüedad.

DESC EMPLE

SELECT FECHA_ALTA FROM EMPLE;

SELECT MIN(FECHA_ALTA) "FECHA MAS ANTIGÜA", MAX(FECHA_ALTA) "FECHA MENOS ANTIGÜA"
  FROM EMPLE;
  
  
SELECT MIN(FECHA_ALTA) "ANTIGÜA - MENOS ANTIGÜA"
  FROM EMPLE
UNION 
SELECT MAX(FECHA_ALTA) 
FROM EMPLE;

-- 3.	Mostrar el primer apellido y el último de la lista alfabética de todos los empleados.

DESC EMPLE

SELECT APELLIDO FROM EMPLE;

SELECT MIN(APELLIDO) "PRIMER APELLIDO", MAX(APELLIDO) "ULTIMO APELLIDO"
  FROM EMPLE
  ORDER BY APELLIDO ASC;
  
-- 4.	Mostrar el número de empleados del departamento 40.

DESC EMPLE

SELECT * FROM EMPLE WHERE DEPT_NO=40;
-- VEO QUE SON 3

SELECT COUNT(*) "NUMERO DE EMPLEADOS"
  FROM EMPLE
  WHERE DEPT_NO=40;
  

-- 5.	Mostrar el número de empleados del departamento 30 que pueden percibir comisión.

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

-- 7.	Visualizar el número de empleados que hay en cada departamento. Mostrar las columnas nº departamento y nº de empleados -cantidad-.

DESC EMPLE

SELECT DEPT_NO "Nº DEPARTAMENTO", COUNT(*) "Nº EMPLEADOS"
  FROM EMPLE
  GROUP BY DEPT_NO;
  
-- AGRUPADAS POR DEPARTAMENTO

-- 8.	Visualizar ( nº departamento y nº de empleados -cantidad-) sólo de los departamentos con más de 4 empleados.

DESC EMPLE

SELECT DEPT_NO "Nº DEPARTAMENTO", COUNT(EMP_NO) "Nº EMPLEADOS"
  FROM EMPLE
  GROUP BY DEPT_NO
  HAVING COUNT(DEPT_NO)>4;
  
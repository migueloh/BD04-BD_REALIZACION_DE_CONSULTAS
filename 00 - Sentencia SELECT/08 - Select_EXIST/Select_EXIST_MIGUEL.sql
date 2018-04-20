
/*
SELECT_EXIST

TABLAS EN 02_creacion_tablas_emple_depart_hjob_datos.sql

POR MIGUEL OLMO HERNANDO

*/

/*
Ejecuta el script 02_creacion_tablas_emple_depart_hjob_y_datos.sql que encontrarás en ikas. 
Genera un pdf utilizando DataModeler que contenga el esquema relacional correspondiente al script.
*/

--1. Obtén los datos de los empleados cuyo salario supera la media de los salarios de la empresa.

DESC EMPLE

SELECT AVG(SALARIO) "SALARIO MEDIO EMPRESA"
  FROM EMPLE;

SELECT *
  FROM EMPLE
  WHERE SALARIO > (SELECT AVG(SALARIO)
                              FROM EMPLE)
                              ;

/*
2.  Realiza una consulta que muestre el nombre, el salario y el código del 
departamento de los empleados cuyo salario supere la media de su departamento.
*/

SELECT D.DNOMBRE, E.SALARIO, D.DEPT_NO 
	FROM EMPLE E , DEPART D 
	WHERE E.DEPT_NO = D.DEPT_NO 
	AND E.SALARIO > ANY (SELECT AVG(salario)  
                      FROM EMPLE); 


SELECT NOMBRE, SALARIO, DEPT_NO 
	FROM EMPLE E  
	WHERE SALARIO >
	 (SELECT AVG(salario)  
                      FROM EMPLE
                      WHERE DEPT_NO = E.DEPT_NO); 


/*
3.  Listar las localidades donde existan departamentos con empleados 
cuya comisión supere el 10% del salario. Realízala de dos formas.
*/
 
 --'v'
SELECT LOC
	FROM DEPART D
	WHERE EXISTS (SELECT *
					FROM EMPLE E
					WHERE COMISION_PCT > 10*SALARIO/100
          AND E.DEPT_NO = D.DEPT_NO);
          
          X
 

/*
4. Escribir una consulta para mostrar los apellidos de los empleados que tengan uno 
o más compañeros de trabajo en sus departamentos con fechas de contratación posteriores paro salarios más altos. 
*/


--1A FORMA
SELECT APELLIDO
  FROM EMPLE E
  WHERE 1<= (SELECT COUNT(*) -- EL COUNT DEVUELVE LA CANTIDAD DE EMPLEADOS 
                FROM EMPLE
                WHERE DEPT_NO = E.DEPT_NO -- QUEDARNOS SOLO CON LAS FILAS EN LAS CUALES EL DEPARTAMENTO ES IGUAL A LA SELECCION ORIGINAL
                AND SALARIO > E.SALARIO -- CONDICION DE LOS SALARIOS
                AND FECHA_ALTA < E.FECHA_ALTA) -- FECHA DE ALTA
                ; 

--2A FORMA
SELECT APELLIDO
  FROM EMPLE E
  WHERE EXISTS (SELECT 'A'
                  FROM EMPLE
                  WHERE DEPT_NO = E.DEPT_NO 
                  AND SALARIO > E.SALARIO 
                  AND FECHA_ALTA < E.FECHA_ALTA) 
                ; 

--5.  Buscar los departamentos que no tengan empleados. Hazlo de dos formas.

--1A FORMA
SELECT DEPART.* 
  FROM DEPART
  WHERE DEPART.DEPT_NO NOT IN  (SELECT DISTINCT EMPLE.DEPT_NO 
                          FROM EMPLE);
--2A FORMA
SELECT D.*
	FROM DEPART D
	WHERE NOT EXISTS (SELECT E.EMP_NO 
						FROM EMPLE E
						WHERE D.DEPT_NO = E.DEPT_NO);


--6.  Muestra los detalles de los empleados que han cambiado de puesto al menos dos veces. 

SELECT *
	FROM EMPLE
	WHERE 2< = (SELECT COUNT(*)
                FROM HJOB
                WHERE HJOB.EMP_NO = EMPLE.EMP_NO);
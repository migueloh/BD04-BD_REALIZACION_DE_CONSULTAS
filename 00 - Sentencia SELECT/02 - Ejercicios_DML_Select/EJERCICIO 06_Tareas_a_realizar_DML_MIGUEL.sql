-- Tareas_a_realizar_0_select_basicas_individual

-- MIGUEL OLMO HERNANDO 


/*1. Seleccionar de la tabla EMPLE aquellos empleados del departamento 20 y cuyo oficio sea ‘ANALISTA’.
La consulta se ha de ordenar de modo descendente por APELLIDO y también de manera descendente por número de empleado.*/

DESC EMPLE

SELECT *  
  FROM EMPLE;

SELECT APELLIDO, OFICIO 
  FROM EMPLE 
  WHERE DEPT_NO=20 AND OFICIO=('ANALISTA')
  ORDER BY DESC APELLIDO AND EMP_NO
  ;
  

/*2. Mostrar el apellido, oficio y fecha de alta de los empleados contratados entre los meses de 
mayo y setiembre del año 1981. Obtener la salida ordenada por fecha de alta.*/


SELECT APELLIDO, OFICIO, FECHA_ALTA
  FROM EMPLE
  WHERE FECHA_ALTA BETWEEN TO_DATE('01-06-1981','DD-MM-YYYY') AND TO_DATE('01-10-1981','DD-MM-YYYY')
  ORDER BY FECHA_ALTA;

/*3.  Mostrar los apellidos de los empleados concatenados con el oficio, separados por una coma y 
un espacio en blanco y ordenados por el apellido. Llamar a la columna 'EMPLE y OFI'.*/

SELECT APELLIDO 
  FROM EMPLE 
  WHERE LIKE ORDER BY APELLIDO;
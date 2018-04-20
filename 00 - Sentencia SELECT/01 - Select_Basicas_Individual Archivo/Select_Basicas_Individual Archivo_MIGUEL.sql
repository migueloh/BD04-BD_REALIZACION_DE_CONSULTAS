/*  

Select_Basicas_Individual Archivo

EJERCICIOS POR MIGUEL OLMO HERNANDO*/


/*1. Seleccionar de la tabla EMPLE aquellos empleados del departamento 20 y cuyo oficio sea ‘ANALISTA’. 
La consulta se ha de ordenar de modo descendente por APELLIDO y también de manera descendente por número de empleado.
*/

SELECT *
  FROM EMPLE
  WHERE DEPT_NO=20 AND UPPER(OFICIO) = ' ANASLISTA'
  ;


-- 2. Mostrar el apellido, oficio y fecha de alta de los empleados contratados entre los meses de mayo y setiembre del año 1981. Obtener la salida ordenada por fecha de alta.

SELECT APELLIDO, OFICIO, FECHA_ALTA
  FROM EMPLE 
  WHERE FECHA_ALATA BETWEEN TO_DATE ('01/05/1981, DD/MM/YYYY') AND TO_DATE ('30/09/1981, DD/MM/YYYY')
  ORDER BY FECHA_ALTA
  ;

 --3.  Mostrar los apellidos de los empleados concatenados con el oficio, separados por una coma y un espacio en blanco y ordenados por el apellido. Llamar a la columna 'EMPLE y OFI'.


  -- SI LA CABECERA LLEVA ESPACIOS EN BLANCO SE TIENEN QUE PONER ENTRE COMILLAS DOBLES 
  -- SI LA CABECERA NO LLEVA ESPACIOS EN BLANCO NO HACE FALTA
  
SELECT APELLIDO || ' , ' || OFICIO AS "EMPLE Y OFICIO" 
  FROM EMPLE
  ORDER BY APELLIDO;
  
  -- ESTA OTRA OPCION FUNCIONA PERO NO PERMITE SEPARAR LAS COLUMNAS
  
SELECT  concat(APELLIDO, OFICIO) 
  FROM emple
  ORDER BY APELLIDO;
  
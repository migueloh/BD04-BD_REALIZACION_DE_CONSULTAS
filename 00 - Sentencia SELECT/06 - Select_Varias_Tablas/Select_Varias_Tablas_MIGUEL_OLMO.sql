/*
REALIZACION DE CONSULTAS

Select_Varias_Tablas

POR MIGUEL OLMO HERNANDO

*/

--1.  A partir de las tablas EMPLE y DEPART obtener los siguientes datos de los empleados: 
--apellido, oficio, número de empleado, nombre de departamento y localidad.

DESC EMPLE
DESC DEPART

SELECT * FROM EMPLE;
SELECT * FROM DEPART;

SELECT E.APELLIDO, E.OFICIO, E.EMP_NO, D.LOC
  FROM EMPLE E, DEPART D
  WHERE E.DEPT_NO = D.DEPT_NO;
  

--2. Queremos consultar los datos de los empleados y el nombre de la localidad de aquellos que  trabajan en ‘MADRID’ o ‘BARCELONA’. 

SELECT E.*, D.LOC
  FROM EMPLE E, DEPART D
  WHERE E.DEPT_NO = D.DEPT_NO AND UPPER(D.LOC) IN ('MADRID', 'BARCELONA');
  

--3. Obtener para cada empleado (código y apellidos), así como los apellidos de su jefe. 
--La columna JEFE de un empleado indica el numero de empleado de su jefe.

SELECT E.EMP_NO "CODIGO EMPLEADO", E.APELLIDO "APELLIDO EMPLEADO", J.EMP_NO "CODIGO JEFE",  J.APELLIDO "APELLIDO JEFE"
  FROM EMPLE E, EMPLE J
  WHERE E.ID_JEFE = J.EMP_NO
  ORDER BY E.APELLIDO;

--4. Visualizar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS.

SELECT * FROM EMPLE;
SELECT * FROM DEPART;

SELECT E.APELLIDO, E.OFICIO, D.LOC
  FROM EMPLE E, DEPART D
  WHERE E.DEPT_NO = D.DEPT_NO AND UPPER(E.OFICIO)='ANALISTA';

--5. Mostrar para cada empleado quién es su jefe (apellido ). Si no tiene jefe, mostrar ausencia de valor(NULL).

SELECT * FROM EMPLE;

SELECT E.EMP_NO, E.APELLIDO, 
        NVL(TO_CHAR(J.EMP_NO),'SIN' )  "CODIGO JEFE",
        NVL(J.APELLIDO, 'NO TIENE JEFE')  "APELLIDO JEFE"
  FROM EMPLE E , EMPLE J
  WHERE  E.ID_JEFE = J.EMP_NO(+)
  ORDER BY E.APELLIDO;
  
/*
PARA CUANDO LOS NULOS SON EN LAS COLUMNAS
*/
  
--6. Mostrar para todos los departamentos que tenemos en la empresa los apellidos de los empleados que 
--pertenecen a cada uno de ellos. Si algún departamento está vacío, mostrar ausencia de valor NULL.

SELECT EMPLE.APELLIDO, DEPART.* 
  FROM EMPLE, DEPART
  WHERE EMPLE.DEPT_NO(+) = DEPART.DEPT_NO
  ORDER BY DEPART.DEPT_NO;
  
  /*
  PARA LOS NULOS EN LAS RELACIONES
  */
  

/*
Select_Funciones_Fila

CREADO POR MIGUEL OLMO HERNANDO
*/

/*
1.	La Gerencia desea contar con informaci�n de los jefes a cargo de cada empleado. 
Para ello se requiere que construya una consulta que muestre el apellido del empleado  
con el alias empleado y la identificaci�n de su jefe con la cabecera jefe. 

Si el empleado NO posee jefe se debe mostrar el mensaje NO TIENE JEFE. La informaci�n 
se debe mostrar ordenada en forma descendente por  identificaci�n del jefe.
*/

-- ATRIBUTOS DE LA TABLA EMPLE
DESC EMPLE

-- COMPRUEBO QUE EMPLEADOS NO TIENEN JEFE Y VEO QUE REY NO TIENE JEFE (NULL)
SELECT * FROM EMPLE;

/*
TEORIA TEMA 6 - REALIZACION DE CONSULTAS 
Se utiliza para sustituir un valor nulo por otro
valor. Si �valor� es NULL es sustituido por la
�expresi�n�; si no lo es, la funci�n devuelve
�valor�. 

LA FUNCION TO_CHAR NOS PERMITE CONVERTIR EN ESTE CASO EL NULO A LA EXPRESION - NO TIENE JEFE - MEDIANTE UNA CADENA DE CARACTERES
*/

SELECT APELLIDO APELLIDO, NVL(TO_CHAR(ID_JEFE),'NO TIENE JEFE') JEFE
  FROM EMPLE
  ORDER BY ID_JEFE DESC;
  
/*
2.	 Los empleados han planteado la necesidad de que se les aumente el valor de 
movilizaci�n mensual que se les debe pagar por ley. Por ello, la Gerencia ha 
definido que el valor de movilizaci�n ser� un porcentaje del salario mensual del empleado.

Este porcentaje corresponder� por cada 1000 del salario de cada empleado, es decir, si el 
salario del empleado es 8200 el porcentaje de aumento de movilizaci�n ser� de 8%, si el 
salario del empleado es de 15000 el porcentaje de aumento ser� de 15% etc. Como primera 
etapa se debe generar un informe que muestre la identificaci�n del empleado, su salario 
actual y el porcentaje del salario que le corresponder� como movilizaci�n. Dar a cada columna 
de salida las cabeceras empleado, salario y "porcentaje de movilizaci�n� respectivamente.
*/

/*
TRUNC
Devuelve �n�mero� truncado a �m� decimales;
�m� puede ser negativo; si lo es, trunca por la
izquierda del punto decimal

EJEMPLO:

EN VEZ DE SALARIO PONGO UNA CANTIDAD

SELECT TRUNC(l.5634,1) FROM EMPLE; ESTE DARIA 1,5
SELECT TRUNC(l.1684,2) FROM EMPLE; ESTE DARIA 1,16
SELECT TRUNC(l.662) FROM EMPLE; ESTE DARIA 1

SELECT TRUNC(187.98,-l) FROM EMPLE; ESTE DARIA 180 
SELECT TRUNC(l87.98,-2) FROM EMPLE; ESTE DARIA 100
SELECT TRUNC(l87.98,-3) FROM EMPLE;  ESTE DARIA 0 
*/

SELECT EMP_NO EMPLEADO, SALARIO SALARIO, TRUNC(SALARIO/1000 ,1) "PORCENTAJE DE MOVILIZACION"
FROM EMPLE;

/*
3.	 La empresa ha decido modificar las pol�ticas de asignaci�n de usuario y clave a acceso del personal 
     a los diferentes sistemas inform�ticos que existen. Desde el pr�ximo mes la pol�tica de asignaci�n 
     de nombres de usuarios y claves ser�:
     
?	Nombre de Usuario: corresponder� a las tres primeras letras del apellido del empleado (la primera en may�scula 
y las otras dos en min�sculas), seguido de la longitud del apellido y de la identificaci�n del trabajo que desempe�a.

?	Clave del Usuario: corresponder� al mes y a�o (en 4 d�gitos) de contrato del empleado 
seguido de las dos �ltimas letras de su apellido en may�sculas.

Se nos pide construir una consulta que permita obtener el nombre del empleado, su apellido, 
identificaci�n de su trabajo, nombre de usuario y clave. La informaci�n se requiere 
ordenada por apellido en forma ascendente.
*/


/*
INITCAP PRA INICIAR POR MAYUS Y TERMINAR POR MINUS

SUBSTR - COJO DEL APELLIDO LAS 2 ULTIMAS LETRAS -2
Devuelve una subcadena de char de n caracteres a partir de la posicion m.
Si m es positivo, empieza a contar desde el principio.
Si m es negativo, empieza a contar desde el final.
Si no ponemos n, devuelve hasta el final de la cadena. 

LA FECHA LO HE SACADO DE ESTE MANUAL
https://www.essentialsql.com/introduction-to-sql-servers-date-functions/

*/
DESC EMPLE;
SELECT * FROM EMPLE;

SELECT APELLIDO NOMBRE, APELLIDO APELLIDO, OFICIO TRABAJO_DESEMPENA, 
       INITCAP(SUBSTR(APELLIDO, 1, 3)) || LENGTH(APELLIDO) || OFICIO "NOMBRE DE USUARIO",
       TO_CHAR(FECHA_ALTA, 'MMYYYY') || UPPER(SUBSTR(APELLIDO, -2)) "CLAVE USUARIO"
FROM EMPLE
ORDER BY APELLIDO;


/*
La empresa desea que se automatice algunos de los procesos involucrados en el c�lculo 
de las remuneraciones mensuales de los empleados. En un esfuerzo por mejorar las necesidades 
econ�micas de los empleados, se desea saber el costo que significar�a efectuar un aumento en 
sus salarios. Para ello, se ha pensado que el porcentaje de reajuste corresponder� al primer 
d�gito del salario actual de cada empleado es decir, si el empleado posee un salario de 24000 
su aumento ser� de 2%, si su salario es de 7500 su aumento ser� de 7% etc. Se requiere de un 
informe que muestre el nombre y apellido del empleado concatenado, salario actual y porcentaje 
de reajuste. 

Dar a cada columna de salida el alias correspondiente y formato a los valores del salario 999,999.999 y el reajuste 9,999.999.

NOTA: 
Tener en cuenta si nuestra base de datos utiliza o no el sistema anglosajon 
a la hora de elaborar la mascara formato de salida.
*/

SELECT APELLIDO "NOMBRE EMPLEADO", 
  TO_CHAR(SALARIO,'999,999.999') SALARIO,
  TO_CHAR((SALARIO * SUBSTR(SALARIO,1,1)/100),'999,999.999') REAJUSTE
FROM EMPLE;

/*
5.	
Se nos pide que realicemos una consulta que implementar el c�lculo de las comisiones y  
salario total de cada uno de los empleados considerando las siguientes especificaciones:

?	Si el empleado posee porcentaje de comisi�n se debe mostrar, de lo contrario se debe mostrar el literal 'SIN COMISION'.

?	El valor de la comisi�n  corresponder� al valor del salario actual multiplicado por el porcentaje de comisi�n. 
Si el empleado no posee porcentaje de comisi�n se debe mostrar el valor cero.

?	 El valor salario total corresponder� a la suma del valor del salario actual m�s el valor de la comisi�n. 
Si el empleado no posee omisi�n el salario total ser� igual al valor del salario actual.

En esta primera etapa, solo se requiere de un listado que muestre  la identificaci�n del empleado con el alias id_emp, 
el valor del salario actual, el porcentaje de comisi�n, el valor de la comisi�n calculada y el valor del salario total calculado.
*/

DESC EMPLE

SELECT EMP_NO ID_EMP, SALARIO "SIN COMICION",
       NVL(TO_CHAR(COMSISION_PCT), 'SIN COMISION') "PORCENTAJE DE LA COMISION",
       NVL2(COMSISION_PCT, SALARIO*COMSISION_PCT,0) "VALOR DE LA COMISION CALCULADA",
       NVL2(COMSISION_PCT, SALARIO+(SALARIO*COMSISION_PCT),SALARIO) "VALOR DEL SALARIO TOTAL CALCULADO"
FROM EMPLE;

/*
6.	
Mostrar el n�mero de empleado, la fecha de alta en la empresa, el n�mero de meses que lleva empleado, 
la fecha de revisi�n de los 6 meses, el primer viernes tras la fecha de alta y el �ltimo d�a del mes 
de contrataci�n para todos los trabajadores que llevan menos de 460 meses.

Nota: Mira en la teor�a las funciones: MONTHS_BETWEEN, ADD_MONTH, NEXT_DAY, y LAST_DAY.

*/
--APELLIDO NOMBRE, APELLIDO APELLIDO, OFICIO TRABAJO_DESEMPENA, 

SELECT EMP_NO "NUMERO DE EMPLEADO", FECHA_ALTA "FECHA DE ALTA EN LA EMPRESA", 
  FROM EMPLE;

SELECT FECHA ALTA DATEADD(month,DATEDIFF(month,0,getdate())+1,0)-1
  FROM EMPLE
  WHERE 
  
/*

NI LEYENDO
https://sites.google.com/site/experienciasenprogramacion/Home/comandos-sql/operaciones-con-fechas
http://mioracle.blogspot.com.es/2008/02/operaciones-con-fechas.html
*/  
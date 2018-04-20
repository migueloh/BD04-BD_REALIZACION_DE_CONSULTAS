/*
Repaso_Tablas_Proyecto

POR MIGUEL OLMO HERNANDO
*/
--1.  Obtener el nombre de los conductores que hayan trabajado con una Volqueta.

SELECT * FROM CONDUCTORES;
SELECT * FROM MAQUINAS;
SELECT * FROM TRABAJOS;

DESC CONDUCTORES
DESC MAQUINAS
DESC TRABAJOS

--VERSION 1
SELECT DISTINCT C.NOMBRE "NOMBRE CONDUCTOR"
  FROM CONDUCTORES C, TRABAJOS T, MAQUINAS M
  WHERE C.COD_C = T.COD_C 
  AND T.COD_M = M.COD_M 
  AND UPPER(M.NOMBRE) = 'VOLQUETA';

--VERSION 2
SELECT DISTINCT C.NOMBRE "NOMBRE CONDUCTOR"
  FROM CONDUCTORES C
  WHERE COD_C IN (SELECT COD_C
                    FROM TRABAJOS
                    WHERE COD_M IN (SELECT COD_M
                                      FROM MAQUINAS M
                                      WHERE UPPER(M.NOMBRE)='VOLQUETA'));
                                      
/*
2. Obtener el código, la descripcion y cliente de aquellos proyectos en los que hayan trabajado 
maquinas con un precio hora superior a 12 conducidas por conductores de Rivas
*/

SELECT * FROM CONDUCTORES;
SELECT * FROM MAQUINAS;
SELECT * FROM TRABAJOS;
SELECT * FROM PROYECTOS;

SELECT P.COD_P, P.DESCRIPCION, P.CLIENTE
  FROM PROYECTOS P, CONDUCTORES C, TRABAJOS T, MAQUINAS M
  WHERE T.COD_P = P.COD_P
  AND T.COD_M = M.COD_M
  AND T.COD_C = C.COD_C
  AND M.PRECIOHORA > 12
  AND INITCAP(C.LOCALIDAD) = 'Rivas';

 
--3.  Obtener los codigos de los conductores que hayan utilizado las maquina M04 y la maquina M03.

--VERSION 1
SELECT COD_C
  FROM TRABAJOS
  WHERE UPPER(COD_M)='M01'
INTERSECT
  SELECT COD_C
    FROM TRABAJOS 
    WHERE UPPER(COD_M)='M03';

--VERSION 2
SELECT COD_C
  FROM TRABAJOS
  WHERE UPPER(COD_M)='M01'
  AND COD_C IN (SELECT COD_C
                  FROM TRABAJOS
                  WHERE UPPER(COD_M)='M03');
  
/*
4. Obtener el número de partes de trabajo (con la cabecera Número de Trabajos), el código del proyecto, 
la descripción y el cliente para aquél proyecto que figure con dos o mas partes de trabajo.
*/

DESC TRABAJOS
DESC PROYECTOS

SELECT P.COD_P, P.DESCRIPCION, P.CLIENTE, COUNT(*) "NUMERO TRABAJOS"
  FROM PROYECTOS P, TRABAJOS T
  WHERE P.COD_P = T.COD_P
  GROUP BY P.COD_P, P.DESCRIPCION, P.CLIENTE
  HAVING COUNT(*) > = 2;


--5. Obtener los trabajadores con categoria inferior a la de algun trabajador de Arganda

SELECT NOMBRE
  FROM CONDUCTORES
  WHERE CATEGORIA < ANY (SELECT CATEGORIA 
                           FROM CONDUCTORES
                           WHERE INITCAP(LOCALIDAD) ='Arganda'); 


--6. Obtener conductores que no han participado en el proyecto 'P01'

DESC PROYECTOS

SELECT C.NOMBRE
  FROM CONDUCTORES C
  WHERE C.COD_C <> ALL (SELECT T.COD_C
                         FROM TRABAJOS T
                         WHERE T.COD_P = 'P01');
                                           
-- NOTA <> QUIERE DECIR DISTINTO !=

--7. Obtener el numero total de maquinas que se han utilizado en 'P02' . 

SELECT * FROM MAQUINAS;
SELECT * FROM PROYECTOS;

SELECT COUNT(DISTINCT M.COD_M) " NUM TOT. MAQUINAS"
  FROM MAQUINAS M
  WHERE M.COD_M = 'P02';
  
SELECT * FROM TRABAJOS WHERE COD_P = 'P02';

--8. Obtener por cada conductor que haya trabajado, el codigo de este y la cantidad total de tiempo empleado

SELECT COD_C, SUM(TIEMPO) "TIEMPO EMPLEADO"
  FROM TRABAJOS
  GROUP BY COD_C;

/*
9. Obtener para los conductores que figuren con mas de un trabajo realizado, la suma de tiempos trabajados, 
con la cabecera: tiempo total trabajado. La salida estará ordenada por conductor. 
*/

DESC TRABAJOS

SELECT T.COD_C, SUM(T.TIEMPO) "TIEMPO TOT. TRABAJADO"
  FROM TRABAJOS T
  GROUP BY T.COD_C, T.COD_C
  HAVING COUNT(*) > 1
  ORDER BY T.COD_C;

--10. Obtener nombres de trabajadores que han utilizado la maquina 'M02'. 

DESC CONDUCTORES
DESC TRABAJOS

--VERSION 1
SELECT C.NOMBRE
  FROM CONDUCTORES C
  WHERE C.COD_C IN (SELECT T.COD_C
                      FROM TRABAJOS T
                      WHERE T.COD_M = 'M02');

--VERSION 2                                   
SELECT DISTINCT C.NOMBRE
  FROM CONDUCTORES C, TRABAJOS T
  WHERE C.COD_C = T.COD_C 
  AND COD_M = 'M02';

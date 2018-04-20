/*
Realización de Consultas

Ejercicio:

DML_Select

Por Miguel Olmo Hernando

*/

/*
EJER 1. Averigua la estructura de la tabla EMPLE,  sus restricciones 
y las columnas que forman parte de cada restricción, 
ya que se pretende crear una tabla de trabajo a partir de ella.

Crear la tabla denominada EMPLEADOS30 con la misma estructura de la tabla EMPLE pero 
con los datos de los empleados del departamento 30 de la tabla EMPLE.  

Para ello utiliza CREATE TABLE … AS SELECT …. ¿Se crean todas las restricciones?
*/

-- MOSTRAR LA ESTRUCTURA DE LA TABLA EMPLE:
DESC EMPLEADOS30

-- EXPLORAR EL CONTENIDO DE LA TABLA EMPLE:
SELECT * FROM EMPLEADOS30;

-- MOSTRAR LAS RESTRICCIONES DE LA TABLA EMPLE:
SELECT *
	FROM USER_CONSTRAINTS
	WHERE UPPER(TABLE_NAME)='EMPLE';

-- MOSTRAR LA INFORMACION DE LAS COLUMNAS QUE PARTICIPAN EN LAS RESTRICCIONES:
SELECT * 
  FROM USER_CONS_COLUMNS
  WHERE UPPER(TABLE_NAME)='EMPLE';
  
SELECT * 
    FROM EMPLEADOS30;
    
SELECT * 
    FROM EMPLEADOS30
    WHERE DEPT_NO=30;

-- CREAR LA TABLA EMPLEADOS30 CON LA MISMA ESTRUCTURA DE LA TABLA EMPLE 
-- PERO CON LOS DATOS DE LOS EMPLEADOS DEL DEPARTAMENTO 30 DE LA TABLA EMPLE 
CREATE TABLE EMPLEADOS30 AS 
  SELECT * 
    FROM EMPLE
    WHERE DEPT_NO=30;
    
-- AÑADIR LAS RESTRICCIONES DE EMPLE PERO EN EMPLEADOS3O EN UNA SOLA SENTENCIA

ALTER TABLE EMPLEADOS30 ADD (
  CONSTRAINT EMPLE30_EMPNO_PK PRIMARY KEY (EMP_NO),
  CONSTRAINT EMPLE30_DIR_FK FOREIGN KEY (ID_JEFE) REFERENCES EMPLE ON DELETE SET NULL,
  CONSTRAINT EMPLE30_DEP_FK FOREIGN KEY (DEPT_NO) REFERENCES DEPART ON DELETE CASCADE
);
  -- SI SE LLAMA DIFERENTE PONER EL NOMBRE DE LA COLUMNA

  
    
-- NOTA: ESTA NUEVA TABLA NO TENDRA CLAVE PRIMARIA NI CUALQUIER OTRA RESTRICCION 
-- DE LA TABLA EMPLE PUESTO QUE ESTAS NO SE CREAN NI SE TRANSFIEREN

-- OTRA PRUEBA POR MI CUENTA -- CREAR LA TABLA EMPLEADOS40 CON LA MISMA ESTRUCTURA Y DATOS DE LA TABLA EMPLE 
CREATE TABLE EMPLEADOS40 AS 
  SELECT * 
    FROM EMPLE;
    
    DROP TABLE EMPLEADOS40 CASCADE CONSTRAINTS;



-- EJER 2.Vamos a realizar una “transacción” que tiene los siguientes pasos. Comprobaremos cada paso. Los pasos son:

/* 1. Insertar en la tabla EMPLE a un empleado de apellido 'SAAVEDRA' con número de empleado 2000. 
      La fecha de alta será la fecha actual, el SALARIO será el mismo salario que el del empleado 
      de apellido 'SALA' más el 20 por 100 y el resto de datos serán los mismos que los datos del 
      empleado de apellido 'SALA'. Hazlo en un sólo paso.*/

-- COMPRUEBO SI EXISTE SALA Y MUESTRO LOS DATOS SI EXISTE
SELECT * 
  FROM EMPLE
  WHERE UPPER(APELLIDO)='SALA';
  
-- OFICIO COMERCIAL - ID_JEFE 7698 - SALARIO 1463 -  COMISION_PCT 5 - DEPT_NO 30 

INSERT INTO EMPLE
  SELECT 2000, 'SAAVEDRA', OFICIO, 7698, DIR, SYSDATE, ROUND(SALARIO+SALARIO*20/100), COMISION_PCT, DEPT_NO   
  FROM EMPLE 
  WHERE UPPER(APELLIDO)='SALA';

  
SAVEPOINT;
  
-- COMPROBACION
SELECT * 
  FROM EMPLE
  WHERE UPPER(APELLIDO)='SAAVEDRA';
  
COMMIT;

/* 2.	Actualiza la tabla EMPLE, cambiando el número de departamento, para todos los empleados que 
      tenga el mismo oficio que el empleado 7566, por el número de departamento actual del empleado 7499.*/
     
-- PRUEBA 1 
UPDATE EMPLE SET (OFICIO, DEPT_NO) =
              (SELECT EMPLE.OFICIO, EMPLE.DEPT_NO 
                FROM EMPLE 
                WHERE EMP_NO=7499)
              WHERE EMP_NO=7566;
              
              
              update emple
              set dept_no=(SELECT DEPT_MNO
              FROM EMPLE
              WHERE EMP_NO = 7499)
              WHERE OFICIO = (SLEECT OFICIO 
              FROM EMPLE
              WHERE EMP_NO = 7566);
   
  
-- 3.	Borrar todos los departamentos de la tabla DEPART para los cuales no existan empleados en EMPLE.              

  -- DISTINCT PARA QUE NO SE REPITAN
SELECT DISTINCT DEPT_NO
  FROM EMPLE
  ;

DELETE FROM DEPART
  WHERE DEPT_NO NOT IN (SELECT DISTINCT DEPT_NO
                          FROM EMPLE
                          );
                          

                          
-- 4.	Eliminar a todos los empleados que están en un departamento cuyo nombre contiene una 'O'.

DELETE FROM EMPLE
  WHERE DEPT_NO IN (SELECT DEPT_NO
  FROM DEPART
  WHERE UPPER(DNOMBRE) LIKE '%O%';
  
  

/* 5.	Incrementa el salario del empleado de apellido REY. Su nuevo salario será el que tenía antes más 
   un importe que corresponde con la comisión que tiene ARROYO.*/
   
   
UPDATE EMPLE SET SALARIO =
     + (SELECT SALARIO
        FROM EMPLE
        WHERE UPPER(APPELIDO)='ARROYO');
        
        
        
        UPDATE * FROM EMPLE;

        UPDATE EMPLRE SET SALARIO=
        SLARIO+(SELECT NVL(COMISION, 0)
        FROM EMPLE
        WHERE UPPER(APELLIDO)='ARROYO')
        
--COMPROBAR
        SELECT* FROM EMPLE;
        

-- EJER 3.	Deshaz toda la transacción.
ROLLBACK TO start_transaction;



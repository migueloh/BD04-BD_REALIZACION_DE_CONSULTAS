REM ******** TABLA DEPART: *********** 

DROP TABLE DEPART CASCADE CONSTRAINTS; 

CREATE TABLE DEPART (
 	DEPT_NO  NUMBER(2),
	DNOMBRE  VARCHAR2(14), 
 	LOC      VARCHAR2(14),
	CONSTRAINT DEP_PK PRIMARY KEY (DEPT_NO)
	);

INSERT INTO DEPART VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO DEPART VALUES (20,'INVESTIGACION','MADRID');
INSERT INTO DEPART VALUES (30,'VENTAS','BARCELONA');
INSERT INTO DEPART VALUES (40,'PRODUCCION','BILBAO');

COMMIT;

REM /*  ******** TABLA EMPLE: ************* */

DROP TABLE EMPLE CASCADE CONSTRAINTS; 

CREATE TABLE EMPLE (
 	EMP_NO    NUMBER(4),
 	APELLIDO  VARCHAR2(10),
 	OFICIO    VARCHAR2(15),
 	ID_JEFE  NUMBER(4) ,
 	FECHA_ALTA DATE,
 	SALARIO   NUMBER(9) NOT NULL,
 	COMISION_PCT  NUMBER(3),
 	DEPT_NO   NUMBER(2) NOT NULL,
	CONSTRAINT EMPLE_PK PRIMARY KEY (EMP_NO),
	CONSTRAINT EMPLE_DIR_FK FOREIGN KEY (ID_JEFE)
				REFERENCES EMPLE(EMP_NO)  ON DELETE SET NULL,
	CONSTRAINT EMPLE_DEP_FK FOREIGN KEY (DEPT_NO)
				REFERENCES DEPART(DEPT_NO) ON DELETE CASCADE);

INSERT INTO EMPLE VALUES (7839,'REY','PRESIDENTE',NULL,TO_DATE('17/11/1981','DD/MM/YYYY'),6500,NULL,10);
INSERT INTO EMPLE VALUES (7566,'JIMENEZ','GERENTE',7839,TO_DATE('12/04/1981','DD/MM/YYYY'),3867,NULL,20);
INSERT INTO EMPLE VALUES (7698,'NEGRO','GERENTE',7839,TO_DATE('11/05/1981','DD/MM/YYYY'),3705,NULL,30);
INSERT INTO EMPLE VALUES (7782,'CEREZO','GERENTE',7839,TO_DATE('19/06/1981','DD/MM/YYYY'),3185,NULL,10);
INSERT INTO EMPLE VALUES (7788,'GIL','ANALISTA',7566,TO_DATE('19/11/1981','DD/MM/YYYY'),3900,NULL,20);
INSERT INTO EMPLE VALUES (7902,'FERNANDEZ','ANALISTA',7566,TO_DATE('13/12/1981','DD/MM/YYYY'),3900,NULL,20);
INSERT INTO EMPLE VALUES (7499,'ARROYO','COMERCIAL',7698,TO_DATE('20/02/1980','DD/MM/YYYY'),2080,10,30);
INSERT INTO EMPLE VALUES (7521,'SALA','COMERCIAL',7698,TO_DATE('22/02/1981','DD/MM/YYYY'),1625,5,30);
INSERT INTO EMPLE VALUES (7654,'MARTIN','COMERCIAL',7698,TO_DATE('29/09/1981','DD/MM/YYYY'),1625,5,30);
INSERT INTO EMPLE VALUES (7844,'TOVAR','COMERCIAL',7698,TO_DATE('18/09/1981','DD/MM/YYYY'),1950,8,30);
INSERT INTO EMPLE VALUES (7900,'JIMENO','PROGRAMADOR',7566,TO_DATE('13/12/1981','DD/MM/YYYY'),1235,NULL,30);
INSERT INTO EMPLE VALUES (7369,'SANCHEZ','PROGRAMADOR',7566,TO_DATE('17/12/1980','DD/MM/YYYY'),1040,NULL,20);
INSERT INTO EMPLE VALUES (7876,'ALONSO','PROGRAMADOR',7788,TO_DATE('23/09/1981','DD/MM/YYYY'),1430,NULL,20);
INSERT INTO EMPLE VALUES (7934,'SANCHEZ','AUXILIAR',7782,TO_DATE('23/01/1982','DD/MM/YYYY'),1690,NULL,10);

COMMIT;

-- ESPECIALISTA A:  RAFA

-- CONFIRMAR TABLAS
DESC DEPART;
DESC EMPLE;

-- CONFIRMAR DATOS
SELECT * FROM DEPART;
SELECT * FROM EMPLE;

-- OBTENER DATOS DE EMPLE
SELECT APELLIDO,SALARIO,DEPT_NO 
  FROM EMPLE 
  WHERE SALARIO>200000 AND DEPT_NO IN(10,20);

-- OBTENER APELLIDO Y SALARIO EMPLE 1500 y 2000 salario
SELECT APELLIDO,SALARIO 
  FROM EMPLE 
  WHERE SALARIO BETWEEN 1500 AND 2000;

-- OBTENER APELLIDO Y SALARIO NO EMPLE 1500 y 2000 salario
SELECT APELLIDO,SALARIO 
  FROM EMPLE 
  WHERE SALARIO NOT BETWEEN 150000 AND 200000;

-- SLEECCIONAR APELLIDO DE EMPLEADOS CON OFICIO VENDEDOR ANALISTA EMPLEADO
SELECT APELLIDO 
  FROM EMPLE
  WHERE UPPER(OFICIO) IN ('VENDEDOR', 'ANALISTA', 'EMPLEADO');

-- EMPLE, obtener el apellido cuyo departamento sea 10 o 30.
SELECT * 
  FROM EMPLE 
  WHERE DEPT_NO IN(10,20);

-- 13. Mostrar el apellido y el oficio de los empleados que no tienen director.
SELECT APELLIDO, OFICIO 
  FROM EMPLE 
  WHERE ID_JEFE IS NULL;


COMMIT;

--------------------------------------------------------------------------------


-- ESPECIALISTA B:  MIGUEL OLMO HERNANDO


-- 1.  A partir de la tabla EMPLE, obtener aquellos empleados cuyo apellido empiece por una ‘J’. 

SELECT *
  FROM EMPLE
  WHERE APELLIDO LIKE 'J%';
  
-- NOTA: USO DE METACARACTERES 0 1 SOLO CARACTER & ES DE 0 A N

-- 2. A partir de la tabla EMPLE, obtener el apellido y el salario de los empleados cuyo salario NO esté comprendido entre 150000 y 200000.

SELECT APELLIDO, SALARIO
  FROM EMPLE
  WHERE SALARIO NOT BETWEEN 150000 AND 200000;
  
-- 3. Consultar los empleados cuyo departamento no sea ni 10 ni 30. 

SELECT APELLIDO
  FROM EMPLE
  WHERE DEPT_NO NOT IN (10,30);
  
  
-- 14. Consultar los oficios de la empresa pero sin que aparezcan repeticiones.

SELECT DISTINCT OFICIO
  FROM EMPLE;

-- para que no vuelva a mostrar de nuevo el oficio, que no se repitan

--------------------------------------------------------------------------------

-- ESPECIALISTA C - JON MANEIRO


-- 1.  Obtener aquellos empleados cuyo apellido tengan una ‘R’ en la segunda posición. 

SELECT * 
  FROM EMPLE
  WHERE APELLIDO LIKE '_R%';

-- 2. Consultar los apellidos de la tabla EMPLE cuyo oficio sea ‘VENDEDOR’, ‘ANALISTA’ o ’EMPLEADO’.

SELECT APELLIDO 
  FROM EMPLE
  WHERE OFICIO IN ('VENDEDOR','ANALISTA','EMPLEADO');
                
                
-- 3. Consultar los apellidos de los empleados cuya comisión es nula.

SELECT APELLIDO 
  FROM EMPLE
  WHERE COMISION_PCT IS NULL;
                
/*
15. Seleccionar de la tabla EMPLE a todos los empleados del departamento 20. 

Además, la consulta debe aparecer ordenada por APELLIDO. 
En el caso de que dos empleados tengan el mismo apellido, ordenarlos de mayor a menor salario. 
Los campos que hay que consultar son: número de empleado, apellido, oficio y número de departamento. 
*/


DESC EMPLE

SELECT EMP_NO , APELLIDO , OFICIO , DEPT_NO 
  FROM EMPLE 
  WHERE DEPT_NO=20 
  ORDER BY APELLIDO, SALARIO DESC;
              
            
--------------------------------------------------------------------------------


-- ESPECIALISTA D - SEBAS

-- 1.  Obtener aquellos empleados cuyo apellido empiece por ‘A’ y tengan una ‘O’ en su interior. 

SELECT * from emple where (apellido like 'A%') and (apellido like '%O%');

-- 2. Consultar los apellidos de la tabla EMPLE cuyo oficio no sea ni ‘VENDEDOR’, ni ‘ANALISTA’ ni ’EMPLEADO’.

select * from emple where not oficio NOT IN ('VENDEDOR', 'ANALISTA', 'EMPLEADO');

-- 3. Consultar los apellidos de los empleados cuya comisión no es nula.(D)

select apellido 
  from emple 
  where not(comision_pct is null);
  --where comision_pct is NOT null);

-- 16. Consulta de los empleados cuyo oficio sea ‘ANALISTA’ ordenado por número de empleado.

SELECT * 
  FROM emple 
  WHERE UPPER(oficio)= 'ANALISTA' 
  ORDER BY EMP_NO;

-- PORQUE DENTRO DE LA BASE DE DATOS NO SABEMOS COMO ESTAN ESCRITOS LOS OFICIOS, POR ESO EL UPPER
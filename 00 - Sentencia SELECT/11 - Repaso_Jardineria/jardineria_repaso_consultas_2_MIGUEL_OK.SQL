
/*
JARDINERIA REPASO CONSULTAS 2

POR MIGUEL OLMO HERNANDO
*/

/*
1. Sacar un listado con el nombre de cada cliente y el nombre y dos apellidos de su representante de ventas bajo 
una cabecera única denominada Representante (el nombre irá separado por coma de los apellidos)
*/

DESC CLIENTES
DESC EMPLEADOS

SELECT * FROM EMPLEADOS;

SELECT CLIENTES.NOMBRECLIENTE "CLIENTE", EMPLEADOS.NOMBRE || ', ' || EMPLEADOS.APELLIDO1 || ' ' || EMPLEADOS.APELLIDO2 AS REPRESENTANTE
  FROM CLIENTES, EMPLEADOS
  WHERE EMPLEADOS.CODIGOEMPLEADO = CLIENTES.CODIGOEMPLEADOREPVENTAS
  ORDER BY EMPLEADOS.CODIGOEMPLEADO
    ;
 
/*
2. La compañía desea saber, en una sólo consulta, cuál fue el cliente que 
hizo el pago con mayor cuantía, así como el que hizo el pago con menor cuantía.
*/

DESC CLIENTES
DESC PAGOS

SELECT CLIENTES.NOMBRECLIENTE, PAGOS.CANTIDAD
    FROM PAGOS, CLIENTES
    WHERE PAGOS.CODIGOCLIENTE = CLIENTES.CODIGOCLIENTE
        AND ( CANTIDAD = (SELECT MAX(CANTIDAD)
                        FROM PAGOS)
                        OR PAGOS.CANTIDAD =
                            (SELECT MIN (CANTIDAD)
                                FROM PAGOS))
;

/*
3.  Sacar el código del cliente, el nombre del cliente, el estado y cuántos pedidos 
tiene cada cliente en cada estado. Ordena la salida por código  cliente y estado.
*/

DESC PEDIDOS

SELECT PEDIDOS.CODIGOCLIENTE, CLIENTES.NOMBRECLIENTE, INITCAP(PEDIDOS.ESTADO) ESTADO, COUNT(PEDIDOS.CODIGOPEDIDO) "PEDIDOS"
  FROM PEDIDOS, CLIENTES
  WHERE PEDIDOS.CODIGOCLIENTE = CLIENTES.CODIGOCLIENTE
  GROUP BY PEDIDOS.CODIGOCLIENTE, INITCAP(PEDIDOS.ESTADO) ,CLIENTES.NOMBRECLIENTE
  ORDER BY PEDIDOS.CODIGOCLIENTE, INITCAP(PEDIDOS.ESTADO)
  ;

/*
4. Obtener el código de empleado y el número de clientes al que atiende cada representante de ventas. 
Si algún empleado no tiene clientes lo queremos saber. La consulta saldrá ordenada por código de empleado.
*/

DESC EMPLEADOS


SELECT E.CODIGOEMPLEADO, COUNT(C.CODIGOEMPLEADOREPVENTAS) "CLIENTES ATENDIDOS"
	FROM EMPLEADOS E, CLIENTES C
	WHERE E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS (+)
	GROUP BY E.CODIGOEMPLEADO, E.CODIGOEMPLEADO 
	ORDER BY E.CODIGOEMPLEADO;
  

--5.  Mostrar el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT CLIENTES.NOMBRECLIENTE "NOMBRE CLIENTE", EMPLEADOS.NOMBRE "NOMBRE REPRESENTANTE"
	FROM CLIENTES, EMPLEADOS
	WHERE CLIENTES.CODIGOEMPLEADOREPVENTAS = EMPLEADOS.CODIGOEMPLEADO 
	AND CLIENTES.CODIGOCLIENTE NOT IN (SELECT PAGOS.CODIGOCLIENTE
										FROM PAGOS);

/*
6. Listar las ventas totales de los productos que hayan facturado mas de 3000 €. 
Se mostrara el nombre, unidades vendidas, total facturado y total facturado con impuestos(21% de IVA).
*/

SELECT P.NOMBRE, D.CANTIDAD, D.PRECIOUNIDAD * D.CANTIDAD "FACTURADO", (D.PRECIOUNIDAD * D.CANTIDAD) + ((D.PRECIOUNIDAD * D.CANTIDAD) * 0.21) "FACTURADO + IVA"
	FROM DETALLEPEDIDOS D, PRODUCTOS P
	WHERE P.CODIGOPRODUCTO = D.CODIGOPRODUCTO
AND (D.CANTIDAD * D.PRECIOUNIDAD)>= 3000
GROUP BY P.NOMBRE;


SELECT UPPER(P.NOMBRE), SUM(D.CANTIDAD), SUM(D.CANTIDAD*PRECIOUNIDAD)"TOTAL SIN IVA",
  SUM (D.CANTIDAD * PRECIOUNIDAD+0.21*(D.CANTIDAD*PRECIOUNIDAD)) " TOTAL CON IVA"
  FROM PRODUCTOS P, DETALLEPEDIDOS D
  WHERE P.CODIGOPRODUCTO =  D.CODIGOPRODUCTO
  GROUP BY UPPER(P.NOMBRE)
  HAVING SUM(D.CANTIDAD * D.PRECIOUNIDAD)>= 3000;

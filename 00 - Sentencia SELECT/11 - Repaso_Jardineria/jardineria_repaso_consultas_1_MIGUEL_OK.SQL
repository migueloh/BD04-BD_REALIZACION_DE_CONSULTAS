/*
1 Sacar la ciudad y el tel�fono de las oficinas de Estados Unidos. 
Obt�n la salida ordenada alfab�ticamente.
*/
SELECT Ciudad , Telefono
  FROM Oficinas
  WHERE UPPER(Pais) = 'EEUU'
  ORDER BY CIUDAD;

/*
2 Obtener una lista con el c�digo de oficina, ciudad, regi�n y pa�s de aquellas 
oficinas que est�n en pa�ses que cuyo nombre empiece por �E�.
*/
SELECT CODIGOOFICINA , CIUDAD, REGION,PAIS
  FROM OFICINAS
  WHERE PAIS LIKE ('E%')
  ORDER BY CIUDAD ASC;

/*
3� Obtener los distintos estados por los que puede pasar un pedido.
*/
SELECT DISTINCT UPPER(ESTADO)
  FROM PEDIDOS;
  
/*
4� Sacar cuantos empleados hay en la empresa.
*/
SELECT COUNT(CODIGOEMPLEADO)
  FROM EMPLEADOS;

/*
5� Sacar cuantos clientes tiene cada pa�s.
*/
SELECT UPPER(PAIS) ,COUNT(CODIGOCLIENTE)
  FROM CLIENTES
  GROUP BY UPPER(PAIS);

/*
6� Sacar cual fue el pago medio en 2007.
*/
SELECT AVG(CANTIDAD)
  FROM PAGOS
  WHERE EXTRACT(YEAR FROM FECHAPAGO)=2007;

/*
7� Sacar para cada cliente cuantos pedidos est�n en cada estado. 
Obt�n la consulta ordenada por cliente y en descendente por la cantidad de pedidos.
*/
SELECT CODIGOCLIENTE,UPPER(ESTADO),COUNT(CODIGOPEDIDO)
  FROM PEDIDOS
  GROUP BY CODIGOCLIENTE, UPPER(ESTADO)
  ORDER BY COUNT(CODIGOCLIENTE)DESC;

/*
8� Sacar el precio de venta y de compra del producto mas caro y del mas barato.
*/
SELECT MAX(PRECIOVENTA),MIN(PRECIOVENTA),
       MAX(PRECIOPROVEEDOR),MIN(PRECIOPROVEEDOR)
  FROM PRODUCTOS;
  
/*
9� Obtener el nombre del cliente con mayor limite de cr�dito.
*/
SELECT NOMBRECLIENTE
  FROM CLIENTES
  WHERE LIMITECREDITO = (SELECT MAX(LIMITECREDITO)
                            FROM CLIENTES);

/*
10� Obtener el nombre, los dos apellidos concatenados bajo la cabecera apellidos 
y el puesto de los empleados que no representan a ning�n cliente.
*/
SELECT NOMBRE , APELLIDO1 || ' ' || APELLIDO2 AS APELLIDOS, PUESTO
  FROM EMPLEADOS
  WHERE CODIGOEMPLEADO NOT IN(SELECT DISTINCT CODIGOEMPLEADOREPVENTAS
                                FROM CLIENTES);
                        
/*
11� Listar  el nombre y la ciudad de aquellos clientes que residan en ciudades 
donde no hay oficinas. El resultado saldr� ordenado por la ciudad donde residen.
*/
SELECT NOMBRECLIENTE,CIUDAD
  FROM CLIENTES
  WHERE CIUDAD NOT IN (
          SELECT OFICINAS.CIUDAD
          FROM OFICINAS)
  ORDER BY CIUDAD;

/*
12� Obtener un listado con los nombres de los clientes que han pedido m�s de 200 unidades 
de cualquier producto. El listado tendr� la cabecera �Nombre de los Clientes� y los 
nombres saldr� en formato T�tulo, es decir la primera letra de cada palabra en may�sculas.
*/
SELECT INITCAP(NOMBRECLIENTE)
  FROM CLIENTES
  WHERE CODIGOCLIENTE IN(
        SELECT CODIGOCLIENTE
           FROM PEDIDOS
           WHERE CODIGOPEDIDO IN (
              SELECT DISTINCT CODIGOPEDIDO
                  FROM DETALLEPEDIDOS
                   WHERE CANTIDAD > 200));

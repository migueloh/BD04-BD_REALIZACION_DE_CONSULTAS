/*
1 Sacar la ciudad y el teléfono de las oficinas de Estados Unidos. 
Obtén la salida ordenada alfabéticamente.
*/
SELECT Ciudad , Telefono
  FROM Oficinas
  WHERE UPPER(Pais) = 'EEUU'
  ORDER BY CIUDAD;

/*
2 Obtener una lista con el código de oficina, ciudad, región y país de aquellas 
oficinas que estén en países que cuyo nombre empiece por “E”.
*/
SELECT CODIGOOFICINA , CIUDAD, REGION,PAIS
  FROM OFICINAS
  WHERE PAIS LIKE ('E%')
  ORDER BY CIUDAD ASC;

/*
3º Obtener los distintos estados por los que puede pasar un pedido.
*/
SELECT DISTINCT UPPER(ESTADO)
  FROM PEDIDOS;
  
/*
4º Sacar cuantos empleados hay en la empresa.
*/
SELECT COUNT(CODIGOEMPLEADO)
  FROM EMPLEADOS;

/*
5º Sacar cuantos clientes tiene cada país.
*/
SELECT UPPER(PAIS) ,COUNT(CODIGOCLIENTE)
  FROM CLIENTES
  GROUP BY UPPER(PAIS);

/*
6º Sacar cual fue el pago medio en 2007.
*/
SELECT AVG(CANTIDAD)
  FROM PAGOS
  WHERE EXTRACT(YEAR FROM FECHAPAGO)=2007;

/*
7º Sacar para cada cliente cuantos pedidos están en cada estado. 
Obtén la consulta ordenada por cliente y en descendente por la cantidad de pedidos.
*/
SELECT CODIGOCLIENTE,UPPER(ESTADO),COUNT(CODIGOPEDIDO)
  FROM PEDIDOS
  GROUP BY CODIGOCLIENTE, UPPER(ESTADO)
  ORDER BY COUNT(CODIGOCLIENTE)DESC;

/*
8º Sacar el precio de venta y de compra del producto mas caro y del mas barato.
*/
SELECT MAX(PRECIOVENTA),MIN(PRECIOVENTA),
       MAX(PRECIOPROVEEDOR),MIN(PRECIOPROVEEDOR)
  FROM PRODUCTOS;
  
/*
9º Obtener el nombre del cliente con mayor limite de crédito.
*/
SELECT NOMBRECLIENTE
  FROM CLIENTES
  WHERE LIMITECREDITO = (SELECT MAX(LIMITECREDITO)
                            FROM CLIENTES);

/*
10º Obtener el nombre, los dos apellidos concatenados bajo la cabecera apellidos 
y el puesto de los empleados que no representan a ningún cliente.
*/
SELECT NOMBRE , APELLIDO1 || ' ' || APELLIDO2 AS APELLIDOS, PUESTO
  FROM EMPLEADOS
  WHERE CODIGOEMPLEADO NOT IN(SELECT DISTINCT CODIGOEMPLEADOREPVENTAS
                                FROM CLIENTES);
                        
/*
11º Listar  el nombre y la ciudad de aquellos clientes que residan en ciudades 
donde no hay oficinas. El resultado saldrá ordenado por la ciudad donde residen.
*/
SELECT NOMBRECLIENTE,CIUDAD
  FROM CLIENTES
  WHERE CIUDAD NOT IN (
          SELECT OFICINAS.CIUDAD
          FROM OFICINAS)
  ORDER BY CIUDAD;

/*
12º Obtener un listado con los nombres de los clientes que han pedido más de 200 unidades 
de cualquier producto. El listado tendrá la cabecera “Nombre de los Clientes” y los 
nombres saldrá en formato Título, es decir la primera letra de cada palabra en mayúsculas.
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

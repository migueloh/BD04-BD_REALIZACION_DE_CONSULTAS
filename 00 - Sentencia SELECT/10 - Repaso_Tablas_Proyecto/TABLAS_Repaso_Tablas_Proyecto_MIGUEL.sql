drop table Trabajos cascade constraints;
drop table Conductores cascade constraints;
drop table Maquinas cascade constraints;
drop table Proyectos cascade constraints;

create table Proyectos
(
Cod_p varchar(10) not null,
Descripcion varchar(40),
Localidad varchar(30),
Cliente varchar(30),
Telefono varchar(9) null,
constraint Proyecto_pk primary key(Cod_p)
);
insert into Proyectos(Cod_p, Descripcion, Localidad, Cliente, Telefono)
 values('P01','Garate','arganda','Felipe Sol','600111111');
insert into Proyectos(Cod_p, Descripcion, Localidad, Cliente, Telefono)
  values('P02','Solado','Rivas','Jose Perez','912222222');
insert into Proyectos(Cod_p, Descripcion, Localidad, Cliente, Telefono)
  values('P03','Jardin','Arganda','Rosa Lopez','669999666');
insert into Proyectos(Cod_p, Descripcion, Localidad, Cliente, Telefono)
  values('P04','Techado','Loeches','Jose Perez','913333333');
insert into Proyectos(Cod_p, Descripcion, Localidad, Cliente)
  values('P05','Buhardia','Rivas','Ana Brito');

COMMIT;


create table Maquinas
(
Cod_m varchar(10) not null,
Nombre varchar(40),
PrecioHora float(10),
constraint Maquinas_pk primary key(Cod_m)
);
insert into Maquinas(Cod_m, Nombre, PrecioHora)
  values('M01','Excabadora','35');
insert into Maquinas(Cod_m, Nombre, PrecioHora)
  values('M02','Hormigonera','43');
insert into Maquinas(Cod_m, Nombre, PrecioHora)
  values('M03','Volqueta','37');
insert into Maquinas(Cod_m, Nombre, PrecioHora)
  values('M04','Apisonadora','67');

COMMIT; 


create table Conductores
(
Cod_c varchar(10) not null,
Nombre varchar(40),
Localidad varchar(30),
Categoria number(3),
constraint Conductores_pk primary key(Cod_c)
);
insert into Conductores
  values('C01','Jose Sanchez','Arganda',18);
insert into Conductores
  values('C02','Manuel Diaz','Arganda',15);
insert into Conductores
  values('C03','Juan Perez','Rivas',20); 
insert into Conductores
  values('C04','Luis Ortiz','Arganda',18);
insert into Conductores
  values('C05','Javier Martin','Loeches',12);
insert into Conductores
  values('C06','Carmen Perez','Rivas',15);

COMMIT; 


create table Trabajos
(id_trabajos number(3) GENERATED ALWAYS AS IDENTITY 
                        MINVALUE 1 
                        MAXVALUE 999
                        INCREMENT BY 1 
                        START WITH 1  
                        NOORDER  
                        NOCYCLE  NOT NULL ENABLE
      CONSTRAINT trabajos_id_pk PRIMARY KEY,
Cod_c varchar(10) not null,
Cod_p varchar(10) not null,
Cod_m varchar(10) not null,
Fecha date,
Tiempo varchar(20) null,
constraint Trabajos_fk foreign key(Cod_p)references Proyectos (Cod_p),
constraint Trabajos_fk1 foreign key(Cod_m)references Maquinas (Cod_m),
constraint Trabajos_fk2 foreign key(Cod_c)references Conductores(Cod_c));

insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C02','M03','P01', TO_DATE('10/09/02','DD/MM/YY'),'100');
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C03','M01','P02', TO_DATE('10/09/02','DD/MM/YY'),'100'); 
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C05','M03','P02', TO_DATE('10/09/02','DD/MM/YY'),'150'); 
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C04','M03','P02', TO_DATE('10/09/02','DD/MM/YY'),'90'); 
insert into Trabajos(Cod_c, Cod_m, Cod_p,Fecha, Tiempo)
  values('C01','M02','P02', TO_DATE('12/09/02','DD/MM/YY'),'130');
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C02','M03','P03', TO_DATE('13/09/02','DD/MM/YY'),'30'); 
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C03','M01','P04', TO_DATE('15/09/02','DD/MM/YY'),'300'); 
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C02','M03','P02',TO_DATE('15/09/02','DD/MM/YY'),Null);
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C01','M03','P04',TO_DATE('15/09/02','DD/MM/YY'),'180');
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C05','M03','P04',TO_DATE('15/09/02','DD/MM/YY'),'90');  
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C01','M02','P04', TO_DATE('17/09/02','DD/MM/YY'),Null); 
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C02','M03','P01',TO_DATE('18/09/02','DD/MM/YY'),Null); 
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C05','M04','P04',TO_DATE('15/12/02','DD/MM/YY'),'90');  
insert into Trabajos(Cod_c, Cod_m, Cod_p, Fecha, Tiempo)
  values('C05','M04','P03',TO_DATE('15/12/02','DD/MM/YY'),'120');  
COMMIT; 
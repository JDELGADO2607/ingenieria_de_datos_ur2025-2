CREATE DATABASE tiendaMascotas;
USE tiendaMascotas;

create table vacuna (
	idVacuna int not null auto_increment,
    nombreEnf varchar(50) not null,
    nombreVacuna varchar(50) not null,
    dosisVacuna int not null,
    primary key(idVacuna)
);

CREATE TABLE cliente (
	cedulaCliente int not null auto_increment,
    telefonoCliente int unique,
    nombreCliente varchar(255) not null,
    apellidoCliente varchar(255),
    direccionCliente varchar(255) not null,
    primary key(cedulaCliente)
);

create table mascota (
	idMascota int not null auto_increment,
    cedulaCliente int not null,
    tipoMascota varchar(255) not null,
    nombreMascota varchar(255) not null,
    razaMascota varchar(255) not null,
    foreign key(cedulaCliente) references cliente(cedulaCliente),
    primary key(idMascota)
);

create table venta(
	idVenta int not null auto_increment,
    primary key(idVenta)
);

create table producto(
	codigoBarProd int not null,
    precioProd float not null,
    nombreProd varchar(50) not null,
    marcaProd varchar(25) not null,
    primary key(codigoBarProd)
);

create table detalleVentaCliente(
	idDetalleVC int auto_increment,
    cedulaCliente int not null,
    idVenta int not null,
    fechaVenta datetime not null,
    
    primary key(idDetalleVC),
    foreign key(cedulaCliente) references cliente(cedulaCliente),
    foreign key(idVenta) references venta(idVenta)
);

create table detalleVentaProducto(
	idVenta int not null,
    idProducto int not null,
    idDetalleVP int not null auto_increment,
    
    primary key(idDetalleVP),
    foreign key(idVenta) references venta(idVenta),
    foreign key(idProducto) references producto(codigoBarProd)
);

create table aplicacionVacuna(
	idAplicacion int not null auto_increment,
    idMascota int not null,
    idVacuna int not null,
    
    primary key(idAplicacion),
    foreign key(idMascota) references mascota(idMascota),
    foreign key(idVacuna) references vacuna(idVacuna)
);

alter table cliente add email varchar(100) unique;

alter table cliente change email emailCliente varchar(100) unique;

create table usuario(
	idUsuario int auto_increment primary key,
    tipoUsuario varchar(50)
);

#DML

#insert

use tiendaMascotas;
describe mascota;
insert into usuario values ("", "Cliente"),("", "Cliente"),("", "Cliente"),("", "Cliente"),("", "Cliente"),("", "Administrador");

alter table cliente add idUsuarioFK int, add constraint foreign key(idUsuarioFK) references usuario(idUSuario);
describe cliente;
alter table cliente modify  cedulaCliente int not null;
alter table cliente modify telefonoCliente bigint unique;
insert into cliente values  (1127941351, 3138488188, "Juan", "Delgado", "KR 71D #64I - 14","blabla", 1), (1127941352, 3138488180, "Joan", "Delgado", "KR 72 #64 - 14","vlavla", 2), (1127941353, 3138488181, "Juan", "Deloda", "KR 73 #67 - 16","blablea", 3), (1127941354, 3138488182, "Jan", "Salgado", "KR 77 #64 - 12","blable", 4), (1127941355, 3138488189, "Juan", "Delgado", "KR 71D #64I - 14","bleebla", 11);

alter table mascota change column cedulaCliente cedulaClienteFK int not null;

insert into mascota values ("", 1127941351, "Perro", "Pedro", "Bulldog"), ("", 1127941352, "Perro", "Mauricio", "Husky"), ("", 1127941351, "Perro", "Daniel", "Bulldog"), ("", 1127941351, "Gato", "Pedro", "Negro");
insert into mascota values ("", 1127941353, "Gato", "Alejandro","Cálico");
describe vacuna;
insert into vacuna values ("", "Moquillo", "Antimoquillo", 17), ("", "Diarrea", "Antidiarrea", 17), ("", "Vomito", "AntiVomito", 17), ("", "Tos", "Antitos", 17), ("", "Gripe", "Antigripe", 17);
describe aplicacionVacuna;
insert into aplicacionVacuna values ("", 1,1), ("",2,2), ("",3,3), ("",4,4), ("",5,5);

show tables;
describe producto;

insert into producto values (111, 20.5, "Comida Perro", "Animal"), (112, 20.5, "Comida Gato", "Animal"), (113, 20.5, "Comida Perro", "Purina"), (114, 20.5, "Comida Gato", "Purina"), (115, 20.5, "Dulcecito", "Animal");

describe detalleVentaProducto;

insert into venta values (""), (""), (""), (""), ("");

alter table detalleVentaProducto
drop foreign key detalleventaproducto_ibfk_2, 
drop column idProducto, 
	add column codigoBarProdFK int not null, 
	add constraint codigoBarProdFK
		foreign key (codigoBarProdFK) references producto(codigoBarProd);
        
insert into detalleVentaProducto values (1, "", 111), (2, "", 112), (3, "", 113), (4, "", 114), (5, "", 115);

describe detalleVentaCliente;

alter table detalleVentaCliente algorithm = inplace, lock = none, change column idVenta idVentaFK int not null, change column cedulaCliente cedulaClienteFK int not null;
alter table detalleVentaCliente modify column cedulaClienteFK bigint not null; 

insert into detalleVentaCliente values ("", 1127941351, 1, ""), ("", 1127941352, 2, ""), ("", 1127941353, 3, ""), ("", 1127941354, 4, ""), ("", 1127941355, 5, "");

select * from detalleVentaCliente;

# Consultas y condicionales

select idVacuna as "Código Vacuna", nombreEnf as "Nombre de la Enfermedad Asociada", dosisVacuna as "Dosis de la Vacuna" from vacuna;

select * from cliente where apellidoCliente like "Del%";
select * from cliente where apellidoCliente like "%oda";
select * from cliente where emailCliente like "%able%";
select * from cliente where nombreCliente like "J%" and nombreCliente like "%n";
select * from cliente where idUsuarioFK in (1,2,11);
select * from cliente where apellidoCliente like "Sal%" and emailCliente like "%bla";
select * from mascota where cedulaClienteFK in (1,2,5,11) and not nombreMascota = "Perro";
select * from mascota order by cedulaClienteFK desc;
select * from mascota group by razaMascota;
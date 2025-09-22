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

insert into cliente values ("", 1127941351, 3138488188, "Juan", "Delgado", "KR 71D #64I - 14","blabla", 1), ("", 1127941352, 3138488180, "Joan", "Delgado", "KR 72 #64 - 14","vlavla", 2), ("", 1127941353, 3138488181, "Juan", "Deloda", "KR 73 #67 - 16","blable", 3), ("", 1127941354, 3138488182, "Jan", "Salgado", "KR 77 #64 - 12","blable", 4), ("", 1127941355, 3138488189, "Juan", "Delgado", "KR 71D #64I - 14","bleebla", 11)

/*
DELIMITER $$
CREATE TRIGGER nuevoEmpleado
after insert
on Empleado
for each row 
begin
	insert into Auditoria(tabla_afectada,accion,descripcion,fecha)
    values('Empleado','INSERT',concat('Se registro empleado:',new.nombreEmpleado,'*Cargo:', new.cargo),
    now());
end $$
DELIMITER ;
describe empleado;
select * from auditoria;
select current_date();
select curdate();
insert into Empleado values('','Tatiana Cabrera','Desarrolladora',3000000.00,curdate(),'','');

drop table if exists Empleado;
drop table if exists Auditoria;

show triggers;
 describe empleado;
DELIMITER $$
CREATE TRIGGER trgValidarSalario
before insert
on Empleado
for each row 
begin
	if new.salario<1500000 then
		signal sqlstate '45000'
        set message_text='error el salario no puede ser menor al salario mínimo';
	end if;
end $$
DELIMITER ;
Insert into Empleado values('','Maria Cabrera','Cajera',1200000.00,curdate(),'','');
select * from auditoria;

DELIMITER $$
CREATE TRIGGER nuevoEmpleado
after insert
on Empleado
for each row 
begin
	insert into Auditoria(tabla_afectada,accion,descripcion,fecha)
    values('Empleado','INSERT',concat('Se registro empleado:',new.nombreEmpleado,'*Cargo:', new.cargo),
    now());
end $$
DELIMITER ;
describe empleado;
select * from auditoria;
select current_date();
select curdate();
insert into Empleado values('','Tatiana Cabrera','Desarrolladora',3000000.00,curdate(),'','');

drop table if exists Empleado;
drop table if exists Auditoria;

show triggers;
 describe empleado;
DELIMITER $$
CREATE TRIGGER trgValidarSalario
before insert
on Empleado
for each row 
begin
	if new.salario<1500000 then
		signal sqlstate '45000'
        set message_text='error el salario no puede ser menor al salario mínimo';
	end if;
end $$
DELIMITER ;
Insert into Empleado values('','Maria Cabrera','Cajera',1200000.00,curdate(),'','');
select * from auditoria;
DELIMITER $$
CREATE TRIGGER trgCambioSalario
after update
on Empleado
for each row 
begin
	if old.salario<>new.salario then
		insert into Auditoria(tabla_afectada,accion,descripcion,fecha)
		values('Empleado','UPDATE',concat('CAMBIO DE SALARIO DE :',old.salario,'a', new.salario,' para el empleado:',new.nombreEmpleado),
		now());
	end if;
end $$
DELIMITER ;
*/

/*Punto 1*/
use tiendaMascotas;
alter table vacuna add column fechaVigencia date;
update vacuna set fechaVigencia = "2024-01-01" where idVacuna = 1;
update vacuna set fechaVigencia = "2026-10-02" where idVacuna = 2;
update vacuna set fechaVigencia = "2023-12-03" where idVacuna = 3;
update vacuna set fechaVigencia = "2030-02-15" where idVacuna = 4;
update vacuna set fechaVigencia = "2040-04-12" where idVacuna = 5;
describe mascota;

/*Punto 2*/
DELIMITER $$
create function consultaCliente(nombreDeMascota varchar(50))
returns varchar(255)
deterministic
begin
declare resultado varchar(255);
select group_concat(concat("La mascota ", m.nombreMascota, " de raza ", m.razaMascota, " tiene como dueño a ", c.nombreCliente) separator ' ;') into resultado from mascota m inner join cliente c on m.cedulaClienteFK = c.cedulaCliente where m.nombreMascota = nombreDeMascota; 
return resultado;
end $$
DELIMITER ;

/*
create table clientesEliminados(
	fechaEliminacion date,
    nombreClienteEliminado varchar(50)
);

drop function if exists consultaCliente;
*/
alter table cliente add column fechaActualizacion datetime;
select * from mascota;
select consultaCliente("Pedro");

create table clienteEliminado(
	nombreCliente varchar(50),
    timestampEliminacion timestamp
);

/*Punto 3 y 4*/
DELIMITER $$

create trigger EliminacionCliente
before delete
on cliente
for each row
begin
declare cantidad_mascotas int;
select count(*) into cantidad_mascotas from mascota where cedulaClienteFK = old.cedulaCliente;
if cantidad_mascotas = 0 then 
insert into clienteEliminado values (old.nombreCliente, current_timestamp());
else
	signal sqlstate '45000'
    set message_text = "Este cliente tiene una mascota registrada";
end if;
end $$
DELIMITER ;
insert into cliente values (329148, 11111311, "Pepito", "Papita", "XXXX", "aZZZZ", 3,"");

select * from cliente;
delete from cliente where cedulaCliente = '32910848';

select * from clienteEliminado;

/*Punto 5*/

DELIMITER $$
create trigger Actualizacion
before update
on cliente
for each row
begin
set new.fechaActualizacion = current_timestamp();
end $$
DELIMITER ;

update cliente set nombreCliente = 'Pepito' where cedulaCliente = 1127941351;

select * from cliente;

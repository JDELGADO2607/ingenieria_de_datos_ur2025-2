create database empleados;
use empleados;

create table departamento (
	idDepartamento int auto_increment primary key,
    nombreDepartamento varchar(25) 
);

insert into departamento values ("", "IT"), ("","Ventas");
insert into departamento values ("", "Servicio al Cliente");
alter table empleado drop depEmpleado;

create table empleado (
	idEmpleado int not null primary key,
	edadEmpleado int not null,
	salarioEmpleado int not null,
	idDepartamentoFK int not null,
	fechaContratacion date not null,
    
    foreign key (idDepartamentoFK) references departamento(idDepartamento)
);
alter table empleado add nombreEmpleado varchar(50);

alter table empleado modify idEmpleado int auto_increment;
describe empleado;
insert into empleado values ("", 19, 5000, 2, 2019-07-30, "Andrés");
insert into empleado values ("", 32, 4500, 2, "2019-07-30", "Daniel");
insert into empleado values ("", 44, 7000, 1, "2017-06-19", "Rogelio Mamanares"), ("", 37, 2000, 1, "2025-06-19", "Radi"), ("", 22, 1000, 3, "2023-06-18", "Schick");
alter table empleado drop column edadEmpleado;
alter table empleado add column fechaNacimientoEmpleado date;
update empleado set fechaContratacion = "2019-07-30" where idEmpleado = 1;
update empleado set fechaNacimientoEmpleado = "2006-09-29" where idEmpleado = 1;
update empleado set fechaNacimientoEmpleado = "1993-09-29" where idEmpleado = 2;
update empleado set fechaNacimientoEmpleado = "1981-09-29" where idEmpleado = 3;
update empleado set fechaNacimientoEmpleado = "1988-09-29" where idEmpleado = 4;
update empleado set fechaNacimientoEmpleado = "2003-09-29" where idEmpleado = 5;
select nombreEmpleado, edadEmpleado, salarioEmpleado from empleado;

select * from empleado where salarioEmpleado > 4000;
select * from empleado where depEmpleado in("Ventas");
select * from empleado where year(fechaNacimientoEmpleado) <= 1995 and year(fechaNacimientoEmpleado) >= 1985;
select * from empleado where year(fechaContratacion) > 2020;
select idDepartamentoFK as "Departamento Empleado", count(*) as "Conteo por departamento" from empleado group by idDepartamentoFK;
select avg(salarioEmpleado) as "Promedio de salarios" from empleado;
select * from empleado where nombreEmpleado like "A%" or nombreEmpleado like "C%";
select * from empleado where not idDepartamentoFK in(1);
select nombreEmpleado as "Nombre Empleado", salarioEmpleado as "Salario"  from empleado
	where salarioEmpleado =(select max(salarioEmpleado) from empleado);

alter table empleado add column idDepartamentoFK int not null;
alter table empleado add constraint fk_departamento_1 foreign key (idDepartamentoFK) references departamento(idDepartamento);
select nombreEmpleado as "Nombre", idDepartamentoFK as "ID Departamento" from empleado where idDepartamentoFK = (select idDepartamento from departamento where nombreDepartamento = "Ventas");
select * from departamento;

/* Joins */

select e.nombreEmpleado as "Nombre Empleado", d.nombreDepartamento as "Nombre departamento" from empleado e inner join departamento d on e.idDepartamentoFK = d.idDepartamento where d.nombreDepartamento = "Ventas";

/*Nombre empleados con salario mayor al promedio*/
select nombreEmpleado, salarioEmpleado from empleado where salarioEmpleado > (select avg(salarioEmpleado) from empleado);
/* Nombre empleado 2do salario mas alto */
select nombreEmpleado, salarioEmpleado from empleado
where salarioEmpleado = (
select max(salarioEmpleado) from empleado 
where salarioEmpleado <> (
	select max(salarioEmpleado) from empleado
	)	
);  
/* Departamentos sin empleados asignados */
select d.nombreDepartamento, e.nombreEmpleado from departamento d right join empleado e on d.idDepartamento = e.idDepartamentoFK where e.idDepartamentoFK is null; 
/* Total de empleados por departamento */

select count(*), idDepartamentoFK from empleado group by idDepartamentoFK;  
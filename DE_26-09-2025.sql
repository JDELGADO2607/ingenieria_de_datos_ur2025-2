create database empleados;
use empleados;

create table empleado (
	idEmpleado int not null primary key,
	edadEmpleado int not null,
	salarioEmpleado int not null,
	depEmpleado varchar(25) not null,
	fechaContratacion date not null
);
alter table empleado add nombreEmpleado varchar(50);

alter table empleado modify idEmpleado int auto_increment;
describe empleado;
insert into empleado values ("", 19, 5000, "Ventas", 2019-07-30, "Andrés");
insert into empleado values ("", 32, 4500, "Ventas", "2019-07-30", "Daniel");
insert into empleado values ("", 44, 7000, "IT", "2017-06-19", "Rogelio Mamanares"), ("", 37, 2000, "IT", "2025-06-19", "Radi"), ("", 22, 1000, "Servicio al Cliente", "2023-06-18", "Schick");

update empleado set fechaContratacion = "2019-07-30" where idEmpleado = 1;
select nombreEmpleado, edadEmpleado, salarioEmpleado from empleado;

select * from empleado where salarioEmpleado > 4000;
select * from empleado where depEmpleado in("Ventas");
select * from empleado where edadEmpleado between 30 and 40;
select * from empleado where year(fechaContratacion) > 2020;
select depEmpleado as "Departamento Empleado", count(*) as "Conteo por departamento" from empleado group by depEmpleado;
select avg(salarioEmpleado) as "Promedio de salarios" from empleado;
select * from empleado where nombreEmpleado like "A%" or nombreEmpleado like "C%";
select * from empleado where not depEmpleado in("IT");
select nombreEmpleado as "Nombre Empleado", max(salarioEmpleado) as "Salario"  from empleado;


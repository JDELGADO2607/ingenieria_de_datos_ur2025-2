/* Número: 9 */

create database BD_TechNova;
use BD_TechNova;

/* Creacion de tablas */
CREATE TABLE Departamento (
id_departamento INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);
CREATE TABLE Empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
id_departamentoFK INT,
fecha_ingreso DATE,
FOREIGN KEY (id_departamentoFK) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Proyecto (
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
fecha_inicio DATE,
presupuesto DECIMAL(12,2),
id_departamentoFK INT,
FOREIGN KEY (id_departamentoFK) REFERENCES Departamento(id_departamento)
);
CREATE TABLE Asignacion (
id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
id_empleadoFK INT,
id_proyectoFK INT,
horas_trabajadas INT CHECK (horas_trabajadas >= 0),
FOREIGN KEY (id_empleadoFK) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_proyectoFK) REFERENCES Proyecto(id_proyecto)
);

/* Problema de redacción del reto: Si el total de salarios de los empleados de un proyecto supera su presupuesto, reducir presupuesto
en 10%.
Corrección
Aumentar presupuesto 10%
*/

/* Inserción de datos de departamento */


describe departamento;

insert into departamento values
(null, "Bases de datos", 10000000.00),
(null, "Reportes", 500000.00),
(null, "Inteligencia Artificial", 10000000.00);
update departamento set presupuesto = 5000000 where id_departamento = 2;

select * from departamento;

/* Inserción de datos de empleado */

describe empleado;

insert into empleado values
(null, "Pepito", "MD de bases de datos", 3000000.00, 1, "2023-07-08"),
(null, "Juanito", "Desarrollador de bases de datos", 1500000.00, 1, "2024-06-08"),
(null, "Andrea", "Desarrolladora de inteligancia artificial", 1500000.00, 3, "2025-01-02"),
(null, "Nicole", "MD de inteligencia artificial", 4300000.00, 3, "2022-09-10"),
(null, "Andres", "Creador de reportes", 1400000.00, 2, "2021-01-02"),
(null, "Kendrick", "MD de reportes", 2500000.00, 2, "2021-02-02");
select * from empleado;


 /* Inserción de proyecto */

describe proyecto;

insert into proyecto values
(null, "Microchips", "2025-09-10", 5000000.00, 3),
(null, "Reporte del sector de inteligencia artificial", "2025-09-10", 4000000.00, 2),
(null, "Gestion de bases de datos", "2025-10-10", 5000000.00, 1);

/* Inserción de asignación */

describe asignacion;

insert into asignacion values 
(null, 3, 1, 70),
(null, 4, 1, 72),
(null, 1, 3, 70),
(null, 2, 3, 72),
(null, 5, 2, 20),
(null, 6, 2, 15);


/* Función para calcular el total de salarios en un proyecto */

DELIMITER $$
create function TotalSalariosProyecto(id_proyecto_busqueda int)
	returns decimal(13,2)
    deterministic
    
    begin
    declare sumaSalarios decimal(11,2);
    
    select sum(e.salario) into sumaSalarios from empleado e inner join asignacion a on e.id_empleado = a.id_empleadoFK where a.id_proyectoFK = id_proyecto_busqueda;
    
    return sumaSalarios;
    end $$
    
DELIMITER ;

select TotalSalariosProyecto(2);

/* Procedimiento para ajustar los salarios */

DELIMITER $$
create procedure AjustarPresupuestoProyecto(in id_proyecto_busqueda int)
begin
declare presupuestoCalculadoProyecto decimal(12,2);
declare presupuestoProyecto decimal(12,2);

	select TotalSalariosProyecto(id_proyecto_busqueda) into presupuestoCalculadoProyecto;
	select presupuesto into presupuestoProyecto from proyecto where id_proyecto = id_proyecto_busqueda;
    
	if presupuestoCalculadoProyecto > presupuestoProyecto then
	update proyecto set presupuesto = presupuesto * 1.10 where id_proyecto = id_proyecto_busqueda;
    select presupuesto into presupuestoProyecto from proyecto where id_proyecto = id_proyecto_busqueda;
    end if;
    select presupuesto as "Nuevo Presupuesto" from proyecto where id_proyecto = id_proyecto_busqueda limit 1;
    
	/* Intento de hacerlo mediante un while, error de sintaxis */
    
    /* while presupuestoCalculadoProyecto > presupuestoProyecto
    begin
	update proyecto set presupuesto = presupuesto * 1.10 where id_proyecto = id_proyecto_busqueda;
    select presupuesto into presupuestoProyecto from proyecto where id_proyecto = id_proyecto_busqueda;
    end; */
    
end $$
DELIMITER ;

/* Trigger de historial de cambios en proyectos */

create table historialProyectos(
	idRegistroCambio int auto_increment primary key,
    fechaCambio date,
    horaCambio time,
    idproyectoCambioFK int,
    foreign key (idProyectoCambioFK) references proyecto(id_proyecto)
);

DELIMITER $$
create trigger actualizacionPresupuestos
before update on proyecto
for each row
begin
declare presupuestoCalculado decimal(12,2);
select TotalSalariosProyecto(old.id_proyecto) into presupuestoCalculado;
if old.presupuesto < presupuestoCalculado then
	insert into historialProyectos values (null, current_date(), current_time(), old.id_proyecto);
else
	signal sqlstate "45000"
    set message_text = "La suma de los salarios no es mayor al presupuesto del proyecto";
end if;
end $$
DELIMITER ;

call AjustarPresupuestoProyecto(1);

select * from historialProyectos;



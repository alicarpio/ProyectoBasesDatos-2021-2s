-- Tabla sonido
create or replace procedure ingresar_sonido(
    descripcion varchar(255),
    son bytea
)
AS
$$
begin
    insert into sonido (descripcion, sonido)
    values (descripcion, son);
end;
$$
language plpgsql;

call ingresar_sonido('mascota','\x10D309');

create or replace procedure actualizar_sonido(
    id int,
    descripcion varchar(255)
)
AS
$$
begin
    update sonido as s
       set descripcion = descripcion
     where s.id_sonido = id;
end;
$$
language plpgsql;

call actualizar_sonido(13,'escuela');

create or replace procedure eliminar_sonido(
    id int
)
AS
$$
begin
    delete from sonido
     where id_sonido = id;
end;
$$
language plpgsql;

call eliminar_sonido(15);

-- Tabla cliente
CREATE OR REPLACE PROCEDURE insertar_cliente(
    nom_usuario VARCHAR(60),
    password    VARCHAR(255),
    nombre      VARCHAR(60),
    apellido    VARCHAR(60),
    correo      VARCHAR(100),
    telef       VARCHAR(60)
)
AS
$$
BEGIN
    INSERT INTO cliente (nombre_usuario, contrasena, nombre, apellido, correo, telefono)
    VALUES (nom_usuario, password, nombre, apellido, correo, telef);
END;
$$
LANGUAGE plpgsql;

call insertar_cliente('johncotrina','Po-09301','John','Cotrina','johncootrina12@','09509235092')

CREATE OR REPLACE PROCEDURE actualizar_cliente(
    nom_usuario VARCHAR(60),
    mail         VARCHAR(100)
)
AS
$$
BEGIN
    UPDATE cliente
       SET correo = mail
    WHERE nombre_usuario = nom_usuario;
exception when others then
    raise notice 'Ocurrio un error al intentar actualizar el cliente';
END;
$$
LANGUAGE plpgsql;

call actualizar_cliente('victorec','vctor15@hotmail.com');

CREATE OR REPLACE PROCEDURE eliminar_cliente(
    nom_usuario VARCHAR(60)
)
AS
$$
BEGIN
    DELETE FROM cliente
     WHERE nombre_usuario = nom_usuario;
exception when others then
    raise notice 'Ocurrio un error al intentar eliminar el cliente';
END;
$$
LANGUAGE plpgsql;

call eliminar_cliente('marounefellani');

-- Tabla administrador
create or replace procedure insertar_administrador(
    usuario varchar (50),
    contrasena varchar (50)
)
AS
$$
begin
    insert into administrador (nombre_usuario, constrasena)
    values (usuario, contrasena);
exception when others then
    raise notice 'Ocurrio un error al intentar insertar el administrador';
end;
$$
language plpgsql;

call eliminar_cliente('admin41','PO0-2321');

create or replace procedure actualizar_administrador(
    usuario varchar (50),
    contra varchar (50)
)
AS
$$
begin
    update administrador
       set constrasena = contra
     where nombre_usuario = usuario;
exception when others then
    raise notice 'Ocurrio un error al intentar actualizar el administrador';
end;
$$
language plpgsql;

-- TODO
call actualizar_administrador('admin32','340PL-23');

create or replace procedure eliminar_administrador(
    usuario varchar (50)
)
AS
$$
begin
    delete from administrador
     where nombre_usuario = usuario;
end;
$$
language plpgsql;

call eliminar_administrador('admin3');

-- Tabla recomendacion
create or replace procedure insert_recomendacion(
    id_adm varchar (50),
    nombre varchar (50),
    descripcion varchar (50),
    cat varchar (50)
)
AS
$$
begin
    insert into recomendacion (id_admin, nombre, descripcion, categoria)
    values (id_adm, nombre, descripcion, cat);
exception when others then
    raise notice 'Ocurrio un error al intentar insertar recomendacion';

end;
$$
language plpgsql;

call insert_recomendacion('41','recom41','realiza tu tarea','tarea fisica');

create or replace procedure actualizar_recomendacion(
    id int,
    cat varchar (50)
)
AS
$$
begin
    update recomendacion
       set categoria = cat
     where id_recomendacion = id;
end;
$$
language plpgsql;

call actualizar_recomendacion(3,'finanzas');


create or replace procedure eliminar_recomendacion(
    id int
)
AS
$$
begin
   delete from recomendacion
    where id_recomendacion = id;
end;
$$
language plpgsql;

call actualizar_recomendacion(15);

-- Tabla recomendacion_cliente
CREATE OR REPLACE PROCEDURE ingresar_recomendacion_cliente(
    id_client VARCHAR(60),
    id_recomen VARCHAR(255),
    fech DATE
)
AS
$$
BEGIN
    INSERT INTO recomendacion_cliente (id_cliente, id_recomendacion, fecha)
    VALUES (id_client,id_recomen,fech);
END;
$$
LANGUAGE plpgsql;

call ingresar_recomendacion_cliente('francisco',41,'10/8/2021');

CREATE OR REPLACE PROCEDURE actualizar_recomendacion_cliente(
    nom_usuario VARCHAR(60),
    id_reco INT,
    fech DATE
)
AS
$$
BEGIN
    UPDATE recomendacion_cliente
    SET fecha = fech
    WHERE id_cliente = nom_usuario AND id_recomendacion = id_reco;
END;
$$
LANGUAGE plpgsql;

call actualizar_recomendacion_cliente('ruthcv',3,'10/22/2021');

CREATE OR REPLACE PROCEDURE eliminar_recomendacion_cliente(
    nom_usuario VARCHAR(60),
    id_reco INT
)
AS
$$
BEGIN
    DELETE FROM recomendacion_cliente
    WHERE id_cliente = nom_usuario AND id_recomendacion = id_reco;
END;
$$
LANGUAGE plpgsql;



-- Tabla tarea
create or replace procedure ingresar_tarea(
    id_clie varchar (60),
    id_adm varchar (50),
    descripcion varchar (255),
    fecha_inicio date,
    fecha_fin date,
    categoria varchar (50)
)
AS
$$
begin
    insert into tarea (id_cliente, id_admin, descripcion, fecha_inicio, fecha_fin, categoria)
    values (id_clie, id_adm, descripcion, fecha_inicio, fecha_fin, categoria);
end;
$$
language plpgsql;



create or replace procedure actualizar_tarea(
    id int,
    descrip varchar (255)
)
AS
$$
begin
    update tarea
       set descripcion = descrip
     where id_tarea = id;
end;
$$
language plpgsql;

call actualizar_tarea(34, 'Bajar el jitomate');

create or replace procedure eliminar_tarea(
    id int
)
AS
$$
begin
    delete from tarea
     where id_tarea = id;
end;
$$
language plpgsql;

call eliminar_tarea(34);

-- Tabla recordatorios
create or replace procedure ingresar_recordatorio(
    id_recordatorio serial,
    id_tarea int,
    id_cliente varchar (60),
    id_sonido int,
    fecha_inicio date,
    hora_inicio time,
    fecha_fin date,
    hora_fin date
)
AS
$$
begin
    insert into recordatorios (id_recordatorio, id_tarea, id_cliente, id_sonido, fecha_inicio, hora_inicio, fecha_fin, hora_fin)
    values (id_recordatorio, id_tarea, id_cliente, id_sonido, fecha_inicio, hora_inicio, fecha_fin, hora_fin);
end;
$$
language plpgsql;

-- TODO
call ingresar_recordatorio();

create or replace procedure actualizar_recordatorio(
    id_rec int,
    fecha_inc date
)
AS
$$
begin
    update recordatorios
       set fecha_inicio = fecha_inc
     where id_recordatorio = id_rec;
end;
$$
language plpgsql;

call actualizar_recordatorio(32, '08/15/2019');

create or replace procedure eliminar_recordatorio(
    id_rec int
)
AS
$$
begin
    delete from recordatorios
     where id_recordatorio = id_rec;
end;
$$
language plpgsql;

call eliminar_recordatorio(3);

/* consultar tarea */
create or replace procedure consultar_tarea(
    idtarea int
)
AS
$$
begin
    select *
      from tarea as t
     where t.id_tarea = idtarea;
end;
$$
language plpgsql;

call consultar_tarea(34);

/* ver calendario : tareas del mes actual */
create or replace procedure ver_calendario()
as
$$
declare
    month int := extract(Month from now());
begin
    select *
      from tarea as t
     where month = extract(Month from t.fecha_inicio);
end;
$$
language plpgsql;

call ver_calendario();

/* consultar recordatorio recibe el id tarea */
CREATE OR REPLACE PROCEDURE consultar_recordatorio(
     idtarea INT
)
AS
$$
BEGIN
    SELECT *
      FROM recordatorios AS rec
     WHERE rec.id_tarea = idtarea;
END;
$$
language plpgsql;

call consultar_recordatorio(2);

/* consultar recomendaciones recibe la categoria */
CREATE OR REPLACE PROCEDURE consultar_recomendaciones(
    categ VARCHAR (50)
)
AS
$$
BEGIN
    SELECT *
      FROM recomendacion AS r
     WHERE r.categoria = categ;
END;
$$
language plpgsql;

call consultar_recomendaciones('hogar');

/* Consultas */

-- Mostrar un reporte de todas las tareas del cliente 'Shawn' que tienen un recordatorio.
CREATE OR REPLACE PROCEDURE tareas_Shawn_recordatorio()
AS
$$
BEGIN
    SELECT *
      FROM tareas_Shawn_recordatorio;
END;
$$
language plpgsql;

call tareas_Shawn_recordatorio();

-- Mostrar un reporte de todas las tareas que no poseen un recordatorio.
create or replace procedure recomendaciones_administrador_alina()
as
$$
begin
    select *
      from recomendaciones_administrador_alina;
end;
$$
language plpgsql;

call recomendaciones_administrador_alina();

-- Mostrar un reporte de todas las tareas que han sido ingresados por un administrador.
create or replace procedure tareas_insert_administrador()
as
$$
begin
    select *
      from tareas_insert_administrador;
end;
$$
language plpgsql;

call tareas_insert_administrador();

-- Mostrar un reporte con todos los recordatorios que tienen un sonido asociado.
create or replace procedure recordatorios_con_sonido()
as
$$
begin
    select *
      from recordatorios_con_sonido;
end;
$$
language plpgsql;

call recordatorios_con_sonido();

-- Mostrar un reporte de todas las recomendaciones (nombre, descripcion, categoria) dadas por el administrador Alina.
create or replace procedure recomendaciones_administrador_alina ()
as
$$
begin
    select *
      from recomendaciones_administrador_alina;
end;
$$
language plpgsql;

call recomendaciones_administrador_alina();

-- ¿Cuántas tareas tiene el cliente Oscar?
create or replace procedure tareas_oscar()
as
$$
begin
    select *
      from tareas_oscar;
end;
$$
language plpgsql;

call tareas_oscar();

-- ¿Cuántas tareas tiene el cliente Rasputín en la categoría “ocio”?
create or replace procedure tareas_lili_ocio()
as
$$
begin
    select *
      from tareas_lili_ocio;
end;
$$
language plpgsql;

call tareas_lili_ocio();

-- ¿Cuál es el nombre del cliente con más tareas?
create or replace procedure cliente_mas_tareas()
as
$$
begin
    select *
      from cliente_mas_tareas;
end;
$$
language plpgsql;

call cliente_mas_tareas();

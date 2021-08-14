-- Tabla sonido
create or replace procedure insert_sonido(
    descripcion varchar(255),
    sonido bytea
)
AS
$$
begin
    insert into sonido (descripcion, sonido)
    values (descripcion, sonido);
end;
$$
language plpgsql;

create or replace procedure update_descripcion_sonido(
    id int,
    desc varchar(255)
)
AS
$$
begin
    update sonido
       set descripcion = desc
     where id_sonido = id;
end;
$$
language plpgsql;

create or replace procedure delete_sonido(
    id int
)
AS
$$
begin
    delete from delete
     where id_sonido = id;
end;
$$
language plpgsql;

-- Tabla cliente
CREATE OR REPLACE PROCEDURE insert_cliente(
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
    INSERT INTO cliente (nombre_usuario, contraseña, nombre, apellido, correo, telefono)
    VALUES (nom_usuario, password, nombre, apellido, correo, telef);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE update_cliente_por_nombreUsuario(
    nom_usuario VARCHAR(60),
    mail         VARCHAR(100)
)
AS
$$
BEGIN
    UPDATE cliente
       SET correo = mail
    WHERE nombre_usuario = nom_usuario;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE delete_cliente_por_nombreUsuario(
    nom_usuario VARCHAR(60)
)
AS
$$
BEGIN
    DELETE FROM cliente
    WHERE nombre_usuario = nom_usuario;
END;
$$
LANGUAGE plpgsql;


-- Tabla administrador
create or replace procedure insertar_administrador(
    usuario varchar (50),
    contrasena varchar (50)
)
AS
$$
begin
    insert into administrador (nombre_usuario, contrasena)
    values (usuario, contrasena);
end;
$$
language plpgsql;

create or replace procedure update_contrasena_administrador(
    usuario varchar (50),
    contra varchar (50)
)
AS
$$
begin
    update administrador
       set contrasena = contra
     where nombre_usuario = usuario;
end;
$$
language plpgsql;

create or replace procedure delete_administrador(
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

-- Tabla recomendacion
create or replace procedure insert_recomendacion(
    id_adm varchar (50),
    nombre varchar (50),
    desc varchar (50),
    cat varchar (50)
)
AS
$$
begin
    insert into recomendacion (id_admin, nombre, descripcion, categoria)
    values (id_adm, nombre, desc, cat);
end;
$$
language plpgsql;

create or replace procedure update_categoria_recomendacion(
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

create or replace procedure delete_recomendacion(
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

-- Tabla recomendacion_cliente

CREATE OR REPLACE PROCEDURE insert_recomendacion_cliente(
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


CREATE OR REPLACE PROCEDURE update_recomendacioncliente(
    nom_usuario VARCHAR(60),
    id_reco INT,
    fech DATE
)
AS
$$
BEGIN
    UPDATE recomendacion_cliente
    SET fecha = fech
    WHERE id_cliente = nom_usuario AND id_reomendacion = id_reco;
END;
$$
    LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE delete_recomendacionCliente(
    nom_usuario VARCHAR(60),
    id_reco INT
)
AS
$$
BEGIN
    DELETE FROM cliente
    WHERE nombre_usuario = nom_usuario AND id_recomendacion = id_reco;
END;
$$
LANGUAGE plpgsql;

-- Tabla tarea
create or replace procedure insertar_tarea(
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

create or replace procedure update_descripcion_tarea(
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

create or replace procedure delete_tarea(
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

-- Tabla recordatorios
create or replace procedure insertar_recordatorio(
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

create or replace procedure update_fecha_inicio_recordatorio(
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


create or replace procedure delete_recordatorio(
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


/*
    Este disparador ingresa una nueva recomendacion cuando se ingresa
    una tarea con categoria 'proyectos', 'avances' o 'proposito'.
*/
create or replace function actualizar_recomendacion()
returns trigger
AS
$$
declare
    nombre_recomendacion varchar(50);
    desc_recomendacion varchar(255);
begin
    if NEW.categoria not in ('proyectos', 'avances', 'proposito') then
        return NEW;
    end if;

    raise notice 'Categoria recomendable ingresada!';

    -- Use perform instead of select for side effects, see:
    -- https://www.postgresql.org/docs/current/plpgsql-statements.html#PLPGSQL-STATEMENTS-DIAGNOSTICS
    perform categoria
      from recomendacion as r
     where r.categoria = NEW.categoria;

    nombre_recomendacion := 'Recomendacion (' || NEW.categoria || ')';
    desc_recomendacion := (case NEW.categoria
                           when 'proyectos' then 'Asegurate de comenzar con tiempo!'
                           when 'avances' then 'Las guerras se ganan una batalla a la vez'
                           when 'proposito' then 'La responsabilidad mueve al hombre'
                           end);

    if not found then
        insert into recomendacion (id_admin, nombre, descripcion, categoria)
        values ('alina', nombre_recomendacion, desc_recomendacion, NEW.categoria);

        raise notice 'Recomendacion nueva ingresada: %', nombre_recomendacion;
    end if;

    return NEW;
end;
$$
language plpgsql;

drop trigger if exists actualizar_recomendacion on tarea;
create trigger actualizar_recomendacion
    before insert on tarea
    for each row execute function actualizar_recomendacion();

/*
    Este disparador ingresa un nuevo recordatorio cuando el usuario
    ingresa una tarea en la categoria 'universidad' o 'colegio'.
*/
create or replace function actualizar_recordatorio()
returns trigger
as
$$
declare
    idson int;
    finicio date;
    hinicio time;
    ffin date;
    hfin time;
begin
    if NEW.categoria not in ('universidad', 'colegio') then
        return null;
    end if;

    idson := (select s.id_sonido
                from sonido as s
               where s.descripcion like '%relajante%'
               limit 1);

    if idson is null then
        raise notice 'No hay sonidos relajantes, usando sonido default...';
        idson := (select s.id_sonido
                   from sonido as s
                  limit 1);
    end if;

    finicio := current_date;
    hinicio := current_time;

    -- Simulamos extraer la due date de algun servicio externo
    raise notice 'Extrayendo fecha de Aula Virtual...';

    ffin := finicio + integer '7';
    hfin := hinicio + interval '3 hours';

    insert into recordatorios(id_tarea, id_cliente, id_sonido, fecha_inicio, hora_inicio, fecha_fin, hora_fin)
    values (NEW.id_tarea, NEW.id_cliente, idson, finicio, hinicio, ffin, hfin);

    raise notice 'Se ha insertado un recordatorio nuevo';

    return null;
end;
$$
language plpgsql;

drop trigger if exists actualizar_recordatorio on tarea;
create trigger actualizar_recordatorio
    after insert on tarea
    for each row execute function actualizar_recordatorio();

/*
    Este disparador se asegura de que al ingresar un recordatorio el id_tarea especificado sí
    corresponda a una tarea perteneciente al cliente ingresado.
*/
create or replace function checkear_recordatorio_legal()
returns trigger as
$$
begin
    perform t.id_cliente
      from tarea as t
     where t.id_cliente = NEW.id_cliente
       and t.id_tarea   = NEW.id_tarea;

    if not found then
        raise exception 'Tarea "%" no pertence al usuario "%"', NEW.id_tarea, NEW.id_cliente;
    end if;

    return NEW;
end;
$$ language plpgsql;

drop trigger if exists checkear_recordatorio_legal on recordatorios;
create trigger checkear_recordatorio_legal
    before insert or update on recordatorios
    for each row execute function checkear_recordatorio_legal();

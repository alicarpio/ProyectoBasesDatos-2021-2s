

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

    select categoria
      from recomendacion as r
     where r.categoria = categoria;

    nombre_recomendacion := 'Recomendacion (' || categoria || ')';
    desc_recomendacion := (case categoria
                           when 'proyectos' then ''
                           when 'avances' then ''
                           when 'propostio' then ''
                           end);

    if not found then
        insert into recomendacion (id_admin, nombre, descripcion, categoria)
        values (1, nombre_recomendacion, desc_recomendacion, categoria);
    end if;

    return NEW;
end;
$$
language plpgsql;

create trigger actualizar_recomendacion
    before insert on tarea
    for each row execute function actualizar_recomendacion();

create or replace function actualizar_recordatorio()
returns trigger
as
$$
declare
    id_sonido int;
    fecha_inicio date;
    hora_inicio time;
    fecha_fin date;
    hora_fin time;
begin
    if NEW.categoria not in ('universidad', 'colegio') then
        return NEW;
    end if;

    id_sonido := (select id_sonido
                    from sonido as s
                   where s.descripcion like '%relajante%'
                   limit 1);

    fecha_inicio := current_date;
    hora_inicio := current_time;

    -- Simulamos extraer la due date de algun servicio externo
    raise notice 'Extrayendo fecha de Aula Virtual...';

    fecha_fin := fecha_inicio + integer '7';
    hora_fin := hora_inicio + interval '3 hours';

    insert into recordatorios(id_tarea, id_cliente, id_sonido, fecha_incio, hora_inicio, fecha_fin, hora_fin)
    values (NEW.id_tarea, NEW.id_cliente, id_sonido, fecha_inicio, hora_inicio, fecha_fin, hora_fin);

    return NEW;
end;
$$
language plpgsql;

create trigger actualizar_recordatorio
    before insert on tarea
    for each row execute function actualizar_recordatorio();
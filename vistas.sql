/* Mostrar un reporte con todos los clientes (nombreUsuario) que tienen
   tareas con la categoría “deber”
 */
create or replace view tareas_categoria_deber as
    (select nombre_usuario
       from cliente as c
            inner join tarea as t
            on c.nombre_usuario = t.id_cliente
      where t.categoria = 'deber');

/* Mostrar un reporte de todos los clientes que tienen recordatorios
   con fecha de inicio 15 Julio 2021 y fecha de fin 15 Agosto 2021
 */
 create or replace view recordatorio_julio_agosto as
    (select nombre_usuario
       from cliente as c
            inner join recordatorios as r
            on c.nombre_usuario = r.id_cliente
      where fecha_inicio = '07/15/2021'
        and fecha_fin = '08/15/2021');

/* Mostrar un reporte con todos los clientes (nombreUsuario) que tienen tareas con la categoría “deber”. */
create or replace view cliente_categoria_deber as
    (SELECT c.nombre_usuario
       FROM cliente AS c
            INNER JOIN tarea AS t
            ON c.nombre_usuario = t.id_cliente
      WHERE t.categoria LIKE '%deber%');

/* Mostrar un reporte de todas las tareas que han sido ingresadas por un administrador. */
create or replace VIEW tareas_insert_administrador AS
    (SELECT *
       FROM tarea
      WHERE id_admin IS NOT NULL);

/* Mostrar un reporte con todos los recordatorios que tienen un sonido asociado. */
create or replace VIEW recordatorios_con_sonido AS
    (SELECT rec.*
       FROM recordatorios AS rec
            INNER JOIN sonido AS so
            ON so.id_sonido = rec.id_sonido);

/* Mostrar un reporte de todas las tareas que no poseen un recordatorio. */
create or replace VIEW tareas_not_recordatorios AS
(SELECT *
   FROM tarea AS t
  WHERE NOT EXISTS (SELECT 1
                      FROM recordatorios AS r
                     WHERE t.id_tarea = r.id_tarea));

/* ¿Cuántas tareas tiene el cliente Oscar? */
create or replace view tareas_oscar as
    (SELECT count (id_tarea) AS numero_tareas
       FROM tarea AS t
            INNER JOIN cliente AS cl
            ON cl.nombre_usuario = t.id_cliente
      WHERE cl.nombre = 'Oscar');

/* ¿Cuántas tareas tiene el cliente Lili en la categoría “ocio”? */
create or replace view tareas_lili_ocio as
    (SELECT count (id_tarea) AS numero_tareas
       FROM tarea AS t
            INNER JOIN cliente AS cl
            ON cl.nombre_usuario = t.id_cliente
      WHERE cl.nombre = 'Lili' AND t.categoria ='ocio');

/* ¿Cuál es el nombre del cliente con más tareas? */
create or replace view cliente_mas_tareas as
    (select n.nombre_usuario, max(n.nTareas)
       from (select c.nombre_usuario, count(c.nombre_usuario) as nTareas
               from cliente as c
                    inner join tarea as t
                    on c.nombre_usuario = t.id_cliente
              group by c.nombre_usuario) as n
      group by n.nombre_usuario);

/* Mostrar un reporte de todos los clientes que tienen recordatorios con fecha de
   inicio 15 Julio 2021 y fecha de fin 15 agosto 2021. */
create or replace view clientes_julio_agosto as
    (select *
       from cliente as c
            inner join recordatorios as r
            on c.nombre_usuario = r.id_cliente
      where r.fecha_inicio >= '07/15/2021' and r.fecha_fin <= '08/15/2021');

/* Mostrar un reporte de todas las tareas del cliente 'Shawn' que tienen un recordatorio. */
create or replace view tareas_shawn_recodatorio as
    (SELECT t.*
       FROM tarea AS t
            INNER JOIN recordatorios AS rc
            ON t.id_tarea = rc.id_tarea

            INNER JOIN cliente AS c
            ON c.nombre_usuario = rc.id_cliente
      WHERE nombre_usuario = 'Shawn');

/* Mostrar un reporte de todas las recomendaciones (nombre, descripcion, categoria)
   dadas por el administrador Alina. */
create or replace VIEW recomendaciones_administrador_alina AS
    (SELECT *
       FROM recomendacion
      WHERE id_admin LIKE 'alina');

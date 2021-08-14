/* Mostrar un reporte con todos los clientes (nombreUsuario) que tienen
   tareas con la categoría “deber”
 */
create view tareasCategoriaDeber as
    (select nombre_usuario
       from cliente as c
            inner join tareas as t
            on c.nombre_usuario = t.id_cliente
      where t.categoria = 'deber');

/* Mostrar un reporte de todos los clientes que tienen recordatorios
   con fecha de inicio 15 Julio 2021 y fecha de fin 15 Agosto 2021
 */
 create view recordatorioJulioAgosto as
    (select nombre_usuario
       from cliente as c
            inner join recordatorios as r
            on c.nombre_usuario = r.id_cliente
      where fecha_inicio = '15/7/2021'
        and fecha_fin = '15/8/2021');
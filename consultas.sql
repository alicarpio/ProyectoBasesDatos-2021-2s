-- 1.
SELECT *
  FROM sonido;

SELECT *
  FROM tarea;

SELECT *
  FROM cliente;

SELECT *
  FROM administrador;

SELECT *
  FROM recomendacion;

SELECT *
  FROM recordatorios;

SELECT *
  FROM recomendacion_cliente;

-- 2.
SELECT id_sonido
  FROM sonido;

SELECT id_tarea
  FROM tarea;

SELECT nombre_usuario
  FROM cliente;

SELECT nombre_usuario
  FROM administrador;

SELECT id_recomendacion
  FROM recomendacion;

SELECT id_recordatorio
  FROM recordatorios;

SELECT id_cliente, id_recomendacion
  FROM recomendacion_cliente;

-- 3.
SELECT *
  FROM sonido AS s
 WHERE s.id_sonido = 5;

SELECT *
  FROM tarea AS t
 WHERE t.categoria LIKE '%i%' ;

SELECT *
  FROM cliente AS c
 WHERE c.nombre LIKE '%b%';

SELECT *
  FROM administrador AS a
 WHERE a.nombreUsuario LIKE 'admin%';

SELECT *
  FROM recomendacion AS r
 WHERE r.categoria LIKE '%finanza%';

SELECT *
  FROM recordatorios AS r
 WHERE r.fecha_inicio BETWEEN '9/1/2021' AND '11/1/2021';

SELECT *
  FROM recomendacion_cliente AS r
 WHERE r.id_cliente IN ('ruthcv', 'lilicollins15', 'oscarmoises', 'tinistossel');

-- 4.
SELECT c.nombre_usuario
  FROM cliente AS c
       INNER JOIN tarea AS t
       ON c.nombre_usuario = t.id_cliente
 WHERE t.categoria LIKE '%deber%';

SELECT *
  FROM tarea
 WHERE id_admin IS NOT NULL;

SELECT *
  FROM recordatorios AS rec
       INNER  JOIN sonido AS son
       ON son.id_sonido = rec.id_sonido;

-- SELECT *
--   FROM tarea AS t
--        LEFT JOIN recordatorios AS r
--        ON t.id_tarea = r.id_tarea
--  WHERE r.id_recordatorio is NULL;

SELECT *
  FROM tarea AS t
 WHERE NOT EXISTS (SELECT 1
                     FROM recordatorios AS r
                    WHERE t.id_tarea = r.id_tarea);

SELECT count (id_tarea)
  FROM tarea AS t
       INNER JOIN cliente AS cl
       ON cl.nombre_usuario = t.id_cliente
 WHERE cl.nombre = 'Oscar';

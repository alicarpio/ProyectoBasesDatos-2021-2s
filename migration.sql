-- Set up db
drop table if exists sonido cascade;
drop table if exists cliente cascade;
drop table if exists administrador cascade;
drop table if exists recomendacion cascade;
drop table if exists recomendacion_cliente cascade;
drop table if exists tarea cascade;
drop table if exists recordatorios cascade; 

\i bd.sql

-- Load data
\i datos.sql

-- Set up views
\i vistas.sql

-- TODO: procedimientos

-- Set up triggers
\i disparadores.sql

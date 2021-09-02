-- Set up schema
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

-- Create views
\i vistas.sql

-- Create procedures
\i procedimientos.sql

-- Prepare triggers
\i disparadores.sql

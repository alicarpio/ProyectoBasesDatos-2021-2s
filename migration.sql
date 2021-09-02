-- Set up schema
\echo 'Setting up schema...'

drop table if exists sonido cascade;
drop table if exists cliente cascade;
drop table if exists administrador cascade;
drop table if exists recomendacion cascade;
drop table if exists recomendacion_cliente cascade;
drop table if exists tarea cascade;
drop table if exists recordatorios cascade; 

\i bd.sql

\echo 'Schema ready!'

-- Load data
\echo 'Loading data...'
\i datos.sql
\echo 'Data loaded!'

-- Create views
\echo 'Creating views...'
\i vistas.sql
\echo 'Views created!'

-- Create procedures
\echo 'Creating procedures...'
\i procedimientos.sql
\echo 'Procedures created!'

-- Prepare triggers
\echo 'Preparing triggers...'
\i disparadores.sql
\echo 'Triggers ready!'

\echo 'Done!'

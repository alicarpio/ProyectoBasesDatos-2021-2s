![on time logo](./assets/logo.png)

# Proyecto Bases de Datos 

Proyecto de la materia Bases de Datos, ESPOL

## Modelo Lógico

![modelo logico](./assets/modelo_logico.png)

## Dependencias

- Gradle
- PostgreSQL

## Corriendo el Proyecto

Para correr el programa es necesario tener las credenciales correspondientes
de heroku:

```bash
heroku login
```

Una vez loggeado puedes correr el proyecto con gradle, pero necesitas exportar
la variable de entorno `DATABASE_URL`. Puedes conseguir esto corriendo el siguiente
commando:

```bash
export DATABASE_URL=$(heroku run echo \$DATABASE_URL); gradle run
```

## Evidencia

- [Modelo Conceptual](./evidencias/modelo_conceptual)
- [Modelo Lógico](./evidencias/modelo_logico)
- [Diccionario Datos](./evidencias/diccionario_datos)
- [Consultas Álgebra Relacional](./evidencias/consultas_algebra)

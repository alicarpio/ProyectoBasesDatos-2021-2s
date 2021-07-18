/* Creamos la tabla sonido */
CREATE TABLE IF NOT EXISTS sonido (
	PRIMARY KEY (id_sonido),
	id_sonido   SERIAL       NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	sonido      BYTEA        NOT NULL
);

/* Creamos la tabla administrador */
CREATE TABLE IF NOT EXISTS administrador (
	PRIMARY KEY (nombre_usuario),
	nombre_usuario VARCHAR(50) NOT NULL,
	constrasena    VARCHAR(50) NOT NULL
);

/* Creamos la tabla recomendaciones */
CREATE TABLE IF NOT EXISTS recomendacion (
	PRIMARY KEY (id_recomendacion),
	id_recomendacion SERIAL      NOT NULL,
	id_admin         VARCHAR(50) NOT NULL,
	FOREIGN KEY (id_admin)
		REFERENCES administrador (nombre_usuario)
		ON DELETE CASCADE ON UPDATE CASCADE,
	nombre      VARCHAR(50)  NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	categoria   VARCHAR(50)  NOT NULL
);

/* Creamos la tabla recomendacion_cliente */
CREATE TABLE IF NOT EXISTS recomendacion_cliente (
	PRIMARY KEY (id_cliente, id_recomendacion),
	id_cliente VARCHAR(60) NOT NULL,
	FOREIGN KEY (id_cliente)
		REFERENCES cliente (nombre_usuario)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_recomendacion INT NOT NULL,
	FOREIGN KEY (id_recomendacion)
		REFERENCES recomendacion (id_recomendacion)
		ON DELETE CASCADE ON UPDATE CASCADE,
	fecha DATE NOT NULL
);

/* Creamos la tabla tarea */
CREATE TABLE IF NOT EXISTS tarea (
	PRIMARY KEY (id_tarea),
	id_tarea SERIAL NOT NULL,
	id_cliente VARCHAR(60) NOT NULL,
	FOREIGN KEY (id_cliente)
		REFERENCES cliente (nombre_usuario)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_admin VARCHAR(50) NOT NULL,
	FOREIGN KEY (id_admin)
		REFERENCES administrador (nombre_usuario)
		ON DELETE CASCADE ON UPDATE CASCADE,
	descripcion  VARCHAR(255) NOT NULL,
	fecha_inicio DATE         NOT NULL,
	hora_inicio  TIME         NOT NULL,
	fecha_fin    DATE         NOT NULL,
	hora_fin     TIME         NOT NULL,
	categoria    VARCHAR(50)  NOT NULL
);

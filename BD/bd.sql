CREATE TABLE IF NOT EXISTS sonido (
	PRIMARY KEY (id_sonido),
	id_sonido   SERIAL       NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	sonido      BYTEA        NOT NULL
);

CREATE TABLE IF NOT EXISTS cliente (
	PRIMARY KEY (nombre_usuario),
	nombre_usuario VARCHAR(60)  NOT NULL,
	contrasena     VARCHAR(255)  NOT NULL,
	nombre         VARCHAR(60)  NOT NULL,
	apellido       VARCHAR(60)  NOT NULL,
	correo         VARCHAR(100) NOT NULL,
	telefono       VARCHAR(60)  NOT NULL 
);

CREATE TABLE IF NOT EXISTS administrador (
	PRIMARY KEY (nombre_usuario),
	nombre_usuario VARCHAR(50) NOT NULL,
	constrasena    VARCHAR(50) NOT NULL
);

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

CREATE TABLE IF NOT EXISTS tarea (
	PRIMARY KEY (id_tarea),
	id_tarea SERIAL NOT NULL,
	id_cliente VARCHAR(60) NOT NULL,
	FOREIGN KEY (id_cliente)
		REFERENCES cliente (nombre_usuario)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_admin VARCHAR(50),
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

CREATE TABLE IF NOT EXISTS recordatorios (
	PRIMARY KEY (id_recordatorio),
	id_recordatorio SERIAL NOT NULL,
	id_tarea INT NOT NULL,
	FOREIGN KEY (id_tarea)
		REFERENCES tarea (id_tarea) 
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_cliente VARCHAR(60) NOT NULL,
	FOREIGN KEY (id_cliente)
		REFERENCES cliente (nombre_usuario) 
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_sonido INT NOT NULL,
	FOREIGN KEY (id_sonido)
		REFERENCES sonido (id_sonido) 
		ON DELETE CASCADE ON UPDATE CASCADE,
	nombre VARCHAR(60) NOT NULL,
	fecha_inicio DATE  NOT NULL,
	hora_inicio  TIME  NOT NULL,
	fecha_fin    DATE  NOT NULL,
	hora_fin     TIME  NOT NULL
);

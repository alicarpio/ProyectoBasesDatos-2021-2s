CREATE TABLE IF NOT EXISTS cliente (
	PRIMARY KEY (nombre_usuario),
	nombre_usuario VARCHAR(60)  NOT NULL,
	contrasena     VARCHAR(55)  NOT NULL,
	nombre         VARCHAR(60)  NOT NULL,
	apellido       VARCHAR(60)  NOT NULL,
	correo         VARCHAR(100) NOT NULL,
	telefono       VARCHAR(60)  NOT NULL 
);

CREATE TABLE IF NOT EXISTS recordatorios(
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
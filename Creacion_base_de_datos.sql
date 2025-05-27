CREATE DATABASE sistema_aeropuertario;
USE sistema_aeropuertario;

CREATE TABLE aerolinea(
	aerolinea_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    codigo_IATA CHAR(2) NOT NULL,
    pais_origen VARCHAR(100) NOT NULL,
    fecha_fundacion DATE NOT NULL,
    sitio_web VARCHAR(255) NOT NULL
);

CREATE TABLE aeronave(
	aeronave_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    aerolinea_id SMALLINT NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    capacidad_pasajeros SMALLINT NOT NULL,
    capacidad_carga DECIMAL(10, 2) NOT NULL,
    fecha_fabriacion DATE NOT NULL,
    ultimo_mantenimiento DATE NOT NULL,
    estado ENUM("Activo", "Mantenimiento", "Inactivo") NOT NULL,
    FOREIGN KEY(aerolinea_id) REFERENCES aerolinea(aerolinea_id)
);

CREATE TABLE ruta(
	ruta_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    aeropuerto_origen CHAR(3) NOT NULL,
    aeropuerto_destino CHAR(3) NOT NULL,
    distancia_km DECIMAL(7,2) NOT NULL,
    tiempo_estimado_min SMALLINT NOT NULL
);

CREATE TABLE vuelo(
	vuelo_id INT PRIMARY KEY AUTO_INCREMENT,
    aerolinea_id SMALLINT NOT NULL,
    ruta_id SMALLINT NOT NULL,
    aeronave_id SMALLINT NOT NULL,
    fecha_salida TIMESTAMP NOT NULL,
    fecha_llegada_estimada TIMESTAMP NOT NULL,
    fecha_llegada_real TIMESTAMP,
    puerta_embarque VARCHAR(5) NOT NULL,
    estado ENUM("Programado", "En vuelo", "Aterrizado", "Cancelado", "Retrasado") NOT NULL,
    asientos_disponibles INT DEFAULT 0,
    FOREIGN KEY(aeronave_id) REFERENCES aeronave(aeronave_id),
    FOREIGN KEY(ruta_id) REFERENCES ruta(ruta_id),
    FOREIGN KEY(aerolinea_id) REFERENCES aerolinea(aerolinea_id)
);

CREATE TABLE pasajero(
	pasajero_id INT PRIMARY KEY AUTO_INCREMENT,
    pasaporte VARCHAR(15) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    nacionalidad VARCHAR(100) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL,
    programa_fidelidad VARCHAR(255),
    contador_vuelos INT DEFAULT 0
);

CREATE TABLE tripulacion(
	empleado_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    aerolinea_id SMALLINT NOT NULL,
    licencia VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
	puesto ENUM("Piloto", "Copiloto", "Azafata", "Ingeniero", "Jefe de cabina") NOT NULL,
    fecha_contratacion DATE NOT NULL,
    horas_vuelo DEC(8, 2) NOT NULL,
    FOREIGN KEY(aerolinea_id) REFERENCES aerolinea(aerolinea_id)
);

CREATE TABLE reservacion(
	reservacion_id INT PRIMARY KEY AUTO_INCREMENT,
    vuelo_id INT NOT NULL,
    pasajero_id INT NOT NULL,
	clase ENUM("Primera", "Business", "Turista", "Premium") NOT NULL,
	asiento VARCHAR(5) NOT NULL,
	fecha_reservacion TIMESTAMP NOT NULL,
	estado ENUM("Confirmada", "En espera", "Cancelada", "Utilizada") NOT NULL,
	precio DECIMAL(8, 2) NOT NULL,
	metodo_pago ENUM("Tarjeta", "Efectivo", "Transferencia") NOT NULL,
    FOREIGN KEY(vuelo_id) REFERENCES vuelo(vuelo_id),
    FOREIGN KEY(pasajero_id) REFERENCES pasajero(pasajero_id)
);

CREATE TABLE tripulacion_vuelo(
	vuelo_id INT,
    empleado_id SMALLINT,
    rol TEXT NOT NULL,
    FOREIGN KEY(vuelo_id) REFERENCES vuelo(vuelo_id),
    FOREIGN KEY(empleado_id) REFERENCES tripulacion(empleado_id),
    PRIMARY KEY(vuelo_id, empleado_id)
);

CREATE TABLE notificaciones (
    notificacion_id INT AUTO_INCREMENT PRIMARY KEY,
    vuelo_id INT,
    pasajero_id INT,
    mensaje VARCHAR(255),
    fecha_notificacion DATETIME,
    FOREIGN KEY (vuelo_id) REFERENCES vuelo(vuelo_id),
    FOREIGN KEY (pasajero_id) REFERENCES pasajero(pasajero_id)
);

CREATE TABLE pagos (
    pago_id INT PRIMARY KEY AUTO_INCREMENT,
    reservacion_id INT NOT NULL,
    monto DECIMAL(8, 2) NOT NULL,
    fecha_pago TIMESTAMP NOT NULL,
    metodo_pago ENUM('Tarjeta', 'Efectivo', 'Transferencia') NOT NULL,
    FOREIGN KEY (reservacion_id) REFERENCES reservacion(reservacion_id)
);

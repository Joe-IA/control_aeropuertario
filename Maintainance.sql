SET GLOBAL event_scheduler=ON;
-- Particiones para datos historicos
CREATE TABLE vuelo_historico(
	vuelo_id INT PRIMARY KEY,
    aerolinea_id SMALLINT NOT NULL,
    ruta_id SMALLINT NOT NULL,
    aeronave_id SMALLINT NOT NULL,
    fecha_salida TIMESTAMP NOT NULL,
    fecha_llegada_estimada TIMESTAMP NOT NULL,
    fecha_llegada_real TIMESTAMP,
    puerta_embarque VARCHAR(5) NOT NULL,
    estado ENUM("Programado", "En vuelo", "Aterrizado", "Cancelado", "Retrasado") NOT NULL,
    FOREIGN KEY(aeronave_id) REFERENCES aeronave(aeronave_id),
    FOREIGN KEY(ruta_id) REFERENCES ruta(ruta_id),
    FOREIGN KEY(aerolinea_id) REFERENCES aerolinea(aerolinea_id)
);

CREATE TABLE reservacion_historica(
	reservacion_id INT PRIMARY KEY,
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

DELIMITER //
CREATE EVENT registrar_vuelos_historicos
ON SCHEDULE EVERY 1 MONTH
DO 
BEGIN
	INSERT INTO vuelo_historico
    SELECT * FROM vuelo 
    WHERE fecha_salida < NOW() - INTERVAL 5 YEAR;
    
    DELETE FROM vuelo WHERE fecha_salida < NOW() - INTERVAL 5 YEAR;
END//

DELIMITER ;

DELIMITER //
CREATE EVENT registrar_reservaciones_historicas
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
	INSERT INTO reservacion_historica
    SELECT * FROM reservacion
    WHERE fecha_reservacion < NOW() - INTERVAL 3 YEAR;
    
    DELETE FROM reservacion WHERE fecha_reservacion < NOW() - INTERVAL 3 YEAR;
END //
DELIMITER ;
	
-- Autorizacion y autentificacion
CREATE USER 'airport_administrator'@'%' IDENTIFIED BY 'IceStorm79/85';
GRANT ALL PRIVILEGES ON sistema_aeropuertario.* TO 'airport_administrator'@'%';

CREATE USER 'admin_aeroMX'@'%' IDENTIFIED BY 'Vivaaerobus1234!';
CREATE VIEW aerolinea_aeromexico AS SELECT * FROM aerolinea a WHERE a.aerolinea_id = 10;
CREATE VIEW aeronave_aeromexico AS SELECT * FROM aeronave a WHERE a.aerolinea_id = 10;
CREATE VIEW vuelo_aeromexico AS SELECT * FROM vuelo v WHERE v.aerolinea_id = 10;
CREATE VIEW tripulacion_aeromexico AS SELECT * FROM tripulacion t WHERE t.aerolinea_id = 10;
GRANT ALL PRIVILEGES ON sistema_aeropuertario.aerolinea_aeromexico TO 'admin_aeroMX'@'%';
GRANT ALL PRIVILEGES ON sistema_aeropuertario.aeronave_aeromexico TO 'admin_aeroMX'@'%';
GRANT ALL PRIVILEGES ON sistema_aeropuertario.vuelo_aeromexico TO 'admin_aeroMX'@'%';
GRANT ALL PRIVILEGES ON sistema_aeropuertario.tripulacion_aeromexico TO 'admin_aeroMX'@'%';

CREATE USER 'empleado_chekin'@'localhost' IDENTIFIED BY 'Empleado1!';
GRANT SELECT, UPDATE ON sistema_aeropuertario.reservacion TO 'empleado_chekin'@'localhost';
GRANT SELECT, UPDATE ON sistema_aeropuertario.pasajero TO 'empleado_chekin'@'localhost';

CREATE USER 'api_consumer'@'%' IDENTIFIED BY 'App_working24/7';
CREATE VIEW info_vuelos_publicos AS
SELECT a.nombre,
v.vuelo_id,
r.aeropuerto_origen,
r.aeropuerto_destino,
v.fecha_salida,
v.fecha_llegada_estimada,
v.puerta_embarque,
v.estado
FROM vuelo v
JOIN ruta r
	USING(ruta_id)
JOIN aerolinea a
	USING(aerolinea_id);
GRANT SELECT ON sistema_aeropuertario.info_vuelos_publicos TO 'api_consumer'@'%';



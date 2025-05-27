INSERT INTO aerolinea (nombre, codigo_IATA, pais_origen, fecha_fundacion, sitio_web) VALUES
('American Airlines', 'AA', 'Estados Unidos', '1930-04-15', 'https://www.aa.com'),
('Lufthansa', 'LH', 'Alemania', '1953-01-06', 'https://www.lufthansa.com'),
('Air France', 'AF', 'Francia', '1933-10-07', 'https://www.airfrance.com'),
('LATAM Airlines', 'LA', 'Chile', '2012-06-22', 'https://www.latam.com'),
('Qatar Airways', 'QR', 'Catar', '1993-11-22', 'https://www.qatarairways.com'),
('Singapore Airlines', 'SQ', 'Singapur', '1947-05-01', 'https://www.singaporeair.com'),
('Emirates', 'EK', 'Emiratos Árabes Unidos', '1985-10-25', 'https://www.emirates.com'),
('British Airways', 'BA', 'Reino Unido', '1974-03-31', 'https://www.britishairways.com'),
('Turkish Airlines', 'TK', 'Turquía', '1933-05-20', 'https://www.turkishairlines.com'),
('Aeroméxico', 'AM', 'México', '1934-09-14', 'https://www.aeromexico.com');

INSERT INTO aeronave (aerolinea_id, modelo, capacidad_pasajeros, capacidad_carga, fecha_fabriacion, ultimo_mantenimiento, estado) VALUES
(1, 'Boeing 737-800', 160, 20000.00, '2010-06-15', '2024-12-10', 'Activo'),
(2, 'Airbus A320', 180, 19000.00, '2012-08-22', '2025-01-12', 'Mantenimiento'),
(3, 'Boeing 777-300ER', 396, 37000.50, '2014-03-10', '2025-04-01', 'Activo'),
(4, 'Airbus A350-900', 314, 25000.00, '2017-11-28', '2025-03-14', 'Activo'),
(5, 'Boeing 787-9 Dreamliner', 296, 23000.00, '2016-04-19', '2025-02-27', 'Mantenimiento'),
(6, 'Airbus A380', 555, 40000.00, '2015-09-30', '2025-01-18', 'Activo'),
(7, 'Boeing 777F', 0, 103000.00, '2018-02-12', '2025-03-30', 'Activo'),
(8, 'Airbus A319', 144, 18000.00, '2009-12-07', '2024-10-05', 'Inactivo'),
(9, 'Boeing 737 MAX 8', 178, 20400.00, '2020-07-21', '2025-04-20', 'Mantenimiento'),
(10, 'Embraer E190', 114, 13000.00, '2013-05-25', '2025-01-30', 'Activo');

INSERT INTO ruta (aeropuerto_origen, aeropuerto_destino, distancia_km, tiempo_estimado_min) VALUES
('JFK', 'LAX', 3974.00, 360),
('CDG', 'FRA', 478.00, 75),
('SCL', 'EZE', 1140.00, 135),
('DOH', 'DXB', 379.00, 70),
('SIN', 'NRT', 5330.00, 420),
('LHR', 'JFK', 5540.00, 435),
('IST', 'AMS', 2215.00, 210),
('MEX', 'CUN', 1280.00, 140),
('GRU', 'BOG', 4300.00, 320),
('SYD', 'MEL', 713.00, 85);

INSERT INTO vuelo (aerolinea_id, ruta_id, aeronave_id, fecha_salida, fecha_llegada_estimada, fecha_llegada_real, puerta_embarque, estado, asientos_disponibles) VALUES
(1, 8, 1, '2025-06-01 08:00:00', '2025-06-01 11:00:00', NULL, 'A1', 'Programado', 160),
(2, 10, 2, '2025-06-01 09:30:00', '2025-06-01 13:00:00', NULL, 'B2', 'Programado', 180),
(1, 3, 1, '2025-06-01 14:00:00', '2025-06-01 16:00:00', NULL, 'C3', 'Programado', 160),
(3, 4, 3, '2025-05-30 12:00:00', '2025-05-30 15:00:00', '2025-05-30 15:10:00', 'D4', 'Aterrizado', 396),
(7, 5, 9, '2025-05-31 18:00:00', '2025-05-31 21:00:00', '2025-05-31 21:45:00', 'E5', 'Retrasado', 178),
(4, 2, 5, '2025-06-01 06:00:00', '2025-06-01 08:30:00', NULL, 'F1', 'En vuelo', 296),
(5, 8, 2, '2025-06-02 11:00:00', '2025-06-02 14:00:00', NULL, 'A2', 'Programado', 180),
(7, 1, 4, '2025-06-03 07:00:00', '2025-06-03 10:30:00', NULL, 'B3', 'Programado', 314),
(10, 6, 9, '2025-06-04 13:00:00', '2025-06-04 16:00:00', NULL, 'C1', 'Cancelado', 178),
(1, 5, 3, '2025-06-05 17:00:00', '2025-06-05 20:30:00', NULL, 'D2', 'Programado', 396),
(1, 1, 1, '2025-05-25 08:00:00', '2025-05-25 10:30:00', '2025-05-25 10:25:00', 'A1', 'Aterrizado', 160),
(2, 2, 2, '2025-05-25 13:15:00', '2025-05-25 15:45:00', NULL, 'B3', 'En vuelo', 180),
(3, 3, 3, '2025-05-25 18:00:00', '2025-05-25 20:30:00', NULL, 'C2', 'Programado', 396),
(4, 4, 4, '2025-06-03 07:00:00', '2025-06-03 09:30:00', NULL, 'D1', 'Programado', 314),
(5, 5, 5, '2025-06-03 11:45:00', '2025-06-03 14:15:00', NULL, 'E4', 'Programado', 296),
(6, 6, 6, '2025-06-03 17:20:00', '2025-06-03 19:50:00', NULL, 'F2', 'Programado', 555),
(1, 2, 3, '2025-05-24 08:30:00', '2025-05-24 11:00:00', '2025-05-24 11:10:00', 'B12', 'Aterrizado', 396),
(4, 1, 2, '2025-05-23 22:00:00', '2025-05-24 00:30:00', '2025-05-24 00:40:00', 'C3', 'Aterrizado', 180),
(1, 8, 1, '2025-05-26 19:00:00', '2025-05-26 21:30:00', NULL, 'A3', 'Programado', 160);

INSERT INTO pasajero (pasaporte, nombre, apellido, fecha_nacimiento, nacionalidad, telefono, email, programa_fidelidad) VALUES
('P1234567A', 'Carlos', 'Ramírez', '1985-04-12', 'México', '+5215551234567', 'carlos.ramirez@example.com', 'SkyMiles'),
('P2345678B', 'Ana', 'Gómez', '1990-08-25', 'Colombia', '+573013456789', 'ana.gomez@example.com', 'LifeMiles'),
('P3456789C', 'Lucía', 'Martínez', '1978-01-30', 'Argentina', '+5491122334455', 'lucia.martinez@example.com', NULL),
('P4567890D', 'Juan', 'Pérez', '1995-11-05', 'España', '+34666777888', 'juan.perez@example.es', 'Iberia Plus'),
('P5678901E', 'Sofía', 'Torres', '1988-06-14', 'Chile', '+56987654321', 'sofia.torres@example.cl', 'Flying bird'),
('P6789012F', 'Mateo', 'Díaz', '2000-03-21', 'Perú', '+519987654321', 'mateo.diaz@example.pe', 'LATAM Pass'),
('P7890123G', 'Valentina', 'Morales', '1992-09-10', 'Uruguay', '+59891234567', 'valentina.morales@example.uy', NULL),
('P8901234H', 'Sebastián', 'Herrera', '1983-12-03', 'Venezuela', '+584141234567', 'sebastian.herrera@example.ve', 'AAdvantage'),
('P9012345I', 'María', 'Rojas', '1975-07-19', 'Panamá', '+50761234567', 'maria.rojas@example.pa', NULL),
('P0123456J', 'Andrés', 'Cruz', '1998-02-28', 'Ecuador', '+593987654321', 'andres.cruz@example.ec', 'Miles & More');

INSERT INTO tripulacion (aerolinea_id, licencia, nombre, apellido, puesto, fecha_contratacion, horas_vuelo) VALUES
(1, 'LIC123456A', 'Luis', 'Mendoza', 'Piloto', '2015-03-01', 9200.50),
(2, 'LIC234567B', 'María', 'Fernández', 'Azafata', '2018-07-15', 3500.75),
(3, 'LIC345678C', 'Jorge', 'Ramírez', 'Copiloto', '2016-10-22', 6100.00),
(4, 'LIC456789D', 'Carla', 'González', 'Azafata', '2019-01-10', 2800.25),
(5, 'LIC567890E', 'Andrés', 'Paredes', 'Ingeniero', '2014-05-05', 5000.00),
(6, 'LIC678901F', 'Lucía', 'Ortega', 'Jefe de cabina', '2013-09-30', 7200.10),
(7, 'LIC789012G', 'Ricardo', 'Vega', 'Piloto', '2017-12-18', 8400.80),
(8, 'LIC890123H', 'Paola', 'Salinas', 'Azafata', '2020-06-07', 1900.45),
(9, 'LIC901234I', 'Esteban', 'Moreno', 'Copiloto', '2016-04-20', 6600.00),
(10, 'LIC012345J', 'Valeria', 'Torres', 'Ingeniero', '2011-02-14', 7800.30);

INSERT INTO reservacion (vuelo_id, pasajero_id, clase, asiento, fecha_reservacion, estado, precio, metodo_pago) VALUES
(1, 1, 'Turista', '12A', '2025-05-20 10:15:00', 'Confirmada', 250.00, 'Tarjeta'),
(2, 2, 'Business', '2B', '2025-05-21 11:30:00', 'En espera', 520.50, 'Transferencia'),
(3, 3, 'Primera', '1A', '2025-05-22 14:00:00', 'Confirmada', 950.00, 'Tarjeta'),
(4, 4, 'Turista', '15C', '2025-05-23 09:45:00', 'Utilizada', 180.00, 'Efectivo'),
(5, 5, 'Premium', '6D', '2025-05-24 08:20:00', 'Confirmada', 340.00, 'Tarjeta'),
(6, 6, 'Turista', '17E', '2025-05-25 13:10:00', 'Cancelada', 210.75, 'Transferencia'),
(7, 7, 'Business', '3A', '2025-05-26 15:25:00', 'En espera', 480.00, 'Efectivo'),
(8, 8, 'Turista', '18B', '2025-05-27 12:00:00', 'Confirmada', 200.00, 'Tarjeta'),
(9, 9, 'Primera', '1B', '2025-05-28 16:40:00', 'Utilizada', 975.00, 'Tarjeta'),
(10, 10, 'Premium', '5C', '2025-05-29 17:55:00', 'Confirmada', 360.00, 'Transferencia'),
(1, 7, 'Turista', '13A', '2025-05-26 19:00:00', 'Confirmada', 150.00, 'Tarjeta'),
(2, 7, 'Turista', '14B', '2025-05-26 19:00:00', 'En espera', 160.00, 'Transferencia'),
(3, 7, 'Business', '4C', '2025-05-26 19:00:00', 'Cancelada', 400.00, 'Efectivo'),
(4, 7, 'Primera', '1F', '2025-05-26 19:00:00', 'Confirmada', 600.00, 'Tarjeta'),
(5, 7, 'Turista', '18B', '2025-05-26 19:00:00', 'En espera', 155.00, 'Tarjeta'),
(6, 7, 'Turista', '16F', '2025-05-26 19:00:00', 'Confirmada', 170.00, 'Efectivo'),
(7, 7, 'Premium', '5D', '2025-05-26 19:00:00', 'Confirmada', 320.00, 'Transferencia'),
(8, 7, 'Business', '3F', '2025-05-26 19:00:00', 'Cancelada', 410.00, 'Tarjeta'),
(9, 7, 'Turista', '21C', '2025-05-26 19:00:00', 'Confirmada', 140.00, 'Efectivo'),
(10, 7, 'Primera', '1E', '2025-05-26 19:00:00', 'En espera', 620.00, 'Tarjeta'),
(1, 5, 'Turista', '11A', '2025-05-26 19:00:00', 'Utilizada', 150.00, 'Tarjeta'),
(2, 5, 'Business', '2C', '2025-05-26 19:00:00', 'Utilizada', 380.00, 'Transferencia'),
(3, 5, 'Premium', '6F', '2025-05-26 19:00:00', 'Utilizada', 290.00, 'Tarjeta'),
(4, 5, 'Primera', '1C', '2025-05-26 19:00:00', 'Utilizada', 600.00, 'Efectivo'),
(5, 5, 'Turista', '15B', '2025-05-26 19:00:00', 'Utilizada', 160.00, 'Tarjeta'),
(6, 5, 'Business', '3D', '2025-05-26 19:00:00', 'Utilizada', 390.00, 'Transferencia'),
(7, 5, 'Premium', '7A', '2025-05-26 19:00:00', 'Utilizada', 310.00, 'Tarjeta'),
(8, 5, 'Turista', '17E', '2025-05-26 19:00:00', 'Utilizada', 145.00, 'Efectivo'),
(9, 5, 'Business', '2B', '2025-05-26 19:00:00', 'Utilizada', 395.00, 'Tarjeta'),
(10, 5, 'Primera', '1D', '2025-05-26 19:00:00', 'Utilizada', 615.00, 'Transferencia'),
(1, 2, 'Turista', '12B', '2025-05-26 19:00:00', 'Utilizada', 150.00, 'Tarjeta'),
(2, 2, 'Turista', '14C', '2025-05-26 19:00:00', 'Utilizada', 160.00, 'Tarjeta'),
(3, 2, 'Business', '3B', '2025-05-26 19:00:00', 'Utilizada', 400.00, 'Transferencia'),
(4, 2, 'Primera', '1A', '2025-05-26 19:00:00', 'Utilizada', 600.00, 'Efectivo'),
(5, 2, 'Turista', '18D', '2025-05-26 19:00:00', 'Utilizada', 155.00, 'Tarjeta'),
(6, 2, 'Turista', '16E', '2025-05-26 19:00:00', 'Utilizada', 170.00, 'Tarjeta'),
(7, 2, 'Premium', '5C', '2025-05-26 19:00:00', 'Utilizada', 320.00, 'Transferencia'),
(8, 2, 'Business', '2D', '2025-05-26 19:00:00', 'Utilizada', 410.00, 'Efectivo'),
(9, 2, 'Turista', '20F', '2025-05-26 19:00:00', 'Utilizada', 140.00, 'Tarjeta'),
(10, 2, 'Primera', '1B', '2025-05-26 19:00:00', 'Utilizada', 620.00, 'Tarjeta');


INSERT INTO tripulacion_vuelo (vuelo_id, empleado_id, rol) VALUES
(1, 1, 'Piloto al mando del vuelo 1'),
(1, 2, 'Azafata responsable de cabina trasera'),
(2, 3, 'Copiloto encargado de navegación'),
(2, 4, 'Azafata a cargo del servicio de bebidas'),
(3, 5, 'Ingeniero responsable del control técnico'),
(3, 1, 'Piloto al mando del vuelo 3'),
(4, 6, 'Jefe de cabina supervisando seguridad del vuelo'),
(5, 7, 'Piloto al mando del vuelo 5'),
(6, 8, 'Azafata de cabina delantera'),
(6, 2, 'Azafata responsable de cabina delantera'),
(7, 9, 'Copiloto a cargo del contacto con torre'),
(7, 3, 'Copiloto encargado de navegación'),
(8, 10, 'Ingeniero en verificación de sistemas prevuelo'),
(8, 4, 'Azafata a cargo del servicio de bebidas'),
(14, 5, 'Ingeniero responsable del control técnico'),
(15, 6, 'Jefe de cabina supervisando seguridad del vuelo'),
(16, 7, 'Piloto al mando del vuelo 16'),
(19, 1, 'Piloto al mando del vuelo 19');

-- Inicializar contador_vuelos en pasajeros
UPDATE pasajero p
JOIN (
    SELECT pasajero_id, COUNT(*) as vuelos_utilizados
    FROM reservacion
    WHERE estado = 'Utilizada'
    GROUP BY pasajero_id
) r ON p.pasajero_id = r.pasajero_id
SET p.contador_vuelos = r.vuelos_utilizados;
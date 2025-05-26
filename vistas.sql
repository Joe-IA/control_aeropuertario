-- Vistas
# 1: Vuelos del dia
CREATE VIEW vuelos_del_dia AS
SELECT v.vuelo_id, 
a.nombre as nombre_aerolinea, 
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
	USING(aerolinea_id)
WHERE DATE(v.fecha_salida) = CURDATE();

#2:
CREATE VIEW pasajeros_frecuentes AS 
SELECT p.nombre,
p.apellido,
p.pasaporte,
p.programa_fidelidad
FROM pasajero p
JOIN reservacion r
	USING (pasajero_id)
WHERE r.estado = "Utilizada"
GROUP BY pasajero_id
HAVING COUNT(*) >= 10;

#3: 
CREATE VIEW aeronaves_mantenimiento AS
SELECT a.aeronave_id,
al.nombre,
a.modelo,
a.fecha_fabriacion,
a.ultimo_mantenimiento,
a.estado,
DATE_ADD(CURDATE(), INTERVAL ROUND((RAND() * 29 + 1), 0) DAY) AS "fecha estimada de retorno"
FROM aeronave a 
JOIN aerolinea al
	USING(aerolinea_id)
WHERE a.estado = "Mantenimiento";

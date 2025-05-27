-- Actualización de estado de aeronave

DELIMITER //

CREATE TRIGGER actualizar_estado_aeronave
BEFORE UPDATE ON aeronave
FOR EACH ROW
BEGIN
    IF NEW.ultimo_mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN
        SET NEW.estado = 'Activo';
    ELSE
        SET NEW.estado = 'Mantenimiento';
    END IF;
END //

DELIMITER ;


-- Notificación de retrasos
DELIMITER //

CREATE TRIGGER notificar_retrasos
AFTER UPDATE ON vuelo
FOR EACH ROW
BEGIN
    IF NEW.fecha_llegada_real IS NOT NULL 
       AND TIMESTAMPDIFF(MINUTE, NEW.fecha_llegada_estimada, NEW.fecha_llegada_real) > 15 THEN
        INSERT INTO notificaciones (vuelo_id, pasajero_id, mensaje, fecha_notificacion)
        SELECT 
            NEW.vuelo_id,
            r.pasajero_id,
            CONCAT('El vuelo ', NEW.vuelo_id, ' ha sido retrasado. Nueva llegada: ', NEW.fecha_llegada_real) AS mensaje,
            NOW()
        FROM 
            reservacion r
        WHERE 
            r.vuelo_id = NEW.vuelo_id
            AND r.estado = 'Confirmada';
    END IF;
END //

DELIMITER ;


--Actualización de programa de fidelidad
DELIMITER //

CREATE TRIGGER actualizar_fidelidad
AFTER INSERT ON reservacion
FOR EACH ROW
BEGIN
    IF NEW.estado = 'Utilizada' THEN
        UPDATE pasajero
        SET 
            contador_vuelos = contador_vuelos + 1,
            programa_fidelidad = CASE 
                WHEN contador_vuelos + 1 >= 20 THEN 'Oro'
                WHEN contador_vuelos + 1 >= 10 THEN 'Plata'
                ELSE programa_fidelidad
            END
        WHERE pasajero_id = NEW.pasajero_id;
    END IF;
END //

DELIMITER ;


-- 1. Trigger actualizar_estado_aeronave
UPDATE aeronave SET ultimo_mantenimiento = '2025-05-26' WHERE aeronave_id = 2;
SELECT * FROM aeronave WHERE aeronave_id = 2;

-- 2. Trigger notificar_retraso
DELETE FROM notificaciones WHERE vuelo_id = 4;
UPDATE vuelo SET fecha_llegada_real = '2025-05-30 15:30:00' WHERE vuelo_id = 4;
SELECT * FROM notificaciones WHERE vuelo_id = 4;

-- 3. Trigger actualizar_fidelidad
INSERT INTO reservacion (vuelo_id, pasajero_id, clase, asiento, fecha_reservacion, estado, precio, metodo_pago)
VALUES (1, 7, 'Turista', '13B', '2025-05-26 19:54:00', 'Utilizada', 150.00, 'Tarjeta');
SELECT * FROM pasajero WHERE pasajero_id = 7;
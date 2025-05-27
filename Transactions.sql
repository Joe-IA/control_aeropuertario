-- Proceso completo de reservación
DELIMITER //

CREATE PROCEDURE proceso_reservacion(
    IN p_vuelo_id INT,
    IN p_pasajero_id INT,
    IN p_clase ENUM('Primera', 'Business', 'Turista', 'Premium'),
    IN p_asiento VARCHAR(5),
    IN p_precio DECIMAL(8, 2),
    IN p_metodo_pago ENUM('Tarjeta', 'Efectivo', 'Transferencia')
)
BEGIN
    DECLARE v_asientos_disponibles INT;
    DECLARE v_reservacion_id INT;

    -- Iniciar transacción
    START TRANSACTION;

    -- Verificar asientos disponibles
    SELECT COUNT(*) INTO v_asientos_disponibles
    FROM reservacion
    WHERE vuelo_id = p_vuelo_id
    AND asiento = p_asiento
    AND estado IN ('Confirmada', 'Utilizada');

    IF v_asientos_disponibles > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El asiento ya está ocupado';
    END IF;

    -- Insertar la reservación
    INSERT INTO reservacion (
        vuelo_id, pasajero_id, clase, asiento, fecha_reservacion, 
        estado, precio, metodo_pago
    )
    VALUES (
        p_vuelo_id, p_pasajero_id, p_clase, p_asiento, NOW(), 
        'Confirmada', p_precio, p_metodo_pago
    );

    -- Obtener el ID de la reservación recién creada
    SET v_reservacion_id = LAST_INSERT_ID();

    -- Insertar el pago
    INSERT INTO pagos (reservacion_id, monto, fecha_pago, metodo_pago)
    VALUES (v_reservacion_id, p_precio, NOW(), p_metodo_pago);

    -- Actualizar asientos disponibles (simulado, ya que no hay columna 'asientos_disponibles')
    UPDATE vuelo
    SET asientos_disponibles = asientos_disponibles - 1
    WHERE vuelo_id = p_vuelo_id;

    -- Confirmar transacción
    COMMIT;
    
    -- Manejo de errores
    IF @@ERROR_COUNT > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error en el proceso de reservación';
    END IF;
END //

DELIMITER ;

--Check-in de pasajeros
DELIMITER //

CREATE PROCEDURE checkin_pasajeros(
    IN p_vuelo_id INT,
    IN p_pasajero_id INT
)
BEGIN
    DECLARE v_asientos_ocupados INT;
    DECLARE v_capacidad_pasajeros INT;
    DECLARE v_pasaporte_valido BOOLEAN;

    -- Iniciar transacción
    START TRANSACTION;

    -- Verificar capacidad del vuelo
    SELECT COUNT(*) INTO v_asientos_ocupados
    FROM reservacion
    WHERE vuelo_id = p_vuelo_id
    AND estado IN ('Confirmada', 'Utilizada');

    SELECT a.capacidad_pasajeros INTO v_capacidad_pasajeros
    FROM vuelo v
    JOIN aeronave a ON v.aeronave_id = a.aeronave_id
    WHERE v.vuelo_id = p_vuelo_id;

    IF v_asientos_ocupados >= v_capacidad_pasajeros THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay asientos disponibles en el vuelo';
    END IF;

    -- Verificar validez del pasaporte (ejemplo: no debe estar vencido)
    SELECT COUNT(*) > 0 INTO v_pasaporte_valido
    FROM pasajero
    WHERE pasajero_id = p_pasajero_id
    AND pasaporte IS NOT NULL
    AND fecha_nacimiento <= DATE_SUB(CURDATE(), INTERVAL 18 YEAR); -- Ejemplo: pasajero mayor de 18 años

    IF NOT v_pasaporte_valido THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pasaporte no válido o pasajero menor de edad';
    END IF;

    -- Actualizar estado de la reservación
    UPDATE reservacion
    SET estado = 'Utilizada'
    WHERE vuelo_id = p_vuelo_id
    AND pasajero_id = p_pasajero_id
    AND estado = 'Confirmada';

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se encontró una reservación confirmada para este pasajero';
    END IF;

    -- Confirmar transacción
    COMMIT;

    -- Manejo de errores
    IF @@ERROR_COUNT > 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error en el proceso de check-in';
    END IF;
END //

DELIMITER ;

-- 1. proceso_reservacion
CALL proceso_reservacion(1, 1, 'Turista', '14A', 150.00, 'Tarjeta');
SELECT * FROM reservacion WHERE reservacion_id = LAST_INSERT_ID();
SELECT * FROM pagos WHERE reservacion_id = LAST_INSERT_ID();

-- 2. checkin_pasajeros
CALL checkin_pasajeros(1, 1);
SELECT * FROM reservacion WHERE vuelo_id = 1 AND pasajero_id = 1 AND estado = 'Utilizada';
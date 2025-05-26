-- Asignación de tripulación a vuelos

DELIMITER //

CREATE PROCEDURE asignar_tripulacion_vuelo(
    IN p_fecha_vuelo DATETIME,
    IN p_ruta_id INT
)
BEGIN
    DECLARE v_vuelo_id INT;
    DECLARE v_piloto_id INT;
    DECLARE v_azafata_id INT;

    -- Seleccionar un vuelo programado para la fecha y ruta
    SELECT vuelo_id INTO v_vuelo_id
    FROM vuelo
    WHERE ruta_id = p_ruta_id
    AND fecha_salida = p_fecha_vuelo
    AND estado = 'Programado'
    LIMIT 1;

    -- Seleccionar piloto disponible con menos horas de vuelo
    SELECT empleado_id INTO v_piloto_id
    FROM tripulacion
    WHERE puesto = 'Piloto'
    AND empleado_id NOT IN (
        SELECT empleado_id 
        FROM tripulacion_vuelo tv
        JOIN vuelo v ON tv.vuelo_id = v.vuelo_id
        WHERE DATE(v.fecha_salida) = DATE(p_fecha_vuelo)
    )
    ORDER BY horas_vuelo ASC
    LIMIT 1;

    -- Seleccionar azafata disponible
    SELECT empleado_id INTO v_azafata_id
    FROM tripulacion
    WHERE puesto = 'Azafata'
    AND empleado_id NOT IN (
        SELECT empleado_id 
        FROM tripulacion_vuelo tv
        JOIN vuelo v ON tv.vuelo_id = v.vuelo_id
        WHERE DATE(v.fecha_salida) = DATE(p_fecha_vuelo)
    )
    ORDER BY horas_vuelo ASC
    LIMIT 1;

    -- Asignar piloto y azafata al vuelo
    IF v_vuelo_id IS NOT NULL AND v_piloto_id IS NOT NULL THEN
        INSERT INTO tripulacion_vuelo (vuelo_id, empleado_id, rol)
        VALUES (v_vuelo_id, v_piloto_id, 'Piloto al mando');
    END IF;

    IF v_vuelo_id IS NOT NULL AND v_azafata_id IS NOT NULL THEN
        INSERT INTO tripulacion_vuelo (vuelo_id, empleado_id, rol)
        VALUES (v_vuelo_id, v_azafata_id, 'Azafata principal');
    END IF;
END //

DELIMITER ;


-- Check-in automático

DELIMITER //

CREATE PROCEDURE checkin_automatico(
    IN p_vuelo_id INT
)
BEGIN
    DECLARE v_asiento VARCHAR(5);
    DECLARE v_count INT;

    -- Contar asientos disponibles
    SELECT COUNT(*) INTO v_count
    FROM reservacion
    WHERE vuelo_id = p_vuelo_id
    AND estado = 'Confirmada';

    -- Actualizar estado y asignar asientos
    UPDATE reservacion
    SET 
        estado = 'Utilizada',
        asiento = CONCAT(FLOOR(RAND() * 30) + 1, CHAR(FLOOR(RAND() * 6) + 65))
    WHERE 
        vuelo_id = p_vuelo_id
        AND estado = 'Confirmada'
        AND fecha_reservacion <= DATE_SUB(NOW(), INTERVAL 24 HOUR);
END //

DELIMITER ;


-- Cálculo de estadísticas de puntualidad

DELIMITER //

CREATE PROCEDURE estadisticas_puntualidad(
    IN p_anio INT,
    IN p_mes INT
)
BEGIN
    SELECT 
        a.nombre AS aerolinea,
        COUNT(*) AS total_vuelos,
        SUM(CASE 
            WHEN v.fecha_llegada_real IS NOT NULL 
            AND TIMESTAMPDIFF(MINUTE, v.fecha_llegada_estimada, v.fecha_llegada_real) > 15 
            THEN 1 ELSE 0 
        END) AS vuelos_retrasados,
        ROUND(SUM(CASE 
            WHEN v.fecha_llegada_real IS NOT NULL 
            AND TIMESTAMPDIFF(MINUTE, v.fecha_llegada_estimada, v.fecha_llegada_real) <= 15 
            THEN 1 ELSE 0 
        END) / COUNT(*) * 100, 2) AS porcentaje_puntual
    FROM 
        vuelo v
        JOIN aerolinea a ON v.aerolinea_id = a.aerolinea_id
    WHERE 
        YEAR(v.fecha_salida) = p_anio
        AND MONTH(v.fecha_salida) = p_mes
        AND v.estado IN ('Aterrizado', 'Retrasado')
    GROUP BY 
        a.nombre;
END //

DELIMITER ;
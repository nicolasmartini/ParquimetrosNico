#Creacion de stored procedure.

delimiter !

CREATE PROCEDURE conectar(IN id_tarjeta INTEGER , IN id_parq INTEGER)
    BEGIN
        # Declaro variables locales.
        DECLARE saldo_actual DECIMAL(5,2);
        DECLARE saldo_nuevo DECIMAL(5,2);
        DECLARE descuento DECIMAL(3,2) UNSIGNED;
        DECLARE tarifa DECIMAL(5,2) UNSIGNED;
        DECLARE fecha_ent DATE;
        DECLARE hora_ent TIME;
        DECLARE fecha_actual DATE;
        DECLARE hora_actual TIME;
        DECLARE tiempo INTEGER;

        # Declaro variables locales para recuperar los errores .
	    DECLARE codigo_SQL  CHAR(5) DEFAULT '00000';	 
	    DECLARE codigo_MYSQL INT DEFAULT 0;
	    DECLARE mensaje_error TEXT;

        DECLARE EXIT HANDLER FOR SQLEXCEPTION 	 	 
	    BEGIN 
		    GET DIAGNOSTICS CONDITION 1  codigo_MYSQL= MYSQL_ERRNO, codigo_SQL= RETURNED_SQLSTATE, mensaje_error= MESSAGE_TEXT;
	        SELECT 'SQLEXCEPTION!, transacción abortada' AS resultado, codigo_MySQL, codigo_SQL,  mensaje_error;		
            ROLLBACK;
	    END;		    

        START TRANSACTION;	# Comienza la transacción  
        SET fecha_actual = curdate();
        SET hora_actual = curtime();
        IF EXISTS (SELECT * FROM tarjetas t WHERE t.id_tarjeta=id_tarjeta) AND
           EXISTS (SELECT * FROM parquimetros p WHERE p.id_parq=id_parq)
        THEN    # verifico que existen la tarjeta y el parquimetro.
            SET descuento = (SELECT tt.descuento FROM tarjetas t NATURAL JOIN tipos_tarjeta tt WHERE t.id_tarjeta = id_tarjeta LIMIT 1);
            SET tarifa = (SELECT u.tarifa FROM ubicaciones u JOIN parquimetros p WHERE u.calle=p.calle AND u.altura=p.altura AND p.id_parq=id_parq LIMIT 1);
            IF EXISTS (SELECT * FROM parquimetros NATURAL JOIN estacionamientos e NATURAL JOIN tarjetas 
                       WHERE e.id_parq=id_parq AND e.id_tarjeta=id_tarjeta AND e.fecha_sal IS NULL AND e.hora_sal IS NULL)
            THEN
                #Tiene estacionamiento abierto.
                SELECT saldo INTO saldo_actual FROM tarjetas t  WHERE t.id_tarjeta=id_tarjeta FOR UPDATE;
                SET fecha_ent =(SELECT e.fecha_ent FROM estacionamientos e 
                    WHERE e.id_parq=id_parq AND e.id_tarjeta=id_tarjeta AND e.fecha_sal IS NULL AND e.hora_sal IS NULL LIMIT 1);
                SET hora_ent =(SELECT e.hora_ent FROM estacionamientos e 
                    WHERE e.id_parq=id_parq AND e.id_tarjeta=id_tarjeta AND e.fecha_sal IS NULL AND e.hora_sal IS NULL LIMIT 1);
                SET tiempo = (TIMESTAMPDIFF(MINUTE,fecha_ent,fecha_actual)) + (TIMESTAMPDIFF(MINUTE,hora_ent,hora_actual));
                SET saldo_nuevo = saldo_actual - (tiempo * tarifa * (1 - descuento));
                UPDATE tarjetas t SET saldo = saldo_nuevo WHERE t.id_tarjeta=id_tarjeta;
                UPDATE estacionamientos e SET fecha_sal = fecha_actual WHERE e.id_parq=id_parq AND e.id_tarjeta=id_tarjeta;
                UPDATE estacionamientos e SET hora_sal = hora_actual WHERE e.id_parq=id_parq AND e.id_tarjeta=id_tarjeta;
                SELECT 'Cierre' AS Operacion, tiempo AS 'Tiempo(min)', saldo_nuevo AS Saldo;
            ELSE
                #Tiene estacionamiento cerrado.
                SET saldo_actual = (SELECT t.saldo FROM tarjetas t  WHERE t.id_tarjeta=id_tarjeta LIMIT 1);
                IF (saldo_actual > 0)
                THEN
                    SET tiempo = saldo_actual / (tarifa * (1 - descuento));
                    INSERT INTO estacionamientos VALUES (id_tarjeta, id_parq, fecha_actual,hora_actual,NULL,NULL);
                    SELECT 'Apertura' AS Operacion, 'Exito' AS Estado, tiempo AS 'Tiempo(min)';
                ELSE
                    SELECT 'Apertura' AS Operacion, 'Saldo menor o igual a cero' AS Estado, '0' AS 'Tiempo(min)';
                END IF;
            END IF;
        ELSE  
            SELECT 'ERROR: Parquimetro o tarjeta inexistente' AS Resultado;
        END IF;

	 COMMIT;
END; !

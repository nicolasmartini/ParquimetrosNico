#Se crea la base de datos con el nombre Parquimetros
CREATE DATABASE Parquimetros;

#Se usa la base de datos creada previamente
USE Parquimetros;

#----------------------------------------------------------------------------------------------

#Se crean las tablas y las relaciones

create table Conductores(
	dni INT UNSIGNED NOT NULL ,
	nombre VARCHAR(40) NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	direccion VARCHAR(40)NOT NULL,
	telefono  VARCHAR(40) ,
	registro INT UNSIGNED NOT NULL,

	CONSTRAINT pk_Conductores 
	PRIMARY KEY (dni)
	
 ) ENGINE=InnoDB;


create table Automoviles (
	patente VARCHAR(6) NOT NULL,
	marca VARCHAR(40) NOT NULL,
	modelo VARCHAR(40) NOT NULL,
	color VARCHAR(40) NOT NULL,
	dni INT UNSIGNED NOT NULL ,

	CONSTRAINT pk_Automoviles 
	PRIMARY KEY (patente),
 
	CONSTRAINT FK_dni_Automoviles 
	 FOREIGN KEY (dni) REFERENCES Conductores (dni) 
	  ON DELETE RESTRICT ON UPDATE CASCADE
 ) ENGINE=InnoDB;
 

create table Tipos_tarjeta(
	tipo VARCHAR(40) NOT NULL,
	descuento DECIMAL(3,2) UNSIGNED NOT NULL, 
	CONSTRAINT pk_Tipos_Tarjeta 
	PRIMARY KEY (tipo)
  ) ENGINE=InnoDB;
  
create table Tarjetas(
	id_tarjeta INT UNSIGNED AUTO_INCREMENT NOT NULL ,
	saldo DECIMAL(5,2) NOT NULL,
	tipo VARCHAR(40) NOT NULL,
	patente VARCHAR(6) NOT NULL,
  
	CONSTRAINT pk_Tarjeta 
	PRIMARY KEY (id_tarjeta),
 
	CONSTRAINT FK_Tipos_Tarjeta 
	 FOREIGN KEY (tipo) REFERENCES Tipos_tarjeta (tipo) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
   
	CONSTRAINT FK_patente_Automoviles 
	 FOREIGN KEY (patente) REFERENCES Automoviles (patente) 
	  ON DELETE RESTRICT ON UPDATE CASCADE
	  
) ENGINE=InnoDB;
 
create table Inspectores(
	legajo INT UNSIGNED NOT NULL ,
	dni INT UNSIGNED NOT NULL ,
	nombre VARCHAR(40) NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	password CHAR(32) NOT NULL,

	CONSTRAINT pk_Inspectores 
	PRIMARY KEY (legajo)
  
) ENGINE=InnoDB;

create table Ubicaciones(
	calle VARCHAR(40) NOT NULL,
	altura INT UNSIGNED NOT NULL ,
	tarifa  DECIMAL(5,2) UNSIGNED NOT NULL ,

	CONSTRAINT pk_Ubicaciones 
	PRIMARY KEY (calle,altura)	

) ENGINE=InnoDB;



create table Parquimetros (

	id_parq INT UNSIGNED NOT NULL , 
	numero INT UNSIGNED NOT NULL ,
	calle VARCHAR(40) NOT NULL,
	altura INT UNSIGNED NOT NULL ,
	
	CONSTRAINT pk_Parquimetros 
	PRIMARY KEY (id_parq),
	
	CONSTRAINT FK_calle_altura_Parquimetros 
	 FOREIGN KEY (calle,altura) REFERENCES Ubicaciones (calle,altura) 
	  ON DELETE RESTRICT ON UPDATE CASCADE	

) ENGINE=InnoDB;

create table Estacionamientos (
	
	id_tarjeta INT UNSIGNED NOT NULL ,
	id_parq INT UNSIGNED NOT NULL ,
	fecha_ent DATE NOT NULL ,
	hora_ent TIME NOT NULL ,
	fecha_sal DATE ,
	hora_sal TIME ,
	
	CONSTRAINT Pk_Estacionamientos 
	PRIMARY KEY (id_parq,fecha_ent,hora_ent),	
	
	CONSTRAINT FK_idTarjeta_Estacionamientos 
	 FOREIGN KEY (id_tarjeta) REFERENCES Tarjetas (id_tarjeta) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  
	CONSTRAINT FK_IdParq_Estacionamientos 
	 FOREIGN KEY (id_parq) REFERENCES Parquimetros (id_parq) 
	  ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;



create table Accede (

	legajo INT UNSIGNED NOT NULL ,
	id_Parq INT UNSIGNED NOT NULL ,
	fecha DATE NOT NULL ,
	hora TIME NOT NULL ,
	
	CONSTRAINT Pk_Accede 
	PRIMARY KEY (id_parq,fecha,hora),	
	
	CONSTRAINT FK_idParq_Accede 
	 FOREIGN KEY (id_parq) REFERENCES Parquimetros (id_parq)
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  
	CONSTRAINT FK_legajo_Accede 
	 FOREIGN KEY (legajo) REFERENCES Inspectores (legajo) 
	  ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;


create table Asociado_con(

	id_asociado_con INT UNSIGNED AUTO_INCREMENT NOT NULL ,
	legajo INT UNSIGNED NOT NULL ,
	calle VARCHAR(40) NOT NULL,
	altura INT UNSIGNED NOT NULL ,
	dia CHAR(2) NOT NULL, 
	turno CHAR(1) NOT NULL,

	CONSTRAINT Pk_Asociado_con 
	PRIMARY KEY (id_asociado_con),
	
	CONSTRAINT FK_legajo_Asociado_con 
	 FOREIGN KEY (legajo) REFERENCES Inspectores (legajo) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  
	CONSTRAINT FK_calle_altura_Asociado_con 
	 FOREIGN KEY (calle,altura) REFERENCES Ubicaciones (calle,altura) 
	  ON DELETE RESTRICT ON UPDATE CASCADE	  
	
	  
) ENGINE=InnoDB;



create table Multa(

	numero INT UNSIGNED AUTO_INCREMENT NOT NULL ,
	fecha DATE NOT NULL ,
	hora TIME NOT NULL ,
	patente VARCHAR(6) NOT NULL,
	id_asociado_con INT UNSIGNED NOT NULL ,
	
	CONSTRAINT Pk_Multa
	PRIMARY KEY (numero),
	
	CONSTRAINT FK_patente_Multa 
	 FOREIGN KEY (patente) REFERENCES Automoviles (patente) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  
	CONSTRAINT id_asociado_con_Multa 
	 FOREIGN KEY (id_asociado_con) REFERENCES Asociado_con (id_asociado_con) 
	  ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB;

create table Ventas(

	id_tarjeta INT UNSIGNED AUTO_INCREMENT NOT NULL ,
	tipo_tarjeta VARCHAR(40) NOT NULL,
	saldo DECIMAL(5,2) NOT NULL,
	fecha DATE NOT NULL ,
	hora TIME NOT NULL ,
	
	CONSTRAINT Pk_Ventas
	PRIMARY KEY (id_tarjeta,fecha,hora),
	
	CONSTRAINT FK_ventas_idTarjeta 
	 FOREIGN KEY (id_tarjeta) REFERENCES Tarjetas (id_tarjeta) 
	  ON DELETE RESTRICT ON UPDATE CASCADE,
	  
	  	CONSTRAINT FK_ventas_tipoTarjeta 
	 FOREIGN KEY (tipo_tarjeta) REFERENCES Tarjetas (tipo) 
	  ON DELETE RESTRICT ON UPDATE CASCADE	  


) ENGINE=InnoDB;

#----------------------------------------------------------------------------------------------
#Se crea una vista
		
CREATE VIEW Estacionados AS 
   SELECT p.calle, p.altura, t.patente
          
   FROM Estacionamientos as e NATURAL JOIN Parquimetros as p NATURAL JOIN Tarjetas as t 
        
   WHERE e.fecha_sal is NULL and e.hora_sal is NULL;
   
#----------------------------------------------------------------------------------------------
#Procedimiento conectar

DELIMITER !
CREATE PROCEDURE conectar(IN id_tarjeta INTEGER , IN id_parq INTEGER)
BEGIN		

	DECLARE saldo_actual DECIMAL(16,2);
	DECLARE tiemp INT; 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT 'SQLEXCEPTION!, Transacción cancelada' AS Operacion;
		ROLLBACK;
	END;
	START TRANSACTION;
	
	IF EXISTS (SELECT * FROM tarjetas AS T WHERE T.id_tarjeta = id_tarjeta) THEN
		IF EXISTS (SELECT * FROM parquimetros AS P WHERE P.id_parq = id_parq) THEN	   
			
			IF EXISTS (SELECT * FROM estacionamientos AS E WHERE E.id_parq = id_parq AND E.id_tarjeta = id_tarjeta AND E.fecha_sal IS NULL AND E.hora_sal IS NULL)  THEN
			    
				CALL calcularTiempoCierre((SELECT fecha_ent FROM estacionamientos AS E WHERE  E.id_parq = id_parq AND E.id_tarjeta = id_tarjeta AND E.fecha_sal IS NULL AND E.hora_sal IS NULL),(SELECT hora_ent FROM estacionamientos AS E WHERE  E.id_parq = id_parq AND E.id_tarjeta = id_tarjeta AND E.fecha_sal IS NULL AND E.hora_sal IS NULL),tiemp);				 
				CALL calcularSaldo((SELECT saldo FROM tarjetas AS T WHERE T.id_tarjeta = id_tarjeta),tiemp,(SELECT tarifa FROM ubicaciones NATURAL JOIN parquimetros AS P WHERE P.id_parq = id_parq),(SELECT descuento FROM tarjetas AS T NATURAL JOIN tipos_tarjeta WHERE T.id_tarjeta = id_tarjeta),saldo_actual);
				UPDATE Estacionamientos E SET fecha_sal = CURDATE(),hora_sal =CURTIME() WHERE E.id_parq = id_parq AND E.id_tarjeta = id_tarjeta;
				UPDATE Tarjetas AS T SET saldo = saldo_actual WHERE T.id_tarjeta = id_tarjeta ; 
				SELECT 'CIERRE' AS Operacion, tiemp AS Tiempo,saldo_actual AS Saldo ;
					
			ELSE IF	EXISTS ( SELECT saldo AS saldo_actual FROM tarjetas AS T WHERE T.id_tarjeta = id_tarjeta AND T.saldo >0 ) THEN 				
					#No esta estacionado, corresponde abrir
					INSERT INTO estacionamientos (id_tarjeta,id_parq,fecha_ent,hora_ent,fecha_sal,hora_sal) VALUES (id_tarjeta,id_parq,CURDATE(),CURTIME(),NULL,NULL);
					CALL calcularTiempoApertura((SELECT saldo FROM tarjetas AS T WHERE T.id_tarjeta = id_tarjeta),(SELECT tarifa FROM ubicaciones NATURAL JOIN parquimetros AS P WHERE P.id_parq = id_parq),(SELECT descuento FROM tarjetas AS T NATURAL JOIN tipos_tarjeta WHERE T.id_tarjeta = id_tarjeta),tiemp);
					SELECT 'APERTURA' AS Operacion, 'EXITO' AS Resultado, tiemp AS Tiempo ;
				ELSE
					SELECT 'Error saldo insuficiente' AS Operacion;				
				END IF;		
			END IF;
		ELSE
			SELECT 'Error el parquimetro no existe' AS Operacion;
		END IF;
	ELSE
		SELECT 'Error la tarjeta no existe' AS Operacion;
	END IF;
COMMIT;
END; !

CREATE PROCEDURE calcularSaldo(IN saldo DECIMAL(16,2), IN tiempo INT, IN tarifa DECIMAL(16,2), IN descuento DECIMAL(16,2),OUT s DECIMAL(16,2) )
BEGIN
    
    SET s = saldo - (tiempo * tarifa * (1-descuento)) ;

END;!	
	

CREATE PROCEDURE calcularTiempoApertura(IN saldo DECIMAL(16,2), IN tarifa DECIMAL(16,2), IN descuento DECIMAL(16,2), OUT tiempo DECIMAL(16,2) )
BEGIN

	IF (tarifa > 0) THEN 		
		SET tiempo = saldo / (tarifa * (1-descuento));		
	ELSE
		SELECT 'Error no existe valor de tarifa;' AS Operacion;
	END IF;

END;!	


CREATE PROCEDURE calcularTiempoCierre(IN fecha_apertura DATE, IN hora_apertura TIME, OUT tiempo INT)
BEGIN

    SET tiempo = TIMESTAMPDIFF(MINUTE,TIMESTAMP(fecha_apertura,hora_apertura),TIMESTAMP(CURDATE(),CURTIME())); 
END;!
#----------------------------------------------------------------------------------------------
#Trigger de ventas

CREATE TRIGGER guardarVentas
AFTER INSERT ON Tarjetas
FOR EACH ROW
BEGIN
INSERT INTO Ventas (id_tarjeta,tipo_tarjeta,saldo,fecha,hora) VALUES (NEW.id_tarjeta,NEW.tipo,NEW.saldo,CURDATE(),CURTIME());
END;!

#----------------------------------------------------------------------------------------------
#Se crean los usuarios y se le otorgan los privelegios

#Administrador con todos los privelegios.
DELIMITER ; 
GRANT ALL PRIVILEGES ON Parquimetros.* TO admin@localhost 
    IDENTIFIED BY 'admin' WITH GRANT OPTION;

#Usuario venta que tiene privelegios minimos.    
GRANT SELECT,INSERT  ON Parquimetros.Tarjetas TO 'venta'@'%' IDENTIFIED BY 'venta';
GRANT SELECT ON Parquimetros.Tipos_tarjeta TO 'venta'@'%';
GRANT SELECT ON Parquimetros.Automoviles TO 'venta'@'%';

#Usuario inspector que tiene privelegios minimos.

GRANT SELECT ON Parquimetros.Estacionados TO 'inspector'@'%' IDENTIFIED BY 'inspector';
GRANT SELECT,INSERT ON Parquimetros.Multa TO 'inspector'@'%';
GRANT SELECT,INSERT ON Parquimetros.Accede TO 'inspector'@'%';
GRANT SELECT ON Parquimetros.Inspectores TO 'inspector'@'%';
GRANT SELECT ON Parquimetros.Parquimetros TO 'inspector'@'%';
GRANT SELECT ON Parquimetros.Asociado_con TO 'inspector'@'%';
GRANT SELECT ON Parquimetros.Ubicaciones TO 'inspector'@'%';

#Usuario parquimetro que tiene privelegios minimos.
GRANT EXECUTE ON PROCEDURE Parquimetros.conectar TO 'parquimetro'@'%' IDENTIFIED BY 'parq';
GRANT SELECT ON Parquimetros.Ubicaciones TO 'parquimetro'@'%';
GRANT SELECT ON Parquimetros.Tarjetas TO 'parquimetro'@'%';
GRANT SELECT ON Parquimetros.Parquimetros TO 'parquimetro'@'%';
GRANT UPDATE ON Parquimetros.Estacionamientos TO 'parquimetro'@'%';
GRANT UPDATE ON Parquimetros.Tarjetas TO 'parquimetro'@'%';






	


	
  

 
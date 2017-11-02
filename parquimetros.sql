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

#----------------------------------------------------------------------------------------------
#Se crea una vista
		
CREATE VIEW Estacionados AS 
   SELECT p.calle, p.altura, t.patente
          
   FROM Estacionamientos as e NATURAL JOIN Parquimetros as p NATURAL JOIN Tarjetas as t 
        
   WHERE e.fecha_sal is NULL and e.hora_sal is NULL;
   
#----------------------------------------------------------------------------------------------
#Se crean los usuarios y se le otorgan los privelegios

#Administrador con todos los privelegios. 
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






	


	
  

 
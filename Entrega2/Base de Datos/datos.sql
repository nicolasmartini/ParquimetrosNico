#Se insertan datos a la tabla Conductores
INSERT INTO Conductores VALUES(35244406,"Nicolas","Martini","Bravard 583",NULL,90542);
INSERT INTO Conductores VALUES(36329749,"Lisandro","Laurent","Roca 93","4541168",97542);
INSERT INTO Conductores VALUES(39235406,"Pepito","Sanchez","Juan Molina 1024","4303286",100542);
INSERT INTO Conductores VALUES(50235467,"Zulma","Lobato","Patricios 678","4543221",89542);
INSERT INTO Conductores VALUES(45678932,"Patrick","Huenchul","Estomba 32",NULL,12323);
INSERT INTO Conductores VALUES(85678932,"Miriam","Larriera","Vieytes 453","445676",97456);
INSERT INTO Conductores VALUES(16968432,"Gustavo","Zapata","Sarmiento 123",NULL,67455);
INSERT INTO Conductores VALUES(67456345,"Francisco","Colegas","Chanchay 74","4558967",100542);
INSERT INTO Conductores VALUES(45678234,"Leticia","Aguirre","Blandengues 231",NULL,100542);
INSERT INTO Conductores VALUES(90765899,"Nicolas","Tunessi","Castelli 657","4538999",4536542);

#Se insertan datos a la tabla Automoviles
INSERT INTO Automoviles VALUES("LIL345","Peugeot","1994","Verde",90765899);
INSERT INTO Automoviles VALUES("SXV456","VMW","2014","Negro",35244406);
INSERT INTO Automoviles VALUES("SML123","Audi","2014","Gris",36329749);
INSERT INTO Automoviles VALUES("AQP678","Fiat","2000","Blanco",39235406);
INSERT INTO Automoviles VALUES("SMF123","Audi","2012","Gris",50235467);
INSERT INTO Automoviles VALUES("AQG678","Fiat","1998","Blanco",45678932);
INSERT INTO Automoviles VALUES("RMB123","Audi","2014","Gris",85678932);
INSERT INTO Automoviles VALUES("AQD678","Fiat","1998","Blanco",16968432);
INSERT INTO Automoviles VALUES("SYO123","Citroen","2014","Negro",67456345);
INSERT INTO Automoviles VALUES("WTP123","Ford","2014","Azul",45678234);

#Se insertan datos a la tabla Tipos_tarjeta
INSERT INTO Tipos_tarjeta VALUES("Jubilado",0.15);
INSERT INTO Tipos_tarjeta VALUES("Discapacitado",0.20);
INSERT INTO Tipos_tarjeta VALUES("Estudiante",0.05);

#Se insertan datos a la tabla Tarjeta
INSERT INTO Tarjetas VALUES(0001,001.50,"Jubilado","LIL345");
INSERT INTO Tarjetas VALUES(0002,020.00,"Estudiante","SXV456");
INSERT INTO Tarjetas VALUES(0003,020.00,"Jubilado","SML123");
INSERT INTO Tarjetas VALUES(0004,020.00,"Discapacitado","AQP678");
INSERT INTO Tarjetas VALUES(0005,180.00,"Jubilado","SMF123");
INSERT INTO Tarjetas VALUES(0006,220.00,"Discapacitado","AQG678");
INSERT INTO Tarjetas VALUES(0007,050.50,"Jubilado","RMB123");
INSERT INTO Tarjetas VALUES(0008,180.00,"Jubilado","AQD678");
INSERT INTO Tarjetas VALUES(0009,220.00,"Discapacitado","SYO123");
INSERT INTO Tarjetas VALUES(0010,050.50,"Estudiante","WTP123");

#Se insertan datos a la tabla Inspectores
INSERT INTO Inspectores VALUES (98244, 154182544, "Luis", "Gonzales",md5("1234"));
INSERT INTO Inspectores VALUES (94124, 156902312, "Roberto", "Piermarocchi",md5("1234"));
INSERT INTO Inspectores VALUES (75521, 155982731, "Juan", "Torroba",md5("1234"));
INSERT INTO Inspectores VALUES (68322, 154982031, "Walter", "Barbagelata",md5("1234"));
INSERT INTO Inspectores VALUES (58231, 156098291, "Sergio", "Gomez",md5("1234"));
INSERT INTO Inspectores VALUES (75284, 154809213, "Alejandro", "Napoli",md5("1234"));
INSERT INTO Inspectores VALUES (54274, 155098203, "Adriana", "Castanio",md5("1234"));
INSERT INTO Inspectores VALUES (58812, 154182666, "Sonia", "Ballesteros",md5("1234"));
INSERT INTO Inspectores VALUES (47241, 155631289, "Gustavo", "Agenta",md5("1234"));
INSERT INTO Inspectores VALUES (78234, 156871211, "Carlos", "Perez",md5("1234"));

#Se insertan datos a la tabla Ubicaciones
INSERT INTO Ubicaciones VALUES ("Sarmiento", 583, 103.44);
INSERT INTO Ubicaciones VALUES ("Sarmiento", 844, 102.45);
INSERT INTO Ubicaciones VALUES ("Estomba", 433, 102.42);
INSERT INTO Ubicaciones VALUES ("Estomba", 782 , 102.44);
INSERT INTO Ubicaciones VALUES ("Chiclana", 1289, 103.35);
INSERT INTO Ubicaciones VALUES ("Chiclana", 1002, 103.46);
INSERT INTO Ubicaciones VALUES ("Donado", 583, 103.44);
INSERT INTO Ubicaciones VALUES ("Donado", 1423, 105.32);
INSERT INTO Ubicaciones VALUES ("Beruti", 1823, 103.44);
INSERT INTO Ubicaciones VALUES ("Beruti", 1724, 103.66);
INSERT INTO Ubicaciones VALUES ("Colon", 1832, 103.44);
INSERT INTO Ubicaciones VALUES ("Colon", 1932, 103.55);

#Se insertan datos a la tabla Parquimetros
INSERT INTO Parquimetros VALUES (1,2,"Sarmiento", 583);
INSERT INTO Parquimetros VALUES (2,4,"Sarmiento", 844);
INSERT INTO Parquimetros VALUES (3,6,"Estomba", 433);
INSERT INTO Parquimetros VALUES (4,8,"Estomba", 782);
INSERT INTO Parquimetros VALUES (5,10,"Chiclana", 1289);
INSERT INTO Parquimetros VALUES (6,12,"Chiclana", 1002);
INSERT INTO Parquimetros VALUES (7,14,"Donado", 583);
INSERT INTO Parquimetros VALUES (8,16,"Donado", 1423);
INSERT INTO Parquimetros VALUES (9,18,"Beruti", 1823);
INSERT INTO Parquimetros VALUES (10,20,"Beruti", 1724);
INSERT INTO Parquimetros VALUES (11,22,"Colon", 1832);
INSERT INTO Parquimetros VALUES (12,24,"Colon", 1932);

#Se insertan datos a la tabla Estacionamientos
INSERT INTO Estacionamientos VALUES (0001,1,'2014:03:12','13:32:45',NULL,NULL);
INSERT INTO Estacionamientos VALUES (0002,2,'2014:03:20','13:32:45','2014:03:20','18:40:00');
INSERT INTO Estacionamientos VALUES (0003,3,'2014:04:27','09:30:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (0004,4,'2014:05:02','07:32:32',NULL,NULL);
INSERT INTO Estacionamientos VALUES (0005,5,'2014:05:05','18:40:00','2014:05:05','20:30:00');
INSERT INTO Estacionamientos VALUES (0006,6,'2014:05:05','18:42:45','2014:05:05','22:15:03');
INSERT INTO Estacionamientos VALUES (0007,7,'2014:06:20','09:30:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (0008,8,'2014:07:06','18:40:00',NULL,NULL);
INSERT INTO Estacionamientos VALUES (0009,9,'2014:07:19','18:40:00','2014:07:20','09:22:01');
INSERT INTO Estacionamientos VALUES (0010,10,'2014:08:03','10:15:05',NULL,NULL);

#Se insertan datos a la tabla Asociado_con
INSERT INTO Asociado_con VALUES (1,98244, "Sarmiento", 844, 'Lu', 'M');
INSERT INTO Asociado_con VALUES (2,94124, "Estomba", 433, 'Ma', 'M');
INSERT INTO Asociado_con VALUES (3,75521, "Estomba", 782, 'Mi', 'M');
INSERT INTO Asociado_con VALUES (4,68322, "Estomba", 782, 'Ju', 'M');
INSERT INTO Asociado_con VALUES (5,58231, "Chiclana", 1289, 'Vi', 'M');
INSERT INTO Asociado_con VALUES (6,75284, "Chiclana", 1002, 'Lu', 'T');
INSERT INTO Asociado_con VALUES (7,54274, "Donado", 583, 'Ma', 'T');
INSERT INTO Asociado_con VALUES (8,58812, "Donado", 1423, 'Mi', 'T');
INSERT INTO Asociado_con VALUES (9,47241, "Beruti", 1823, 'Ju', 'T');
INSERT INTO Asociado_con VALUES (10,78234, "Beruti", 1724, 'Vi', 'T');

#Se insertan datos a la tabla Multa
INSERT INTO Multa VALUES (1,'2014:03:12','13:32:45',"LIL345",1);
INSERT INTO Multa VALUES (2,'2014:04:10','16:30:50',"SXV456",2);
INSERT INTO Multa VALUES (3,'2014:04:12','16:32:03',"SML123",3);
INSERT INTO Multa VALUES (4,'2014:05:05','09:40:55',"AQP678",4);
INSERT INTO Multa VALUES (5,'2014:05:20','13:19:02',"SMF123",5);
INSERT INTO Multa VALUES (6,'2014:07:24','12:12:30',"AQG678",6);
INSERT INTO Multa VALUES (7,'2014:07:24','18:00:00',"RMB123",7);
INSERT INTO Multa VALUES (8,'2014:08:03','08:10:45',"AQD678",8);
INSERT INTO Multa VALUES (9,'2014:08:07','09:32:03',"SYO123",9);
INSERT INTO Multa VALUES (10,'2014:09:02','13:32:12',"WTP123",10);

#Se insertan datos a la tabla Accede
INSERT INTO Accede VALUES (98244,1, '2014:01:13', '15:00:00');
INSERT INTO Accede VALUES (94124,2, '2014:01:13', '14:23:23');
INSERT INTO Accede VALUES (75521, 3, '2014:01:13', '15:44:20');
INSERT INTO Accede VALUES (68322, 4, '2014:01:13', '16:11:57');
INSERT INTO Accede VALUES (58231, 5, '2014:01:13', '15:35:32');
INSERT INTO Accede VALUES (75284, 12, '2014:01:13', '17:22:32');
INSERT INTO Accede VALUES (54274, 8, '2014:01:13', '16:52:44');
INSERT INTO Accede VALUES (58812, 9, '2014:01:13', '20:00:25');
INSERT INTO Accede VALUES (47241, 7, '2014:01:13', '09:41:28');
INSERT INTO Accede VALUES (78234, 10, '2014:01:13', '10:23:37');





















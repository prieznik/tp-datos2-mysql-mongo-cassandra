-- keyspace 
CREATE KEYSPACE IF NOT EXISTS agencia WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

DESCRIBE KEYSPACES;

USE agencia;

-- CONSULTA 9 
CREATE TABLE recorrido_micro (
    patente text,
    fecha date,
    fyh timestamp,
    latitud decimal,
    longitud decimal,
    velocidad_kmh int,
    PRIMARY KEY ((patente, fecha), fyh)
) WITH CLUSTERING ORDER BY (fyh DESC);

INSERT INTO recorrido_micro (patente, fecha, fyh, latitud, longitud, velocidad_kmh) VALUES ('A1B2', '2026-11-11', '2026-11-11 09:00:00', 28.3772, -81.5707, 0);
INSERT INTO recorrido_micro (patente, fecha, fyh, latitud, longitud, velocidad_kmh) VALUES ('A1B2', '2026-11-11', '2026-11-11 09:00:15', 28.3780, -81.5712, 25);
INSERT INTO recorrido_micro (patente, fecha, fyh, latitud, longitud, velocidad_kmh) VALUES ('A1B2', '2026-11-11', '2026-11-11 09:00:30', 28.3791, -81.5720, 40);
INSERT INTO recorrido_micro (patente, fecha, fyh, latitud, longitud, velocidad_kmh) VALUES ('A1B2', '2026-11-10', '2026-11-10 09:00:00', 28.3772, -81.5707, 0);
INSERT INTO recorrido_micro (patente, fecha, fyh, latitud, longitud, velocidad_kmh) VALUES ('C3D4', '2026-11-11', '2026-11-11 09:00:00', 28.4177, -81.5812, 0);

SELECT * FROM recorrido_micro;

/*
Resultado:
 patente | fecha      | fyh                             | latitud | longitud | velocidad_kmh
---------+------------+---------------------------------+---------+----------+---------------
    C3D4 | 2026-11-11 | 2026-11-11 09:00:00.000000+0000 | 28.4177 | -81.5812 |             0
    A1B2 | 2026-11-10 | 2026-11-10 09:00:00.000000+0000 | 28.3772 | -81.5707 |             0
    A1B2 | 2026-11-11 | 2026-11-11 09:00:30.000000+0000 | 28.3791 | -81.5720 |            40
    A1B2 | 2026-11-11 | 2026-11-11 09:00:15.000000+0000 | 28.3780 | -81.5712 |            25
    A1B2 | 2026-11-11 | 2026-11-11 09:00:00.000000+0000 | 28.3772 | -81.5707 |             0
(5 rows)
*/

-- Consulta 9
SELECT fyh, latitud, longitud, velocidad_kmh FROM recorrido_micro WHERE patente = 'A1B2' AND fecha = '2026-11-11';

/*
Resultado:
 fyh                             | latitud | longitud | velocidad_kmh
---------------------------------+---------+----------+---------------
 2026-11-11 09:00:30.000000+0000 | 28.3791 | -81.5720 |            40
 2026-11-11 09:00:15.000000+0000 | 28.3780 | -81.5712 |            25
 2026-11-11 09:00:00.000000+0000 | 28.3772 | -81.5707 |             0
(3 rows)
*/

-- Token (A1B2, 2026-11-11)
SELECT token(patente, fecha) FROM recorrido_micro WHERE patente = 'A1B2' AND fecha = '2026-11-11';

/*
Resultado:
 system.token(patente, fecha)
------------------------------
          8125047671528697231
          8125047671528697231
          8125047671528697231
(3 rows)
*/

-- CONSULTA 10
CREATE TABLE tiempos_espera (
    codigo_atraccion int,
    fecha date,
    hora time,
    minutos_espera int,
    PRIMARY KEY ((codigo_atraccion, fecha), hora)
) WITH CLUSTERING ORDER BY (hora ASC);

INSERT INTO tiempos_espera (codigo_atraccion, fecha, hora, minutos_espera) VALUES (2233, '2026-11-11', '11:00:00', 45);
INSERT INTO tiempos_espera (codigo_atraccion, fecha, hora, minutos_espera) VALUES (2233, '2026-11-11', '10:50:00', 30);
INSERT INTO tiempos_espera (codigo_atraccion, fecha, hora, minutos_espera) VALUES (2233, '2026-11-11', '10:55:00', 35);
INSERT INTO tiempos_espera (codigo_atraccion, fecha, hora, minutos_espera) VALUES (2233, '2026-11-10', '10:50:00', 20);

SELECT * FROM tiempos_espera;

/*
Resultado:
 codigo_atraccion | fecha      | hora               | minutos_espera
------------------+------------+--------------------+----------------
             2233 | 2026-11-10 | 10:50:00.000000000 |             20
             2233 | 2026-11-11 | 10:50:00.000000000 |             30
             2233 | 2026-11-11 | 10:55:00.000000000 |             35
             2233 | 2026-11-11 | 11:00:00.000000000 |             45
(4 rows)
*/

SELECT hora, minutos_espera FROM tiempos_espera WHERE codigo_atraccion = 2233 AND fecha = '2026-11-11';

/*
Resultado:
 hora               | minutos_espera
--------------------+----------------
 10:50:00.000000000 |             30
 10:55:00.000000000 |             35
 11:00:00.000000000 |             45
(3 rows)
*/

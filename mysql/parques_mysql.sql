CREATE DATABASE agencia;
USE agencia;

-- CONSULTA 1
CREATE TABLE hoteles (
    codigo_h INT PRIMARY KEY,
    nombre_h VARCHAR(50) NOT NULL,
    direccion_h VARCHAR(100) NOT NULL,
    estrellas INT NOT NULL
);

CREATE TABLE parques (
    codigo_p INT PRIMARY KEY,
    nombre_p VARCHAR(50) NOT NULL,
    horario_apertura TIME NOT NULL,
    horario_cierre TIME NOT NULL
);

CREATE TABLE micros (
    patente VARCHAR(10) PRIMARY KEY,           
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    asientos INT NOT NULL
);

CREATE TABLE pasajeros (
    pasaporte VARCHAR(20) PRIMARY KEY,         
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    codigo_h INT NOT NULL,
    FOREIGN KEY (codigo_h) REFERENCES hoteles(codigo_h)
);

CREATE TABLE traslados (
    codigo_T INT PRIMARY KEY,
    patente VARCHAR(10) NOT NULL,              
    codigo_h INT NOT NULL,
    codigo_p INT NOT NULL,
    fecha_y_h DATETIME NOT NULL,               
    FOREIGN KEY (patente) REFERENCES micros(patente),
    FOREIGN KEY (codigo_h) REFERENCES hoteles(codigo_h),
    FOREIGN KEY (codigo_p) REFERENCES parques(codigo_p)
);

CREATE TABLE reservas (
    pasaporte VARCHAR(20),                     
    codigo_T INT,
    numero_asiento INT NOT NULL,
    fecha_reserva DATE NOT NULL,               
    PRIMARY KEY (pasaporte, codigo_T),        
    UNIQUE (codigo_T, numero_asiento),        
    FOREIGN KEY (pasaporte) REFERENCES pasajeros(pasaporte),
    FOREIGN KEY (codigo_T) REFERENCES traslados(codigo_T)
);

SHOw TABLES;

INSERT INTO hoteles (codigo_h, nombre_h, direccion_h, estrellas) VALUES
    (1, 'Mickey', 'Orlando 123', 5),
    (2, 'Pluto', 'Orlando 456', 4);

INSERT INTO parques (codigo_p, nombre_p, horario_apertura, horario_cierre) VALUES
    (1, 'Magic Kingdom', '09:00:00', '23:00:00'),
    (2, 'EPCOT', '10:00:00', '22:00:00');

INSERT INTO micros (patente, marca, modelo, asientos) VALUES
    ('A1B2', 'Mercedes', 'Gold', 50),
    ('C3D4', 'Mercedes', 'Gold', 50);

INSERT INTO pasajeros (pasaporte, nombre, apellido, correo, fecha_nacimiento, codigo_h) VALUES
    ('AA11', 'Paloma', 'Rieznik', 'paloma@mail.com', '2003-11-11', 1),
    ('BB22', 'Pablo', 'Sabatino', 'pablo@mail.com', '1985-08-02', 2),
    ('CC33', 'Tomás', 'Álvarez', 'tomas@mail.com', '1999-04-15', 1);

INSERT INTO traslados (codigo_T, patente, codigo_h, codigo_p, fecha_y_h) VALUES
    (10, 'A1B2', 1, 2, '2026-11-11 09:00:00'),
    (15, 'A1B2', 1, 2, '2026-11-11 15:00:00'),
    (13, 'C3D4', 2, 1, '2026-11-21 09:00:00');
    
SELECT * FROM hoteles;
SELECT * FROM parques;
SELECT * FROM micros;
SELECT * FROM pasajeros;
SELECT * FROM traslados;

-- CONSULTA 2 
INSERT INTO reservas (pasaporte, codigo_T, numero_asiento, fecha_reserva) VALUES
    ('BB22', 10, 30, '2026-11-05'),
    ('AA11', 10, 32, '2026-11-06'),
    ('CC33', 10, 5,  '2026-11-07'),
    ('AA11', 13, 32, '2026-11-08');

SELECT * FROM reservas;

-- Prueba 1: el mismo pasajero no puede reservar dos veces en el mismo traslado (falla por la PK)
INSERT INTO reservas VALUES ('AA11', 10, 40, '2026-11-09');

-- Prueba 2: el mismo asiento no puede reservarse dos veces en el mismo traslado (falla por el UNIQUE)
INSERT INTO reservas VALUES ('BB22', 13, 32, '2026-11-09');

-- Prueba 3: no se puede reservar con un pasaporte que no existe (falla por la FK)
INSERT INTO reservas VALUES ('ZZ99', 10, 12, '2026-11-09');

-- CONSULTA 3
SELECT codigo_T, COUNT(*) AS asientos_reservados
FROM reservas
WHERE codigo_T = 10
GROUP BY codigo_T;

-- CONSULTA 4 
SELECT p.pasaporte, p.nombre, p.apellido, r.numero_asiento
FROM reservas AS r
INNER JOIN pasajeros AS p
    ON r.pasaporte = p.pasaporte
WHERE r.codigo_T = 10
ORDER BY r.numero_asiento;

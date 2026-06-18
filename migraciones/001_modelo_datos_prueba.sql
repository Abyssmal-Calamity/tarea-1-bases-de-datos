SET search_path TO test;

INSERT INTO pelicula (titulo, duracion_min) VALUES
('Avengers', 120),
('Batman', 110),
('Spiderman', 100);

INSERT INTO sala (nombre, capacidad) VALUES
('Sala 1', 10),
('Sala 2', 8);

-- Asientos
INSERT INTO asiento (sala_id, fila, numero)
SELECT 1, 'A', generate_series(1,10);

INSERT INTO asiento (sala_id, fila, numero)
SELECT 2, 'A', generate_series(1,8);

-- Funciones
INSERT INTO funcion (pelicula_id, sala_id, fecha, hora) VALUES
(1,1,'2026-06-20','18:00'),
(2,1,'2026-06-20','21:00'),
(3,2,'2026-06-20','19:00');

-- Clientes
INSERT INTO cliente (nombre, rut, email) VALUES
('Juan','12345678-5','juan@mail.com'),
('Ana','87654321-4','ana@mail.com');

-- Entradas
INSERT INTO entrada (funcion_id, asiento_id, cliente_id, precio) VALUES
(1,1,1,5000),
(1,2,2,5000),
(2,3,1,5000),
(3,4,2,5000);

INSERT INTO schema_migrations VALUES ('001_modelo_datos_prueba');



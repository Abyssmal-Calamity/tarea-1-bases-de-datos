CREATE SCHEMA IF NOT EXISTS cine;
SET search_path TO cine;

CREATE TABLE schema_migrations (
    version TEXT PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT now()
);

-- Películas
CREATE TABLE IF NOT EXISTS pelicula (
    pelicula_id SERIAL PRIMARY KEY,
    titulo TEXT NOT NULL,
    duracion_min INT NOT NULL
);

-- Salas
CREATE TABLE IF NOT EXISTS sala (
    sala_id SERIAL PRIMARY KEY,
    nombre TEXT,
    capacidad INT NOT NULL
);

-- Asientos (por sala)
CREATE TABLE IF NOT EXISTS asiento (
    asiento_id SERIAL PRIMARY KEY,
    sala_id INT REFERENCES sala(sala_id),
    fila CHAR(1),
    numero INT
);

-- Funciones
CREATE TABLE IF NOT EXISTS funcion (
    funcion_id SERIAL PRIMARY KEY,
    pelicula_id INT REFERENCES pelicula(pelicula_id),
    sala_id INT REFERENCES sala(sala_id),
    fecha DATE,
    hora TIME
);

-- Clientes
CREATE TABLE IF NOT EXISTS cliente (
    cliente_id SERIAL PRIMARY KEY,
    nombre TEXT,
    rut TEXT,
    email TEXT
);

-- Entradas
CREATE TABLE IF NOT EXISTS entrada (
    entrada_id SERIAL PRIMARY KEY,
    funcion_id INT REFERENCES funcion(funcion_id),
    asiento_id INT REFERENCES asiento(asiento_id),
    cliente_id INT REFERENCES cliente(cliente_id),
    precio INT
);

INSERT INTO schema_migrations VALUES ('000_modelo_inicial');
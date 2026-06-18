SET search_path TO cine;

CREATE UNIQUE INDEX IF NOT EXISTS unique_asiento_funcion
ON entrada(funcion_id, asiento_id);

INSERT INTO schema_migrations VALUES ('004_unique_asiento');
SET search_path TO cine;

CREATE OR REPLACE FUNCTION evitar_solapamiento()
RETURNS TRIGGER AS '
BEGIN
    IF EXISTS (
        SELECT 1
        FROM funcion f
        JOIN pelicula p ON f.pelicula_id = p.pelicula_id
        WHERE f.sala_id = NEW.sala_id
        AND f.fecha = NEW.fecha
        AND NEW.hora BETWEEN f.hora 
        AND f.hora + (p.duracion_min || '' minutes'')::interval
    ) THEN
        RAISE EXCEPTION ''Función solapada'';
    END IF;

    RETURN NEW;
END;
' LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_solapamiento ON funcion;

CREATE TRIGGER trg_solapamiento
BEFORE INSERT ON funcion
FOR EACH ROW EXECUTE FUNCTION evitar_solapamiento();

INSERT INTO schema_migrations VALUES ('003_trigger_solapamiento');

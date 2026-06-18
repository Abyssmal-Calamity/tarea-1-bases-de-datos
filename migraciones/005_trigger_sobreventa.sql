SET search_path TO cine;

CREATE OR REPLACE FUNCTION evitar_sobreventa()
RETURNS TRIGGER AS '
DECLARE
    total INT;
    cap INT;
BEGIN
    SELECT COUNT(*) INTO total 
    FROM entrada 
    WHERE funcion_id = NEW.funcion_id;

    SELECT capacidad INTO cap
    FROM sala s
    JOIN funcion f ON f.sala_id = s.sala_id
    WHERE f.funcion_id = NEW.funcion_id;

    IF total >= cap THEN
        RAISE EXCEPTION ''Sala llena'';
    END IF;

    RETURN NEW;
END;
' LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sobreventa ON entrada;

CREATE TRIGGER trg_sobreventa
BEFORE INSERT ON entrada
FOR EACH ROW EXECUTE FUNCTION evitar_sobreventa();

INSERT INTO schema_migrations VALUES ('005_trigger_sobreventa');

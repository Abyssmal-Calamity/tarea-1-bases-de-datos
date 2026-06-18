SET search_path TO cine;

CREATE OR REPLACE FUNCTION validar_rut() RETURNS TRIGGER AS '
DECLARE
    rut_num TEXT;
BEGIN
    -- Se usan dos comillas simples para escapar el patrón y modificadores
    rut_num := regexp_replace(NEW.rut, ''[^0-9kK]'', '''', ''g'');

    IF length(rut_num) < 2 THEN
        RAISE EXCEPTION ''RUT inválido'';
    END IF;

    RETURN NEW;
END;
' LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_rut ON cliente;

CREATE TRIGGER trg_rut
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW EXECUTE FUNCTION validar_rut();

INSERT INTO schema_migrations VALUES ('002_trigger_rut');

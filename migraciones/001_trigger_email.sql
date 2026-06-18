SET search_path TO cine;

CREATE OR REPLACE FUNCTION validar_email() RETURNS TRIGGER AS '
BEGIN
    IF NEW.email !~ ''^[^@]+@[^@]+\.[^@]+$'' THEN
        RAISE EXCEPTION ''Email inválido'';
    END IF;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_email ON cliente;

CREATE TRIGGER trg_email
BEFORE INSERT OR UPDATE ON cliente
FOR EACH ROW EXECUTE FUNCTION validar_email();

INSERT INTO schema_migrations VALUES ('001_trigger_email');
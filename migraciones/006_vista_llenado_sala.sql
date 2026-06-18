SET search_path TO cine;

CREATE OR REPLACE VIEW vista_llenado_sala AS
SELECT 
    s.sala_id,
    s.nombre,
    s.capacidad,
    COUNT(e.entrada_id)::float / 
    (s.capacidad * COUNT(DISTINCT f.funcion_id)) * 100 AS porcentaje_llenado
FROM sala s
LEFT JOIN funcion f USING (sala_id)
LEFT JOIN entrada e USING (funcion_id)
GROUP BY s.sala_id;

INSERT INTO schema_migrations VALUES ('006_vista_llenado_sala');
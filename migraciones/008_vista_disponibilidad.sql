SET search_path TO cine;

CREATE OR REPLACE VIEW vista_disponibilidad_funcion AS
SELECT 
    f.funcion_id,
    COUNT(a.asiento_id) - COUNT(e.entrada_id) AS disponibles,
    COUNT(e.entrada_id) AS vendidos,
    COALESCE(SUM(e.precio),0) AS recaudado
FROM funcion f
JOIN sala s USING (sala_id)
JOIN asiento a USING (sala_id)
LEFT JOIN entrada e 
ON e.asiento_id = a.asiento_id 
AND e.funcion_id = f.funcion_id
GROUP BY f.funcion_id;

INSERT INTO schema_migrations VALUES ('008_vista_disponibilidad');
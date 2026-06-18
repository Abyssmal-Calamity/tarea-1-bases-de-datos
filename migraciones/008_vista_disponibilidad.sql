SET search_path TO cine;

CREATE OR REPLACE VIEW vista_disponibilidad_funcion AS
SELECT 
    f.funcion_id,

    -- capacidad total
    s.capacidad 
    - COALESCE(v.vendidos, 0) AS disponibles,

    COALESCE(v.vendidos, 0) AS vendidos,

    COALESCE(v.recaudado, 0) AS recaudado

FROM funcion f
JOIN sala s USING (sala_id)

-- subconsulta de ventas (CLAVE)
LEFT JOIN (
    SELECT 
        funcion_id,
        COUNT(*) AS vendidos,
        SUM(precio) AS recaudado
    FROM entrada
    GROUP BY funcion_id
) v ON v.funcion_id = f.funcion_id;

INSERT INTO schema_migrations VALUES ('006_vista_disponibilidad');
COMMIT;

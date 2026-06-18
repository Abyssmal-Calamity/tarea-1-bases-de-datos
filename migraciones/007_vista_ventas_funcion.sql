SET search_path TO cine;

CREATE OR REPLACE VIEW vista_ventas_funcion AS
SELECT 
    f.funcion_id,
    p.titulo,
    s.nombre,
    f.fecha,
    f.hora,
    SUM(e.precio) AS total,
    SUM(e.precio) * 100.0 / 
    SUM(SUM(e.precio)) OVER (PARTITION BY f.fecha) AS porcentaje_dia
FROM funcion f
JOIN pelicula p USING (pelicula_id)
JOIN sala s USING (sala_id)
LEFT JOIN entrada e USING (funcion_id)
GROUP BY f.funcion_id, p.titulo, s.nombre, f.fecha, f.hora;

INSERT INTO schema_migrations VALUES ('007_vista_ventas_funcion');
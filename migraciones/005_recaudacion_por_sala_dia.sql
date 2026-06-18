SET search_path TO test;
-- 4. Recaudación por sala y día
SELECT s.nombre, f.fecha, SUM(e.precio)
FROM sala s
JOIN funcion f USING (sala_id)
JOIN entrada e USING (funcion_id)
GROUP BY s.nombre, f.fecha
INSERT INTO schema_migrations VALUES ('005_recaudacion_por_sala_dia');

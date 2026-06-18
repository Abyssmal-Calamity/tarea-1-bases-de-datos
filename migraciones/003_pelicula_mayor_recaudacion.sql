-- 2. Función con mayor ocupación
SELECT f.funcion_id,
COUNT(e.entrada_id)*1.0 / s.capacidad AS ocupacion
FROM funcion f
JOIN sala s USING (sala_id)
LEFT JOIN entrada e USING (funcion_id)
GROUP BY f.funcion_id, s.capacidad
ORDER BY ocupacion DESC
LIMIT 1
INSERT INTO schema_migrations VALUES ('003_pelicula_mayor_recaudacion');
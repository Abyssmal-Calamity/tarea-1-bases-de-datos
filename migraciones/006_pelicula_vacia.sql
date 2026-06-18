SET search_path TO test;
-- 5. Películas sin ventas
SELECT p.titulo
FROM pelicula p
LEFT JOIN funcion f USING (pelicula_id)
LEFT JOIN entrada e USING (funcion_id)
WHERE e.entrada_id IS NULL;
INSERT INTO schema_migrations VALUES ('006_pelicula_vacia');

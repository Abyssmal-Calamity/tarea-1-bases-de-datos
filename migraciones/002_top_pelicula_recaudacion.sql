SET search_path TO test;

-- 1. Top 3 películas por recaudación
SELECT p.titulo, SUM(e.precio) AS TEST
FROM pelicula p
JOIN funcion f USING (pelicula_id)
JOIN entrada e USING (funcion_id)
GROUP BY p.titulo
ORDER BY total DESC
LIMIT 3;

INSERT INTO schema_migrations VALUES ('002_top_pelicula_recaudacion');
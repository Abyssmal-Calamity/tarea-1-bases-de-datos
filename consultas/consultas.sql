SET search_path TO cine;

-- 1. Top 3 películas por recaudación
SELECT p.titulo, SUM(e.precio) AS total
FROM pelicula p
JOIN funcion f USING (pelicula_id)
JOIN entrada e USING (funcion_id)
GROUP BY p.titulo
ORDER BY total DESC
LIMIT 3;

-- 2. Función con mayor ocupación
SELECT f.funcion_id,
COUNT(e.entrada_id)*1.0 / s.capacidad AS ocupacion
FROM funcion f
JOIN sala s USING (sala_id)
LEFT JOIN entrada e USING (funcion_id)
GROUP BY f.funcion_id, s.capacidad
ORDER BY ocupacion DESC
LIMIT 1;

-- 3. Clientes con 3 o más funciones distintas
SELECT c.nombre
FROM cliente c
JOIN entrada e USING (cliente_id)
GROUP BY c.nombre
HAVING COUNT(DISTINCT e.funcion_id) >= 3;

-- 4. Recaudación por sala y día
SELECT s.nombre, f.fecha, SUM(e.precio)
FROM sala s
JOIN funcion f USING (sala_id)
JOIN entrada e USING (funcion_id)
GROUP BY s.nombre, f.fecha;

-- 5. Películas sin ventas
SELECT p.titulo
FROM pelicula p
LEFT JOIN funcion f USING (pelicula_id)
LEFT JOIN entrada e USING (funcion_id)
WHERE e.entrada_id IS NULL;

-- 6. Horario peak
SELECT f.hora, COUNT(e.entrada_id) AS total
FROM funcion f
JOIN entrada e USING (funcion_id)
GROUP BY f.hora
ORDER BY total DESC
LIMIT 1;
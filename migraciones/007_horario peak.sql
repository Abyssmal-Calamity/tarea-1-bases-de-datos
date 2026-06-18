-- 6. Horario peak
SELECT f.hora, COUNT(e.entrada_id) AS total
FROM funcion f
JOIN entrada e USING (funcion_id)
GROUP BY f.hora
ORDER BY total DESC
LIMIT 1
INSERT INTO schema_migrations VALUES ('007_horario peak');;
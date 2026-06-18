-- 3. Clientes con 3 o más funciones distintas
SELECT c.nombre
FROM cliente c
JOIN entrada e USING (cliente_id)
GROUP BY c.nombre
HAVING COUNT(DISTINCT e.funcion_id) >= 3
INSERT INTO schema_migrations VALUES ('004_clientes_multi-funciones_distintas');
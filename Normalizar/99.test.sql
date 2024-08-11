USE movies;

SET NOCOUNT ON;
DECLARE @crc as varchar(max);
DECLARE @crc_fail as bigint;
DECLARE @count_fail as bigint;
DECLARE @tiempoini as datetime;
SET @tiempoini=GETDATE();

DROP TABLE IF EXISTS valores_esperados, valores_encontrados;
CREATE TABLE valores_esperados (
    tabla   VARCHAR(30)  NOT NULL PRIMARY KEY,
    regs    INT          NOT NULL,
    crc_md5 VARCHAR(100) NOT NULL
);

CREATE TABLE valores_encontrados (
    tabla   VARCHAR(30)  NOT NULL PRIMARY KEY,
    regs    INT          NOT NULL,
    crc_md5 VARCHAR(100) NOT NULL
);

INSERT INTO valores_esperados VALUES 
('pais',                        88,'4543f172d68f026a07772b7c623fa224'),
('especialidad',                12,'ff62e7f1f62c62a3341bdd1ad825b4a7'),
('genero',                       3,'9cb7b4d99e88b51d379d99a65b882537'),
('categoria',                   20,'516f666bf920b534df86c13afc6f9bbd'),
('palabra_clave',             9794,'8621e6c2a36493325b690799eeade7ea'),
('idioma',                      88,'4bf56089d97d3986665b4bab4bf00a7f'),
('idioma_rol',                   2,'dd724b9ff87161ac93c5102018abbca1'),
('pelicula',                  4803,'f148c6617be8cdc3eb91dc69106f7bc9'),
('pelicula_elenco',         106257,'fa620a00df7286295e6d1e2aeefdb6f4'),
('pelicula_productora',      13677,'bc689ecb8a650634f316cbf1657d8d7b'),
('pelicula_equipo',         129581,'c530fefa4035774d3e278eafd60540ad'),
('trabajo      ',              417,'5e264d063701b77d60742fb5258c91d4'),
('pelicula_categorias',      12160,'e9b11af617713e69d62cbe45e0c312a8'),
('pelicula_palabra_claves',  36162,'57ce556f0c77d8e7037fd0469540e472'),
('pelicula_idiomas',         11740,'d0db854e0e3dec95c3ca9130c491d2f1'),
('persona',                 104842,'5efc0b03655b1448f100bccaa3ba4dbb'),
('productora',                5047,'d5c1d727279ed5a74a10e7722ffa2021'),
('pelicula_pais',             6436,'15d56508a0d0ef85c8a9459e58425816');

SELECT tabla, regs AS registros_esperados, crc_md5 AS crc_esperado FROM valores_esperados;

SET @crc= '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc,pais_id,pais_codigo_iso,pais_nombre)),2))
    FROM pais ORDER BY pais_id;
INSERT INTO valores_encontrados VALUES ('pais', (SELECT COUNT(*) FROM pais),@crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, especialidad_id,especialidad_nombre)),2))
    FROM especialidad ORDER BY especialidad_id;
INSERT INTO valores_encontrados VALUES ('especialidad', (SELECT COUNT(*) FROM especialidad), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, genero_id, genero)),2))
    FROM genero ORDER BY genero_id;
INSERT INTO valores_encontrados VALUES ('genero', (SELECT COUNT(*) FROM genero), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, categoria_id, categoria_nombre)),2))
    FROM categoria ORDER BY categoria_id;
INSERT INTO valores_encontrados VALUES ('categoria', (SELECT COUNT(*) FROM categoria), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, palabra_clave_id, palabra_clave_nombre)),2))
    FROM palabra_clave ORDER BY palabra_clave_id;
INSERT INTO valores_encontrados VALUES ('palabra_clave', (SELECT COUNT(*) FROM palabra_clave), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, idioma_id, idioma_codigo, idioma_nombre)),2))
    FROM idioma ORDER BY idioma_id;
INSERT INTO valores_encontrados VALUES ('idioma', (SELECT COUNT(*) FROM idioma), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, rol_id, idioma_rol)),2))
    FROM idioma_rol ORDER BY rol_id;
INSERT INTO valores_encontrados VALUES ('idioma_rol', (SELECT COUNT(*) FROM idioma_rol), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, titulo, presupuesto, sitio_web, resumen, popularidad, fecha_estreno, ingresos, duracion, estado, lema, promedio_votos, cantidad_votos )),2))
    FROM pelicula ORDER BY pelicula_id;
INSERT INTO valores_encontrados VALUES ('pelicula', (SELECT COUNT(*) FROM pelicula), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, persona_id, personaje_nombre, genero_id, elenco_orden )),2))
    FROM pelicula_elenco ORDER BY pelicula_id, persona_id, genero_id, elenco_orden;
INSERT INTO valores_encontrados VALUES ('pelicula_elenco', (SELECT COUNT(*) FROM pelicula_elenco), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, productora_id )),2))
    FROM pelicula_productora ORDER BY pelicula_id, productora_id;
INSERT INTO valores_encontrados VALUES ('pelicula_productora', (SELECT COUNT(*) FROM pelicula_productora), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, persona_id, especialidad_id, trabajo_id )),2))
    FROM pelicula_equipo ORDER BY pelicula_id, persona_id, especialidad_id, trabajo_id;
INSERT INTO valores_encontrados VALUES ('pelicula_equipo', (SELECT COUNT(*) FROM pelicula_equipo), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, trabajo_id, trabajo_nombre )),2))
    FROM trabajo ORDER BY trabajo_id;
INSERT INTO valores_encontrados VALUES ('trabajo', (SELECT COUNT(*) FROM trabajo), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, categoria_id )),2))
    FROM pelicula_categorias ORDER BY pelicula_id, categoria_id;
INSERT INTO valores_encontrados VALUES ('pelicula_categorias', (SELECT COUNT(*) FROM pelicula_categorias), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, palabra_clave_id )),2))
    FROM pelicula_palabra_claves ORDER BY pelicula_id, palabra_clave_id;
INSERT INTO valores_encontrados VALUES ('pelicula_palabra_claves', (SELECT COUNT(*) FROM pelicula_palabra_claves), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, idioma_id, idioma_rol_id )),2))
    FROM pelicula_idiomas ORDER BY pelicula_id, idioma_id, idioma_rol_id;
INSERT INTO valores_encontrados VALUES ('pelicula_idiomas', (SELECT COUNT(*) FROM pelicula_idiomas), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, persona_id, persona_nombre )),2))
    FROM persona ORDER BY persona_id;
INSERT INTO valores_encontrados VALUES ('persona', (SELECT COUNT(*) FROM persona), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, productora_id, productora_nombre )),2))
    FROM productora ORDER BY productora_id;
INSERT INTO valores_encontrados VALUES ('productora', (SELECT COUNT(*) FROM productora), @crc);

SET @crc = '';
    SELECT @crc = LOWER(CONVERT(VARCHAR(32),HashBytes('MD5',CONCAT_WS('#',@crc, pelicula_id, pais_id )),2))
    FROM pelicula_pais ORDER BY pelicula_id, pais_id;
INSERT INTO valores_encontrados VALUES ('pelicula_pais', (SELECT COUNT(*) FROM pelicula_pais), @crc);

SELECT tabla, regs AS 'registros_encontrados', crc_md5 AS crc_encontrado FROM valores_encontrados;

SELECT  
    e.tabla, 
    IIF(e.regs=f.regs,'OK', 'No OK') AS coinciden_registros, 
    IIF(e.crc_md5=f.crc_md5,'OK','No OK') AS coindicen_crc 
FROM 
    valores_esperados e INNER JOIN valores_encontrados f ON e.tabla=f.tabla;

SET @crc_fail=(SELECT COUNT(*) FROM valores_esperados e INNER JOIN valores_encontrados f ON (e.tabla=f.tabla) WHERE f.crc_md5 != e.crc_md5);
SET @count_fail=(SELECT COUNT(*) FROM valores_esperados e INNER JOIN valores_encontrados f ON (e.tabla=f.tabla) WHERE f.regs != e.regs);

DROP TABLE valores_esperados,valores_encontrados;

SELECT 'UUID' AS Resumen, CAST([service_broker_guid] AS varchar(50)) AS 'Resultado'
FROM   sys.databases
WHERE [name] = N'master'
UNION ALL
SELECT 'Server Name', @@SERVERNAME
UNION ALL
SELECT 'CRC', IIF(@crc_fail = 0, 'OK', 'Error')
UNION ALL
SELECT 'Cantidad', IIF(@count_fail = 0, 'OK', 'Error' )
UNION ALL
SELECT 'Tiempo', CAST(DATEDIFF(MILLISECOND,@tiempoini,GETDATE()) AS varchar(50));

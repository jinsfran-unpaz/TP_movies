USE movies;

SET @tiempoini=NOW(6);

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
('country',                     88,'4543f172d68f026a07772b7c623fa224'),
('department',                  12,'ff62e7f1f62c62a3341bdd1ad825b4a7'),
('gender',                       3,'9cb7b4d99e88b51d379d99a65b882537'),
('genre',                       20,'516f666bf920b534df86c13afc6f9bbd'),
('keyword',                   9794,'8621e6c2a36493325b690799eeade7ea'),
('language',                    88,'4292236294829f0824924fe1dbdb7211'),
('language_role',                2,'dd724b9ff87161ac93c5102018abbca1'),
('movie',                     4803,'efdb9d610ee1e771fb5a5c9327a3fc4d'),
('movie_cast',              106257,'1c6dd61239ecc6d6027c018db512d90b'),
('movie_company',            13677,'bc689ecb8a650634f316cbf1657d8d7b'),
('movie_crew',              129581,'c45dc00d973b057ffed2ee238b26c604'),
('movie_genres',             12160,'e9b11af617713e69d62cbe45e0c312a8'),
('movie_keywords',           36162,'57ce556f0c77d8e7037fd0469540e472'),
('movie_languages',          11740,'d0db854e0e3dec95c3ca9130c491d2f1'),
('persons',                 104842,'5efc0b03655b1448f100bccaa3ba4dbb'),
('production_company',        5047,'b8b6855890d4e1ecc0188a6057478cab'),
('production_country',        6436,'15d56508a0d0ef85c8a9459e58425816');

SELECT tabla, regs AS registros_esperados, crc_md5 AS crc_esperado FROM valores_esperados;

SET @crc= '';
DROP TABLE IF EXISTS tchecksum;
CREATE TABLE tchecksum (chk char(100));
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc,country_id,country_iso_code,country_name))
    FROM country ORDER BY country_id;
INSERT INTO valores_encontrados VALUES ('country', (SELECT COUNT(*) FROM country),@crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, department_id,department_name))
    FROM department ORDER BY department_id;
INSERT INTO valores_encontrados VALUES ('department', (SELECT COUNT(*) FROM department), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, gender_id, gender))
    FROM gender ORDER BY gender_id;
INSERT INTO valores_encontrados VALUES ('gender', (SELECT COUNT(*) FROM gender), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, genre_id, genre_name))
    FROM genre ORDER BY genre_id;
INSERT INTO valores_encontrados VALUES ('genre', (SELECT COUNT(*) FROM genre), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, keyword_id, keyword_name))
    FROM keyword ORDER BY keyword_id;
INSERT INTO valores_encontrados VALUES ('keyword', (SELECT COUNT(*) FROM keyword), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, language_id, language_code, language_name))
    FROM language ORDER BY language_id;
INSERT INTO valores_encontrados VALUES ('language', (SELECT COUNT(*) FROM language), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, role_id, language_role))
    FROM language_role ORDER BY role_id;
INSERT INTO valores_encontrados VALUES ('language_role', (SELECT COUNT(*) FROM language_role), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, title, budget, homepage, overview, popularity, release_date, revenue, runtime, movie_status, tagline, vote_average, vote_count ))
    FROM movie ORDER BY movie_id;
INSERT INTO valores_encontrados VALUES ('movie', (SELECT COUNT(*) FROM movie), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, person_id, character_name, gender_id, cast_order ))
    FROM movie_cast ORDER BY movie_id, person_id, gender_id, cast_order;
INSERT INTO valores_encontrados VALUES ('movie_cast', (SELECT COUNT(*) FROM movie_cast), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, company_id ))
    FROM movie_company ORDER BY movie_id, company_id;
INSERT INTO valores_encontrados VALUES ('movie_company', (SELECT COUNT(*) FROM movie_company), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, person_id, department_id, job ))
    FROM movie_crew ORDER BY movie_id, person_id, department_id, job;
INSERT INTO valores_encontrados VALUES ('movie_crew', (SELECT COUNT(*) FROM movie_crew), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, genre_id ))
    FROM movie_genres ORDER BY movie_id, genre_id;
INSERT INTO valores_encontrados VALUES ('movie_genres', (SELECT COUNT(*) FROM movie_genres), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, keyword_id ))
    FROM movie_keywords ORDER BY movie_id, keyword_id;
INSERT INTO valores_encontrados VALUES ('movie_keywords', (SELECT COUNT(*) FROM movie_keywords), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, language_id, language_role_id ))
    FROM movie_languages ORDER BY movie_id, language_id, language_role_id;
INSERT INTO valores_encontrados VALUES ('movie_languages', (SELECT COUNT(*) FROM movie_languages), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, person_id, person_name ))
    FROM person ORDER BY person_id;
INSERT INTO valores_encontrados VALUES ('person', (SELECT COUNT(*) FROM person), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, company_id, company_name ))
    FROM production_company ORDER BY company_id;
INSERT INTO valores_encontrados VALUES ('production_company', (SELECT COUNT(*) FROM production_company), @crc);

SET @crc = '';
INSERT INTO tchecksum 
    SELECT @crc := MD5(CONCAT_WS('#',@crc, movie_id, country_id ))
    FROM production_country ORDER BY movie_id, country_id;
INSERT INTO valores_encontrados VALUES ('production_country', (SELECT COUNT(*) FROM production_country), @crc);

DROP TABLE IF EXISTS tchecksum;

SELECT tabla, regs AS 'registros_encontrados', crc_md5 AS crc_encontrado FROM valores_encontrados;

SELECT  
    e.tabla, 
    IF(e.regs=f.regs,'OK', 'No OK') AS coinciden_registros, 
    IF(e.crc_md5=f.crc_md5,'OK','No OK') AS coindicen_crc 
FROM 
    valores_esperados e INNER JOIN valores_encontrados f ON e.tabla=f.tabla;

SET @crc_fail=(SELECT COUNT(*) FROM valores_esperados e INNER JOIN valores_encontrados f ON (e.tabla=f.tabla) WHERE f.crc_md5 != e.crc_md5);
SET @count_fail=(SELECT COUNT(*) FROM valores_esperados e INNER JOIN valores_encontrados f ON (e.tabla=f.tabla) WHERE f.regs != e.regs);

DROP TABLE valores_esperados,valores_encontrados;

SELECT 'UUID' AS Resumen, @@server_uuid AS Resultado
UNION ALL
SELECT 'Server Name', @@hostname
UNION ALL
SELECT 'CRC', IF(@crc_fail = 0, 'OK', 'Error')
UNION ALL
SELECT 'Cantidad', IF(@count_fail = 0, 'OK', 'Error' )
UNION ALL
SELECT 'Tiempo', TIMESTAMPDIFF(MICROSECOND,@tiempoini,NOW(6))/1000;

USE movies;

CREATE TABLE trabajo (
    trabajo_id INT IDENTITY NOT NULL,
    trabajo_nombre VARCHAR(100) NOT NULL,
    CONSTRAINT PK_trabajo PRIMARY KEY (trabajo_id)
);

GO

-- Agregar en la tabla trabajo los trabajos de la tabla pelicula_equipo
INSERT INTO trabajo (trabajo_nombre)
SELECT DISTINCT trabajo
FROM pelicula_equipo
ORDER BY trabajo;

GO

-- Agrego la columna trabajo_id en la tabla pelicula_equipo
ALTER TABLE pelicula_equipo
ADD trabajo_id INT NULL;

GO

-- Agrego la clave foranea trabajo_id en la tabla pelicula_equipo
ALTER TABLE pelicula_equipo
ADD CONSTRAINT FK_pelicula_equipo_trabajo
FOREIGN KEY (trabajo_id)
REFERENCES trabajo(trabajo_id);

GO

-- Actualizo la columna trabajo_id en la tabla pelicula_equipo
UPDATE pelicula_equipo
SET trabajo_id = trabajo.trabajo_id
FROM trabajo
WHERE pelicula_equipo.trabajo = trabajo.trabajo_nombre;

GO

-- Modifico la clave primaria de la tabla pelicula_equipo
ALTER TABLE pelicula_equipo
DROP CONSTRAINT PK_pelicula_equipo;

GO

ALTER TABLE pelicula_equipo
ALTER COLUMN trabajo_id INT NOT NULL;

GO

ALTER TABLE pelicula_equipo
ADD CONSTRAINT PK_pelicula_equipo PRIMARY KEY (pelicula_id, persona_id, especialidad_id, trabajo_id);

GO

-- Elimino la columna trabajo de la tabla pelicula_equipo
ALTER TABLE pelicula_equipo
DROP COLUMN trabajo;

GO
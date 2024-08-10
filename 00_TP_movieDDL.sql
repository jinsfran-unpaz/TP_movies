DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;

USE movies;

DROP TABLE IF EXISTS pais;

CREATE TABLE pais (
  pais_id INT NOT NULL,
  pais_codigo_iso varchar(10) NULL,
  pais_nombre varchar(200) NULL,
  CONSTRAINT PK_pais PRIMARY KEY (pais_id)
);

DROP TABLE IF EXISTS genero;

CREATE TABLE genero (
  genero_id INT NOT NULL,
  genero VARCHAR(20) NULL,
  CONSTRAINT PK_genero PRIMARY KEY (genero_id)
);

DROP TABLE IF EXISTS categoria;

CREATE TABLE categoria (
  categoria_id INT NOT NULL,
  categoria_nombre varchar(100) NULL,
  CONSTRAINT PK_categoria PRIMARY KEY (categoria_id)
);

DROP TABLE IF EXISTS idioma;

CREATE TABLE idioma (
  idioma_id INT NOT NULL,
  idioma_codigo varchar(10) NULL,
  idioma_nombre nvarchar(500) NULL,
  CONSTRAINT PK_idioma PRIMARY KEY (idioma_id)
);

DROP TABLE IF EXISTS idioma_rol;

CREATE TABLE idioma_rol (
  rol_id INT NOT NULL,
  idioma_rol varchar(20) NULL,
  CONSTRAINT PK_idioma_rol PRIMARY KEY (rol_id)
);

DROP TABLE IF EXISTS especialidad;

CREATE TABLE especialidad (
  especialidad_id INT NOT NULL,
  especialidad_nombre varchar(200) NULL,
  CONSTRAINT PK_especialidad PRIMARY KEY (especialidad_id)
);

DROP TABLE IF EXISTS palabra_clave;

CREATE TABLE palabra_clave (
  palabra_clave_id INT NOT NULL,
  palabra_clave_nombre VARCHAR(200) NULL,
  CONSTRAINT PK_palabra_clave PRIMARY KEY (palabra_clave_id)
);

DROP TABLE IF EXISTS persona;

CREATE TABLE persona (
  persona_id INT NOT NULL,
  persona_nombre nvarchar(500) NULL,
  CONSTRAINT PK_persona PRIMARY KEY (persona_id)
);

DROP TABLE IF EXISTS productora;

CREATE TABLE productora (
  productora_id INT NOT NULL,
  productora_nombre nvarchar(200) NULL,
  CONSTRAINT PK_productora PRIMARY KEY (productora_id)
);

DROP TABLE IF EXISTS pelicula;

CREATE TABLE pelicula (
  pelicula_id INT NOT NULL,
  titulo nvarchar(1000) NULL,
  presupuesto BIGINT NULL,
  sitio_web varchar(1000) NULL,
  resumen nvarchar(1000) NULL,
  popularidad DECIMAL(12,6) NULL,
  fecha_estreno DATE NULL,
  ingresos BIGINT NULL,
  duracion INT NULL,
  estado varchar(50) NULL,
  lema nvarchar(1000) NULL,
  promedio_votos DECIMAL(4,2) NULL,
  cantidad_votos INT NULL,
  CONSTRAINT PK_pelicula PRIMARY KEY (pelicula_id)
);

DROP TABLE IF EXISTS pelicula_elenco;

CREATE TABLE pelicula_elenco (
  pelicula_id INT,
  persona_id INT,
  personaje_nombre nvarchar(400) NULL,
  genero_id INT,
  elenco_orden INT,
  CONSTRAINT PK_pelicula_elenco PRIMARY KEY (pelicula_id, persona_id, genero_id, elenco_orden),
  CONSTRAINT FK_pel_genero FOREIGN KEY (genero_id) REFERENCES genero (genero_id),
  CONSTRAINT FK_pel_pelicula  FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id),
  CONSTRAINT FK_pel_persona FOREIGN KEY (persona_id) REFERENCES persona (persona_id)
);

DROP TABLE IF EXISTS pelicula_productora;

CREATE TABLE pelicula_productora (
  pelicula_id INT,
  productora_id INT,
  CONSTRAINT PK_pelicula_productora PRIMARY KEY (pelicula_id, productora_id),
  CONSTRAINT FK_ppro_productora FOREIGN KEY (productora_id) REFERENCES productora (productora_id),
  CONSTRAINT FK_ppro_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id)
);

DROP TABLE IF EXISTS pelicula_equipo;

CREATE TABLE pelicula_equipo (
  pelicula_id INT,
  persona_id INT,
  especialidad_id INT,
  trabajo varchar(200),
  CONSTRAINT PK_pelicula_equipo PRIMARY KEY (pelicula_id, persona_id, especialidad_id,trabajo),
  CONSTRAINT FK_peq_especialidad FOREIGN KEY (especialidad_id) REFERENCES especialidad (especialidad_id),
  CONSTRAINT FK_peq_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id),
  CONSTRAINT FK_peq_persona FOREIGN KEY (persona_id) REFERENCES persona (persona_id)
);

DROP TABLE IF EXISTS pelicula_categorias;

CREATE TABLE pelicula_categorias (
  pelicula_id INT,
  categoria_id INT,
  CONSTRAINT PK_pelicula_categorias PRIMARY KEY (pelicula_id, categoria_id),
  CONSTRAINT FK_pca_categoria FOREIGN KEY (categoria_id) REFERENCES categoria (categoria_id),
  CONSTRAINT FK_pca_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id)
);

DROP TABLE IF EXISTS pelicula_palabra_claves;

CREATE TABLE pelicula_palabra_claves (
  pelicula_id INT,
  palabra_clave_id INT,
  CONSTRAINT PK_pelicula_palabra_claves PRIMARY KEY (pelicula_id, palabra_clave_id),
  CONSTRAINT FK_ppc_palabra_clave FOREIGN KEY (palabra_clave_id) REFERENCES palabra_clave (palabra_clave_id),
  CONSTRAINT FK_ppc_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id)
);

DROP TABLE IF EXISTS pelicula_idiomas;

CREATE TABLE pelicula_idiomas (
  pelicula_id INT,
  idioma_id INT,
  idioma_rol_id INT,
  CONSTRAINT PK_pelicula_idiomas PRIMARY KEY (pelicula_id, idioma_id, idioma_rol_id),
  CONSTRAINT FK_pid_idioma FOREIGN KEY (idioma_id) REFERENCES idioma (idioma_id),
  CONSTRAINT FK_pid_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id),
  CONSTRAINT FK_pid_rol FOREIGN KEY (idioma_rol_id) REFERENCES idioma_rol (rol_id)
);

DROP TABLE IF EXISTS pelicula_pais;

CREATE TABLE pelicula_pais (
  pelicula_id INT,
  pais_id INT,
  CONSTRAINT PK_pelicula_pais PRIMARY KEY (pelicula_id, pais_id),
  CONSTRAINT FK_ppa_pais FOREIGN KEY (pais_id) REFERENCES pais (pais_id),
  CONSTRAINT FK_ppa_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula (pelicula_id)
);

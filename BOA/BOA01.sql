--
-- Create a very simple database to hold book and author information
--
PRAGMA foreign_keys = ON;
DROP TABLE boa;
DROP TABLE amigo;
DROP TABLE usuario;

CREATE TABLE usuario (
  nombreusuario     TEXT PRIMARY KEY UNIQUE,
  nombres           TEXT,
  apellidos         TEXT,
  email             TEXT,
  contrasena        TEXT
);

CREATE TABLE boa (
  id                SERIAL,
  autor             TEXT REFERENCES usuario(nombreusuario),
  contenido         TEXT,
  fecha             timestamp, 
  PRIMARY KEY (id)
);


--INSERCIONES POR DEFAULT
INSERT INTO usuario VALUES ('origds', 'Oriana', 'Gomez', 'origds@gmail.com', 'oriana');
INSERT INTO usuario VALUES ('betocolsf', 'Alberto', 'Cols', 'betocolsf@gmail.com', 'alberto');
INSERT INTO usuario VALUES ('dreabalbas', 'Andrea Carolina', 'Balbas Quintero', 'drea.balbas@gmail.com', 'andrea');
INSERT INTO boa VALUES (1, 'origds', 'boa 1 de oriana', '2011-05-10 21:02:34');
INSERT INTO boa VALUES (2, 'origds', 'boa 2 de oriana', '2011-05-10 21:02:34');
INSERT INTO boa VALUES (3, 'betocolsf', 'boa 1 de beto', '2011-05-10 21:02:34');
INSERT INTO boa VALUES (4, 'betocolsf', 'boa 2 de beto', '2011-05-10 21:02:34');
INSERT INTO boa VALUES (5, 'dreabalbas', 'boa 1 de andre', '2011-05-10 21:02:34');
INSERT INTO boa VALUES (6, 'dreabalbas', 'boa 2 de andre', '2011-05-10 21:02:34');
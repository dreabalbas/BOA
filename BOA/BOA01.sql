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
  email             TEXT
);

CREATE TABLE boa (
  autor             TEXT REFERENCES usuario(nombreusuario),
  contenido         TEXT,
  fecha             timestamp, 
  PRIMARY KEY (autor,contenido)
);

CREATE TABLE amigo (
  usuario1           TEXT REFERENCES usuario(nombreusuario),
  usuario2           TEXT REFERENCES usuario(nombreusuario),
  PRIMARY KEY (usuario1, usuario2)
);

--INSERCIONES POR DEFAULT
INSERT INTO usuario VALUES ('origds', 'Oriana', 'Gomez', 'origds@gmail.com');
INSERT INTO usuario VALUES ('betocolsf', 'Alberto', 'Cols', 'betocolsf@gmail.com');
INSERT INTO usuario VALUES ('dreabalbas', 'Andrea Carolina', 'Balbas Quintero', 'drea.balbas@gmail.com');
INSERT INTO boa VALUES ('origds', 'boa 1 de oriana', '2011-05-10 21:02:34');
INSERT INTO boa VALUES ('origds', 'boa 2 de oriana', '2011-05-10 21:02:34');
INSERT INTO boa VALUES ('betocolsf', 'boa 1 de beto', '2011-05-10 21:02:34');
INSERT INTO boa VALUES ('betocolsf', 'boa 2 de beto', '2011-05-10 21:02:34');
INSERT INTO boa VALUES ('dreabalbas', 'boa 1 de andre', '2011-05-10 21:02:34');
INSERT INTO boa VALUES ('dreabalbas', 'boa 2 de andre', '2011-05-10 21:02:34');
INSERT INTO amigo VALUES ('origds', 'betocolsf');
INSERT INTO amigo VALUES ('origds', 'dreabalbas');
INSERT INTO amigo VALUES ('betocolsf', 'dreabalbas');
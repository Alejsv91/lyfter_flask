-- SCHEMA: sql_desde_python

-- DROP SCHEMA IF EXISTS sql_desde_python ;

CREATE SCHEMA IF NOT EXISTS sql_desde_python
    AUTHORIZATION alejandrosolanovega;

CREATE TABLE sql_desde_python.users(
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(30),
	email VARCHAR(20),
	password VARCHAR(20)
);

INSERT INTO sql_desde_python.users (full_name, email, password) values ('Manuel Vega', 'm.vega@gmail.com', 'A1SFA3!!');
INSERT INTO sql_desde_python.users (full_name, email, password) values ('Carlos Antonio', 'c.antonio@yahoo.com', '2001_02_03');
INSERT INTO sql_desde_python.users (full_name, email, password) values ('Jose Mora', 'j.mora@gmail.com', 'password123');
INSERT INTO sql_desde_python.users (full_name, email, password) values ('Alfred Lopez', 'alfredlo@hotmail.com', 'alfredLP.');
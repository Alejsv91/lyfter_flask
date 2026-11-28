-- SCHEMA: lyfter_car_rental

-- DROP SCHEMA IF EXISTS lyfter_car_rental ;

CREATE SCHEMA IF NOT EXISTS lyfter_car_rental
    AUTHORIZATION alejandrosolanovega;

SET search_path TO lyfter_car_rental;

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, 
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    active_account BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS makes (
    id SERIAL PRIMARY KEY,
    make_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS models (
    id SERIAL PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    fabrication_year INTEGER NOT NULL,
    make_id INTEGER NOT NULL REFERENCES makes(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS car_statuses (
id SERIAL PRIMARY KEY,
description VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS cars (
    id SERIAL PRIMARY KEY,
    model_id INTEGER NOT NULL REFERENCES models(id) ON DELETE CASCADE,
	car_status_id INTEGER NOT NULL REFERENCES car_statuses(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rental_statuses (
    id SERIAL PRIMARY KEY,
    description VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS rentals (
    id SERIAL PRIMARY KEY,
    rental_date DATE NOT NULL DEFAULT CURRENT_DATE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    car_id INTEGER NOT NULL REFERENCES cars(id) ON DELETE CASCADE,
    rental_status_id INTEGER NOT NULL REFERENCES rental_statuses(id) ON DELETE CASCADE
);


/*INSERT INTO users (name, last_name, email, username, password, birthdate, active_account) VALUES
('Carlos', 'Mendoza', 'carlos.mendoza@gmail.com', 'cmendoza', 'Pass2024#1', '1990-05-14', TRUE),
('Ana', 'Vargas', 'ana.vargas@hotmail.com', 'avargas', 'Pass2024#2', '1988-11-23', TRUE),
('Luis', 'Fernandez', 'luis.fernandez@yahoo.com', 'lfernandez', 'Pass2024#3', '1995-02-10', TRUE),
('Maria', 'Rodriguez', 'maria.rodriguez@gmail.com', 'mrodriguez', 'Pass2024#4', '1992-08-30', TRUE),
('Jose', 'Gomez', 'jose.gomez@outlook.com', 'jgomez', 'Pass2024#5', '1985-03-19', FALSE),
('Laura', 'Jimenez', 'laura.jimenez@gmail.com', 'ljimenez', 'Pass2024#6', '1998-07-12', TRUE),
('Diego', 'Castillo', 'diego.castillo@empresa.com', 'dcastillo', 'Pass2024#7', '1991-12-05', TRUE),
('Sofia', 'Morales', 'sofia.morales@gmail.com', 'smorales', 'Pass2024#8', '2000-01-25', TRUE),
('Andres', 'Rojas', 'andres.rojas@hotmail.com', 'arojas', 'Pass2024#9', '1987-09-14', TRUE),
('Valeria', 'Castro', 'valeria.castro@gmail.com', 'vcastro', 'Pass2024#10', '1996-04-18', TRUE),
('Jorge', 'Herrera', 'jorge.herrera@yahoo.com', 'jherrera', 'Pass2024#11', '1982-06-22', FALSE),
('Camila', 'Navarro', 'camila.navarro@gmail.com', 'cnavarro', 'Pass2024#12', '1999-10-03', TRUE),
('Ricardo', 'Salazar', 'ricardo.salazar@outlook.com', 'rsalazar', 'Pass2024#13', '1993-02-28', TRUE),
('Paula', 'Solis', 'paula.solis@gmail.com', 'psolis', 'Pass2024#14', '1994-11-11', TRUE),
('Fernando', 'Araya', 'fernando.araya@empresa.com', 'faraya', 'Pass2024#15', '1989-08-07', TRUE),
('Daniela', 'Chaves', 'daniela.chaves@gmail.com', 'dchaves', 'Pass2024#16', '2001-05-19', TRUE),
('Miguel', 'Alvarez', 'miguel.alvarez@hotmail.com', 'malvarez', 'Pass2024#17', '1986-12-30', FALSE),
('Gabriela', 'Mora', 'gabriela.mora@gmail.com', 'gmora', 'Pass2024#18', '1997-03-09', TRUE),
('Alejandro', 'Quesada', 'alejandro.quesada@yahoo.com', 'aquesada', 'Pass2024#19', '1990-09-21', TRUE),
('Natalia', 'Cordero', 'natalia.cordero@gmail.com', 'ncordero', 'Pass2024#20', '1995-06-15', TRUE),
('Esteban', 'Brenes', 'esteban.brenes@outlook.com', 'ebrenes', 'Pass2024#21', '1991-01-08', TRUE),
('Lucia', 'Soto', 'lucia.soto@gmail.com', 'lsoto', 'Pass2024#22', '1998-04-27', TRUE),
('Kevin', 'Calderon', 'kevin.calderon@hotmail.com', 'kcalderon', 'Pass2024#23', '2002-08-14', TRUE),
('Andrea', 'Vega', 'andrea.vega@gmail.com', 'avega', 'Pass2024#24', '1984-10-19', FALSE),
('Oscar', 'Pacheco', 'oscar.pacheco@empresa.com', 'opacheco', 'Pass2024#25', '1988-02-03', TRUE),
('Mariana', 'Campos', 'mariana.campos@gmail.com', 'mcampos', 'Pass2024#26', '1993-07-29', TRUE),
('Roberto', 'Monge', 'roberto.monge@yahoo.com', 'rmonge', 'Pass2024#27', '1980-11-16', TRUE),
('Elena', 'Aguilar', 'elena.aguilar@gmail.com', 'eaguilar', 'Pass2024#28', '1996-12-12', TRUE),
('David', 'Zuniga', 'david.zuniga@outlook.com', 'dzuniga', 'Pass2024#29', '1992-05-04', TRUE),
('Carolina', 'Acuna', 'carolina.acuna@gmail.com', 'cacuna', 'Pass2024#30', '1999-09-09', FALSE),
('Hector', 'Mendez', 'hector.mendez@hotmail.com', 'hmendez', 'Pass2024#31', '1987-01-31', TRUE),
('Adriana', 'Porras', 'adriana.porras@gmail.com', 'aporras', 'Pass2024#32', '1994-06-18', TRUE),
('Sebastian', 'Urena', 'sebastian.urena@empresa.com', 'surena', 'Pass2024#33', '2000-10-25', TRUE),
('Monica', 'Guzman', 'monica.guzman@gmail.com', 'mguzman', 'Pass2024#34', '1991-03-14', TRUE),
('Pablo', 'Ramos', 'pablo.ramos@yahoo.com', 'pramos', 'Pass2024#35', '1985-08-22', TRUE),
('Silvia', 'Salas', 'silvia.salas@gmail.com', 'ssalas', 'Pass2024#36', '1997-11-05', TRUE),
('Mauricio', 'Reyes', 'mauricio.reyes@outlook.com', 'mreyes', 'Pass2024#37', '1989-04-11', FALSE),
('Jimena', 'Ortiz', 'jimena.ortiz@gmail.com', 'jortiz', 'Pass2024#38', '2003-02-17', TRUE),
('Cristian', 'Villalobos', 'cristian.villalobos@hotmail.com', 'cvillalobos', 'Pass2024#39', '1993-12-24', TRUE),
('Melissa', 'Esquivel', 'melissa.esquivel@gmail.com', 'mesquivel', 'Pass2024#40', '1995-07-08', TRUE),
('Gabriel', 'Alpizar', 'gabriel.alpizar@empresa.com', 'galpizar', 'Pass2024#41', '1986-09-30', TRUE),
('Tatiana', 'Madrigal', 'tatiana.madrigal@gmail.com', 'tmadrigal', 'Pass2024#42', '1998-01-13', TRUE),
('Rafael', 'Chacon', 'rafael.chacon@yahoo.com', 'rchacon', 'Pass2024#43', '1983-05-26', TRUE),
('Veronica', 'Barrantes', 'veronica.barrantes@gmail.com', 'vbarrantes', 'Pass2024#44', '1992-10-07', FALSE),
('Eduardo', 'Fonseca', 'eduardo.fonseca@outlook.com', 'efonseca', 'Pass2024#45', '1990-06-02', TRUE),
('Rebeca', 'Quiros', 'rebeca.quiros@gmail.com', 'rquiros', 'Pass2024#46', '1996-08-19', TRUE),
('Alonso', 'Sanabria', 'alonso.sanabria@hotmail.com', 'asanabria', 'Pass2024#47', '1994-03-28', TRUE),
('Diana', 'Granados', 'diana.granados@gmail.com', 'dgranados', 'Pass2024#48', '2001-11-15', TRUE),
('Marco', 'Arias', 'marco.arias@empresa.com', 'marias', 'Pass2024#49', '1988-04-04', TRUE),
('Irene', 'Solano', 'irene.solano@gmail.com', 'isolano', 'Pass2024#50', '1999-12-20', TRUE);*/
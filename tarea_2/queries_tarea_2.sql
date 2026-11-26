-- SCHEMA: lyfter_car_rental

-- DROP SCHEMA IF EXISTS lyfter_car_rental ;

CREATE SCHEMA IF NOT EXISTS lyfter_car_rental
    AUTHORIZATION alejandrosolanovega;

	SET search_path TO lyfter_car_rental;

	--SELECT * FROM users;
	--1. Un script que agregue un usuario nuevo
	/*INSERT INTO users (name, last_name, email, username, password, birthdate, active_account)
	VALUES ('Enzo', 'Solano', 'en2020@gmail.com', 'en2020', 'Abcd124?!', '2020-10-17', true);*/

	--2. Un script que agregue un automovil nuevo
	--Para este paso hice dos tablas adicionales, una para makes y otras para models
	--Por lo cual se tiene que crear informacion primero en makes,  model, car_statuses y luego cars
	
	/*INSERT INTO makes (make_name)
	VALUES ('Toyota');
	SELECT * FROM makes;
	
	INSERT INTO models (model_name, fabrication_year, make_id)
	VALUES ('Corolla', 2025, 2);
	SELECT * FROM models;
	
	INSERT INTO car_statuses(description)
	VALUES ('enabled');
	SELECT * FROM car_statuses;
	
	INSERT INTO cars (model_id, car_status_id)
	VALUES (5, 1);
	SELECT * FROM cars;*/

	--3. Un script que cambie el estado de un usuario
	/*UPDATE users
	SET active_account = false
	WHERE id = 1;
	
	SELECT * FROM users
	ORDER BY id ASC;*/

	--4. Un script que cambie el estado de un automovil
	-- Para esto voy a crear un estado adicional en la tabla car_statuses
	/*INSERT INTO car_statuses (description)
	VALUES ('available');

	-- Luego procedo a crear el cambio de status
	UPDATE cars
	SET car_status_id = 3
	WHERE id = 4;*/

	--5. Un script que genere un alquiler nuevo con los datos de un usuario y un automovil
	/*SELECT *
	FROM rentals;

	SELECT *
	FROM rental_statuses;
	
	INSERT INTO rental_statuses (description)
	VALUES ('pending');
	INSERT INTO rental_statuses (description)
	VALUES ('active');
	INSERT INTO rental_statuses (description)
	VALUES ('completed');
	INSERT INTO rental_statuses (description)
	VALUES ('overdue');
	INSERT INTO rental_statuses (description)
	VALUES ('canceled');

	INSERT INTO rentals (user_id, car_id, rental_status_id)
	VALUES (2, 4, 2)*/

	--6. Un script que confirme la devolución del auto al completar el alquiler, colocando el auto como disponible y completando el estado del alquiler
	UPDATE rentals
	SET rental_status_id = 3
	WHERE id = 1;

	UPDATE cars
	SET car_status_id = 5
	WHERE id = 1; --5 es available;

	--7. Un script que deshabilite un automovil del alquiler
	UPDATE cars
	SET car_status_id = 6
	WHERE id = 4;

	--8. Un script que obtenga todos los automoviles alquilados, y otro que obtenga todos los disponibles.
	SELECT *
	FROM cars
	WHERE car_status_id = 4;

	SELECT *
	FROM cars
	WHERE car_status_id = 5;

	


	

	

	
	


	

	
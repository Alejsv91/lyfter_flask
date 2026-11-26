-- 5. Un script que genere un alquiler nuevo con los datos de un usuario y un automovil
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
	v_user_id INTEGER := 2;
	v_car_id INTEGER := 2;
	v_rental_status_id INTEGER := 2;    -- ID de 'active' en rental_statuses
	v_available_status_id INTEGER := 5; -- ID de 'available' en car_statuses
	v_rented_status_id INTEGER := 1;    -- ID de 'rented' en car_statuses
BEGIN
	-- 1. Validar que el usuario exista y esté activo
	IF NOT EXISTS (
		SELECT 1 
		FROM users u
		WHERE u.id = v_user_id AND u.active_account = true
	) THEN
		RAISE EXCEPTION 'User id % is not registered or account is inactive', v_user_id;
	END IF;

	-- 2. Validar que el auto exista y esté disponible
	IF NOT EXISTS (
		SELECT 1
		FROM cars c
		WHERE c.id = v_car_id AND c.car_status_id = v_available_status_id
	) THEN
		RAISE EXCEPTION 'Car id % is not registered or is not available for rent', v_car_id;
	END IF;

	-- 3. Validar que el estado del alquiler exista
	IF NOT EXISTS (
		SELECT 1
		FROM rental_statuses
		WHERE id = v_rental_status_id
	) THEN
		RAISE EXCEPTION 'Rental status id % is not registered in our database', v_rental_status_id;
	END IF;

	-- 4. Crear el registro del alquiler
	INSERT INTO rentals (user_id, car_id, rental_status_id)
	VALUES (v_user_id, v_car_id, v_rental_status_id);

	-- 5. Cambiar el estado del auto a 'rented'
	UPDATE cars
	SET car_status_id = v_rented_status_id
	WHERE id = v_car_id;

END $$;

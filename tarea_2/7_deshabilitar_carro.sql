-- 7. Un script que deshabilite un automovil del alquiler
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
	v_disabled_status_id INTEGER := 6; 
	v_car_id INTEGER := 4;             
	v_rented_status_id INTEGER := 4;   
BEGIN
	-- 1. Validar que el auto exista
	IF NOT EXISTS (
		SELECT 1
		FROM cars
		WHERE id = v_car_id
	) THEN
		RAISE EXCEPTION 'Car id % is not registered in our database', v_car_id;
	END IF;

	-- 2. Validar que el auto no esté actualmente rentado
	IF EXISTS (
		SELECT 1
		FROM cars
		WHERE id = v_car_id AND car_status_id = v_rented_status_id
	) THEN
		RAISE EXCEPTION 'Car id % is currently rented and cannot be disabled', v_car_id;
	END IF;
	
	-- 3. Deshabilitar el automóvil
	UPDATE cars
	SET car_status_id = v_disabled_status_id
	WHERE id = v_car_id;

END $$;

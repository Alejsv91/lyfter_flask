--4. Un script que cambie el estado de un automovil
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
	v_car_status_id INTEGER := 5;
	v_car_id INTEGER := 4;

BEGIN
	IF NOT EXISTS (
		SELECT *
		FROM car_statuses cs
		WHERE cs.id = v_car_status_id
	) THEN
		RAISE EXCEPTION 'Current v_car_status_id is not available in the database';
	END IF;
	
	IF NOT EXISTS (
		SELECT *
		FROM cars c
		WHERE c.id = v_car_id
	) THEN
		RAISE EXCEPTION 'Current v_car_id is not available in the database';
	END IF;

	UPDATE cars
	SET car_status_id = v_car_status_id
	WHERE id = v_car_id;

END $$;
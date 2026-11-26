--2. Un script que agregue un automovil nuevo

SET search_path TO lyfter_car_rental;

DO $$
DECLARE
v_model_id INTEGER := 5; --Modelo Corolla
v_car_status_id INTEGER := 5; --available

BEGIN
	--Validar si el modelo existe en la base de datos
	IF NOT EXISTS (
		SELECT *
		FROM models m
		WHERE m.id = v_model_id
	
	)	THEN
		RAISE EXCEPTION 'Current model_id is not registered in our database';
	END IF;

	--Validar si el status existe en la base de datos
	IF NOT EXISTS (
		SELECT *
		FROM car_statuses cs
		WHERE cs.id = v_car_status_id
	)	THEN
		RAISE EXCEPTION 'Current car_status_id is not registered in our database';
	END IF;

	INSERT INTO cars (model_id, car_status_id)
	VALUES (v_model_id, v_car_status_id);

END  $$;
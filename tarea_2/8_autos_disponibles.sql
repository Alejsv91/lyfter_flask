-- 8a. Un script que obtenga todos los automoviles alquilados
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
	v_rented_status_id INTEGER := 4; -- ID de 'rented'
	v_car RECORD;
BEGIN
	-- Validar que el estado exista
	IF NOT EXISTS (
		SELECT 1
		FROM car_statuses
		WHERE id = v_rented_status_id
	) THEN
		RAISE EXCEPTION 'Current car_status_id % is not registered in our database', v_rented_status_id;
	END IF;

	-- Recorrer y mostrar los autos alquilados en la consola de mensajes
	FOR v_car IN
		SELECT 
			c.id,
			mk.make_name,
			m.model_name,
			m.fabrication_year
		FROM cars c
		INNER JOIN models m ON c.model_id = m.id
		INNER JOIN makes mk ON m.make_id = mk.id
		WHERE c.car_status_id = v_rented_status_id
	LOOP
		RAISE NOTICE 'Car ID: % | Brand: % | Model: % | Year: % | Status: Rented',
			v_car.id, v_car.make_name, v_car.model_name, v_car.fabrication_year;
	END LOOP;

END $$;

-- 8b. Un script que obtenga todos los automoviles disponibles
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
	v_available_status_id INTEGER := 5; -- ID de 'available'
	v_car RECORD;
BEGIN
	-- Validar que el estado exista
	IF NOT EXISTS (
		SELECT 1
		FROM car_statuses
		WHERE id = v_available_status_id
	) THEN
		RAISE EXCEPTION 'Current car_status_id % is not registered in our database', v_available_status_id;
	END IF;

	-- Recorrer y mostrar los autos disponibles en la consola de mensajes
	FOR v_car IN
		SELECT 
			c.id,
			mk.make_name,
			m.model_name,
			m.fabrication_year
		FROM cars c
		INNER JOIN models m ON c.model_id = m.id
		INNER JOIN makes mk ON m.make_id = mk.id
		WHERE c.car_status_id = v_available_status_id
	LOOP
		RAISE NOTICE 'Car ID: % | Brand: % | Model: % | Year: % | Status: Available',
			v_car.id, v_car.make_name, v_car.model_name, v_car.fabrication_year;
	END LOOP;

END $$;


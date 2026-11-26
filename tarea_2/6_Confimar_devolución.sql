-- 6. Un script que confirme la devolución del auto al completar el alquiler
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
	v_rental_id INTEGER := 1;
	v_rental_complete_status_id INTEGER := 3;
	v_car_status_available_id INTEGER := 5;
	v_car_id INTEGER; -- Aquí guardaremos el ID real del auto rentado
BEGIN
	-- 1. Validar que el rental exista, no esté completado ya, y obtener su car_id
	SELECT car_id INTO v_car_id
	FROM rentals
	WHERE id = v_rental_id
	  AND rental_status_id <> v_rental_complete_status_id;

	-- FOUND es false si el alquiler no existe o si ya estaba completado
	IF NOT FOUND THEN
		RAISE EXCEPTION 'Rental id % does not exist or is already completed', v_rental_id;
	END IF;

	-- 2. Actualizar status del rental usando las variables
	UPDATE rentals
	SET rental_status_id = v_rental_complete_status_id
	WHERE id = v_rental_id;

	-- 3. Actualizar status del auto usando el v_car_id que obtuvimos arriba
	UPDATE cars
	SET car_status_id = v_car_status_available_id
	WHERE id = v_car_id;

END $$;

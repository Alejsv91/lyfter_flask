-- SCHEMA: lyfter_car_rental

-- DROP SCHEMA IF EXISTS lyfter_car_rental ;

	SET search_path TO lyfter_car_rental;

	DO $$
	DECLARE
	    v_name VARCHAR := 'Eva';
	    v_last_name VARCHAR := 'Solano';
	    v_email VARCHAR := 'evaS@gmail.com';
	    v_username VARCHAR := 'Abcd12345/!';
	    v_password VARCHAR := 'MiPassword123!'; 
	    v_birthdate DATE := '2021-09-14';
	    v_active_account BOOLEAN := true;
	BEGIN
	    -- 1. Validar username
	    IF EXISTS (
	        SELECT 1 
	        FROM users u
	        WHERE u.username = v_username 
	    ) THEN
	        RAISE EXCEPTION 'Username already exists in the database';
	    END IF;
	
	    -- 2. Validar email
	    IF EXISTS (
	        SELECT 1
	        FROM users u
	        WHERE u.email = v_email
	    ) THEN
	        RAISE EXCEPTION 'Email already exists in the database';
	    END IF;
	
	    -- 3. Insertar usando las variables declaradas
	    INSERT INTO users (name, last_name, email, username, password, birthdate, active_account)
	    VALUES (v_name, v_last_name, v_email, v_username, v_password, v_birthdate, v_active_account);
	
	END $$;

-- 3. Un script que cambie el estado de un usuario
SET search_path TO lyfter_car_rental;

DO $$
DECLARE
    v_identifier VARCHAR := TRIM(LOWER('evaS@gmail.com')); 
    v_new_status BOOLEAN := false;
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM users u
        WHERE TRIM(LOWER(u.email)) = v_identifier
           OR TRIM(LOWER(u.username)) = v_identifier
    ) THEN 
        RAISE EXCEPTION 'User not found with that email or username';
    END IF;

    UPDATE users
    SET active_account = v_new_status
    WHERE TRIM(LOWER(email)) = v_identifier
       OR TRIM(LOWER(username)) = v_identifier;
END $$;


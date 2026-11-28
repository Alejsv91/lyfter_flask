INSERT INTO lyfter_car_rental.users (
    name, last_name, email, username, password, birthdate, active_account
)
VALUES (%s, %s, %s, %s, %s, %s, %s)
RETURNING id;

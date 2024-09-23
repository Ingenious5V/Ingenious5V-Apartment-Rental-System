-- Create Players Table
CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    player_email VARCHAR(100) UNIQUE NOT NULL
);

-- Create Rentals Table
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_name VARCHAR(100) NOT NULL,
    rental_location VARCHAR(100) NOT NULL,
    rental_price DECIMAL(10, 2) NOT NULL
);

-- Create PlayerRentals Table
CREATE TABLE PlayerRentals (
    player_rental_id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    rental_id INT NOT NULL,
    rental_start_date DATE NOT NULL,
    rental_end_date DATE,
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id)
);

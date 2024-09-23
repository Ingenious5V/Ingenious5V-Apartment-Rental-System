CREATE TABLE IF NOT EXISTS Apartments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    price INT,
    interior_id INT,
    shell_id INT,
    coords VARCHAR(255),
    teleportCoords VARCHAR(255),
    markerCoords VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS RentedApartments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    player_id VARCHAR(255),
    apartment_id INT,
    interior_id INT,
    shell_id INT,
    rent_start DATETIME,
    rent_end DATETIME,
    location_id INT,
    FOREIGN KEY (apartment_id) REFERENCES Apartments(id)
);

-- Add other necessary tables and fields as per your requirements

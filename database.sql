-- Create a table to store player information
CREATE TABLE Players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(255) NOT NULL UNIQUE, -- Unique identifier for each player (e.g., Steam ID, Xbox ID)
    name VARCHAR(255) NOT NULL,
    rent_due DATETIME DEFAULT NULL -- To track when the next rent payment is due
);

-- Create a table to store apartment information
CREATE TABLE Apartments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL -- Price of the apartment rent
);

-- Create a table to manage the rental agreements
CREATE TABLE RentedApartments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    apartment_id INT NOT NULL,
    rent_start DATETIME NOT NULL, -- When the rent starts
    rent_end DATETIME NOT NULL, -- When the rent ends or needs to be renewed
    FOREIGN KEY (player_id) REFERENCES Players(id),
    FOREIGN KEY (apartment_id) REFERENCES Apartments(id)
);

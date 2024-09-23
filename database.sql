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
    interior_id INT NOT NULL, -- Added to track which interior is associated with the rental
    rent_start DATETIME NOT NULL, -- When the rent starts
    rent_end DATETIME NOT NULL, -- When the rent ends or needs to be renewed
    FOREIGN KEY (player_id) REFERENCES Players(id) ON DELETE CASCADE, -- Added ON DELETE CASCADE for better management
    FOREIGN KEY (apartment_id) REFERENCES Apartments(id) ON DELETE CASCADE, -- Added ON DELETE CASCADE for better management
    FOREIGN KEY (interior_id) REFERENCES Interiors(id) -- Make sure to create the Interiors table as well
);

-- Create a table to store interior information
CREATE TABLE Interiors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    image VARCHAR(255) NOT NULL -- Optional: Add an image path if needed for the UI
);

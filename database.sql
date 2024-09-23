-- Create Apartments Table
CREATE TABLE IF NOT EXISTS Apartments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    shell_id INT NOT NULL,
    FOREIGN KEY (shell_id) REFERENCES Shells(id)
);

-- Create Shells Table
CREATE TABLE IF NOT EXISTS Shells (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    coords JSON NOT NULL
);

-- Create RentedApartments Table
CREATE TABLE IF NOT EXISTS RentedApartments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    apartment_id INT NOT NULL,
    shell_id INT NOT NULL,
    rent_start DATETIME NOT NULL,
    rent_end DATETIME NOT NULL,
    FOREIGN KEY (apartment_id) REFERENCES Apartments(id),
    FOREIGN KEY (shell_id) REFERENCES Shells(id)
);

-- Insert Initial Shells Data
INSERT INTO Shells (name, coords) VALUES
('K4MB1 Shell 1', '{"x":-1037.857,"y":-2736.747,"z":20.169}'),
('K4MB1 Shell 2', '{"x":-1051.372,"y":-2742.367,"z":20.169}'),
('K4MB1 Shell 3', '{"x":-1064.144,"y":-2748.409,"z":20.169}'),
('K4MB1 Shell 4', '{"x":-1076.447,"y":-2754.431,"z":20.169}');

-- Insert Initial Apartments Data
INSERT INTO A

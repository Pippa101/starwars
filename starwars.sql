DROP DATABASE IF EXISTS starwars;
CREATE DATABASE starwars;

\c starwars;

CREATE TABLE planets (
    planet_id SERIAL PRIMARY KEY,
    planet_name TEXT NOT NULL UNIQUE,
    sector TEXT,
    terrain TEXT,
    planet_population INT,
    affiliation TEXT
);

INSERT INTO planets(planet_name, sector, terrain, planet_population, affiliation)
VALUES
('Tatooine', 'Outer Rim', 'Desert', 200000, 'Neutral'),
('Alderaan', 'Core Worlds', 'Grasslands', 2000000, 'Rebel'),
('Hoth', 'Outer Rim', 'Ice', 0, 'Rebel'),
('Endor', 'Outer Rim', 'Forest', 30000, 'Neutral'),
('Yavin 4', 'Core Worlds', 'Urban', 1000000000, 'Empire'),
('Hoth', 'Outer Rim', 'Jungle', 1000, 'Rebel'),
('Bespin', 'Outer Rim', 'Gas Clouds', 6000000, 'Empire'),
('Naboo', 'Mid Rim', 'Grasslands', 4500000000, 'Empire'),
('Jakku','Inner Rim','Desert',50,'Neutral'),
('Lothal','Outer Rim','Grasslands',1000000,'Rebel');


CREATE TABLE RebelAgents(
    agent_id SERIAL PRIMARY KEY,
    codename TEXT,
    species TEXT,
    rank TEXT,
    homeworld TEXT REFERENCES Planets(planet_name),
    years_of_service INT,
    contact_frequency TEXT 
);

INSERT INTO RebelAgents
(codename,species,rank,homeworld,years_of_service,contact_frequency)
Values
('Rogue One', 'Human', 'Captain', 'Yavin 4', 5, 'High');


CREATE TABLE Starships(
    ship_id SERIAL PRIMARY KEY,
    captain INT,
    FOREIGN KEY (captain) REFERENCES RebelAgents(agent_id),
    ship_name TEXT,
    class TEXT,
    hyperdrive FLOAT(2),
    armament TEXT,
    ship_status TEXT 
);

INSERT INTO Starships
(ship_name,class,hyperdrive,armament,ship_status)
Values
('Millennium Falcon', 'YT-1300', 0.5, 'Turrets', 'Active');




CREATE TABLE Missions(
    mission_id SERIAL PRIMARY KEY,
    associated_starship INT,
    FOREIGN KEY (associated_starship) REFERENCES Starships(ship_id),
    destinationID INT,
    FOREIGN KEY (destinationID) REFERENCES Planets(planet_id),
    objective TEXT,
    mission_start_date DATE,
    mission_end_date DATE,
    mission_status TEXT,
    report_summary TEXT 
);

INSERT INTO Missions
(objective,mission_start_date,mission_end_date,mission_status,report_summary)
Values
('Steal Death Star plans', '2022-03-15', '2022-03-17', 'Completed', 'Obtained plans from Scarif base');



SELECT * FROM Planets;
SELECT * FROM RebelAgents;
SELECT * FROM Starships;
SELECT * FROM Missions;

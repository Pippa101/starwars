DROP DATABASE IF EXISTS starwars;
CREATE DATABASE starwars;

\c starwars

CREATE TABLE Planets (
    planet_id INT PRIMARY KEY,
    planet_name TEXT NOT NULL,
    sector TEXT NOT NULL,
    terrain TEXT NOT NULL,
    planet_population INT NOT NULL,
    affiliation TEXT NOT NULL
);


CREATE TABLE Starships(
    ship_id INT PRIMARY KEY,
    FOREIGN KEY (captain) REFERENCES RebelAgents(agent_id),
    ship_name TEXT NOT NULL,
    class TEXT NOT NULL,
    hyperdrive FLOAT(2) NOT NULL,
    armament TEXT NOT NULL,
    ship_status TEXT NOT NULL
);


CREATE TABLE RebelAgents(
    agent_id INT PRIMARY KEY,
    codename TEXT NOT NULL,
    species TEXT NOT NULL,
    rank TEXT NOT NULL,
    FOREIGN KEY (homeworld) REFERENCES Planets(planet_id),
    years_of_service INT NOT NULL,
    contact_frequency TEXT NOT NULL
);

CREATE TABLE Missions(
    mission_id INT PRIMARY KEY,
    FOREIGN KEY (associated_starship) REFERENCES Starships(ship_id),
    FOREIGN KEY (destinationID) REFERENCES Planets(planet_id),
    objective TEXT NOT NULL,
    mission_start_date DATE NOT NULL,
    mission_end_date DATE NOT NULL,
    mission_status TEXT NOT NULL,
    report_summary TEXT NOT NULL
);



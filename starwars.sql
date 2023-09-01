DROP DATABASE IF EXISTS starwars;
CREATE DATABASE starwars;

\c starwars;

CREATE TABLE planets (
    planet_id SERIAL PRIMARY KEY,
    planet_name TEXT NOT NULL UNIQUE,
    sector TEXT,
    terrain TEXT,
    planet_population BIGINT,
    affiliation TEXT
);

INSERT INTO planets(planet_name, sector, terrain, planet_population, affiliation)
VALUES
('Tatooine', 'Outer Rim', 'Desert', 200000, 'Neutral'),
('Alderaan', 'Core Worlds', 'Grasslands', 2000000, 'Rebel'),
('Hoth', 'Outer Rim', 'Ice', 0, 'Rebel'),
('Endor', 'Outer Rim', 'Forest', 30000, 'Neutral'),
('Coruscant', 'Core Worlds', 'Urban', 1000000000, 'Empire'),
('Yavin 4', 'Outer Rim', 'Jungle', 1000, 'Rebel'),
('Bespin', 'Outer Rim', 'Gas Clouds', 6000000, 'Empire'),
('Naboo', 'Mid Rim', 'Grasslands', 4500000000, 'Empire'),
('Jakku','Inner Rim','Desert',50,'Neutral'),
('Lothal','Outer Rim','Grasslands',1000000,'Rebel');


CREATE TABLE RebelAgents(
    agent_id SERIAL PRIMARY KEY,
    codename TEXT,
    species TEXT,
    rank TEXT,
    homeworld TEXT,
    years_of_service INT,
    contact_frequency TEXT 
);

INSERT INTO RebelAgents
(codename,species,rank,homeworld,years_of_service,contact_frequency)
Values
('Rogue One', 'Human', 'Captain', 'Yavin 4', 5, 'High'),
('Specter 5', 'Twi''lek','Lieutenant', 'Ryloth', 3, 'Moderate'),
('Pathfinder', 'Mon Calamari', 'Admiral', 'Mon Cala', 10, 'Low'),
('Ghost','Lasat', 'Commander', 'Lasan', 2, 'High'),
('Ace', 'Duros', 'Captain', 'Bespin', 7, 'Moderate'),
('Havoc Six', 'Zabrak', 'Lieutenant', 'Iridonia', 4, 'Moderate'),
('Whisperer', 'Mirialan', 'Operative', 'Mirial', 2,'High'),
('Nomad','Human', 'Sergeant', 'Corellia', 6, 'Low'),
('Specter 7','Duros', 'Captain', 'Coruscant', 8, 'Moderate'),
('Fulcrum','Clawdite','Commander','Naboo',5,'High');


CREATE TABLE Starships(
    ship_id SERIAL PRIMARY KEY,
    ship_name TEXT,
    class TEXT,
    hyperdrive FLOAT(2),
    armament TEXT,
    ship_status TEXT 
);

-- need to create a junction table to fix the captain column, the table should include an agent id and a ship to show who is the captain


INSERT INTO Starships
(ship_name,class,hyperdrive,armament,ship_status)
Values
('Millennium Falcon', 'YT-1300', 0.5, 'Turrets', 'Active'),
('Tantive IV','CR90 Corvette',2.0,'Laser Cannons','Decommissioned'),
('X-Wing Red 5','T-65 X-Wing',1.0,'Proton Torpedoes','Active'),
('Slave I','Firespray-31',1.5,'Blaster Cannons','In Repair'),
('Star Destroyer','Imperial-class',2.0,'Turbolasers','Active'),
('A-Wing Green 3','RZ-1 A-Wing',1.5,'Laser Cannons','Active'),
('B-Wing Dagger 9','Blade Wing', 2.0,'Ion Cannons','In Repair'),
('Falcon''s Pride','YT-1300',0.7,'Quad Laser Turrets','Active'),
('Rogue Shadow','Star Courier',1.8,'Blaster Cannons','Active'),
('Ghost II','Modified VCX-100',1.5,'Blaster Turrets','Active');



CREATE TABLE starship_captains(
    starship_captains_id SERIAL PRIMARY KEY,
    ship_id INT,
    FOREIGN KEY (ship_id) REFERENCES Starships(ship_id),
    captain INT,
    FOREIGN KEY (captain) REFERENCES RebelAgents(agent_id)
);

INSERT INTO starship_captains(ship_id, captain)
VALUES(1,7),(2,8),(3,8),(4,4),(5,5),(6,10),(7,6),(8,1),(9,3),(10,4);


CREATE TABLE Missions(
    mission_id SERIAL PRIMARY KEY,
    mission_captain_id INT,
    FOREIGN KEY (mission_captain_id) REFERENCES starship_captains(starship_captains_id),
    destination_id INT,
    FOREIGN KEY (destination_id) REFERENCES Planets(planet_id),
    objective TEXT,
    mission_start_date DATE,
    mission_end_date DATE,
    mission_status TEXT,
    report_summary TEXT 
);

INSERT INTO Missions
(mission_captain_id,destination_id,objective,mission_start_date,mission_end_date,mission_status,report_summary)
Values
(1,2,'Steal Death Star plans', '2022-03-15', '2022-03-17', 'Completed', 'Obtained plans from Scarif base'),
(8,3, 'Establish Echo Base','2022-11-01','2023-01-05','Ongoing','Hoth base operational, facing Empire attacks'),
(4,4,'Destroy Death Star II','2023-06-10','2023-06-12','Completed','Successful destruction near Endor'),
(9,1,'Infiltrate Jabba''s Palace','2023-02-20','2023-02-23','Aborted','Captured and imprisoned, mission compromised'),
(6,5,'Rescue Senator Amidala','2023-08-15','2023-08-17','Ongoing','Infiltrating Coruscant, facing Empire''s grip'),
(7,8,'Extract Naboo Diplomat','2023-04-02','2023-04-05','Completed','Rescued Naboo diplomat from Imperial custody'),
(10,6,'Smuggling Supplies to Lothal','2023-07-20','2023-07-23','Ongoing', 'Evading Imperial patrols, delivering goods'),
(4,7,'Infiltrate Cloud City','2022-09-15','2022-09-17','Aborted','Discovered by authorities, mission compromised'),
(4,9,'Locate Jakku Artifact','2023-01-10','2023-01-12','Completed','Recovered ancient artifact from desert ruins'),
(5,10,'Establish Lothal Rebel Cell','2023-06-01','2023-06-03','Ongoing','Training local recruits, expanding rebel presence');


SELECT * FROM Planets;
SELECT * FROM RebelAgents;
SELECT * FROM Starships;
SELECT * FROM starship_captains;
JOIN Starships ON starship_captains.ship_id = Starships.ship_id;
JOIN RebelAgents ON starship_captains.captain = RebelAgents.agent_id;
SELECT * FROM Missions;

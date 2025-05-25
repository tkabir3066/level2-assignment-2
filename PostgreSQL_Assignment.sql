-- Active: 1747503291940@@localhost@5432@conservation_db
-- CREATE DATABASE conservation_db;


-- creating table of rangers, species and sightings

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);


CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE,
    conservation_status VARCHAR(50) CHECK (
             conservation_status IN (
            'Vulnerable',
            'Endangered',
            'Critically Endangered'
    )
    )
);

CREATE TABLE sightings (
sighting_id SERIAL PRIMARY KEY,
ranger_id INTEGER NOT NULL REFERENCES rangers(ranger_id),
species_id INTEGER NOT NULL REFERENCES species(species_id),
sighting_time TIMESTAMP NOT NULL,
location TEXT NOT NULL,
notes TEXT
);


-- inserted data into rangers table
INSERT INTO rangers (name, region) VALUES ('Alice Green', 'Northern Hills'), ('Bob White', 'River Delta'), ('Carol King', 'Mountain Range');


-- inserted data into species table
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'), 
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(' Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Javan Rhino', 'Rhinoceros sondaicus', '1822-07-20', 'Critically Endangered')


-- inserted data into sightings table
INSERT INTO sightings (ranger_id, species_id, location, sighting_time, notes) VALUES 
(1,1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2,2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3,3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1,2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- PROBLEM-1

INSERT INTO rangers(name, region) VALUES ('Derek Fox', 'Coastal Plains');


-- PROBLEM-2

SELECT count(DISTINCT species_id) AS unique_species_count  FROM sightings;



-- PROBLEM-3

SELECT * FROM sightings
WHERE location ILIKE '%Pass%'


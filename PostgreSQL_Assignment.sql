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
            'Endangered'
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
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');



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


-- PROBLEM-4

SELECT name, count(sighting_id) AS total_sightings FROM rangers
JOIN sightings on rangers.ranger_id = sightings.ranger_id
GROUP BY name, name;


-- PROBLEM-5

SELECT common_name FROM species
LEFT JOIN sightings USING(species_id)
WHERE sighting_id IS NULL;

-- PROBLEM-6

SELECT 
    common_name, 
    sighting_time, 
    "name"
FROM sightings 
JOIN species USING(species_id)
JOIN rangers USING(ranger_id)
ORDER BY sighting_time DESC
LIMIT 2;




-- PROBLEM-7

-- drop the old check constrain 
ALTER TABLE species DROP CONSTRAINT species_conservation_status_check;

-- Add the new CHECK constraint including 'Historic'

ALTER TABLE species
ADD CONSTRAINT species_conservation_status_check
CHECK (conservation_status IN ('Vulnerable', 'Endangered', 'Historic'));

-- update the species
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';


-- PROBLEM-8

SELECT sighting_id,
    CASE
        WHEN EXTRACT(HOUR FROM sightings.sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sightings.sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
        END AS time_of_day
    FROM sightings;
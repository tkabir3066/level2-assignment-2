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
            'Least Concern',
            'Near Threatened',
            'Vulnerable',
            'Endangered',
            'Critically Endangered',
            'Extinct in the Wild',
            'Extinct'
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



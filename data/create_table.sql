-- Création des tables

BEGIN;

DROP TABLE IF EXISTS "circuit", "current_saison_team", "team", "current_saison_driver", "driver", "race" CASCADE;


CREATE TABLE IF NOT EXISTS "circuit" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "first_time" TEXT NOT NULL,
    "lap_number" INTEGER NOT NULL,
    "circuit_lap_lenght" INTEGER NOT NULL,
    "circuit_distance" INTEGER NOT NULL,
    "lap_record" JSON
);

CREATE TABLE IF NOT EXISTS "current_saison_team" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "podiums" INTEGER NOT NULL,
    "wins" INTEGER NOT NULL,
    "points" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "team" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "logo" TEXT NOT NULL,
    "car_image" TEXT NOT NULL,
    "first_time" INTEGER NOT NULL,
    "chief" TEXT NOT NULL,
    "wins" INTEGER NOT NULL,
    "world_championships" INTEGER NOT NULL,
    "saison_team_id" INTEGER NOT NULL REFERENCES "current_saison_team"("id")
);

CREATE TABLE IF NOT EXISTS "current_saison_driver" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "highest_grid_position" INTEGER NOT NULL,
    "highest_race_finish" INTEGER NOT NULL,
    "podiums" INTEGER NOT NULL,
    "wins" INTEGER NOT NULL,
    "points" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "driver" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "photo" TEXT NOT NULL,
    "nationality" TEXT NOT NULL,
    "birthday" TEXT NOT NULL,
    "birthday_place" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "participations" INTEGER NOT NULL,
    "highest_grid_position" INTEGER NOT NULL,
    "highest_race_finish" INTEGER NOT NULL,
    "podiums" INTEGER NOT NULL,
    "wins" INTEGER NOT NULL,
    "points" INTEGER NOT NULL,
    "world_championships" INTEGER NOT NULL,
    "team_id" INTEGER NOT NULL REFERENCES "team"("id"),
    "saison_driver_id" INTEGER NOT NULL REFERENCES "current_saison_driver"("id")
);

CREATE TABLE IF NOT EXISTS "race" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "driver_id" INTEGER NOT NULL REFERENCES "driver"("id"),
    "circuit_id" INTEGER NOT NULL REFERENCES "circuit"("id"),
    "team_id" INTEGER NOT NULL REFERENCES "team"("id"),
    "date" DATE NOT NULL,
    "ranking" INTEGER NOT NULL
);

COMMIT;
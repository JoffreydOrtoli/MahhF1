BEGIN;

DROP TABLE IF EXISTS "circuit", "current_saison_team", "team", "current_saison_driver", "driver", "race", "qualifying", "qualifying_race" CASCADE;

CREATE TABLE IF NOT EXISTS "circuit" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL,
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
    "best_lap" BOOLEAN NOT NULL,
    "date" DATE NOT NULL,
    "ranking" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "qualifying_race" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "driver_id" INTEGER NOT NULL REFERENCES "driver"("id"),
    "circuit_id" INTEGER NOT NULL REFERENCES "circuit"("id"),
    "team_id" INTEGER NOT NULL REFERENCES "team"("id"),
    "best_lap" BOOLEAN NOT NULL,
    "date" DATE NOT NULL,
    "ranking" INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS "qualifying" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "driver_id" INTEGER NOT NULL REFERENCES "driver"("id"),
    "circuit_id" INTEGER NOT NULL REFERENCES "circuit"("id"),
    "team_id" INTEGER NOT NULL REFERENCES "team"("id"),
    "best_lap" BOOLEAN NOT NULL,
    "date" DATE NOT NULL,
    "ranking" INTEGER NOT NULL
);

-- function new_qualifying

CREATE OR REPLACE FUNCTION new_qualifying(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	best_lap BOOLEAN,
	"date" DATE,
	ranking INT
) RETURNS qualifying AS $$
    INSERT INTO qualifying
    ("driver_id", "circuit_id", "team_id", "best_lap", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"best_lap",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;

-- function new_qualifying_race (/!\ Voir les points !)

CREATE OR REPLACE FUNCTION new_qualifying_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	best_lap BOOLEAN,
	"date" DATE,
	ranking INT
) RETURNS qualifying_race AS $$
    UPDATE driver
		SET participations = participations + 1,
			podiums = podiums +1,
			wins = wins +1,
			points = points + 8
	WHERE id=driver_id AND ranking = 1;
	UPDATE current_saison_driver
		SET podiums = podiums + 1,
			wins = wins + 1,
			points = points + 8
	WHERE id=driver_id AND ranking = 1;
	UPDATE team
		SET wins = wins + 1
	WHERE id=team_id AND ranking = 1;
	UPDATE current_saison_team
		SET podiums = podiums + 1,
			wins = wins + 1,
			points = points + 8
	WHERE id=team_id AND ranking = 1;
	UPDATE driver
		SET participations = participations + 1,
			podiums = podiums +1,
			points = points + 7
	WHERE id=driver_id AND ranking = 2;
	UPDATE current_saison_driver
		SET podiums = podiums + 1,
			points = points + 7
	WHERE id=driver_id AND ranking = 2;
	UPDATE current_saison_team
		SET podiums = podiums + 1,
			points = points + 7
	WHERE id=team_id AND ranking = 2;
	UPDATE driver
		SET participations = participations + 1,
			podiums = podiums + 1,
			points = points + 6
	WHERE id=driver_id AND ranking = 3;
	UPDATE current_saison_driver
		SET podiums = podiums + 1,
			points = points + 6
	WHERE id=driver_id AND ranking = 3;
	UPDATE current_saison_team
		SET podiums = podiums + 1,
			points = points + 6
	WHERE id=team_id AND ranking = 3;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 5
	WHERE id=driver_id AND ranking = 4;
	UPDATE current_saison_driver
		SET	points = points + 5
	WHERE id=driver_id AND ranking = 4;
	UPDATE current_saison_team
		SET points = points + 5
	WHERE id=team_id AND ranking = 4;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 4
	WHERE id=driver_id AND ranking = 5;
	UPDATE current_saison_driver
		SET	points = points + 4
	WHERE id=driver_id AND ranking = 5;
	UPDATE current_saison_team
		SET points = points + 4
	WHERE id=team_id AND ranking = 5;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 3
	WHERE id=driver_id AND ranking = 6;
	UPDATE current_saison_driver
		SET	points = points + 3
	WHERE id=driver_id AND ranking = 6;
	UPDATE current_saison_team
		SET points = points + 3
	WHERE id=team_id AND ranking = 6;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 2
	WHERE id=driver_id AND ranking = 7;
	UPDATE current_saison_driver
		SET	points = points + 2
	WHERE id=driver_id AND ranking = 7;
	UPDATE current_saison_team
		SET points = points + 2
	WHERE id=team_id AND ranking = 7;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 1
	WHERE id=driver_id AND ranking = 8;
	UPDATE current_saison_driver
		SET	points = points + 1
	WHERE id=driver_id AND ranking = 8;
	UPDATE current_saison_team
		SET points = points + 1
	WHERE id=team_id AND ranking = 8;
    INSERT INTO qualifying_race
    ("driver_id", "circuit_id", "team_id", "best_lap", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"best_lap",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;

-- function new_race

CREATE OR REPLACE FUNCTION new_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	best_lap BOOLEAN,
	"date" DATE,
	ranking INT
) RETURNS race AS $$
	UPDATE driver
		SET participations = participations + 1,
			podiums = podiums +1,
			wins = wins +1,
			points = points + 25
	WHERE id=driver_id AND ranking = 1;
	UPDATE current_saison_driver
		SET podiums = podiums + 1,
			wins = wins + 1,
			points = points + 25
	WHERE id=driver_id AND ranking = 1;
	UPDATE team
		SET wins = wins + 1
	WHERE id=team_id AND ranking = 1;
	UPDATE current_saison_team
		SET podiums = podiums + 1,
			wins = wins + 1,
			points = points + 25
	WHERE id=team_id AND ranking = 1;
	UPDATE driver
		SET participations = participations + 1,
			podiums = podiums +1,
			points = points + 18
	WHERE id=driver_id AND ranking = 2;
	UPDATE current_saison_driver
		SET podiums = podiums + 1,
			points = points + 18
	WHERE id=driver_id AND ranking = 2;
	UPDATE current_saison_team
		SET podiums = podiums + 1,
			points = points + 18
	WHERE id=team_id AND ranking = 2;
	UPDATE driver
		SET participations = participations + 1,
			podiums = podiums + 1,
			points = points + 15
	WHERE id=driver_id AND ranking = 3;
	UPDATE current_saison_driver
		SET podiums = podiums + 1,
			points = points + 15
	WHERE id=driver_id AND ranking = 3;
	UPDATE current_saison_team
		SET podiums = podiums + 1,
			points = points + 15
	WHERE id=team_id AND ranking = 3;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 12
	WHERE id=driver_id AND ranking = 4;
	UPDATE current_saison_driver
		SET	points = points + 12
	WHERE id=driver_id AND ranking = 4;
	UPDATE current_saison_team
		SET points = points + 12
	WHERE id=team_id AND ranking = 4;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 10
	WHERE id=driver_id AND ranking = 5;
	UPDATE current_saison_driver
		SET	points = points + 10
	WHERE id=driver_id AND ranking = 5;
	UPDATE current_saison_team
		SET points = points + 10
	WHERE id=team_id AND ranking = 5;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 8
	WHERE id=driver_id AND ranking = 6;
	UPDATE current_saison_driver
		SET	points = points + 8
	WHERE id=driver_id AND ranking = 6;
	UPDATE current_saison_team
		SET points = points + 8
	WHERE id=team_id AND ranking = 6;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 6
	WHERE id=driver_id AND ranking = 7;
	UPDATE current_saison_driver
		SET	points = points + 6
	WHERE id=driver_id AND ranking = 7;
	UPDATE current_saison_team
		SET points = points + 6
	WHERE id=team_id AND ranking = 7;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 4
	WHERE id=driver_id AND ranking = 8;
	UPDATE current_saison_driver
		SET	points = points + 4
	WHERE id=driver_id AND ranking = 8;
	UPDATE current_saison_team
		SET points = points + 4
	WHERE id=team_id AND ranking = 8;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 2
	WHERE id=driver_id AND ranking = 9;
	UPDATE current_saison_driver
		SET	points = points + 2
	WHERE id=driver_id AND ranking = 9;
	UPDATE current_saison_team
		SET points = points + 2
	WHERE id=team_id AND ranking = 9;
	UPDATE driver
		SET participations = participations + 1,
			points = points + 1
	WHERE id=driver_id AND ranking = 10;
	UPDATE current_saison_driver
		SET	points = points + 1
	WHERE id=driver_id AND ranking = 10;
	UPDATE current_saison_team
		SET points = points + 1
	WHERE id=team_id AND ranking = 10;
	UPDATE driver
		SET participations = participations + 1
	WHERE id=driver_id AND ranking > 10;
	UPDATE driver
		SET highest_race_finish = ranking
	WHERE id=driver_id AND ranking < highest_race_finish;
	UPDATE current_saison_driver
		SET highest_race_finish = ranking
	WHERE id=driver_id AND ranking < highest_race_finish;
	UPDATE driver
		SET points = points + 1
	WHERE id=driver_id AND best_lap = true;
	UPDATE current_saison_driver
		SET	points = points + 1
	WHERE id=driver_id AND best_lap = true;
	UPDATE current_saison_team
		SET points = points + 1
	WHERE id=team_id AND best_lap = true;
    INSERT INTO race
    ("driver_id", "circuit_id", "team_id", "best_lap", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"best_lap",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;

--  Vue classement pilotes (drivers_ranking)
CREATE VIEW drivers_ranking AS
	SELECT driver.id,
		driver.name,
		driver.firstname,
		driver.number,
		current_saison_driver.points
	   FROM driver
		JOIN current_saison_driver ON saison_driver_id = current_saison_driver.id
		ORDER BY current_saison_driver.points DESC;
		
--   Vue classement constructeurs (teams_ranking)
CREATE VIEW teams_ranking AS
	SELECT team.id,
	team.name,
    current_saison_team.points
   FROM team
   JOIN current_saison_team ON saison_team_id = current_saison_team.id
  ORDER BY current_saison_team.points DESC;

-- Vue classement par week-end
-- bahrain_race_ranking
CREATE VIEW bahrain_race_ranking AS
	SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
		FROM race
		JOIN driver ON race.driver_id = driver.id
		JOIN circuit ON race.circuit_id = circuit.id
		JOIN team ON race.team_id = team.id
		WHERE race.date = '2022-03-20'
		ORDER BY race.ranking ASC;

-- jeddah_race_ranking
CREATE VIEW jeddah_race_ranking AS
	SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
		FROM race
		JOIN driver ON race.driver_id = driver.id
		JOIN circuit ON race.circuit_id = circuit.id
		JOIN team ON race.team_id = team.id
		WHERE race.date = '2022-03-27'
		ORDER BY race.ranking ASC;

-- albert-park_race_ranking
CREATE VIEW albert_park_race_ranking AS
	SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
		FROM race
		JOIN driver ON race.driver_id = driver.id
		JOIN circuit ON race.circuit_id = circuit.id
		JOIN team ON race.team_id = team.id
		WHERE race.date = '2022-04-10'
		ORDER BY race.ranking ASC;

-- emilia-romagna_race_ranking
CREATE VIEW emilia_romagna_race_ranking AS
	SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
		FROM race
		JOIN driver ON race.driver_id = driver.id
		JOIN circuit ON race.circuit_id = circuit.id
		JOIN team ON race.team_id = team.id
		WHERE race.date = '2022-04-24'
		ORDER BY race.ranking ASC;

-- miami_race_ranking
CREATE VIEW miami_race_ranking AS
	SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
		FROM race
		JOIN driver ON race.driver_id = driver.id
		JOIN circuit ON race.circuit_id = circuit.id
		JOIN team ON race.team_id = team.id
		WHERE race.date = '2022-05-08'
		ORDER BY race.ranking ASC;

-- barcelone_race_ranking
CREATE VIEW barcelone_race_ranking AS
	SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
		FROM race
		JOIN driver ON race.driver_id = driver.id
		JOIN circuit ON race.circuit_id = circuit.id
		JOIN team ON race.team_id = team.id
		WHERE race.date = '2022-05-22'
		ORDER BY race.ranking ASC;

INSERT INTO "circuit" ("name", "country", "first_time", "lap_number", "circuit_lap_lenght", "circuit_distance", "lap_record") VALUES
('Bahrein', 'Abu Dhabi', 2004, 57, 5412, 308.238, '{"time": "1:31:447", "name": "Pedro de la Rosa", "year": 2005}'),
('Jeddah', 'Arabie saoudite ', 2021, 50, 6174, 308.45, '{"time": "1:30:734", "name": "Lewis Hamilton", "year": 2021}'),
('Albert park', 'Australie', 1996, 58, 5278, 306.124, '{"time": "1:20:260", "name": "Charles Leclerc", "year": 2022}'),
('Emilia Romagna', 'Italie', 1980, 63, 4909, 309.049, '{"time": "1:15:484", "name": "Lewis Hamilton", "year": 2020}'),
('Miami', 'Etats-Unis', 2022, 57, 5410, 308.37, '{"time": "1:31:361", "name": "Max Verstappen", "year": 2022}'),
('Barcelone', 'Espagne', 1991, 66, 4675, 308.424, '{"time": "1:18:149", "name": "Max Verstappen", "year": 2021}'),
('Monaco', 'Monaco', 1950, 78, 3337, 260.286, '{"time": "1:12:909", "name": "Lewis Hamilton", "year": 2021}'),
('Baku', 'Azerbaijan', 2016, 51, 6003, 306.049, '{"time": "1:43:009", "name": "Charles Leclerc", "year": 2019}'),
('Gilles-Villeneuve', 'Canada', 1978, 70, 4361, 305.27, '{"time": "1:13:078", "name": "Valtteri Bottas", "year": 2019}'),
('Silverstone', 'Grande Bretagne', 52, 5891, 306.198, 1950, '{"time": "1:27:097", "name": "Max Verstappen", "year": 2020}'),
('Red Bull Ring', 'Autriche', 1970, 71, 4318, 306.452, '{"time": "1:05:619", "name": "Carlos Sainz", "year": 2020}'),
('Paul Ricard', 'France', 1971, 53, 5842, 309.69, '{"time": "1:32:740", "name": "Sebastian Vettel", "year": 2019}'),
('Hungaroring', 'Hongrie', 1986, 70, 4381, 306.63, '{"time": "1:16:627", "name": "Lewis Hamilton", "year": 2020}'),
('Spa-Francorchamps', 'Belgique', 1950, 44, 7004, 308.052, '{"time": "1:46:286", "name": "Valtteri Bottas", "year": 2018}'),
('Zandvoort', 'Hongrie', 1952, 72, 4259, 306.587, '{"time": "1:11:097", "name": "Lewis Hamilton", "year": 2021}'),
('Monza', 'Italie', 1950, 53, 5793, 306.72, '{"time": "1:21:046", "name": "Rubens Barrichello", "year": 2004}'),
('Marina Bay', 'Singapour', 2008, 61, 5063, 308.706, '{"time": "1:41:905", "name": "Kevin Magnussen", "year": 20018}'),
('Suzuka', 'Japon', 1987, 53, 5807, 307.471, '{"time": "1:30:987", "name": "Lewis Hamilton", "year": 2019}'),
('Of the Americas', 'Etats-Unis', 2012, 53, 5807, 307.471, '{"time": "1:36:169", "name": "Charles Leclerc", "year": 2019}'),
('Hermanos Rodriguez', 'Mexique', 1963, 71, 4304, 305.354, '{"time": "1:17:774", "name": "Valtteri Bottas", "year": 2021}'),
('Jose Carlos Pace', 'Brésil', 1973, 71, 4309, 305.879, '{"time": "1:10:540", "name": "Valtteri Bottas", "year": 2018}'),
('Yas Marina', 'Abu Dhabi', 2009, 58, 5281, 306.183, '{"time": "1:26:103", "name": "Max Verstappen", "year": 2021}');

INSERT INTO "current_saison_team" ("podiums", "wins", "points") VALUES
(0, 0, 25),
(0, 0, 16),
(0, 0, 22),
(0, 0, 5),
(5, 2, 124),
(0, 0, 15),
(1, 0, 46),
(2, 0, 77),
(4, 2, 113),
(0, 0, 1);

INSERT INTO "team" ("name", "first_time", "chief", "wins", "world_championships", "saison_team_id") VALUES
('Alfa Romeo F1 Team', 1993, 'Frédéric Vasseur', 1, 0, 1),
('Scuderia AlphaTauri', 1985, 'Franz Tost', 2, 0, 2),
('BWT Alpine F1 Team', 1986, 'Otmar Szafnauer', 21, 2, 3),
('Aston Martin F1 Team', 2018, 'Mike Krack', 1, 0, 4),
('Scuderia Ferrari', 1950, 'Mattia Binotto', 241, 16, 5),
('Haas F1 Team', 2016, 'Guenther Steiner', 0, 0, 6),
('McLaren F1 Team', 1966, 'Andreas Seidl', 183, 8, 7),
('Mercedes-AMG Petronas F1 Team', 1970, 'Toto Wolff', 115, 8, 8),
('Oracle Red Bull Racing', 1997, 'Christian Horner', 77, 4, 9),
('Williams Racing', 1978, 'Jost Capito', 114, 9, 10);

INSERT INTO "current_saison_driver" ("highest_grid_position", "highest_race_finish", "podiums", "wins", "points") VALUES
(14, 10, 0, 0, 1),
(7, 9, 0, 0, 2),
(6, 5, 0, 0, 24),
(9, 8, 0, 0, 6),
(5, 10, 1, 0, 28),
(18, 16, 0, 0, 0),
(1, 1, 3, 2, 86),
(7, 5, 0, 0, 15),
(4, 3, 1, 0, 35),
(5, 6, 0, 0, 20),
(1, 2, 2, 0, 54),
(6, 6, 0, 0, 11),
(6, 3, 1, 0, 49),
(3, 2, 2, 0, 38),
(10, 11, 0, 0, 0),
(13, 10, 0, 0, 1),
(12, 7, 0, 0, 10),
(1, 1, 3, 3, 59),
(13, 8, 0, 0, 4),
(12, 10, 0, 0, 1);

INSERT INTO "driver" ("name", "firstname", "nationality", "birthday", "birthday_place", "number", "participations", "highest_grid_position", "highest_race_finish", "podiums", "wins", "points", "world_championships", "team_id", "saison_driver_id") VALUES
('Albon', 'Alexander', 'Thailandais', '23/03/1996', 'Londre, Angleterre', 23, 42, 4, 3, 2, 0, 198, 0, 10, 1),
('Alonso', 'Fernando', 'Espagnol', '29/07/1981', 'Oviedo, Espagne', 14, 340, 1, 1, 98, 32, 1982, 2, 3, 2),
('Bottas', 'Valtteri', 'Finlandais', '28/08/1989', 'Nastola, Finlande', 77, 182, 1, 1, 67, 10, 1762, 0, 1,3),
('Gasly', 'Pierre', 'Français', '07/02/1996', 'Rouen, France', 10, 90, 2, 1, 3, 1, 315, 0, 2, 4),
('Hamilton', 'Lewis', 'Anglais', '07/01/1985', 'Stevenage, Angleterre', 44, 292, 1, 1, 183, 103, 4193.5, 8, 8, 5),
('Latifi', 'Nicholas', 'Canadiens', '29/06/1995', 'Montreal, Canada', 6, 43, 10, 7, 0, 0, 7, 0, 10, 6),
('Leclerc', 'Charles', 'Monegasque', '16/10/1997', 'Monte Carlo, Monaco', 16, 85, 1, 1, 16, 4, 646, 0, 5, 7),
('Magnussen', 'Kevin', 'Danois', '05/10/1992', 'Roskilde, Danemarque', 20, 124, 4, 2, 1, 0, 173, 0, 6, 8),
('Norris', 'Lando', 'Anglais', '13/11/1999', 'Bristol, Angleterre', 4, 64, 1, 2, 6, 0, 341, 0, 7, 9),
('Ocon', 'Esteban', 'Français', '17/09/1996', 'Evreux, France', 31, 93, 3, 1, 2, 1, 292, 0, 3, 10),
('Perez', 'Sergio', 'Mexicain', '26/01/1990', 'Guadalajara, Mexique', 11, 218, 1, 1, 17, 2, 950, 0, 9, 11),
('Ricciardo', 'Daniel', 'Australien', '01/07/1989', 'Perth, Australia', 3, 214, 1, 1, 32, 8, 1282, 0, 7, 12),
('Russell', 'George', 'Anglais', '15/02/1998', 'King"s Lynn, Angleterre', 63, 64, 2, 2, 2, 0, 68, 0, 8, 13),
('Sainz', 'Carlos', 'Espagnol', '01/09/1994', 'Madrid, Espagne', 55, 145, 2, 2, 8, 0, 574.5, 0, 5, 14),
('Schumacher', 'Mick', 'Allemand', '22/03/1999', 'Vufflens-le-Château, Switzerland', 47, 25, 10, 11, 0, 0, 0, 0, 6, 15),
('Stroll', 'Lance', 'Canadiens', '29/10/1998', 'Montreal, Canada', 18, 104, 1, 3, 3, 0, 177, 0, 4, 16),
('Tsunoda', 'Yuki', 'Japonais', '11/05/2000', 'Sagamihara, Japan', 22, 26, 7, 4, 0, 0, 42, 0, 2, 17),
('Verstappen', 'Max', 'Néerlandais', '30/09/1997', 'Hasselt, Belgique', 1, 145, 1, 1, 62, 22, 1616.5, 1, 9, 18),
('Vettel', 'Sebastian', 'Allemand', '03/07/1987', 'Heppenheim, Allemagne', 5, 282, 1, 1, 122, 53, 3065, 4, 4, 19),
('Guanyu', 'Zhou', 'Chinois', '30/05/1999', 'Shanghai, Chine', 24, 4, 12, 10, 0, 0, 1, 0, 1, 20);

INSERT INTO "race" ("driver_id", "circuit_id", "team_id", "best_lap", "date", "ranking") VALUES
(1, 1, 10, false, '2022-03-20', 13),
(2, 1, 3, false, '2022-03-20', 9),
(3, 1, 1, false, '2022-03-20', 6),
(4, 1, 2, false, '2022-03-20', 20),
(5, 1, 8, false, '2022-03-20', 3),
(6, 1, 10, false, '2022-03-20', 16),
(7, 1, 5, true, '2022-03-20', 1),
(8, 1, 6, false, '2022-03-20', 5),
(9, 1, 7, false, '2022-03-20', 15),
(10, 1, 3, false, '2022-03-20', 7),
(11, 1, 9, false, '2022-03-20', 18),
(12, 1, 7, false, '2022-03-20', 14),
(13, 1, 8, false, '2022-03-20', 4),
(14, 1, 5, false, '2022-03-20', 2),
(15, 1, 6, false, '2022-03-20', 11),
(16, 1, 4, false, '2022-03-20', 12),
(17, 1, 2, false, '2022-03-20', 8),
(18, 1, 9, false, '2022-03-20', 19),
(19, 1, 4, false, '2022-03-20', 17),
(20, 1, 1, false, '2022-03-20', 10),
(1, 2, 10, false, '2022-03-27', 14),
(2, 2, 3, false, '2022-03-27', 16),
(3, 2, 1, false, '2022-03-27', 15),
(4, 2, 2, false, '2022-03-27', 8),
(5, 2, 8, false, '2022-03-27', 10),
(6, 2, 10, false, '2022-03-27', 18),
(7, 2, 5, true, '2022-03-27', 2),
(8, 2, 6, false, '2022-03-27', 9),
(9, 2, 7, false, '2022-03-27', 7),
(10, 2, 3, false, '2022-03-27', 6),
(11, 2, 9, false, '2022-03-27', 4),
(12, 2, 7, false, '2022-03-27', 17),
(13, 2, 8, false, '2022-03-27', 5),
(14, 2, 5, false, '2022-03-27', 3),
(15, 2, 6, false, '2022-03-27', 20),
(16, 2, 4, false, '2022-03-27', 13),
(17, 2, 2, false, '2022-03-27', 19),
(18, 2, 9, false, '2022-03-27', 1),
(19, 2, 4, false, '2022-03-27', 12),
(20, 2, 1, false, '2022-03-27', 11),
(1, 3, 10, false, '2022-04-10', 10),
(2, 3, 3, false, '2022-04-10', 17),
(3, 3, 1, false, '2022-04-10', 8),
(4, 3, 2, false, '2022-04-10', 9),
(5, 3, 8, false, '2022-04-10', 4),
(6, 3, 10, false, '2022-04-10', 16),
(7, 3, 5, true, '2022-04-10', 1),
(8, 3, 6, false, '2022-04-10', 14),
(9, 3, 7, false, '2022-04-10', 5),
(10, 3, 3, false, '2022-04-10', 7),
(11, 3, 9, false, '2022-04-10', 2),
(12, 3, 7, false, '2022-04-10', 6),
(13, 3, 8, false, '2022-04-10', 3),
(14, 3, 5, false, '2022-04-10', 20),
(15, 3, 6, false, '2022-04-10', 13),
(16, 3, 4, false, '2022-04-10', 12),
(17, 3, 2, false, '2022-04-10', 15),
(18, 3, 9, false, '2022-04-10', 18),
(19, 3, 4, false, '2022-04-10', 19),
(20, 3, 1, false, '2022-04-10', 11),
(1, 4, 10, false, '2022-04-24', 11),
(2, 4, 3, false, '2022-04-24', 19),
(3, 4, 1, false, '2022-04-24', 5),
(4, 4, 2, false, '2022-04-24', 12),
(5, 4, 8, false, '2022-04-24', 13),
(6, 4, 10, false, '2022-04-24', 16),
(7, 4, 5, false, '2022-04-24', 6),
(8, 4, 6, false, '2022-04-24', 9),
(9, 4, 7, false, '2022-04-24', 3),
(10, 4, 3, false, '2022-04-24', 14),
(11, 4, 9, false, '2022-04-24', 2),
(12, 4, 7, false, '2022-04-24', 18),
(13, 4, 8, false, '2022-04-24', 4),
(14, 4, 5, false, '2022-04-24', 20),
(15, 4, 6, false, '2022-04-24', 17),
(16, 4, 4, false, '2022-04-24', 10),
(17, 4, 2, false, '2022-04-24', 7),
(18, 4, 9, true, '2022-04-24', 1),
(19, 4, 4, false, '2022-04-24', 8),
(20, 4, 1, false, '2022-04-24', 15);

INSERT INTO "qualifying" ("driver_id", "circuit_id", "team_id", "best_lap", "date", "ranking") VALUES
(1, 1, 10, false, '2022-03-19', 14),
(2, 1, 3, false, '2022-03-19', 8),
(3, 1, 1, false, '2022-03-19', 6),
(4, 1, 2, false, '2022-03-19', 10),
(5, 1, 8, false, '2022-03-19', 5),
(6, 1, 10, false, '2022-03-19', 20),
(7, 1, 5, true, '2022-03-19', 1),
(8, 1, 6, false, '2022-03-19', 7),
(9, 1, 7, false, '2022-03-19', 13),
(10, 1, 3, false, '2022-03-19', 11),
(11, 1, 9, false, '2022-03-19', 4),
(12, 1, 7, false, '2022-03-19', 18),
(13, 1, 8, false, '2022-03-19', 9),
(14, 1, 5, false, '2022-03-19', 3),
(15, 1, 6, false, '2022-03-19', 12),
(16, 1, 4, false, '2022-03-19', 19),
(17, 1, 2, false, '2022-03-19', 16),
(18, 1, 9, false, '2022-03-19', 2),
(19, 1, 4, false, '2022-03-19', 17),
(20, 1, 1, false, '2022-03-19', 15),
(1, 2, 10, false, '2022-03-26', 17),
(2, 2, 3, false, '2022-03-26', 7),
(3, 2, 1, false, '2022-03-26', 8),
(4, 2, 2, false, '2022-03-26', 9),
(5, 2, 8, false, '2022-03-26', 16),
(6, 2, 10, false, '2022-03-26', 19),
(7, 2, 5, false, '2022-03-26', 2),
(8, 2, 6, false, '2022-03-26', 10),
(9, 2, 7, false, '2022-03-26', 11),
(10, 2, 3, false, '2022-03-26', 5),
(11, 2, 9, true, '2022-03-26', 1),
(12, 2, 7, false, '2022-03-26', 12),
(13, 2, 8, false, '2022-03-26', 6),
(14, 2, 5, false, '2022-03-26', 3),
(15, 2, 6, false, '2022-03-26', 14),
(16, 2, 4, false, '2022-03-26', 15),
(17, 2, 2, false, '2022-03-26', 20),
(18, 2, 9, false, '2022-03-26', 4),
(19, 2, 4, false, '2022-03-26', 18),
(20, 2, 1, false, '2022-03-26', 13),
(1, 3, 10, false, '2022-04-09', 16),
(2, 3, 3, false, '2022-04-09', 10),
(3, 3, 1, false, '2022-04-09', 12),
(4, 3, 2, false, '2022-04-09', 11),
(5, 3, 8, false, '2022-04-09', 5),
(6, 3, 10, false, '2022-04-09', 18),
(7, 3, 5, true, '2022-04-09', 1),
(8, 3, 6, false, '2022-04-09', 17),
(9, 3, 7, false, '2022-04-09', 4),
(10, 3, 3, false, '2022-04-09', 8),
(11, 3, 9, false, '2022-04-09', 3),
(12, 3, 7, false, '2022-04-09', 7),
(13, 3, 8, false, '2022-04-09', 6),
(14, 3, 5, false, '2022-04-09', 9),
(15, 3, 6, false, '2022-04-09', 15),
(16, 3, 4, false, '2022-04-09', 20),
(17, 3, 2, false, '2022-04-09', 13),
(18, 3, 9, false, '2022-04-09', 2),
(19, 3, 4, false, '2022-04-09', 18),
(20, 3, 1, false, '2022-04-09', 14);


INSERT INTO "qualifying_race" ("driver_id", "circuit_id", "team_id", "best_lap", "date", "ranking") VALUES
(1, 4, 10, false, '2022-04-23', 18),
(2, 4, 3, false, '2022-04-23', 9),
(3, 4, 1, false, '2022-04-23', 7),
(4, 4, 2, false, '2022-04-23', 17),
(5, 4, 8, false, '2022-04-23', 14),
(6, 4, 10, false, '2022-04-23', 19),
(7, 4, 5, false, '2022-04-23', 2),
(8, 4, 6, false, '2022-04-23', 8),
(9, 4, 7, false, '2022-04-23', 5),
(10, 4, 3, false, '2022-04-23', 16),
(11, 4, 9, false, '2022-04-23', 3),
(12, 4, 7, false, '2022-04-23', 6),
(13, 4, 8, false, '2022-04-23', 11),
(14, 4, 5, false, '2022-04-23', 4),
(15, 4, 6, false, '2022-04-23', 10),
(16, 4, 4, false, '2022-04-23', 15),
(17, 4, 2, false, '2022-04-23', 12),
(18, 4, 9, true, '2022-04-23', 1),
(19, 4, 4, false, '2022-04-23', 13),
(20, 4, 1, false, '2022-04-23', 20);

-- add qualif Miami
SELECT new_qualifying(1, 5, 10, false, '2022-05-07', 18);
SELECT new_qualifying(2, 5, 3, false, '2022-05-07', 11);
SELECT new_qualifying(3, 5, 1, false, '2022-05-07', 5);
SELECT new_qualifying(4, 5, 2, false, '2022-05-07', 7);
SELECT new_qualifying(5, 5, 8, false, '2022-05-07', 6);
SELECT new_qualifying(6, 5, 10, false, '2022-05-07', 19);
SELECT new_qualifying(7, 5, 5, true, '2022-05-07', 1);
SELECT new_qualifying(8, 5, 6, false, '2022-05-07', 16);
SELECT new_qualifying(9, 5, 7, false, '2022-05-07', 8);
SELECT new_qualifying(10, 5, 3, false, '2022-05-07', 20);
SELECT new_qualifying(11, 5, 9, false, '2022-05-07', 4);
SELECT new_qualifying(12, 5, 7, false, '2022-05-07', 14);
SELECT new_qualifying(13, 5, 8, false, '2022-05-07', 12);
SELECT new_qualifying(14, 5, 5, false, '2022-05-07', 2);
SELECT new_qualifying(15, 5, 6, false, '2022-05-07', 15);
SELECT new_qualifying(16, 5, 4, false, '2022-05-07', 10);
SELECT new_qualifying(17, 5, 2, false, '2022-05-07', 9);
SELECT new_qualifying(18, 5, 9, false, '2022-05-07', 3);
SELECT new_qualifying(19, 5, 4, false, '2022-05-07', 13);
SELECT new_qualifying(20, 5, 1, false, '2022-05-07', 17);

-- add race Miami
SELECT new_race(1, 5, 10, false, '2022-05-08', 9);
SELECT new_race(2, 5, 3, false, '2022-05-08', 11);
SELECT new_race(3, 5, 1, false, '2022-05-08', 7);
SELECT new_race(4, 5, 2, false, '2022-05-08', 18);
SELECT new_race(5, 5, 8, false, '2022-05-08', 6);
SELECT new_race(6, 5, 10, false, '2022-05-08', 14);
SELECT new_race(7, 5, 5, false, '2022-05-08', 2);
SELECT new_race(8, 5, 6, false, '2022-05-08', 16);
SELECT new_race(9, 5, 7, false, '2022-05-08', 19);
SELECT new_race(10, 5, 3, false, '2022-05-08', 8);
SELECT new_race(11, 5, 9, false, '2022-05-08', 4);
SELECT new_race(12, 5, 7, false, '2022-05-08', 13);
SELECT new_race(13, 5, 8, false, '2022-05-08', 5);
SELECT new_race(14, 5, 5, false, '2022-05-08', 3);
SELECT new_race(15, 5, 6, false, '2022-05-08', 15);
SELECT new_race(16, 5, 4, false, '2022-05-08', 10);
SELECT new_race(17, 5, 2, false, '2022-05-08', 12);
SELECT new_race(18, 5, 9, true, '2022-05-08', 1);
SELECT new_race(19, 5, 4, false, '2022-05-08', 17);
SELECT new_race(20, 5, 1, false, '2022-05-08', 20);

-- add qualif Barcelone
SELECT new_qualifying(1, 6, 10, false, '2022-05-21', 19);
SELECT new_qualifying(2, 6, 3, false, '2022-05-21', 17);
SELECT new_qualifying(3, 6, 1, false, '2022-05-21', 7);
SELECT new_qualifying(4, 6, 2, false, '2022-05-21', 14);
SELECT new_qualifying(5, 6, 8, false, '2022-05-21', 6);
SELECT new_qualifying(6, 6, 10, false, '2022-05-21', 20);
SELECT new_qualifying(7, 6, 5, true, '2022-05-21', 1);
SELECT new_qualifying(8, 6, 6, false, '2022-05-21', 8);
SELECT new_qualifying(9, 6, 7, false, '2022-05-21', 11);
SELECT new_qualifying(10, 6, 3, false, '2022-05-21', 12);
SELECT new_qualifying(11, 6, 9, false, '2022-05-21', 5);
SELECT new_qualifying(12, 6, 7, false, '2022-05-21', 9);
SELECT new_qualifying(13, 6, 8, false, '2022-05-21', 4);
SELECT new_qualifying(14, 6, 5, false, '2022-05-21', 3);
SELECT new_qualifying(15, 6, 6, false, '2022-05-21', 10);
SELECT new_qualifying(16, 6, 4, false, '2022-05-21', 18);
SELECT new_qualifying(17, 6, 2, false, '2022-05-21', 13);
SELECT new_qualifying(18, 6, 9, false, '2022-05-21', 2);
SELECT new_qualifying(19, 6, 4, false, '2022-05-21', 16);
SELECT new_qualifying(20, 6, 1, false, '2022-05-21', 15);

-- add race Barcelone
SELECT new_race(1, 6, 10, false, '2022-05-22', 18);
SELECT new_race(2, 6, 3, false, '2022-05-22', 9);
SELECT new_race(3, 6, 1, false, '2022-05-22', 6);
SELECT new_race(4, 6, 2, false, '2022-05-22', 13);
SELECT new_race(5, 6, 8, false, '2022-05-22', 5);
SELECT new_race(6, 6, 10, false, '2022-05-22', 16);
SELECT new_race(7, 6, 5, false, '2022-05-22', 20);
SELECT new_race(8, 6, 6, false, '2022-05-22', 17);
SELECT new_race(9, 6, 7, false, '2022-05-22', 8);
SELECT new_race(10, 6, 3, false, '2022-05-22', 7);
SELECT new_race(11, 6, 9, true, '2022-05-22', 2);
SELECT new_race(12, 6, 7, false, '2022-05-22', 12);
SELECT new_race(13, 6, 8, false, '2022-05-22', 3);
SELECT new_race(14, 6, 5, false, '2022-05-22', 4);
SELECT new_race(15, 6, 6, false, '2022-05-22', 14);
SELECT new_race(16, 6, 4, false, '2022-05-22', 15);
SELECT new_race(17, 6, 2, false, '2022-05-22', 10);
SELECT new_race(18, 6, 9, false, '2022-05-22', 1);
SELECT new_race(19, 6, 4, false, '2022-05-22', 11);
SELECT new_race(20, 6, 1, false, '2022-05-22', 19);

COMMIT;
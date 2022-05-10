--  Vue classement pilotes (drivers_ranking)
CREATE VIEW drivers_ranking AS
	SELECT driver.name,
		driver.firstname,
		driver.photo,
		driver.number,
		current_saison_driver.points
	   FROM driver
		JOIN current_saison_driver ON saison_driver_id = current_saison_driver.id
		ORDER BY current_saison_driver.points DESC;
--   Vue classement constructeurs (teams_ranking)
CREATE VIEW teams_ranking AS
	SELECT team.name,
   	team.logo,
    current_saison_team.points
   FROM team
   JOIN current_saison_team ON saison_team_id = current_saison_team.id
  ORDER BY current_saison_team.points DESC;

-- Vue classement par week-end
-- bahrain_rance_ranking
SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
	FROM race
	JOIN driver ON race.driver_id = driver.id
	JOIN circuit ON race.circuit_id = circuit.id
	JOIN team ON race.team_id = team.id
	WHERE race.date = '2022-03-20'
	ORDER BY race.ranking ASC;

-- jeddah_rance_ranking
SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
	FROM race
	JOIN driver ON race.driver_id = driver.id
	JOIN circuit ON race.circuit_id = circuit.id
	JOIN team ON race.team_id = team.id
	WHERE race.date = '2022-03-27'
	ORDER BY race.ranking ASC;

-- albert_park_rance_ranking
SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
	FROM race
	JOIN driver ON race.driver_id = driver.id
	JOIN circuit ON race.circuit_id = circuit.id
	JOIN team ON race.team_id = team.id
	WHERE race.date = '2022-04-10'
	ORDER BY race.ranking ASC;

-- emilia-romagna_rance_ranking
SELECT circuit.name AS circuit_name, driver.name AS driver_name, race.ranking, race.date, team.name
	FROM race
	JOIN driver ON race.driver_id = driver.id
	JOIN circuit ON race.circuit_id = circuit.id
	JOIN team ON race.team_id = team.id
	WHERE race.date = '2022-04-24'
	ORDER BY race.ranking ASC;


-- function new_race

CREATE OR REPLACE FUNCTION new_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
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
    INSERT INTO race
    ("driver_id", "circuit_id", "team_id", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;

-- function new_race IF CASE

CREATE OR REPLACE FUNCTION new_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	"date" DATE,
	ranking INT
) RETURNS race AS $$
	UPDATE driver
		SET highest_race_finish =
			CASE
				WHEN ranking>highest_race_finish THEN ranking
			END
	WHERE id=driver_id;
    INSERT INTO race
    ("driver_id", "circuit_id", "team_id", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;
	
	SELECT * FROM new_race(1, 5, 10, '2022-05-30', 1);

------------------- 

CREATE OR REPLACE FUNCTION new_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	"date" DATE,
	ranking INT
) RETURNS race AS $$
	UPDATE driver
	SET highest_race_finish = ranking
	WHERE id=driver_id AND ranking < highest_race_finish;
    INSERT INTO race
    ("driver_id", "circuit_id", "team_id", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;
	
	SELECT * FROM new_race(1, 5, 10, '2022-05-30', 2);

-----------------------

CREATE OR REPLACE FUNCTION new_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	"date" DATE,
	ranking INT
) RETURNS race AS $$
DECLARE
	top_rank INT;
	BEGIN
	SELECT highest_race_finish FROM driver WHERE id=driver_id
		RETURNING highest_race_finish INTO top_rank;
	IF ranking< top_rank THEN
			UPDATE driver
				SET highest_race_finish = ranking;			
		END IF;
    INSERT INTO race
    ("driver_id", "circuit_id", "team_id", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"date",
		"ranking"
    ) RETURNING *;
	END;
    $$ LANGUAGE plpgsql;
	
	SELECT * FROM new_race(1, 5, 10, '2022-05-30', 1);


-- function new_race base

CREATE OR REPLACE FUNCTION new_race(
	driver_id INT,
	circuit_id INT,
	team_id INT,
	"date" DATE,
	ranking INT
) RETURNS race AS $$
	UPDATE driver
	SET wins = wins + 1
	WHERE id=driver_id;
    INSERT INTO race
    ("driver_id", "circuit_id", "team_id", "date", "ranking")
    VALUES(
		"driver_id",
		"circuit_id",
		"team_id",
		"date",
		"ranking"
    ) RETURNING *;
    $$ LANGUAGE SQL;


-- Lancement fonction add ne race
SELECT * FROM new_race(1, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(2, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(3, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(4, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(5, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(6, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(7, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(8, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(9, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(10, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(11, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(12, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(13, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(14, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(15, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(16, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(17, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(18, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(19, 5, 10, '2022-05-**', 1);
SELECT * FROM new_race(20, 5, 10, '2022-05-**', 1);

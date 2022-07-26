BEGIN;

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

COMMIT;
BEGIN;

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

CREATE VIEW driverpage AS
	SELECT driver.id,
		driver.name,
		driver.firstname,
		driver.number,
		driver.nationality,
		driver.birthday,
		driver.birthday_place,
		driver.participations,
		driver.highest_grid_position,
		driver.highest_race_finish,
		driver.podiums,
		driver.wins,
		driver.points,
		driver.world_championships,
		driver.team_id,
		team.name AS team_name
	   FROM driver
		JOIN team ON team_id = team.id;

CREATE VIEW teampage AS
	SELECT team.id,
		team.name,
		team.first_time,
		team.chief,
		team.wins,
		team.world_championships,
		driver.name AS driver_name,
		driver.firstname AS driver_firstname,
		driver.number
	   FROM team
		JOIN driver ON driver.team_id = team.id;

COMMIT;
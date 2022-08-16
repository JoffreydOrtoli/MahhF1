const client = require('./dbclient');
const APIError = require('../middlewares/APIError');
const { appendFile } = require('fs/promises');
const path = require('path');
const queryToFilePath = path.resolve(__dirname, '../../data/circuits');

const dataMapper = {
  async getDriversRank() {
    const drivers = await client.query('SELECT * FROM drivers_ranking LIMIT 3');
    if(!drivers){
    throw new APIError ('NOT FOUND', 404);
    };
    return drivers.rows;
  },

  async getAllDriversRank() {
    const drivers = await client.query('SELECT * FROM drivers_ranking');
    if(!drivers){
    throw new APIError ('NOT FOUND', 404);
    }
    return drivers.rows;
  },

  async getDriver(driverId) {
    const query = {
      text: 'SELECT * FROM driverpage WHERE driverpage.id=$1',
      values: [driverId]
    }
    const driver = await client.query(query);
    return driver.rows[0];
  },

  async getTeam(teamId) {
    const query = {
      text: 'SELECT * FROM teampage WHERE teampage.id=$1',
      values: [teamId]
    }
    const team = await client.query(query);
    return team.rows;
  },

  async getTeamsRank() {
    const teams = await client.query('SELECT * FROM teams_ranking');
    if(!teams){
      throw new APIError ('NOT FOUND', 404);
    };
    return teams.rows;
  },

  async getCircuits() {
    const circuits = await client.query('SELECT * FROM circuit');
    if(!circuits){
      throw new APIError ('NOT FOUND', 404);
    };
    return circuits.rows;
  },

  async getCurrentsDrivers() {
    const drivers = await client.query('SELECT * FROM driver JOIN current_saison_driver ON saison_driver_id = current_saison_driver.id ORDER BY current_saison_driver.id asc')
    return drivers.rows;
  },

  async qualifRanking(qualifRanking) {
    const { driver_id, circuit_id, team_id, best_lap, date, ranking, circuit_name } = qualifRanking;
    const keys = ['driver_id', 'circuit_id', 'team_id', 'best_lap', 'date', 'ranking'];
    let queryToFile='BEGIN;\n';
    for (let a = 0; a < driver_id.length; a++) {
      const driver = [driver_id[a], circuit_id[a], team_id[a], best_lap[a], date[a], ranking[a]];
      const driverToPush = Object.assign(...keys.map((k, i)=>({[k]: driver[i]})));
      const query = {
        text: 'SELECT new_qualifying($1,$2,$3,$4,$5,$6)',
        values: [driverToPush.driver_id, driverToPush.circuit_id, driverToPush.team_id, driverToPush.best_lap, driverToPush.date, driverToPush.ranking]
      }
      // const result = await client.query(query);
      // if(!result) {
      //   throw new APIError ('Problème', 404);
      // };
      queryToFile += `SELECT new_qualifying(`
        +`${driverToPush.driver_id},`
        +`${driverToPush.circuit_id},`
        +`${driverToPush.team_id},`
        +`${driverToPush.best_lap},`
        +`'${driverToPush.date}',`
        +`${driverToPush.ranking},`
        +`);`
        + `\n`; 
    };
    const fileName = `${circuit_name}.sql`;
    appendFile(queryToFilePath+"/"+fileName, queryToFile);
  },

  async qualifRaceRanking(qualifRaceRanking) {
    const { driver_id, circuit_id, team_id, best_lap, date, ranking, circuit_name } = qualifRaceRanking;
    const keys = ['driver_id', 'circuit_id', 'team_id', 'best_lap', 'date', 'ranking'];
    let queryToFile='BEGIN;\n';
    for (let a = 0; a < driver_id.length; a++) {
      const driver = [driver_id[a], circuit_id[a], team_id[a], best_lap[a], date[a], ranking[a]];
      const driverToPush = Object.assign(...keys.map((k, i)=>({[k]: driver[i]})));
      const query = {
        text: 'SELECT new_qualifying_race($1,$2,$3,$4,$5,$6)',
        values: [driverToPush.driver_id, driverToPush.circuit_id, driverToPush.team_id, driverToPush.best_lap, driverToPush.date, driverToPush.ranking]
      }
      // const result = await client.query(query);
      // if(!result) {
      //   throw new APIError ('Problème', 404);
      // };
      queryToFile += `SELECT new_qualifying_race(`
        +`${driverToPush.driver_id},`
        +`${driverToPush.circuit_id},`
        +`${driverToPush.team_id},`
        +`${driverToPush.best_lap},`
        +`'${driverToPush.date}',`
        +`${driverToPush.ranking},`
        +`);`
        + `\n`; 
    };
    const fileName = `${circuit_name}.sql`;
    appendFile(queryToFilePath+"/"+fileName, queryToFile);
  },

  async raceRanking(raceRanking) {
    const { driver_id, circuit_id, team_id, best_lap, date, ranking, circuit_name } = raceRanking;
    const keys = ['driver_id', 'circuit_id', 'team_id', 'best_lap', 'date', 'ranking'];
    let queryToFile='';
    for (let a = 0; a < driver_id.length; a++) {
      const driver = [driver_id[a], circuit_id[a], team_id[a], best_lap[a], date[a], ranking[a]];
      const driverToPush = Object.assign(...keys.map((k, i)=>({[k]: driver[i]})));
      const query = {
        text: 'SELECT new_race($1,$2,$3,$4,$5,$6)',
        values: [driverToPush.driver_id, driverToPush.circuit_id, driverToPush.team_id, driverToPush.best_lap, driverToPush.date, driverToPush.ranking]
      }
      // const result = await client.query(query);
      // if(!result) {
      //   throw new APIError ('Problème', 404);
      // };
      queryToFile += `SELECT new_race(`
        +`${driverToPush.driver_id},`
        +`${driverToPush.circuit_id},`
        +`${driverToPush.team_id},`
        +`${driverToPush.best_lap},`
        +`'${driverToPush.date}',`
        +`${driverToPush.ranking},`
        +`);`
        + `\n`; 
    };
    queryToFile += 'COMMIT;';
    const fileName = `${circuit_name}.sql`;
    appendFile(queryToFilePath+"/"+fileName, queryToFile);
  }
};

module.exports = dataMapper;
const client = require('./dbclient');
const APIError = require('../middlewares/APIError');

const dataMapper = {
  async getDriversRank() {
    const drivers = await client.query('SELECT * FROM drivers_ranking');
    if(!drivers){
      throw new APIError ('NOT FOUND', 404);
    };
    return drivers.rows;
  },

  async getTeamsRank() {
    const teams = await client.query('SELECT * FROM teams_ranking');
    if(!teams){
      throw new APIError ('NOT FOUND', 404);
    };
    return teams.rows;
  },

  async getCurrentsDrivers() {
    const drivers = await client.query('Select * FROM driver JOIN current_saison_driver ON saison_driver_id = current_saison_driver.id ORDER BY current_saison_driver.id asc')
    return drivers.rows;
  }
};

module.exports = dataMapper;

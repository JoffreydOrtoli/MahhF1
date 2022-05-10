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
  }
};

module.exports = dataMapper;

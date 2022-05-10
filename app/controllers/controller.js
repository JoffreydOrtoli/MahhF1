require('dotenv').config();
const dataMapper = require('../database/dataMapper');

const controller = {
  async getDriversAndTeamsRank(req, res) {
    const drivers = await dataMapper.getDriversRank();
    const teams = await dataMapper.getTeamsRank();
    res.status(200).send({drivers, teams});
  },
};

module.exports = controller;

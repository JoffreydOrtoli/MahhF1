require('dotenv').config();
const dataMapper = require('../database/dataMapper');

const controller = {
  async home(req, res) {
    const drivers = await dataMapper.getDriversRank();
    const teams = await dataMapper.getTeamsRank();
    res.render('home', {drivers, teams});
  },

  async backOffice(req, res) {
    const drivers = await dataMapper.getCurrentsDrivers();
    res.render('backoffice', {drivers});
  },
};

module.exports = controller;

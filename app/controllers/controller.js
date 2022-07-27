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

  async createNewRace(req, res) {
    const raceRanking = req.body;
    const results = await dataMapper.raceRanking(raceRanking);
    res.redirect('/backoffice');
  }
};

module.exports = controller;

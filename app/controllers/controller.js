require('dotenv').config();
const dataMapper = require('../database/dataMapper');

const controller = {
  async home(req, res) {
    const drivers = await dataMapper.getDriversRank();
    const teams = await dataMapper.getTeamsRank();
    res.render('home', {drivers, teams});
  },

  async getAllDriversRank(req, res) {
    const drivers = await dataMapper.getAllDriversRank();
    res.render('rankdrivers', {drivers});
  },

  async driverPage(req, res) {
    const driverId = req.params.driverId;
    const driver = await dataMapper.getDriver(driverId);
    res.render('driverpage', {driver});
  },

  async backOffice(req, res) {
    const drivers = await dataMapper.getCurrentsDrivers();
    res.render('backoffice', {drivers});
  },

  async createNewQualif(req, res) {
    const qualifRanking = req.body;
    const results = await dataMapper.qualifRanking(qualifRanking);
    res.redirect('/backoffice');
  },

  async createNewRaceQualif(req, res) {
    const qualifRaceRanking = req.body;
    const results = await dataMapper.qualifRaceRanking(qualifRaceRanking);
    res.redirect('/backoffice');
  },

  async createNewRace(req, res) {
    const raceRanking = req.body;
    const results = await dataMapper.raceRanking(raceRanking);
    res.redirect('/backoffice');
  }
};

module.exports = controller;

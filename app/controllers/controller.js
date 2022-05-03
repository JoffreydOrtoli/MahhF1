require('dotenv').config();
const dataMapper = require('../database/dataMapper');

const exampleController = {
  async getExample(req, res) {
    const result = await dataMapper.getExample;
    debug(result);
    res.status(200).json(result);
  },
};

module.exports = exampleController;

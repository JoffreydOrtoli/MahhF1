const client = require('./dbclient');
const APIError = require('../middlewares/APIError');

const dataMapper = {
  async getExample() {
    const test = 'Toto';
    if(!test){
      throw new APIError ('NOT FOUND', 404);
    };
    console.log('Contenu de la requête: ', test);
    return test;
  },
};

module.exports = dataMapper;

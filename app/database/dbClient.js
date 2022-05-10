require('dotenv').config();


const {Pool} = require('pg');

const config = {
    connectionString: process.env.PG_URL
};

const client = new Pool(config);

client.connect()
  .then( () => console.log('DB connection is live.'))
  .catch((err) => console.log('DB connection failed.', err));

module.exports = client;

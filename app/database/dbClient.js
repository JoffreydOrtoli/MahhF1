require('dotenv').config();

const { Pool } = require('pg');

const client = new Pool({
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD,
    database: process.env.PGDATABASE
});

module.exports = client;
